import React, { useMemo, useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import StudentHelpRequest from '../components/StudentHelpRequest';
import { gardenPathData } from '../data/curriculum.js';
import { getChapterDetails, getDatabaseChapterId } from '../data/chapterDetails.js';
import { api } from '../services/apiService.js';
import '../styles/ChapterPage.css';
import StudentFlashcardComponent from '../components/StudentFlashcardComponent.jsx';
import StudentChallengeBoard from '../components/StudentChallengeBoard.jsx';
import StudentQuizComponent from '../components/StudentQuizComponent.jsx';
import ChapterPracticeLab from '../components/ChapterPracticeLab.jsx';
import { preloadPyodide } from '../utils/pyodidePreloader.js';

const ChapterPage = () => {
  const { chapterId } = useParams();
  const navigate = useNavigate();

  // Convert URL numeric ID to database GUID
  const numericId = Number(chapterId);
  const details = useMemo(() => getChapterDetails(numericId), [numericId]);
  const databaseChapterId = details?.databaseChapterId || getDatabaseChapterId(numericId);
  
  // Fallback static data (for UI structure and navigation)
  const metadata = useMemo(
    () => gardenPathData.find((chapter) => chapter.id === numericId),
    [numericId],
  );

  const previousChapter = useMemo(
    () => gardenPathData.find((chapter) => chapter.id === numericId - 1),
    [numericId],
  );
  const nextChapter = useMemo(
    () => gardenPathData.find((chapter) => chapter.id === numericId + 1),
    [numericId],
  );

  // State for the active tab
  const [activeTab, setActiveTab] = useState('notes');
  
  // State to track if user has started learning (clicked "Start Learning" button)
  const [hasStartedLearning, setHasStartedLearning] = useState(false);
  
  // State for challenges mode (practice vs quiz)
  const [challengeMode, setChallengeMode] = useState('practice'); // 'practice' or 'quiz'
  
  // State for database content from "Master Key" endpoint
  const [chapterData, setChapterData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  // State for chapter unlock status
  const [nextChapterUnlocked, setNextChapterUnlocked] = useState(true);
  const [unlockStatusLoading, setUnlockStatusLoading] = useState(false);

  // Reset "Start Learning" state when switching away from notes tab
  useEffect(() => {
    if (activeTab !== 'notes') {
      setHasStartedLearning(false);
    }
  }, [activeTab]);

  // Reset to notes tab when chapter changes
  useEffect(() => {
    setActiveTab('notes');
    setHasStartedLearning(false);
  }, [chapterId]);

  // Preload Pyodide in the background when chapter page loads
  // This ensures it's ready when users open the practice lab
  useEffect(() => {
    // Check if this chapter has a practice lab
    const hasPracticeLab = details?.practiceLab || chapterData?.content?.some(r => r.type === 'practice');
    
    if (hasPracticeLab) {
      // Start preloading Pyodide in the background (non-blocking)
      preloadPyodide().catch(err => {
        // Silently fail - component will handle loading when needed
        console.debug('Pyodide preload failed (will retry when needed):', err);
      });
    }
  }, [details, chapterData]);

  // Fetch chapter data from backend using the master endpoint
  useEffect(() => {
    const fetchChapterData = async () => {
      if (!databaseChapterId) {
        console.warn(`No database mapping for chapter ${numericId}. Using fallback data.`);
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);
        
        // Call the "Master Key" endpoint: GET /api/students/chapters/{chapterId}/content
        // Now returns DTO format: { notes, flashcards, quiz, ... }
        const data = await api.students.getChapterContent(databaseChapterId);
        console.log('✅ Loaded chapter data from backend:', data);
        console.log('📊 Full API Response:', JSON.stringify(data, null, 2));
        console.log('📊 Data structure check:', {
          hasNotes: !!data?.notes,
          hasNotesPascal: !!data?.Notes,
          hasFlashcards: !!data?.flashcards,
          hasQuiz: !!data?.quiz,
          notesStructure: (data?.notes || data?.Notes) ? {
            notes: data?.notes || data?.Notes,
            hasIntroduction: !!(data?.notes?.introduction || data?.Notes?.introduction),
            hasSubtopics: !!(data?.notes?.subtopics?.length || data?.Notes?.subtopics?.length),
            hasCodeSamples: !!(data?.notes?.codeSamples?.length || data?.Notes?.codeSamples?.length),
            hasPracticeIdeas: !!(data?.notes?.practiceIdeas || data?.Notes?.practiceIdeas),
            hasFullContent: !!(data?.notes?.fullContent || data?.Notes?.fullContent || data?.notes?.FullContent || data?.Notes?.FullContent)
          } : null,
          // Legacy format check
          hasContent: !!data?.content,
          contentLength: data?.content?.length || 0,
          allKeys: Object.keys(data || {})
        });
        
        // Set the data directly (DTO format or legacy format)
        setChapterData(data);
      } catch (err) {
        console.error('❌ Failed to load chapter data from database:', err);
        console.warn('⚠️ Falling back to static content');
        setError(null); // Don't show error to user, gracefully fallback
      } finally {
        setLoading(false);
      }
    };

    fetchChapterData();
  }, [databaseChapterId, numericId]);

  // Check if next chapter is unlocked
  useEffect(() => {
    const checkNextChapterUnlock = async () => {
      if (!nextChapter || !databaseChapterId) {
        setNextChapterUnlocked(true); // No next chapter means it's "unlocked" (doesn't exist)
        return;
      }

      try {
        setUnlockStatusLoading(true);
        // Get the database chapter ID for the next chapter
        const nextChapterDetails = getChapterDetails(nextChapter.id);
        const nextDatabaseChapterId = nextChapterDetails?.databaseChapterId || getDatabaseChapterId(nextChapter.id);
        
        if (!nextDatabaseChapterId) {
          setNextChapterUnlocked(true); // If no mapping, assume unlocked
          return;
        }

        const unlockStatus = await api.students.isChapterUnlocked(nextDatabaseChapterId);
        setNextChapterUnlocked(unlockStatus.unlocked || false);
      } catch (err) {
        console.error('Failed to check chapter unlock status:', err);
        // On error, allow navigation (fail open)
        setNextChapterUnlocked(true);
      } finally {
        setUnlockStatusLoading(false);
      }
    };

    checkNextChapterUnlock();
  }, [nextChapter, databaseChapterId, numericId]);

  // Filter and organize resources by type using useMemo
  // Now handles both old format (content array) and new DTO format
  const resources = useMemo(() => {
    if (!chapterData) {
      console.log('⚠️ No chapterData found');
      return { lesson: null, flashcards: null, quiz: null, notes: null };
    }
    
    // Check if this is the new DTO format (has notes, flashcards, quiz properties directly)
    // Check if DTO format exists (notes can be null, but the property should exist)
    const hasDtoFormat = 'notes' in chapterData || 'Notes' in chapterData || 
                         'flashcards' in chapterData || 'Flashcards' in chapterData || 
                         'quiz' in chapterData || 'Quiz' in chapterData;
    
    if (hasDtoFormat) {
      // Handle both camelCase and PascalCase property names (C# serialization can use either)
      const notes = chapterData.notes || chapterData.Notes;
      const flashcards = chapterData.flashcards || chapterData.Flashcards;
      const quiz = chapterData.quiz || chapterData.Quiz;
      
      console.log('✅ Using DTO format');
      console.log('📝 DTO Notes:', notes);
      console.log('📝 Notes structure:', {
        hasNotes: !!notes,
        notesType: typeof notes,
        notesKeys: notes ? Object.keys(notes) : [],
        hasFullContent: !!notes?.fullContent,
        hasIntroduction: !!notes?.introduction,
        hasSubtopics: !!notes?.subtopics,
        subtopicsCount: notes?.subtopics?.length || 0
      });
      
      return {
        lesson: notes ? {
          content: notes.fullContent || notes.FullContent || '',
          structured: notes // Structured sections
        } : null,
        flashcards: flashcards || [],
        quiz: quiz || null,
        notes: notes // Full structured notes object (can be null, but property exists)
      };
    }
    
    // Fallback to old format (content array)
    console.log('⚠️ Using legacy format, falling back to content array');
    const contentArray = chapterData.content || 
                        chapterData.Content || 
                        (Array.isArray(chapterData) ? chapterData : []);
    
    if (!contentArray || contentArray.length === 0) {
      console.log('⚠️ No content array found in chapterData:', chapterData);
      return { lesson: null, flashcards: null, quiz: null, notes: null };
    }
    
    console.log('📦 All resources:', contentArray);
    console.log('📝 Resource types:', contentArray.map(r => {
      const type = r.type || r.Type || 'unknown';
      return { type, resourceId: r.resourceId || r.ResourceId };
    }));
    
    // Normalize type to lowercase for comparison
    const normalizeType = (r) => {
      const type = r.type || r.Type || '';
      return type.toLowerCase();
    };
    
    // Notes can be type 'note' or 'lesson' (PDFExtractor creates 'lesson' type)
    const notes = contentArray.filter(r => {
      const type = normalizeType(r);
      return type === 'note' || type === 'lesson';
    });
    console.log('📋 Filtered notes:', notes);
    
    // Lesson is separate from notes - it's the main lesson content
    const lessonResource = contentArray.find(r => {
      const type = normalizeType(r);
      return type === 'text' || type === 'lesson';
    });
    
    return {
      lesson: lessonResource,
      flashcards: contentArray.find(r => normalizeType(r) === 'flashcard'),
      quiz: contentArray.find(r => normalizeType(r) === 'mcq'),
      notes: notes.length > 0 ? notes : null
    };
  }, [chapterData]);
  if (!metadata || !details) {
    return (
      <>
        <Navbar />
        <main className="chapter-page">
          <div className="chapter-card">
            <h1>Chapter not found</h1>
            <p>The chapter you are looking for does not exist yet.</p>
            <button
              type="button"
              className="chapter-nav-button"
              onClick={() => navigate(-1)}
            >
              Go Back
            </button>
          </div>
        </main>
      </>
    );
  }

  const storySeeds = [
    {
      badge: 'Greenhouse Brief',
      title: 'Morning in the Garden',
      message: [
        'Sunlight spills through the glass roof as you check the clipboard of today’s coding chores.',
        'Every concept you learn waters a different part of CodeSage. Ready to begin?',
      ],
    },
    {
      badge: 'Garden Whisper',
      title: 'The Caretaker’s Tip',
      message: [
        '"Give every tool a name," the caretaker smiles. "When your code calls something clearly, it never gets misplaced."',
      ],
    },
    {
      badge: 'Sprout Story',
      title: 'Sensor Row Awakens',
      message: [
        'Pots blink awake, waiting for instructions. You’ll teach Python to handle each task with care.',
      ],
    },
  ];

  const bloomCheckSeeds = [
    {
      prompt: 'In one sentence, explain why Python needs variables in this lesson.',
      answer: 'Variables label data so your code can store, reuse, and update values as the program runs.',
    },
    {
      prompt: 'Predict what happens if you forget to convert input text into an integer before comparing it.',
      answer: 'The comparison fails because strings and numbers cannot be compared without conversion.',
    },
    {
      prompt: 'How would you describe a loop to someone tending a row of plants?',
      answer: 'A loop is repeating the same task for each plant until every one has been checked or a condition changes.',
    },
  ];

  const storyCard = storySeeds[(numericId - 1) % storySeeds.length];
  const bloomChecks = (details.sections || []).map(
    (_, index) => bloomCheckSeeds[index % bloomCheckSeeds.length],
  );

  const [revealedChecks, setRevealedChecks] = useState({});
  useEffect(() => {
    setRevealedChecks({});
  }, [numericId]);

  const toggleBloomCheck = (index) => {
    setRevealedChecks((prev) => ({
      ...prev,
      [index]: !prev[index],
    }));
  };

  const practiceItems = details.practice || [];
  const practiceLab = chapterData?.practiceLab || details.practiceLab;
  const statusCycle = {
    seedling: 'sprouting',
    sprouting: 'bloom',
    bloom: 'seedling',
  };
  const statusLabels = {
    seedling: 'Seedling',
    sprouting: 'Sprouting',
    bloom: 'In Bloom',
  };

  const createPracticeStatuses = () =>
    practiceItems.reduce((acc, item) => {
      acc[item] = 'seedling';
      return acc;
    }, {});

  const practiceSignature = practiceItems.join('|');
  const [practiceStatuses, setPracticeStatuses] = useState(createPracticeStatuses);

  useEffect(() => {
    setPracticeStatuses(createPracticeStatuses());
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [numericId, practiceSignature]);

  const handlePracticeStatus = (item) => {
    setPracticeStatuses((prev) => {
      const current = prev[item] || 'seedling';
      const next = statusCycle[current];
      return {
        ...prev,
        [item]: next,
      };
    });
  };

  return (
    <>
      <Navbar />
      <main className="chapter-page">
        <div className="chapter-hero">
          <div className="chapter-breadcrumb">
            <button
              type="button"
              onClick={() => navigate('/student-dashboard')}
              className="breadcrumb-link"
            >
              Dashboard
            </button>
            <span>›</span>
            <span>{metadata.title}</span>
          </div>
          <span className="chapter-icon" role="img" aria-label={metadata.level}>
            {metadata.icon}
          </span>
          <h1>{metadata.title}</h1>
          <p className="chapter-overview">{details.overview}</p>
          <div className="chapter-meta">
            <span className="chapter-level">{metadata.level}</span>
            <span>Chapter {metadata.id}</span>
          </div>
        </div>

        <div className="chapter-tabs">
          <button
            type="button"
            className={`chapter-tab ${activeTab === 'notes' ? 'active' : ''}`}
            onClick={() => setActiveTab('notes')}
          >
            Notes
          </button>
          <button
            type="button"
            className={`chapter-tab ${activeTab === 'flashcards' ? 'active' : ''}`}
            onClick={() => setActiveTab('flashcards')}
          >
            Flashcards
          </button>
          <button
            type="button"
            className={`chapter-tab ${activeTab === 'challenges' ? 'active' : ''}`}
            onClick={() => setActiveTab('challenges')}
          >
            Challenges
          </button>
          <button
            type="button"
            className={`chapter-tab ${activeTab === 'help' ? 'active' : ''}`}
            onClick={() => setActiveTab('help')}
          >
            Ask for Help
          </button>
        </div>

        <div className="chapter-content-panel">
          {activeTab === 'notes' && (
            <>
              {/* Preview Section: Always show Greenhouse Brief, Learning Objectives, and "In This Lesson" */}
              <section className="chapter-story-card">
                <div className="chapter-story-card__badge">{storyCard.badge}</div>
                <h2 className="chapter-story-card__title">{storyCard.title}</h2>
                {storyCard.message.map((line) => (
                  <p key={line}>{line}</p>
                ))}
              </section>

              <section className="chapter-section chapter-section--objectives">
                <h2>Learning Objectives</h2>
                <ul className="objectives-list">
                  {details.learningObjectives.map((objective) => (
                    <li key={objective}>
                      <span className="objective-icon" aria-hidden="true">
                        ✽
                      </span>
                      <span>{objective}</span>
                    </li>
                  ))}
                </ul>
              </section>

              {/* Show "Start Learning" button if not started yet */}
              {!hasStartedLearning && (
                <section className="chapter-section chapter-section--start-learning">
                  <div className="start-learning-content">
                    <div className="start-learning-icon">🌱</div>
                    <h2>Ready to Begin?</h2>
                    <p>Click below to start reading the full chapter notes and access interactive learning materials.</p>
                    <button
                      type="button"
                      className="start-learning-btn"
                      onClick={() => setHasStartedLearning(true)}
                    >
                      Start Learning →
                    </button>
                  </div>
                </section>
              )}

              {/* Full Content: Show after clicking "Start Learning" */}
              {hasStartedLearning && (
                <>
                  {/* "In This Lesson" - Step-by-step content with Bloom Checks */}
                  <section className="chapter-section chapter-section--lesson">
                    <h2>In This Lesson</h2>
                    <div className="lesson-timeline">
                      {details.sections.map((section, index) => {
                        const bloomCheck = bloomChecks[index];
                        return (
                          <React.Fragment key={section.heading}>
                            <article className="chapter-article">
                              <div className="chapter-article__badge">Step {index + 1}</div>
                              <div className="chapter-article__content">
                                <h3>{section.heading}</h3>
                                {section.body.map((paragraph, paragraphIndex) => (
                                  <p key={paragraphIndex}>{paragraph}</p>
                                ))}
                              </div>
                            </article>
                            {bloomCheck && (
                              <div
                                className={`bloom-check ${revealedChecks[index] ? 'is-revealed' : ''}`}
                              >
                                <div className="bloom-check__badge">Bloom Check</div>
                                <p className="bloom-check__prompt">{bloomCheck.prompt}</p>
                                {revealedChecks[index] ? (
                                  <p className="bloom-check__answer">{bloomCheck.answer}</p>
                                ) : (
                                  <button
                                    type="button"
                                    className="bloom-check__reveal"
                                    onClick={() => toggleBloomCheck(index)}
                                  >
                                    Reveal growth tip
                                  </button>
                                )}
                              </div>
                            )}
                          </React.Fragment>
                        );
                      })}
                    </div>
                  </section>

                  {/* Chapter Notes - Database content with structured DTO */}
                  <section className="chapter-section chapter-section--notes">
                    <h2>Chapter Notes</h2>
                    
                    {loading && (
                      <div className="lesson-loading">
                        🌱 Loading chapter content...
                      </div>
                    )}
                    
                    {!loading && (resources.notes || (chapterData && ('notes' in chapterData || 'Notes' in chapterData))) && (
                      <div className="lesson-content">
                        {/* Always show fullContent first if available, then structured sections */}
                        {(() => {
                          // Get notes from resources or directly from chapterData
                          const notes = resources.notes || chapterData?.notes || chapterData?.Notes;
                          
                          if (!notes) {
                            return (
                              <div className="lesson-empty">
                                <p>No notes content available for this chapter.</p>
                              </div>
                            );
                          }
                          
                          // Get fullContent (handle both camelCase and PascalCase)
                          const fullContent = notes.fullContent || notes.FullContent || '';
                          
                          // Check if we have any structured content
                          const hasStructuredContent = 
                            notes.introduction ||
                            (notes.subtopics && notes.subtopics.length > 0) ||
                            (notes.codeSamples && notes.codeSamples.length > 0) ||
                            notes.practiceIdeas;
                          
                          // If no structured content but we have fullContent, show it directly
                          if (!hasStructuredContent && fullContent) {
                            return (
                              <div className="lesson-content-wrapper">
                                <div 
                                  className="lesson-html-content"
                                  dangerouslySetInnerHTML={{ __html: fullContent }}
                                />
                              </div>
                            );
                          }
                          
                          // Show structured sections if available
                          if (hasStructuredContent) {
                            return (
                              <>
                                {/* Introduction */}
                                {notes.introduction && (
                                  <div className="lesson-introduction">
                                    <div 
                                      className="lesson-html-content"
                                      dangerouslySetInnerHTML={{ __html: notes.introduction }}
                                    />
                                  </div>
                                )}
                                
                                {/* Subtopics */}
                                {notes.subtopics && notes.subtopics.length > 0 && (
                                  <div className="lesson-subtopics">
                                    {notes.subtopics.map((subtopic, index) => (
                                      <div key={index} className="subtopic-section">
                                        <h3>{subtopic.heading}</h3>
                                        <div 
                                          className="lesson-html-content"
                                          dangerouslySetInnerHTML={{ __html: subtopic.content }}
                                        />
                                      </div>
                                    ))}
                                  </div>
                                )}
                                
                                {/* Code Samples */}
                                {notes.codeSamples && notes.codeSamples.length > 0 && (
                                  <div className="lesson-code-samples">
                                    <h3>Code Examples</h3>
                                    {notes.codeSamples.map((sample, index) => (
                                      <div key={index} className="code-sample">
                                        <h4>{sample.title}</h4>
                                        <pre><code className={`language-${sample.language || 'python'}`}>{sample.code}</code></pre>
                                        {sample.explanation && <p className="code-explanation">{sample.explanation}</p>}
                                      </div>
                                    ))}
                                  </div>
                                )}
                                
                                {/* Practice Ideas */}
                                {notes.practiceIdeas && (
                                  <div className="lesson-practice">
                                    <h3>Practice Ideas</h3>
                                    <div 
                                      className="lesson-html-content"
                                      dangerouslySetInnerHTML={{ __html: notes.practiceIdeas }}
                                    />
                                  </div>
                                )}
                              </>
                            );
                          }
                          
                          // Final fallback: show fullContent if nothing else
                          if (fullContent) {
                            return (
                              <div className="lesson-content-wrapper">
                                <div 
                                  className="lesson-html-content"
                                  dangerouslySetInnerHTML={{ __html: fullContent }}
                                />
                              </div>
                            );
                          }
                          
                          return null;
                        })()}
                      </div>
                    )}
                    
                    {/* Fallback for old format (array of notes) - legacy support */}
                    {!loading && resources.notes && Array.isArray(resources.notes) && resources.notes.length > 0 && (
                      <div className="lesson-content">
                        {resources.notes.map((note, index) => {
                          const noteContent = note.content || note.Content || '';
                          const noteId = note.resourceId || note.ResourceId || index;
                          return (
                            <div key={noteId} className="lesson-content-wrapper">
                              <div 
                                className="lesson-html-content"
                                dangerouslySetInnerHTML={{ __html: noteContent }}
                              />
                            </div>
                          );
                        })}
                      </div>
                    )}
                    
                    {/* Fallback for lesson resource (old format) - legacy support */}
                    {!loading && !resources.notes && resources.lesson && (
                      <div className="lesson-content">
                        {chapterData?.chapterSummary && (
                          <div className="lesson-summary">
                            <p><em>{chapterData.chapterSummary}</em></p>
                          </div>
                        )}
                        <div className="lesson-content-wrapper">
                          <div 
                            className="lesson-html-content"
                            dangerouslySetInnerHTML={{ 
                              __html: resources.lesson.content || resources.lesson.Content || '' 
                            }}
                          />
                        </div>
                      </div>
                    )}
                    
                    {/* Empty state - show when no notes available at all */}
                    {!loading && !resources.notes && !resources.lesson && (
                      <div className="lesson-empty">
                        <p>No notes available for this chapter yet.</p>
                        {chapterData && (
                          <p style={{ fontSize: '0.85rem', color: '#666', marginTop: '0.5rem' }}>
                            Debug: chapterData exists but notes are not available. Check console for details.
                          </p>
                        )}
                      </div>
                    )}
                  </section>

                  {practiceLab && (
                    <section className="chapter-section practice-lab-section">
                      <h2>Code Garden Lab</h2>
                      <ChapterPracticeLab
                        instructions={practiceLab.instructions}
                        starterCode={practiceLab.starterCode}
                        language={practiceLab.language}
                        title={practiceLab.title}
                      />
                    </section>
                  )}

                  {practiceItems.length > 0 && (
                    <section className="chapter-section chapter-section--practice">
                      <h2>Practice Ideas</h2>
                      <ul className="practice-list">
                        {practiceItems.map((item) => {
                          const status = practiceStatuses[item] || 'seedling';
                          return (
                            <li key={item} className={`practice-card status-${status}`}>
                              <div className="practice-card__header">
                                <span className="practice-card__status">{statusLabels[status]}</span>
                                <button
                                  type="button"
                                  className="practice-card__action"
                                  onClick={() => handlePracticeStatus(item)}
                                >
                                  {status === 'seedling' && 'Mark as sprouting'}
                                  {status === 'sprouting' && 'Mark as blooming'}
                                  {status === 'bloom' && 'Start over'}
                                </button>
                              </div>
                              <p>{item}</p>
                            </li>
                          );
                        })}
                      </ul>
                    </section>
                  )}
                </>
              )}
            </>
          )}

          {activeTab === 'flashcards' && (
            <section className="chapter-section flashcard-section">
              <StudentFlashcardComponent
                chapterId={databaseChapterId}
                fallbackFlashcards={resources.flashcards?.flashcards || details.flashcards}
              />
            </section>
          )}

          {activeTab === 'challenges' && (
            <section className="chapter-section challenges-section">
              <div className="challenges-mode-selector">
                <button
                  type="button"
                  className={`mode-button ${challengeMode === 'practice' ? 'active' : ''}`}
                  onClick={() => setChallengeMode('practice')}
                >
                  🌱 Practice Challenges
                </button>
                <button
                  type="button"
                  className={`mode-button ${challengeMode === 'quiz' ? 'active' : ''}`}
                  onClick={() => setChallengeMode('quiz')}
                >
                  📝 Chapter Quiz
                </button>
              </div>
              
              {challengeMode === 'practice' ? (
                <StudentChallengeBoard 
                  chapterId={databaseChapterId}
                  fallbackQuestions={resources.quiz?.questions || details.challenges || []}
                />
              ) : (
                <StudentQuizComponent 
                  chapterId={databaseChapterId}
                  onQuizComplete={async (result) => {
                    console.log('Quiz completed:', result);
                    
                    // Check if the quiz was passed and next chapter should be unlocked
                    if (result.passed && nextChapter) {
                      // Refresh the unlock status for the next chapter
                      try {
                        const nextChapterDetails = getChapterDetails(nextChapter.id);
                        const nextDatabaseChapterId = nextChapterDetails?.databaseChapterId || getDatabaseChapterId(nextChapter.id);
                        
                        if (nextDatabaseChapterId) {
                          const unlockStatus = await api.students.isChapterUnlocked(nextDatabaseChapterId);
                          setNextChapterUnlocked(unlockStatus.unlocked || false);
                          
                          if (unlockStatus.unlocked) {
                            console.log('✅ Next chapter unlocked!');
                            // Show celebration with garden theme
                            setTimeout(() => {
                              alert(`🌱 Garden Path Unlocked! 🌱\n\nCongratulations! You've passed the quiz and unlocked:\n"${nextChapter.title}"\n\nReturn to your Garden Dashboard to see your progress bloom!`);
                            }, 500);
                          }
                        }
                      } catch (err) {
                        console.error('Failed to refresh chapter unlock status:', err);
                      }
                    }
                  }}
                />
              )}
            </section>
          )}

          {activeTab === 'help' && (
            <StudentHelpRequest chapterId={databaseChapterId} />
          )}
        </div>

        <div className="chapter-navigation">
          <button
            type="button"
            className="chapter-nav-button"
            onClick={() =>
              previousChapter
                ? navigate(`/chapters/${previousChapter.id}`)
                : navigate('/student-dashboard')
            }
          >
            {previousChapter ? `← ${previousChapter.title}` : 'Back to Dashboard'}
          </button>
          {nextChapter && (
            <button
              type="button"
              className={`chapter-nav-button ${!nextChapterUnlocked ? 'locked' : ''}`}
              onClick={() => {
                if (nextChapterUnlocked) {
                  navigate(`/chapters/${nextChapter.id}`);
                } else {
                  alert('🔒 This chapter is locked! Complete the quiz in the previous chapter with at least 70% to unlock it.');
                }
              }}
              disabled={!nextChapterUnlocked || unlockStatusLoading}
              title={!nextChapterUnlocked ? 'Complete the previous chapter quiz with at least 70% to unlock this chapter' : ''}
            >
              {unlockStatusLoading ? (
                'Checking...'
              ) : !nextChapterUnlocked ? (
                <>
                 {nextChapter.title} (Locked)
                </>
              ) : (
                `${nextChapter.title} →`
              )}
            </button>
          )}
        </div>
      </main>
    </>
  );
};

export default ChapterPage;


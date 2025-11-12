import React, { useMemo, useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import StudentHelpRequest from '../components/StudentHelpRequest';
import { gardenPathData } from '../data/curriculum.js';
import { getChapterDetails } from '../data/chapterDetails.js';
import { getDatabaseChapterId } from '../data/chapterIdMapping.js';
import { api } from '../services/apiService.js';
import '../styles/ChapterPage.css';
import StudentFlashcardComponent from '../components/StudentFlashcardComponent.jsx';
import StudentChallengeBoard from '../components/StudentChallengeBoard.jsx';
import ChapterPracticeLab from '../components/ChapterPracticeLab.jsx';

const ChapterPage = () => {
  const { chapterId } = useParams();
  const navigate = useNavigate();

  // Convert URL numeric ID to database GUID
  const numericId = Number(chapterId);
  const databaseChapterId = getDatabaseChapterId(numericId);
  
  // Fallback static data (for UI structure and navigation)
  const metadata = useMemo(
    () => gardenPathData.find((chapter) => chapter.id === numericId),
    [numericId],
  );
  const details = useMemo(() => getChapterDetails(numericId), [numericId]);

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
  
  // State for database content from "Master Key" endpoint
  const [chapterData, setChapterData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

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
        const data = await api.students.getChapterContent(databaseChapterId);
        console.log('✅ Loaded chapter data from backend:', data);
        
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

  // Filter and organize resources by type using useMemo
  const resources = useMemo(() => {
    if (!chapterData?.content) return { lesson: null, flashcards: null, quiz: null };
    
    return {
      lesson: chapterData.content.find(r => r.type === 'text' || r.type === 'lesson'),
      flashcards: chapterData.content.find(r => r.type === 'flashcard'),
      quiz: chapterData.content.find(r => r.type === 'mcq')
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

              <section className="chapter-section chapter-section--lesson">
                <h2>In This Lesson</h2>
                
                {loading && (
                  <div className="lesson-loading">
                    🌱 Loading chapter content...
                  </div>
                )}
                
                {!loading && resources.lesson?.content ? (
                  // ✅ RENDER DATABASE CONTENT (HTML from backend)
                  <>
                    {chapterData?.chapterSummary && (
                      <div className="lesson-summary">
                        <p><em>{chapterData.chapterSummary}</em></p>
                      </div>
                    )}
                    <div 
                      className="lesson-database-content"
                      dangerouslySetInnerHTML={{ __html: resources.lesson.content }}
                    />
                  </>
                ) : !loading ? (
                  // ⚠️ FALLBACK TO STATIC CONTENT when backend unavailable
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
                ) : null}
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
              <StudentChallengeBoard 
                chapterId={databaseChapterId}
                fallbackQuestions={resources.quiz?.questions || details.challenges || []}
              />
            </section>
          )}

          {activeTab === 'help' && (
            <StudentHelpRequest chapterId={numericId} />
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
              className="chapter-nav-button"
              onClick={() => navigate(`/chapters/${nextChapter.id}`)}
            >
              {nextChapter.title} →
            </button>
          )}
        </div>
      </main>
    </>
  );
};

export default ChapterPage;


import React, { useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import { gardenPathData } from '../data/curriculum.js';
import { getChapterDetails } from '../data/chapterDetails.js';
import '../styles/ChapterPage.css';

const ChapterPage = () => {
  const { chapterId } = useParams();
  const navigate = useNavigate();

  const numericId = Number(chapterId);
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

  const [activeTab, setActiveTab] = useState('notes');
  const [flashcardIndex, setFlashcardIndex] = useState(0);
  const [showAnswer, setShowAnswer] = useState(false);
  const [activeDifficulty, setActiveDifficulty] = useState('easy');

  const flashcards = details?.flashcards ?? [];
  const questions = details?.questions ?? { easy: [], medium: [], hard: [] };

  const handleNextFlashcard = () => {
    if (flashcards.length === 0) return;
    setFlashcardIndex((prev) => (prev + 1) % flashcards.length);
    setShowAnswer(false);
  };

  const handlePrevFlashcard = () => {
    if (flashcards.length === 0) return;
    setFlashcardIndex((prev) => (prev - 1 + flashcards.length) % flashcards.length);
    setShowAnswer(false);
  };

  const currentFlashcard = flashcards[flashcardIndex];

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
        </div>

        <div className="chapter-content-panel">
          {activeTab === 'notes' && (
            <>
              <section className="chapter-section">
                <h2>Learning Objectives</h2>
                <ul>
                  {details.learningObjectives.map((objective) => (
                    <li key={objective}>{objective}</li>
                  ))}
                </ul>
              </section>

              <section className="chapter-section">
                <h2>In This Lesson</h2>
                {details.sections.map((section) => (
                  <article key={section.heading} className="chapter-article">
                    <h3>{section.heading}</h3>
                    {section.body.map((paragraph, index) => (
                      <p key={index}>{paragraph}</p>
                    ))}
                  </article>
                ))}
              </section>

              {details.practice && (
                <section className="chapter-section">
                  <h2>Practice Ideas</h2>
                  <ul>
                    {details.practice.map((item) => (
                      <li key={item}>{item}</li>
                    ))}
                  </ul>
                </section>
              )}
            </>
          )}

          {activeTab === 'flashcards' && (
            <section className="chapter-section flashcard-section">
              {flashcards.length === 0 ? (
                <p>No flashcards added yet. Check back soon!</p>
              ) : (
                <>
                  <div className="flashcard-progress">
                    Card {flashcardIndex + 1} of {flashcards.length}
                  </div>
                  <div className={`flashcard ${showAnswer ? 'show-answer' : ''}`}>
                    <div className="flashcard-face">
                      <h3>Prompt</h3>
                      <p>{currentFlashcard?.prompt}</p>
                    </div>
                    <div className="flashcard-face flashcard-answer">
                      <h3>Answer</h3>
                      <p>{currentFlashcard?.answer}</p>
                    </div>
                  </div>
                  <div className="flashcard-actions">
                    <button type="button" onClick={handlePrevFlashcard}>
                      ‹ Prev
                    </button>
                    <button type="button" onClick={() => setShowAnswer((prev) => !prev)}>
                      {showAnswer ? 'Hide Answer' : 'Reveal Answer'}
                    </button>
                    <button type="button" onClick={handleNextFlashcard}>
                      Next ›
                    </button>
                  </div>
                </>
              )}
            </section>
          )}

          {activeTab === 'challenges' && (
            <section className="chapter-section challenges-section">
              <div className="difficulty-toggle">
                {['easy', 'medium', 'hard'].map((level) => (
                  <button
                    key={level}
                    type="button"
                    className={`difficulty-button ${
                      activeDifficulty === level ? 'active' : ''
                    }`}
                    onClick={() => setActiveDifficulty(level)}
                  >
                    {level.charAt(0).toUpperCase() + level.slice(1)}
                  </button>
                ))}
              </div>
              <div className="questions-grid">
                {(questions[activeDifficulty] ?? []).map((question) => (
                  <article key={question.id} className="question-card">
                    <h4>{question.prompt}</h4>
                    {question.options && (
                      <ul>
                        {question.options.map((option) => (
                          <li key={option}>{option}</li>
                        ))}
                      </ul>
                    )}
                  </article>
                ))}
                {(questions[activeDifficulty] ?? []).length === 0 && (
                  <p className="empty-state">Challenges coming soon.</p>
                )}
              </div>
            </section>
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
            disabled={!previousChapter}
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


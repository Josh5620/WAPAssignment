import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';
import '../styles/StudentFlashcardComponent.css';

const normalizeFlashcards = (cards = []) =>
  cards.map((card, index) => ({
    id: card.id || `card-${index}`,
    frontText: card.frontText || card.front || card.prompt || '',
    backText: card.backText || card.back || card.answer || '',
  }));

const FlashcardComponent = ({ chapterId, fallbackFlashcards = [] }) => {
  const [flashcards, setFlashcards] = useState(normalizeFlashcards(fallbackFlashcards));
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(fallbackFlashcards.length === 0);
  const [error, setError] = useState(null);
  const [usingFallback, setUsingFallback] = useState(fallbackFlashcards.length > 0);

  useEffect(() => {
    setFlashcards(normalizeFlashcards(fallbackFlashcards));
    setCurrentIndex(0);
    setIsFlipped(false);
    setUsingFallback(fallbackFlashcards.length > 0);
  }, [fallbackFlashcards]);

  useEffect(() => {
    if (chapterId) {
      loadFlashcards();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [chapterId]);

  const loadFlashcards = async () => {
    try {
      setLoading(true);
      const data = await api.students.getFlashcards(chapterId);
      const normalized = normalizeFlashcards(data);

      if (normalized.length > 0) {
        setFlashcards(normalized);
        setUsingFallback(false);
        setError(null);
      } else if (fallbackFlashcards.length > 0) {
        setFlashcards(normalizeFlashcards(fallbackFlashcards));
        setUsingFallback(true);
        setError(null);
      } else {
        setFlashcards([]);
        setError('No flashcards available for this chapter yet.');
      }

      setCurrentIndex(0);
      setIsFlipped(false);
    } catch (err) {
      console.error('Failed to load flashcards:', err);
      if (fallbackFlashcards.length > 0) {
        setFlashcards(normalizeFlashcards(fallbackFlashcards));
        setUsingFallback(true);
        setError(null);
      } else {
        setError('Failed to load flashcards. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleFlip = () => {
    setIsFlipped(!isFlipped);
  };

  const handleNext = () => {
    if (currentIndex < flashcards.length - 1) {
      setCurrentIndex((prev) => prev + 1);
      setIsFlipped(false);
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex((prev) => prev - 1);
      setIsFlipped(false);
    }
  };

  const handleShuffle = () => {
    const shuffled = [...flashcards].sort(() => Math.random() - 0.5);
    setFlashcards(shuffled);
    setCurrentIndex(0);
    setIsFlipped(false);
  };

  if (loading) {
    return <div className="flashcard-loading">Loading flashcards...</div>;
  }

  if (error) {
    return (
      <div className="flashcard-error">
        <p>{error}</p>
        <button onClick={loadFlashcards}>Retry</button>
      </div>
    );
  }

  if (flashcards.length === 0) {
    return <div className="flashcard-empty">No flashcards available for this chapter.</div>;
  }

  const nextIndex = (index) => (index + flashcards.length) % flashcards.length;

  return (
    <div className="flashcard-component">
      <div className="flashcard-header">
        <h3>Flashcards</h3>
        <div className="flashcard-progress">
          Card {currentIndex + 1} of {flashcards.length}
        </div>
      </div>

      {usingFallback && (
        <p className="flashcard-fallback-note">
          Showing sample flashcards while we grow the live set for this chapter.
        </p>
      )}

      <div className="flashcard-container">
        <div className={`flashcard ${isFlipped ? 'flipped' : ''}`} onClick={handleFlip}>
          <div className="flashcard-front">
            <div className="flashcard-label">Front</div>
            <div className="flashcard-content">
              {flashcards[currentIndex].frontText || 'No front text available'}
            </div>
            <div className="flashcard-hint">Click to flip</div>
          </div>
          <div className="flashcard-back">
            <div className="flashcard-label">Back</div>
            <div className="flashcard-content">
              {flashcards[currentIndex].backText || 'No back text available'}
            </div>
            <div className="flashcard-hint">Click to flip</div>
          </div>
        </div>
      </div>

      <div className="flashcard-actions">
        <button
          className="flashcard-button prev-button"
          onClick={handlePrevious}
          disabled={currentIndex === 0}
        >
          ← Previous
        </button>
        <button className="flashcard-button flip-button" onClick={handleFlip}>
          {isFlipped ? 'Show Front' : 'Show Back'}
        </button>
        <button
          className="flashcard-button next-button"
          onClick={handleNext}
          disabled={currentIndex === flashcards.length - 1}
        >
          Next →
        </button>
      </div>

      <div className="flashcard-secondary-actions">
        <button className="flashcard-button shuffle-button" onClick={handleShuffle}>
          Shuffle Cards
        </button>
      </div>
    </div>
  );
};

export default FlashcardComponent;


import React, { useState, useEffect, useMemo, useCallback, useRef } from 'react';
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
  const [seenCards, setSeenCards] = useState(() => new Set());
  const [showReward, setShowReward] = useState(false);
  const rewardTimeoutRef = useRef(null);

  useEffect(() => {
    setFlashcards(normalizeFlashcards(fallbackFlashcards));
    setCurrentIndex(0);
    setIsFlipped(false);
    setUsingFallback(fallbackFlashcards.length > 0);
    setSeenCards(new Set());
    setShowReward(false);
    if (rewardTimeoutRef.current) {
      clearTimeout(rewardTimeoutRef.current);
      rewardTimeoutRef.current = null;
    }
  }, [fallbackFlashcards]);

  const badgeLabel = useMemo(() => {
    const labels = ['Knowledge Seed', 'Growth Spark', 'Challenge Bloom', 'Fresh Sprout'];
    return labels[currentIndex % labels.length];
  }, [currentIndex]);

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

  const handleFlip = useCallback(() => {
    const nextFlipped = !isFlipped;
    setIsFlipped(nextFlipped);

    if (!isFlipped) {
      setSeenCards((prev) => {
        const updated = new Set(prev);
        updated.add(currentIndex);
        if (updated.size === flashcards.length) {
          setShowReward(true);
          if (rewardTimeoutRef.current) {
            clearTimeout(rewardTimeoutRef.current);
          }
          rewardTimeoutRef.current = setTimeout(() => {
            setShowReward(false);
            rewardTimeoutRef.current = null;
          }, 1800);
        }
        return updated;
      });
    }
  }, [currentIndex, flashcards.length, isFlipped]);

  const handleNext = useCallback(() => {
    setCurrentIndex((prev) => {
      if (prev < flashcards.length - 1) {
        setIsFlipped(false);
        return prev + 1;
      }
      return prev;
    });
  }, [flashcards.length]);

  const handlePrevious = useCallback(() => {
    setCurrentIndex((prev) => {
      if (prev > 0) {
        setIsFlipped(false);
        return prev - 1;
      }
      return prev;
    });
  }, []);

  const handleShuffle = useCallback(() => {
    const shuffled = [...flashcards].sort(() => Math.random() - 0.5);
    setFlashcards(shuffled);
    setCurrentIndex(0);
    setIsFlipped(false);
    setSeenCards(new Set());
    setShowReward(false);
  }, [flashcards]);

  useEffect(() => {
    const handleKey = (event) => {
      if (event.key === 'ArrowRight') {
        event.preventDefault();
        handleNext();
      } else if (event.key === 'ArrowLeft') {
        event.preventDefault();
        handlePrevious();
      } else if (event.key === ' ' || event.key === 'Spacebar') {
        event.preventDefault();
        handleFlip();
      }
    };

    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [handleNext, handlePrevious, handleFlip]);

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
    <div className="flashcard-component modern-stack-theme">
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

      <div className="flashcard-progress-dots">
        {flashcards.map((_, index) => (
          <span
            key={index}
            className={`flashcard-progress-dot ${index === currentIndex ? 'active' : ''} ${seenCards.has(index) ? 'seen' : ''}`}
          />
        ))}
      </div>

      <div className="flashcard-container">
        <div
          className={`flashcard ${isFlipped ? 'flipped revealed' : ''}`}
          onClick={handleFlip}
          role="button"
          tabIndex={0}
          onKeyDown={(event) => {
            if (event.key === 'Enter' || event.key === ' ') {
              event.preventDefault();
              handleFlip();
            }
          }}
          aria-label="Flashcard"
        >
          <div className="flashcard-badge">{badgeLabel}</div>
          <div className="flashcard-inner">
            <div className="flashcard-face flashcard-front">
              <div className="flashcard-content">
                {flashcards[currentIndex].frontText || 'No front text available'}
              </div>
              <div className="flashcard-hint">Tap to reveal the answer</div>
            </div>
            <div className="flashcard-face flashcard-back">
              <div className="flashcard-content">
                {flashcards[currentIndex].backText || 'No back text available'}
              </div>
              <div className="flashcard-hint">Tap to view the prompt</div>
            </div>
          </div>
        </div>
        {showReward && <div className="flashcard-reward" aria-hidden="true" />}
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


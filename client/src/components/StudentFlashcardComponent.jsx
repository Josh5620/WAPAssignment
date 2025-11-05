import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';

const FlashcardComponent = ({ chapterId }) => {
const [flashcards, setFlashcards] = useState([]);
const [currentIndex, setCurrentIndex] = useState(0);
const [isFlipped, setIsFlipped] = useState(false);
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);

useEffect(() => {
    if (chapterId) {
    loadFlashcards();
    }
}, [chapterId]);

const loadFlashcards = async () => {
    try {
    setLoading(true);
    const data = await api.students.getFlashcards(chapterId);
    setFlashcards(data);
    setCurrentIndex(0);
    setIsFlipped(false);
    setError(null);
    } catch (err) {
    console.error('Failed to load flashcards:', err);
    setError('Failed to load flashcards. Please try again.');
    } finally {
    setLoading(false);
    }
};

const handleFlip = () => {
    setIsFlipped(!isFlipped);
};

const handleNext = () => {
    if (currentIndex < flashcards.length - 1) {
    setCurrentIndex(currentIndex + 1);
    setIsFlipped(false);
    }
};

const handlePrevious = () => {
    if (currentIndex > 0) {
    setCurrentIndex(currentIndex - 1);
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

const currentCard = flashcards[currentIndex];

return (
    <div className="flashcard-component">
    <div className="flashcard-header">
        <h3>Flashcards</h3>
        <div className="flashcard-progress">
        Card {currentIndex + 1} of {flashcards.length}
        </div>
    </div>

    <div className="flashcard-container">
        <div
        className={`flashcard ${isFlipped ? 'flipped' : ''}`}
        onClick={handleFlip}
        >
        <div className="flashcard-front">
            <div className="flashcard-label">Front</div>
            <div className="flashcard-content">
            {currentCard.frontText || 'No front text available'}
            </div>
            <div className="flashcard-hint">Click to flip</div>
        </div>
        <div className="flashcard-back">
            <div className="flashcard-label">Back</div>
            <div className="flashcard-content">
            {currentCard.backText || 'No back text available'}
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
        <button
        className="flashcard-button flip-button"
        onClick={handleFlip}
        >
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
        <button
        className="flashcard-button shuffle-button"
        onClick={handleShuffle}
        >
        Shuffle Cards
        </button>
    </div>
    </div>
);
};

export default FlashcardComponent;


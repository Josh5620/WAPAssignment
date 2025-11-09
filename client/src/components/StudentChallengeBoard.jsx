import React, { useEffect, useMemo, useState } from 'react';
import { getChapterChallenges } from '../data/chapterChallenges';
import '../styles/StudentChallengeBoard.css';

const DIFFICULTIES = [
  { key: 'easy', label: 'Sprout Patch', theme: 'sprout', hint: 'Easy' },
  { key: 'medium', label: 'Vine Trellis', theme: 'vine', hint: 'Medium' },
  { key: 'hard', label: 'Bloom Bed', theme: 'bloom', hint: 'Hard' },
];

const difficultyLabels = {
  easy: 'Sprout Patch (Easy)',
  medium: 'Vine Trellis (Medium)',
  hard: 'Bloom Bed (Hard)',
};

const TIMER_SECONDS = 60;

const StudentChallengeBoard = ({ chapterId }) => {
  const challengeData = useMemo(() => getChapterChallenges(chapterId), [chapterId]);
  const [selectedDifficulty, setSelectedDifficulty] = useState('easy');
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState(null);
  const [isCorrect, setIsCorrect] = useState(null);
  const [growthMode, setGrowthMode] = useState(false);
  const [timeLeft, setTimeLeft] = useState(TIMER_SECONDS);
  const [streak, setStreak] = useState(0);
  const [progress, setProgress] = useState({
    easy: { completed: 0, correct: 0, xpEarned: 0 },
    medium: { completed: 0, correct: 0, xpEarned: 0 },
    hard: { completed: 0, correct: 0, xpEarned: 0 },
  });

  const questions = challengeData[selectedDifficulty] || [];
  const totalQuestions = questions.length;
  const currentQuestion = questions[currentIndex];

  useEffect(() => {
    setCurrentIndex(0);
    setSelectedOption(null);
    setIsCorrect(null);
    setTimeLeft(TIMER_SECONDS);
    setStreak(0);
  }, [selectedDifficulty, challengeData]);

  useEffect(() => {
    if (!growthMode || !currentQuestion) return;

    setTimeLeft(TIMER_SECONDS);
    const interval = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          clearInterval(interval);
          handleTimesUp();
          return TIMER_SECONDS;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [growthMode, currentQuestion?.id, selectedDifficulty, currentIndex]);

  const handleTimesUp = () => {
    setSelectedOption(null);
    setIsCorrect(false);
    updateProgress(false);
  };

  const handleOptionSelect = (optionIndex) => {
    if (!currentQuestion || selectedOption !== null) return;

    setSelectedOption(optionIndex);
    const correct = optionIndex === currentQuestion.answer;
    setIsCorrect(correct);
    updateProgress(correct);
    if (growthMode) {
      setStreak((prev) => (correct ? prev + 1 : 0));
    }
  };

  const updateProgress = (correct) => {
    setProgress((prev) => {
      const next = { ...prev };
      const earnedXp = correct ? currentQuestion?.xp ?? 0 : 0;
      next[selectedDifficulty] = {
        completed: Math.min(totalQuestions, next[selectedDifficulty].completed + 1),
        correct: correct ? next[selectedDifficulty].correct + 1 : next[selectedDifficulty].correct,
        xpEarned: next[selectedDifficulty].xpEarned + earnedXp,
      };
      return next;
    });
  };

  const handleNext = () => {
    if (currentIndex < totalQuestions - 1) {
      setCurrentIndex((prev) => prev + 1);
    } else {
      setCurrentIndex(0);
    }
    setSelectedOption(null);
    setIsCorrect(null);
    setTimeLeft(TIMER_SECONDS);
  };

  const handleToggleGrowthMode = () => {
    setGrowthMode((prev) => !prev);
    setStreak(0);
    setTimeLeft(TIMER_SECONDS);
  };

  const difficultyProgress = (key) => {
    const { completed, correct, xpEarned } = progress[key] || { completed: 0, correct: 0, xpEarned: 0 };
    const total = challengeData[key]?.length || 0;
    const totalXp = (challengeData[key] || []).reduce((sum, q) => sum + (q.xp ?? 0), 0);
    return {
      completed,
      correct,
      total,
      xpEarned,
      totalXp,
      growthLevel: total ? Math.min(3, Math.floor((correct / total) * 3) + 1) : 1,
    };
  };

  if (!currentQuestion) {
    return (
      <div className="challenge-board">
        <p className="challenge-empty">Challenges coming soon for this chapter.</p>
      </div>
    );
  }

  return (
    <div className="challenge-board">
      <div className="challenge-map">
        {DIFFICULTIES.map(({ key, label, theme, hint }) => {
          const { correct, total, xpEarned, totalXp, growthLevel } = difficultyProgress(key);
          const isActive = key === selectedDifficulty;
          return (
            <button
              type="button"
              key={key}
              className={`challenge-plot challenge-plot--${theme} ${isActive ? 'is-active' : ''} growth-level-${growthLevel}`}
              onClick={() => setSelectedDifficulty(key)}
            >
              <span className="plot-label">{label}</span>
              <span className="plot-hint">{hint}</span>
              <span className="plot-stats">
                {correct}/{total || '?'} cultivated · {xpEarned}/{totalXp || 0} XP
              </span>
            </button>
          );
        })}
      </div>
      <p className="challenge-legend">
        🌱 Sprout Patch (Easy) · 🌿 Vine Trellis (Medium) · 🌸 Bloom Bed (Hard)
      </p>

      <div className="challenge-controls">
        <div className="growth-mode-toggle">
          <label>
            <input type="checkbox" checked={growthMode} onChange={handleToggleGrowthMode} />
            <span>Growth Spurt Mode (timed)</span>
          </label>
          {growthMode && (
            <div className="growth-timer">
              <span role="img" aria-label="timer">
                ⏱
              </span>{' '}
              {timeLeft}s
            </div>
          )}
        </div>
        {growthMode && <p className="streak-indicator">Streak: {streak}</p>}
      </div>

      <div className="challenge-card">
        <header className={`challenge-card__header difficulty-${selectedDifficulty}`}>
          <span className="challenge-xp">{difficultyLabels[selectedDifficulty]}</span>
          <span className="challenge-number">
            {currentIndex + 1} / {totalQuestions}
          </span>
        </header>
        <div className="challenge-card__body">
          <h3>{currentQuestion.prompt}</h3>
          <div className="challenge-options">
            {currentQuestion.options.map((option, index) => {
              const isSelected = selectedOption === index;
              const correctOption = isCorrect !== null && index === currentQuestion.answer;
              const incorrectOption = isSelected && !correctOption;
              return (
                <button
                  key={option}
                  type="button"
                  className={`challenge-option ${isSelected ? 'is-selected' : ''} ${
                    correctOption ? 'is-correct' : ''
                  } ${incorrectOption ? 'is-incorrect' : ''}`}
                  onClick={() => handleOptionSelect(index)}
                  disabled={selectedOption !== null}
                >
                  <span className="option-letter">{String.fromCharCode(65 + index)}</span>
                  <span>{option}</span>
                </button>
              );
            })}
          </div>

          {isCorrect !== null && (
            <div className={`challenge-feedback ${isCorrect ? 'success' : 'error'}`}>
              {isCorrect ? (
                <p>
                  🌱 Great work! <strong>{currentQuestion.xp ?? 15} XP</strong> added to your garden.
                </p>
              ) : (
                <p>
                  🍂 Almost there! The correct answer is{' '}
                  <strong>{currentQuestion.options[currentQuestion.answer]}</strong>.
                </p>
              )}
              {currentQuestion.explanation && <p className="challenge-explanation">{currentQuestion.explanation}</p>}
              <button type="button" className="challenge-next" onClick={handleNext}>
                {currentIndex < totalQuestions - 1 ? 'Next Challenge →' : 'Restart Patch ↻'}
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default StudentChallengeBoard;



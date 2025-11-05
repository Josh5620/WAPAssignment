import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';

const QuizComponent = ({ chapterId, onQuizComplete }) => {
const [questions, setQuestions] = useState([]);
const [selectedAnswers, setSelectedAnswers] = useState({});
const [submitted, setSubmitted] = useState(false);
const [results, setResults] = useState(null);
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);
const [hints, setHints] = useState({});

useEffect(() => {
    if (chapterId) {
    loadQuizQuestions();
    }
}, [chapterId]);

const loadQuizQuestions = async () => {
    try {
    setLoading(true);
      const data = await api.students.getQuizQuestions(chapterId);
      setQuestions(data);
      setError(null);
    } catch (err) {
      console.error('Failed to load quiz questions:', err);
      setError('Failed to load quiz questions. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleAnswerSelect = (questionId, optionId) => {
    if (submitted) return;
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: optionId
    }));
  };

  const handleGetHint = async (questionId) => {
    try {
      const hintData = await api.students.getQuestionHint(questionId);
      setHints(prev => ({
        ...prev,
        [questionId]: hintData.hint
      }));
    } catch (err) {
      console.error('Failed to get hint:', err);
      alert('Failed to get hint. Please try again.');
    }
  };

  const handleSubmit = async () => {
    const userProfile = quickApi.getUserProfile();
    if (!userProfile || !userProfile.id) {
      alert('Please log in to submit the quiz.');
      return;
    }

    const answers = Object.entries(selectedAnswers).map(([questionId, optionId]) => ({
      questionId,
      selectedOptionId: optionId
    }));

    if (answers.length === 0) {
      alert('Please answer at least one question before submitting.');
      return;
    }

    try {
      setLoading(true);
      const result = await api.students.submitQuiz(userProfile.id, chapterId, answers);
      setResults(result);
      setSubmitted(true);
      
      if (onQuizComplete) {
        onQuizComplete(result);
      }
    } catch (err) {
      console.error('Failed to submit quiz:', err);
      setError('Failed to submit quiz. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (loading && questions.length === 0) {
    return <div className="quiz-loading">Loading quiz questions...</div>;
  }

  if (error) {
    return (
      <div className="quiz-error">
        <p>{error}</p>
        <button onClick={loadQuizQuestions}>Retry</button>
      </div>
    );
  }

  if (questions.length === 0) {
    return <div className="quiz-empty">No quiz questions available for this chapter.</div>;
  }

  return (
    <div className="quiz-component">
      <div className="quiz-header">
        <h3>Chapter Quiz</h3>
        {!submitted && (
          <p className="quiz-instructions">
            Answer all questions to test your understanding. You can get hints if needed.
          </p>
        )}
      </div>

      <div className="quiz-questions">
        {questions.map((question, index) => {
          const questionResult = (results?.results || results?.Results || []).find(r => r.questionId === question.questionId);
          
          return (
          <div key={question.questionId} className="quiz-question">
            <div className="question-header">
              <span className="question-number">Question {index + 1}</span>
              <span className="question-difficulty">{question.difficulty}</span>
            </div>
            
            <p className="question-stem">{question.stem}</p>

            {hints[question.questionId] && (
              <div className="question-hint">
                <strong>💡 Hint:</strong> {hints[question.questionId]}
              </div>
            )}

            <div className="question-options">
              {question.options.map((option) => {
                const isSelected = selectedAnswers[question.questionId] === option.optionId;
                const isCorrect = questionResult?.isCorrect;
                const isIncorrect = questionResult && !questionResult.isCorrect;
                const showCorrect = submitted && questionResult?.correctOptionId === option.optionId;

                return (
                  <label
                    key={option.optionId}
                    className={`option-label ${isSelected ? 'selected' : ''} ${submitted && showCorrect ? 'correct' : ''} ${submitted && isIncorrect && isSelected ? 'incorrect' : ''}`}
                  >
                    <input
                      type="radio"
                      name={`question-${question.questionId}`}
                      value={option.optionId}
                      checked={isSelected}
                      onChange={() => handleAnswerSelect(question.questionId, option.optionId)}
                      disabled={submitted}
                    />
                    <span>{option.optionText}</span>
                    {submitted && showCorrect && <span className="correct-mark">✓</span>}
                    {submitted && isIncorrect && isSelected && <span className="incorrect-mark">✗</span>}
                  </label>
                );
              })}
            </div>

            {questionResult?.explanation && (
              <div className="question-explanation">
                <strong>Explanation:</strong> {questionResult.explanation}
              </div>
            )}

            {!submitted && (
              <button
                className="hint-button"
                onClick={() => handleGetHint(question.questionId)}
              >
                Get Hint
              </button>
            )}
          </div>
          );
        })}
      </div>

      {submitted && results && (
        <div className="quiz-results">
          <div className="results-summary">
            <h4>Quiz Results</h4>
            <div className="results-stats">
              <p>Score: <strong>{results.totalCorrect} / {results.totalQuestions}</strong></p>
              <p>Percentage: <strong>{results.score.toFixed(1)}%</strong></p>
              <p>XP Awarded: <strong>+{results.xpAwarded}</strong></p>
            </div>
          </div>
        </div>
      )}

      {!submitted && (
        <div className="quiz-actions">
          <button
            className="submit-quiz-button"
            onClick={handleSubmit}
            disabled={loading || Object.keys(selectedAnswers).length === 0}
          >
            {loading ? 'Submitting...' : 'Submit Quiz'}
          </button>
        </div>
      )}
    </div>
  );
};

export default QuizComponent;


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
      // Handle both camelCase and PascalCase
      const hint = hintData.hint || hintData.Hint;
      setHints(prev => ({
        ...prev,
        [questionId]: hint
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
          // Handle both camelCase and PascalCase property names
          const qId = question.questionId || question.QuestionId;
          const qStem = question.stem || question.Stem;
          const qDifficulty = question.difficulty || question.Difficulty;
          const qOptions = question.options || question.Options || [];
          
          // Find matching result - handle both camelCase and PascalCase
          const resultsArray = results?.results || results?.Results || [];
          const questionResult = resultsArray.find(r => {
            const rId = r.questionId || r.QuestionId;
            return rId === qId;
          });
          
          return (
          <div key={qId} className="quiz-question">
            <div className="question-header">
              <span className="question-number">Question {index + 1}</span>
              <span className="question-difficulty">{qDifficulty}</span>
            </div>
            
            <p className="question-stem">{qStem}</p>

            {hints[qId] && (
              <div className="question-hint">
                <strong>💡 Hint:</strong> {hints[qId]}
              </div>
            )}

            <div className="question-options">
              {qOptions.map((option) => {
                const optId = option.optionId || option.OptionId;
                const optText = option.optionText || option.OptionText;
                const isSelected = selectedAnswers[qId] === optId;
                
                // Handle both camelCase and PascalCase for result properties
                const isCorrect = questionResult?.isCorrect || questionResult?.IsCorrect;
                const isIncorrect = questionResult && !(questionResult.isCorrect || questionResult.IsCorrect);
                const correctOptId = questionResult?.correctOptionId || questionResult?.CorrectOptionId;
                const showCorrect = submitted && correctOptId === optId;

                return (
                  <label
                    key={optId}
                    className={`option-label ${isSelected ? 'selected' : ''} ${submitted && showCorrect ? 'correct' : ''} ${submitted && isIncorrect && isSelected ? 'incorrect' : ''}`}
                  >
                    <input
                      type="radio"
                      name={`question-${qId}`}
                      value={optId}
                      checked={isSelected}
                      onChange={() => handleAnswerSelect(qId, optId)}
                      disabled={submitted}
                    />
                    <span>{optText}</span>
                    {submitted && showCorrect && <span className="correct-mark">✓</span>}
                    {submitted && isIncorrect && isSelected && <span className="incorrect-mark">✗</span>}
                  </label>
                );
              })}
            </div>

            {(questionResult?.explanation || questionResult?.Explanation) && (
              <div className="question-explanation">
                <strong>Explanation:</strong> {questionResult.explanation || questionResult.Explanation}
              </div>
            )}

            {!submitted && (
              <button
                className="hint-button"
                onClick={() => handleGetHint(qId)}
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
              <p>Score: <strong>{results.totalCorrect || results.TotalCorrect} / {results.totalQuestions || results.TotalQuestions}</strong></p>
              <p>Percentage: <strong>{(results.score || results.Score || 0).toFixed(1)}%</strong></p>
              <p>XP Awarded: <strong>+{results.xpAwarded || results.XPAwarded || 0}</strong></p>
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


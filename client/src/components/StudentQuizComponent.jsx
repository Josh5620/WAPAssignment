import React, { useState, useEffect, useRef } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';
import '../styles/StudentQuizComponent.css';

const QuizComponent = ({ chapterId, onQuizComplete }) => {
  const [questions, setQuestions] = useState([]);
  const [selectedAnswers, setSelectedAnswers] = useState({});
  const [textAnswers, setTextAnswers] = useState({});
  const [submitted, setSubmitted] = useState(false);
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [hints, setHints] = useState({});
  
  // Advanced features state
  const [quizInfo, setQuizInfo] = useState(null);
  const [attemptId, setAttemptId] = useState(null);
  const [timeLeft, setTimeLeft] = useState(null);
  const [timeSpent, setTimeSpent] = useState(0);
  const [quizStarted, setQuizStarted] = useState(false);
  const [quizHistory, setQuizHistory] = useState([]);
  const [showHistory, setShowHistory] = useState(false);
  const [canAttempt, setCanAttempt] = useState(true);
  
  const timerIntervalRef = useRef(null);
  const startTimeRef = useRef(null);

  useEffect(() => {
    if (chapterId) {
      loadQuizData();
    }
    return () => {
      if (timerIntervalRef.current) {
        clearInterval(timerIntervalRef.current);
      }
    };
  }, [chapterId]);

  const loadQuizData = async () => {
    try {
      setLoading(true);
      setError(null);
      
      // Load quiz info (time limit, attempt limits)
      const info = await api.students.getQuizInfo(chapterId);
      setQuizInfo(info);
      setCanAttempt(info.canAttempt);
      
      if (!info.canAttempt) {
        setError(`Maximum attempts (${info.maxAttempts}) reached for this quiz.`);
        setLoading(false);
        return;
      }
      
      // Load quiz history
      const history = await api.students.getQuizHistory(chapterId);
      setQuizHistory(history.attempts || []);
      
      // Load questions
      const data = await api.students.getQuizQuestions(chapterId);
      console.log('Loaded quiz questions:', data);
      // Ensure data is an array
      const questionsArray = Array.isArray(data) ? data : (data?.questions || []);
      setQuestions(questionsArray);
      
      if (questionsArray.length === 0) {
        setError('No questions found for this chapter. Please add questions first.');
      }
    } catch (err) {
      console.error('Failed to load quiz data:', err);
      setError(err.message || 'Failed to load quiz. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleStartQuiz = async () => {
    if (questions.length === 0) {
      alert('No questions available. Please add questions to this chapter first.');
      return;
    }
    
    try {
      setLoading(true);
      setError(null);
      const result = await api.students.startQuiz(chapterId);
      console.log('Quiz started:', result);
      setAttemptId(result.attemptId || result.attempt?.attemptId);
      setQuizStarted(true);
      
      // Initialize timer if time limit exists
      if (result.timeLimitSeconds) {
        setTimeLeft(result.timeLimitSeconds);
        startTimeRef.current = Date.now();
        
        timerIntervalRef.current = setInterval(() => {
          setTimeSpent(prev => {
            const elapsed = Math.floor((Date.now() - startTimeRef.current) / 1000);
            const remaining = result.timeLimitSeconds - elapsed;
            
            if (remaining <= 0) {
              clearInterval(timerIntervalRef.current);
              handleTimeUp();
              return result.timeLimitSeconds;
            }
            
            setTimeLeft(remaining);
            return elapsed;
          });
        }, 1000);
      } else {
        // No time limit, just track time spent
        startTimeRef.current = Date.now();
        timerIntervalRef.current = setInterval(() => {
          setTimeSpent(Math.floor((Date.now() - startTimeRef.current) / 1000));
        }, 1000);
      }
    } catch (err) {
      console.error('Failed to start quiz:', err);
      setError(err.message || 'Failed to start quiz. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleTimeUp = () => {
    alert('Time is up! Submitting your quiz automatically...');
    handleSubmit(true);
  };

  const handleAnswerSelect = (questionId, value, questionType) => {
    if (submitted || !quizStarted) return;
    
    if (questionType === 'short_answer' || questionType === 'essay') {
      setTextAnswers(prev => ({
        ...prev,
        [questionId]: value
      }));
    } else {
      setSelectedAnswers(prev => ({
        ...prev,
        [questionId]: value
      }));
    }
  };

  const handleGetHint = async (questionId) => {
    try {
      const hintData = await api.students.getQuestionHint(questionId);
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

  const handleSubmit = async (autoSubmit = false) => {
    if (!quizStarted && !autoSubmit) {
      alert('Please start the quiz first.');
      return;
    }

    // Stop timer
    if (timerIntervalRef.current) {
      clearInterval(timerIntervalRef.current);
      timerIntervalRef.current = null;
    }

    // Calculate final time spent
    const finalTimeSpent = startTimeRef.current 
      ? Math.floor((Date.now() - startTimeRef.current) / 1000)
      : timeSpent;

    // Build answers array supporting different question types
    const answers = questions.map(question => {
      const qId = question.questionId || question.QuestionId;
      const qType = question.questionType || question.QuestionType || 'multiple_choice';
      
      if (qType === 'short_answer' || qType === 'essay') {
        return {
          questionId: qId,
          textAnswer: textAnswers[qId] || ''
        };
      } else if (qType === 'true_false') {
        return {
          questionId: qId,
          selectedOptionId: selectedAnswers[qId] || ''
        };
      } else {
        // Multiple choice
        return {
          questionId: qId,
          selectedOptionId: selectedAnswers[qId] || ''
        };
      }
    }).filter(answer => {
      // Only include answered questions
      return answer.selectedOptionId || answer.textAnswer;
    });

    if (answers.length === 0 && !autoSubmit) {
      alert('Please answer at least one question before submitting.');
      return;
    }

    try {
      setLoading(true);
      const result = await api.students.submitQuiz(
        chapterId, 
        answers, 
        finalTimeSpent, 
        attemptId
      );
      
      setResults(result);
      setSubmitted(true);
      setTimeLeft(null);
      
      // Reload quiz info and history
      await loadQuizData();
      
      if (onQuizComplete) {
        onQuizComplete(result);
      }
    } catch (err) {
      console.error('Failed to submit quiz:', err);
      setError(err.message || 'Failed to submit quiz. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const formatTime = (seconds) => {
    if (seconds === null) return '--:--';
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // Show loading state
  if (loading && !quizStarted && questions.length === 0 && !quizInfo) {
    return <div className="quiz-loading">Loading quiz...</div>;
  }

  // Show error if can't attempt
  if (error && !canAttempt && !quizStarted) {
    return (
      <div className="quiz-error">
        <p>{error}</p>
        {quizHistory.length > 0 && (
          <div className="quiz-history-summary">
            <h4>Your Quiz History</h4>
            <ul>
              {quizHistory.map((attempt, idx) => (
                <li key={idx}>
                  Attempt {idx + 1}: {attempt.scorePercentage}% 
                  {attempt.passed ? ' ✓ Passed' : ' ✗ Failed'}
                  {attempt.timeSpentSeconds && ` (${formatTime(attempt.timeSpentSeconds)})`}
                </li>
              ))}
            </ul>
          </div>
        )}
        <button onClick={loadQuizData}>Refresh</button>
      </div>
    );
  }

  // Show start screen if quiz hasn't started
  if (!quizStarted) {
    return (
      <div className="quiz-component">
        <div className="quiz-header">
          <h3>Chapter Quiz</h3>
          {quizInfo && (
            <div className="quiz-info">
              <p><strong>Total Questions:</strong> {quizInfo.totalQuestions || questions.length}</p>
              {quizInfo.timeLimitSeconds && (
                <p><strong>Time Limit:</strong> {formatTime(quizInfo.timeLimitSeconds)}</p>
              )}
              {quizInfo.maxAttempts && (
                <p>
                  <strong>Attempts:</strong> {quizInfo.currentAttemptCount} / {quizInfo.maxAttempts}
                  {quizInfo.remainingAttempts !== null && (
                    <span> ({quizInfo.remainingAttempts} remaining)</span>
                  )}
                </p>
              )}
            </div>
          )}
          
          {quizHistory.length > 0 && (
            <div className="quiz-history-toggle">
              <button 
                type="button"
                onClick={() => setShowHistory(!showHistory)}
                className="history-toggle-btn"
              >
                {showHistory ? 'Hide' : 'Show'} Quiz History ({quizHistory.length})
              </button>
              
              {showHistory && (
                <div className="quiz-history">
                  <h4>Your Previous Attempts</h4>
                  <table>
                    <thead>
                      <tr>
                        <th>Attempt</th>
                        <th>Score</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Date</th>
                      </tr>
                    </thead>
                    <tbody>
                      {quizHistory.map((attempt, idx) => (
                        <tr key={attempt.attemptId || idx}>
                          <td>{quizHistory.length - idx}</td>
                          <td>{attempt.scorePercentage}%</td>
                          <td>{attempt.timeSpentSeconds ? formatTime(attempt.timeSpentSeconds) : 'N/A'}</td>
                          <td>{attempt.passed ? '✓ Passed' : '✗ Failed'}</td>
                          <td>{new Date(attempt.startedAt).toLocaleDateString()}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          )}
        </div>

        <div className="quiz-actions">
          <button
            className="start-quiz-button"
            onClick={handleStartQuiz}
            disabled={loading || !canAttempt}
          >
            {loading ? 'Starting...' : 'Start Quiz'}
          </button>
        </div>
      </div>
    );
  }

  // Show error if quiz started but no questions
  if (quizStarted && questions.length === 0) {
    return (
      <div className="quiz-error">
        <p>No quiz questions available for this chapter.</p>
        <p>Please contact your teacher to add questions.</p>
        <button onClick={() => {
          setQuizStarted(false);
          loadQuizData();
        }}>Go Back</button>
      </div>
    );
  }
  
  // Show loading while starting quiz
  if (quizStarted && loading) {
    return <div className="quiz-loading">Starting quiz...</div>;
  }
  
  // Show error if there's an error and quiz is started
  if (quizStarted && error) {
    return (
      <div className="quiz-error">
        <p>{error}</p>
        <button onClick={() => {
          setQuizStarted(false);
          setError(null);
          loadQuizData();
        }}>Go Back</button>
      </div>
    );
  }

  // Final check - if quiz started but no questions, show error
  if (quizStarted && (!questions || questions.length === 0)) {
    return (
      <div className="quiz-error">
        <p>No quiz questions available for this chapter.</p>
        <p>Please contact your teacher to add questions.</p>
        <button onClick={() => {
          setQuizStarted(false);
          loadQuizData();
        }}>Go Back</button>
      </div>
    );
  }

  console.log('Rendering quiz with', questions.length, 'questions, quizStarted:', quizStarted);

  return (
    <div className="quiz-component">
      <div className="quiz-header">
        <div className="quiz-header-top">
          <h3>Chapter Quiz</h3>
          {timeLeft !== null && (
            <div className={`quiz-timer ${timeLeft < 60 ? 'timer-warning' : ''}`}>
              ⏱ {formatTime(timeLeft)}
            </div>
          )}
          {timeLeft === null && timeSpent > 0 && (
            <div className="quiz-timer">
              ⏱ {formatTime(timeSpent)}
            </div>
          )}
        </div>
        {!submitted && (
          <p className="quiz-instructions">
            Answer all questions to test your understanding. You can get hints if needed.
          </p>
        )}
      </div>

      <div className="quiz-questions">
        {questions && questions.length > 0 ? questions.map((question, index) => {
          const qId = question.questionId || question.QuestionId;
          const qStem = question.stem || question.Stem;
          const qDifficulty = question.difficulty || question.Difficulty;
          const qType = question.questionType || question.QuestionType || 'multiple_choice';
          const qOptions = question.options || question.Options || [];
          
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
                <span className="question-type">{qType.replace('_', ' ')}</span>
              </div>
              
              <p className="question-stem">{qStem}</p>

              {hints[qId] && (
                <div className="question-hint">
                  <strong>💡 Hint:</strong> {hints[qId]}
                </div>
              )}

              {/* Render different question types */}
              {qType === 'multiple_choice' && (
                <div className="question-options">
                  {qOptions.map((option) => {
                    const optId = option.optionId || option.OptionId;
                    const optText = option.optionText || option.OptionText;
                    const isSelected = selectedAnswers[qId] === optId;
                    
                    const isCorrect = questionResult?.isCorrect;
                    const isIncorrect = questionResult && !isCorrect;
                    const correctAnswer = questionResult?.correctAnswer;
                    const showCorrect = submitted && optText === correctAnswer;

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
                          onChange={() => handleAnswerSelect(qId, optId, qType)}
                          disabled={submitted}
                        />
                        <span>{optText}</span>
                        {submitted && showCorrect && <span className="correct-mark">✓</span>}
                        {submitted && isIncorrect && isSelected && <span className="incorrect-mark">✗</span>}
                      </label>
                    );
                  })}
                </div>
              )}

              {qType === 'true_false' && (
                <div className="question-options">
                  {['True', 'False'].map((option) => {
                    const isSelected = selectedAnswers[qId]?.toLowerCase() === option.toLowerCase();
                    const isCorrect = questionResult?.isCorrect;
                    const isIncorrect = questionResult && !isCorrect;
                    const correctAnswer = questionResult?.correctAnswer;
                    const showCorrect = submitted && option === correctAnswer;

                    return (
                      <label
                        key={option}
                        className={`option-label ${isSelected ? 'selected' : ''} ${submitted && showCorrect ? 'correct' : ''} ${submitted && isIncorrect && isSelected ? 'incorrect' : ''}`}
                      >
                        <input
                          type="radio"
                          name={`question-${qId}`}
                          value={option}
                          checked={isSelected}
                          onChange={() => handleAnswerSelect(qId, option, qType)}
                          disabled={submitted}
                        />
                        <span>{option}</span>
                        {submitted && showCorrect && <span className="correct-mark">✓</span>}
                        {submitted && isIncorrect && isSelected && <span className="incorrect-mark">✗</span>}
                      </label>
                    );
                  })}
                </div>
              )}

              {(qType === 'short_answer' || qType === 'essay') && (
                <div className="question-text-input">
                  <textarea
                    value={textAnswers[qId] || ''}
                    onChange={(e) => handleAnswerSelect(qId, e.target.value, qType)}
                    placeholder={qType === 'essay' ? 'Type your essay answer here...' : 'Type your answer here...'}
                    disabled={submitted}
                    rows={qType === 'essay' ? 6 : 3}
                    className="answer-textarea"
                  />
                  {submitted && questionResult && (
                    <div className="text-answer-feedback">
                      <p><strong>Your answer:</strong> {textAnswers[qId] || 'No answer provided'}</p>
                      {questionResult.correctAnswer && (
                        <p><strong>Expected answer:</strong> {questionResult.correctAnswer}</p>
                      )}
                      <p className={questionResult.isCorrect ? 'correct' : 'incorrect'}>
                        {questionResult.isCorrect ? '✓ Correct!' : '✗ Incorrect'}
                      </p>
                    </div>
                  )}
                </div>
              )}

              {questionResult?.explanation && (
                <div className="question-explanation">
                  <strong>Explanation:</strong> {questionResult.explanation}
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
        }) : (
          <div className="quiz-empty">No questions loaded. Please refresh the page.</div>
        )}
      </div>

      {submitted && results && (
        <div className="quiz-results">
          <div className="results-summary">
            <h4>Quiz Results</h4>
            <div className="results-stats">
              <p>Score: <strong>{results.correctAnswers || 0} / {results.totalQuestions || 0}</strong></p>
              <p>Percentage: <strong>{results.score || 0}%</strong></p>
              <p>Status: <strong>{results.passed ? '✓ Passed' : '✗ Failed'}</strong></p>
              {results.timeSpentSeconds && (
                <p>Time Spent: <strong>{formatTime(results.timeSpentSeconds)}</strong></p>
              )}
              {results.completedInTime !== undefined && (
                <p>Completed in Time: <strong>{results.completedInTime ? '✓ Yes' : '✗ No'}</strong></p>
              )}
            </div>
            {results.message && <p className="results-message">{results.message}</p>}
          </div>
        </div>
      )}

      {!submitted && (
        <div className="quiz-actions">
          <button
            className="submit-quiz-button"
            onClick={() => handleSubmit(false)}
            disabled={loading}
          >
            {loading ? 'Submitting...' : 'Submit Quiz'}
          </button>
        </div>
      )}
    </div>
  );
};

export default QuizComponent;

import React, { useState, useEffect } from 'react';
import { teacherQuestionService } from '../services/apiService';
import '../styles/QuestionEditor.css';

const QuestionEditor = ({ chapterId, onQuestionAdded, onClose }) => {
  const [questionType, setQuestionType] = useState('multiple_choice');
  const [stem, setStem] = useState('');
  const [difficulty, setDifficulty] = useState('medium');
  const [explanation, setExplanation] = useState('');
  const [expectedAnswer, setExpectedAnswer] = useState('');
  
  // For multiple choice and true/false
  const [options, setOptions] = useState([
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
    { text: '', isCorrect: false }
  ]);
  
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);

  useEffect(() => {
    // Reset form when question type changes
    if (questionType === 'true_false') {
      setOptions([
        { text: 'True', isCorrect: false },
        { text: 'False', isCorrect: false }
      ]);
    } else if (questionType === 'multiple_choice') {
      setOptions([
        { text: '', isCorrect: false },
        { text: '', isCorrect: false },
        { text: '', isCorrect: false },
        { text: '', isCorrect: false }
      ]);
    }
    setExpectedAnswer('');
  }, [questionType]);

  const handleOptionChange = (index, field, value) => {
    const newOptions = [...options];
    if (field === 'text') {
      newOptions[index].text = value;
    } else if (field === 'isCorrect') {
      // For true/false, only one can be correct
      if (questionType === 'true_false') {
        newOptions.forEach((opt, i) => {
          opt.isCorrect = i === index;
        });
      } else {
        newOptions[index].isCorrect = value;
      }
    }
    setOptions(newOptions);
  };

  const addOption = () => {
    setOptions([...options, { text: '', isCorrect: false }]);
  };

  const removeOption = (index) => {
    if (options.length > 2) {
      setOptions(options.filter((_, i) => i !== index));
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setSuccess(false);

    // Validation
    if (!stem.trim()) {
      setError('Question text is required');
      return;
    }

    if ((questionType === 'multiple_choice' || questionType === 'true_false')) {
      const validOptions = options.filter(opt => opt.text.trim());
      if (validOptions.length < 2) {
        setError('At least 2 options are required');
        return;
      }
      if (!validOptions.some(opt => opt.isCorrect)) {
        setError('At least one option must be marked as correct');
        return;
      }
    }

    if ((questionType === 'short_answer' || questionType === 'essay') && !expectedAnswer.trim()) {
      setError('Expected answer is required for this question type');
      return;
    }

    try {
      setLoading(true);
      
      const payload = {
        stem: stem.trim(),
        difficulty,
        questionType,
        explanation: explanation.trim() || null,
        expectedAnswer: (questionType === 'short_answer' || questionType === 'essay') 
          ? expectedAnswer.trim() 
          : null,
        options: (questionType === 'multiple_choice' || questionType === 'true_false')
          ? options.filter(opt => opt.text.trim()).map(opt => ({
              text: opt.text.trim(),
              isCorrect: opt.isCorrect
            }))
          : null
      };

      const result = await teacherQuestionService.createQuestion(chapterId, payload);
      
      setSuccess(true);
      
      // Reset form
      setTimeout(() => {
        setStem('');
        setExplanation('');
        setExpectedAnswer('');
        setOptions([
          { text: '', isCorrect: false },
          { text: '', isCorrect: false },
          { text: '', isCorrect: false },
          { text: '', isCorrect: false }
        ]);
        setSuccess(false);
        if (onQuestionAdded) {
          onQuestionAdded(result);
        }
      }, 1500);
      
    } catch (err) {
      console.error('Failed to create question:', err);
      setError(err.message || 'Failed to create question. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="question-editor">
      <div className="question-editor-header">
        <h2>🌱 Add New Question</h2>
        {onClose && (
          <button type="button" className="close-btn" onClick={onClose}>
            ✕
          </button>
        )}
      </div>

      <form onSubmit={handleSubmit} className="question-form">
        {/* Question Type Selector */}
        <div className="form-group">
          <label htmlFor="questionType">Question Type</label>
          <div className="question-type-selector">
            <button
              type="button"
              className={`type-btn ${questionType === 'multiple_choice' ? 'active' : ''}`}
              onClick={() => setQuestionType('multiple_choice')}
            >
              📋 Multiple Choice
            </button>
            <button
              type="button"
              className={`type-btn ${questionType === 'true_false' ? 'active' : ''}`}
              onClick={() => setQuestionType('true_false')}
            >
              ✓✗ True/False
            </button>
            <button
              type="button"
              className={`type-btn ${questionType === 'short_answer' ? 'active' : ''}`}
              onClick={() => setQuestionType('short_answer')}
            >
              ✏️ Short Answer
            </button>
            <button
              type="button"
              className={`type-btn ${questionType === 'essay' ? 'active' : ''}`}
              onClick={() => setQuestionType('essay')}
            >
              📝 Essay
            </button>
          </div>
        </div>

        {/* Question Text */}
        <div className="form-group">
          <label htmlFor="stem">Question Text *</label>
          <textarea
            id="stem"
            value={stem}
            onChange={(e) => setStem(e.target.value)}
            placeholder="Enter your question here..."
            rows={3}
            required
            className="question-textarea"
          />
        </div>

        {/* Difficulty */}
        <div className="form-group">
          <label htmlFor="difficulty">Difficulty Level</label>
          <div className="difficulty-selector">
            <button
              type="button"
              className={`difficulty-btn ${difficulty === 'easy' ? 'active' : ''}`}
              onClick={() => setDifficulty('easy')}
            >
              🌱 Easy
            </button>
            <button
              type="button"
              className={`difficulty-btn ${difficulty === 'medium' ? 'active' : ''}`}
              onClick={() => setDifficulty('medium')}
            >
              🌿 Medium
            </button>
            <button
              type="button"
              className={`difficulty-btn ${difficulty === 'hard' ? 'active' : ''}`}
              onClick={() => setDifficulty('hard')}
            >
              🌸 Hard
            </button>
          </div>
        </div>

        {/* Options for Multiple Choice and True/False */}
        {(questionType === 'multiple_choice' || questionType === 'true_false') && (
          <div className="form-group">
            <label>Answer Options *</label>
            <div className="options-list">
              {options.map((option, index) => (
                <div key={index} className="option-item">
                  <div className="option-input-group">
                    <input
                      type="text"
                      value={option.text}
                      onChange={(e) => handleOptionChange(index, 'text', e.target.value)}
                      placeholder={`Option ${index + 1}${questionType === 'true_false' ? '' : '...'}`}
                      className="option-input"
                      disabled={questionType === 'true_false'}
                      required={option.text || index < 2}
                    />
                    <label className="correct-checkbox">
                      <input
                        type={questionType === 'true_false' ? 'radio' : 'checkbox'}
                        checked={option.isCorrect}
                        onChange={(e) => handleOptionChange(index, 'isCorrect', e.target.checked || e.target.checked)}
                        name={questionType === 'true_false' ? 'correctOption' : undefined}
                      />
                      <span className="checkmark">✓ Correct</span>
                    </label>
                    {questionType === 'multiple_choice' && options.length > 2 && (
                      <button
                        type="button"
                        className="remove-option-btn"
                        onClick={() => removeOption(index)}
                      >
                        ✕
                      </button>
                    )}
                  </div>
                </div>
              ))}
              {questionType === 'multiple_choice' && (
                <button
                  type="button"
                  className="add-option-btn"
                  onClick={addOption}
                >
                  + Add Option
                </button>
              )}
            </div>
          </div>
        )}

        {/* Expected Answer for Short Answer and Essay */}
        {(questionType === 'short_answer' || questionType === 'essay') && (
          <div className="form-group">
            <label htmlFor="expectedAnswer">Expected Answer *</label>
            <textarea
              id="expectedAnswer"
              value={expectedAnswer}
              onChange={(e) => setExpectedAnswer(e.target.value)}
              placeholder={questionType === 'essay' ? 'Enter the expected essay answer or key points...' : 'Enter the expected short answer...'}
              rows={questionType === 'essay' ? 4 : 2}
              required
              className="answer-textarea"
            />
            <small className="form-hint">
              {questionType === 'essay' 
                ? 'For essays, provide key points or a sample answer. Grading will be case-insensitive.' 
                : 'Students\' answers will be compared case-insensitively to this value.'}
            </small>
          </div>
        )}

        {/* Explanation */}
        <div className="form-group">
          <label htmlFor="explanation">Explanation (Optional)</label>
          <textarea
            id="explanation"
            value={explanation}
            onChange={(e) => setExplanation(e.target.value)}
            placeholder="Provide an explanation that will be shown after students answer..."
            rows={2}
            className="explanation-textarea"
          />
        </div>

        {/* Error/Success Messages */}
        {error && (
          <div className="message error-message">
            ⚠️ {error}
          </div>
        )}
        {success && (
          <div className="message success-message">
            ✅ Question created successfully!
          </div>
        )}

        {/* Submit Button */}
        <div className="form-actions">
          <button
            type="submit"
            className="submit-question-btn"
            disabled={loading}
          >
            {loading ? 'Creating...' : '✨ Create Question'}
          </button>
          {onClose && (
            <button
              type="button"
              className="cancel-btn"
              onClick={onClose}
              disabled={loading}
            >
              Cancel
            </button>
          )}
        </div>
      </form>
    </div>
  );
};

export default QuestionEditor;


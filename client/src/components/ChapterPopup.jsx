import React from 'react';
import { getUser } from '../utils/auth';
import '../styles/ChapterPopup.css';

const ChapterPopup = ({ isOpen, chapter, onClose, onStartLearning }) => {
  if (!isOpen || !chapter) return null;

  const user = getUser();
  const isTeacherOrAdmin = user && (user.role === 'teacher' || user.role === 'admin');

  const handleOverlayClick = (e) => {
    if (e.target === e.currentTarget) onClose();
  };

  const handleStartLearning = () => {
    if (onStartLearning) {
      onStartLearning(chapter.id, chapter.number);
    }
    onClose();
  };

  return (
    <div className="chapter-popup-overlay" onClick={handleOverlayClick}>
      <div className="chapter-popup-content">
        <div className="chapter-popup-header">
          <div className="chapter-popup-number">
            <span>{chapter.number}</span>
          </div>
          <div className="chapter-popup-title-section">
            <h3>{chapter.title}</h3>
          </div>
          <button className="chapter-popup-close" onClick={onClose}>×</button>
        </div>
        
        <div className="chapter-popup-body">
          <div className="chapter-popup-summary">
            <h4>{isTeacherOrAdmin ? 'Chapter Overview' : 'What You\'ll Study'}</h4>
            <p>{chapter.summary}</p>
          </div>
        </div>

        <div className="chapter-popup-actions">
          <button
            type="button"
            className="chapter-popup-start-btn"
            onClick={handleStartLearning}
          >
            {isTeacherOrAdmin ? 'Edit Chapter →' : 'Start Learning →'}
          </button>
        </div>
      </div>
    </div>
  );
};

export default ChapterPopup;


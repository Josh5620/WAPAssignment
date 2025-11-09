import React from 'react';
import '../styles/PathCard.css';

/*
 * A reusable flip card to display a single chapter or "path"
 * in the curriculum map. Shows flower patch on front, details on back.
 * Flips on hover!
 */
const PathCard = ({ icon, title, level, topics = [], status = '' }) => {
  const isCompleted = status.includes('is-completed');
  const isLocked = status.includes('is-locked');

  return (
    <div 
      className={`path-card ${isCompleted ? 'is-completed-card' : ''} ${isLocked ? 'is-locked-card' : ''}`}
    >
      <div className="path-card-inner">
        {/* Front side - Flower patch image */}
        <div className="path-card-front">
          <img src="/flowerpatch.jpg" alt="Flower patch" className="path-card-image" />
          <div className="path-card-front-overlay">
          </div>
        </div>

        {/* Back side - Chapter details */}
        <div className="path-card-back">
          <div className="path-card-header">
            <span className="path-card-icon">{icon}</span>
            <span className="path-card-level">{level}</span>
          </div>
          <h3 className="path-card-title">{title}</h3>
          <ul className="path-card-topics">
            {topics.map((topic, index) => (
              <li key={index}>{topic}</li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
};

export default PathCard;

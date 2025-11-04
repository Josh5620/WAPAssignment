import React from 'react';
import '../styles/PathCard.css';

/*
 * A reusable card to display a single chapter or "path"
 * in the curriculum map.
 */
const PathCard = ({ icon, title, level, topics = [] }) => {
  return (
    <div className="path-card">
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
  );
};

export default PathCard;

import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/XPEarnedPopup.css';

const XPEarnedPopup = ({ xpEarned, difficulty, onClose, showBadge = null }) => {
  const navigate = useNavigate();
  const [isVisible, setIsVisible] = useState(false);
  const [animatedXP, setAnimatedXP] = useState(0);

  useEffect(() => {
    setIsVisible(true);
    
    // Animate XP counter
    const duration = 1500;
    const steps = 30;
    const increment = xpEarned / steps;
    let current = 0;
    
    const interval = setInterval(() => {
      current += increment;
      if (current >= xpEarned) {
        setAnimatedXP(xpEarned);
        clearInterval(interval);
      } else {
        setAnimatedXP(Math.floor(current));
      }
    }, duration / steps);

    return () => clearInterval(interval);
  }, [xpEarned]);

  const difficultyLabels = {
    easy: 'Sprout Patch',
    medium: 'Vine Trellis',
    hard: 'Bloom Bed',
  };

  const difficultyEmojis = {
    easy: '🌱',
    medium: '🌿',
    hard: '🌸',
  };

  if (!isVisible) return null;

  return (
    <div className="xp-popup-overlay" onClick={onClose}>
      <div className="xp-popup" onClick={(e) => e.stopPropagation()}>
        <div className="xp-popup__header">
          <span className="xp-popup__emoji">{difficultyEmojis[difficulty]}</span>
          <h2 className="xp-popup__title">Challenge Complete!</h2>
        </div>
        
        <div className="xp-popup__content">
          <p className="xp-popup__difficulty">{difficultyLabels[difficulty]} Completed</p>
          
          <div className="xp-popup__xp-display">
            <div className="xp-popup__xp-label">XP Earned</div>
            <div className="xp-popup__xp-value">
              +{animatedXP}
            </div>
          </div>

          {showBadge && (
            <div className="xp-popup__badge">
              <div className="xp-popup__badge-icon">
                {showBadge.iconUrl ? (
                  <img src={showBadge.iconUrl} alt={showBadge.name} />
                ) : (
                  '🏆'
                )}
              </div>
              <div className="xp-popup__badge-text">
                <strong>New Badge Unlocked!</strong>
                <span>{showBadge.name}</span>
                {showBadge.description && (
                  <span className="xp-popup__badge-desc">{showBadge.description}</span>
                )}
              </div>
            </div>
          )}

          <p className="xp-popup__message">
            Your progress has been updated on the leaderboard!
          </p>
        </div>

        <button 
          className="xp-popup__close" 
          onClick={() => {
            onClose();
            navigate('/student-profile');
          }}
        >
          View Leaderboard
        </button>
      </div>
    </div>
  );
};

export default XPEarnedPopup;


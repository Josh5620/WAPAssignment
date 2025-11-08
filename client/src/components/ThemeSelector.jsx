import React, { useState } from 'react';
import { useTheme } from '../contexts/ThemeContext';
import '../styles/ThemeSelector.css';

const ThemeSelector = () => {
  const { currentTheme, themeNames, changeTheme } = useTheme();
  const [isOpen, setIsOpen] = useState(false);

  const themeColors = {
    garden: '#717744',
    sage: '#979A68',
    earth: '#766153',
  };

  return (
    <div className="theme-selector">
      <button
        className="theme-toggle-button"
        onClick={() => setIsOpen(!isOpen)}
        aria-label="Change theme"
      >
        <span className="theme-icon">🎨</span>
        <span className="theme-label">Theme</span>
      </button>

      {isOpen && (
        <>
          <div className="theme-overlay" onClick={() => setIsOpen(false)} />
          <div className="theme-panel">
            <div className="theme-panel-header">
              <h3>Choose Your Theme</h3>
              <button
                className="close-theme-button"
                onClick={() => setIsOpen(false)}
                aria-label="Close theme selector"
              >
                ×
              </button>
            </div>

            <div className="theme-options">
              {themeNames.map(({ key, name }) => {
                const color = themeColors[key];
                const isActive = currentTheme === key;
                
                return (
                  <button
                    key={key}
                    className={`theme-option ${isActive ? 'active' : ''}`}
                    onClick={() => {
                      changeTheme(key);
                      setIsOpen(false);
                    }}
                  >
                    <div 
                      className="theme-circle"
                      style={{ backgroundColor: color }}
                    >
                      {isActive && <span className="check-icon">✓</span>}
                    </div>
                    <span className="theme-name" style={{ color: color }}>
                      {name}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default ThemeSelector;


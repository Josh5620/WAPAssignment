import React, { useState } from 'react';
import { useTheme } from '../contexts/ThemeContext';
import '../styles/ThemeSelector.css';

const ThemeSelector = () => {
  const { currentTheme, mode, themeNames, changeTheme, toggleMode } = useTheme();
  const [isOpen, setIsOpen] = useState(false);

  const themeColors = {
    garden: { light: '#717744', dark: '#373D20' },
    forest: { light: '#545A32', dark: '#545A32' },
    sage: { light: '#979A68', dark: '#373D20' },
    earth: { light: '#766153', dark: '#373D20' },
    khaki: { light: '#998F6F', dark: '#373D20' },
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

            <div className="theme-mode-toggle">
              <span className="mode-label">Mode:</span>
              <button
                className={`mode-button ${mode === 'light' ? 'active' : ''}`}
                onClick={() => mode !== 'light' && toggleMode()}
              >
                ☀️ Light
              </button>
              <button
                className={`mode-button ${mode === 'dark' ? 'active' : ''}`}
                onClick={() => mode !== 'dark' && toggleMode()}
              >
                🌙 Dark
              </button>
            </div>

            <div className="theme-options">
              <h4>Select Theme:</h4>
              <div className="theme-grid">
                {themeNames.map(({ key, name }) => {
                  const colors = themeColors[key];
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
                        className="theme-preview"
                        style={{
                          background: `linear-gradient(135deg, ${colors.light} 0%, ${colors.dark} 100%)`
                        }}
                      />
                      <span className="theme-name">{name}</span>
                      {isActive && <span className="active-indicator">✓</span>}
                    </button>
                  );
                })}
              </div>
            </div>

            <div className="theme-preview-section">
              <h4>Preview:</h4>
              <div className="theme-preview-card">
                <div className="preview-header">
                  <div className="preview-title">Sample Card</div>
                </div>
                <div className="preview-content">
                  <p>This is how your theme will look.</p>
                  <button className="preview-button">Sample Button</button>
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default ThemeSelector;


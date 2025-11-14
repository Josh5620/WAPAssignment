import React from 'react';
import '../styles/ChapterNavigation.css';

const ChapterNavigation = ({ chapters, currentChapterIndex, userProgress, onChapterSelect }) => {
  const getChapterStatus = (chapterId) => {
    if (userProgress[chapterId]?.completed) return 'completed';
    if (chapters.findIndex(ch => ch.id === chapterId) === currentChapterIndex) return 'current';
    return 'pending';
  };

  const getStatusIcon = (status) => {
    switch (status) {
      case 'completed': return '✓';
      case 'current': return '▶';
      default: return '○';
    }
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'completed': return '#27ae60';
      case 'current': return '#3498db';
      default: return '#95a5a6';
    }
  };

  return (
    <div className="chapter-navigation">
      <h3 className="nav-title">Course Content</h3>
      
      <div className="chapters-list">
        {chapters.map((chapter, index) => {
          const status = getChapterStatus(chapter.id);
          const isActive = index === currentChapterIndex;
          
          return (
            <div
              key={chapter.id}
              className={`chapter-item ${isActive ? 'active' : ''} ${status}`}
              onClick={() => onChapterSelect(index)}
            >
              <div className="chapter-status">
                <span 
                  className="status-icon"
                  style={{ color: getStatusColor(status) }}
                >
                  {getStatusIcon(status)}
                </span>
              </div>
              
              <div className="chapter-info">
                <div className="chapter-number">
                  Chapter {chapter.number}
                </div>
                <div className="chapter-title">
                  {chapter.title}
                </div>
                {chapter.summary && (
                  <div className="chapter-summary">
                    {chapter.summary}
                  </div>
                )}
              </div>
              
              {status === 'completed' && (
                <div className="completion-time">
                  {userProgress[chapter.id]?.completedAt && (
                    <small>
                      Completed {new Date(userProgress[chapter.id].completedAt).toLocaleDateString()}
                    </small>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Course Statistics */}
      <div className="course-stats">
        <h4>Your Progress</h4>
        <div className="stats-grid">
          <div className="stat-item">
            <span className="stat-number">{chapters.length}</span>
            <span className="stat-label">Total Chapters</span>
          </div>
          <div className="stat-item">
            <span className="stat-number">{Object.keys(userProgress).length}</span>
            <span className="stat-label">Completed</span>
          </div>
          <div className="stat-item">
            <span className="stat-number">
              {Math.round((Object.keys(userProgress).length / chapters.length) * 100) || 0}%
            </span>
            <span className="stat-label">Progress</span>
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="quick-actions">
        <button className="action-btn bookmark-btn" title="Bookmark this chapter">
          🔖 Bookmark
        </button>
        <button className="action-btn notes-btn" title="Take notes">
          📝 Notes
        </button>
        <button className="action-btn quiz-btn" title="Take quiz">
          🧠 Quiz
        </button>
      </div>
    </div>
  );
};

export default ChapterNavigation;
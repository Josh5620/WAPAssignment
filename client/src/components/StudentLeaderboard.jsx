import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';

const Leaderboard = () => {
  const [leaderboard, setLeaderboard] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadLeaderboard();
  }, []);

  const loadLeaderboard = async () => {
    try {
      setLoading(true);
      const userProfile = quickApi.getUserProfile();
      const userId = userProfile?.id || null;
      const data = await api.students.getLeaderboard(userId);
      setLeaderboard(data);
      setError(null);
    } catch (err) {
      console.error('Failed to load leaderboard:', err);
      setError('Failed to load leaderboard. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const getRankIcon = (rank) => {
    if (rank === 1) return '🥇';
    if (rank === 2) return '🥈';
    if (rank === 3) return '🥉';
    return `#${rank}`;
  };

  if (loading) {
    return <div className="leaderboard-loading">Loading leaderboard...</div>;
  }

  if (error) {
    return (
      <div className="leaderboard-error">
        <p>{error}</p>
        <button onClick={loadLeaderboard}>Retry</button>
      </div>
    );
  }

  if (leaderboard.length === 0) {
    return (
      <div className="leaderboard-empty">
        <p>No leaderboard data available yet. Start learning to earn points!</p>
      </div>
    );
  }

  return (
    <div className="leaderboard-component">
      <div className="leaderboard-header">
        <h3>Leaderboard</h3>
        <button className="refresh-button" onClick={loadLeaderboard}>
          Refresh
        </button>
      </div>

      <div className="leaderboard-list">
        {leaderboard.map((entry) => (
          <div
            key={entry.userId}
            className={`leaderboard-entry ${entry.isCurrentUser ? 'current-user' : ''}`}
          >
            <div className="entry-rank">
              <span className="rank-icon">{getRankIcon(entry.rank)}</span>
            </div>
            <div className="entry-info">
              <div className="entry-name">
                {entry.userName}
                {entry.isCurrentUser && <span className="you-badge">(You)</span>}
              </div>
              <div className="entry-stats">
                <span className="stat-item">
                  <strong>{entry.xp}</strong> XP
                </span>
                {entry.streaks > 0 && (
                  <span className="stat-item">
                    <strong>{entry.streaks}</strong> day streak
                  </span>
                )}
                {entry.badges && (
                  <span className="stat-item">
                    {entry.badges}
                  </span>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Leaderboard;


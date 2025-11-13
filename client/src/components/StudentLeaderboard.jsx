import React, { useState, useEffect, useCallback } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';
import '../styles/StudentLeaderboard.css';

const Leaderboard = () => {
  const [leaderboard, setLeaderboard] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const loadLeaderboard = useCallback(async () => {
    try {
      setLoading(true);
      const userProfile = quickApi.getUserProfile();
      console.log('📊 Loading leaderboard - User profile:', userProfile);
      console.log('📊 User profile keys:', userProfile ? Object.keys(userProfile) : 'null');
      
      // Try multiple ways to get userId
      const userId = userProfile?.id || userProfile?.UserId || userProfile?.userId || userProfile?.user?.id || userProfile?.user?.UserId || userProfile?.user?.userId || null;
      console.log('📊 Extracted userId for leaderboard:', userId);
      
      // If no userId, still fetch leaderboard (just won't highlight current user)
      const data = await api.students.getLeaderboard(userId);
      console.log('📊 Leaderboard data received:', data);
      console.log('📊 Leaderboard entries count:', data?.length);
      if (data && data.length > 0) {
        console.log('📊 First entry:', data[0]);
        console.log('📊 All entries XP:', data.map(e => ({ name: e.userName, xp: e.xp })));
      }
      setLeaderboard(data || []);
      setError(null);
    } catch (err) {
      console.error('❌ Failed to load leaderboard:', err);
      console.error('❌ Error details:', {
        message: err.message,
        stack: err.stack,
        response: err.response
      });
      setError('Failed to load leaderboard. Please try again.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadLeaderboard();
    
    // Listen for XP awarded events to refresh leaderboard
    const handleXPAwarded = (event) => {
      console.log('🔄 XP awarded event received - refreshing leaderboard', event.detail);
      // Refresh immediately, then again after a short delay to ensure DB is updated
      loadLeaderboard();
      setTimeout(() => {
        console.log('🔄 Second refresh after delay');
        loadLeaderboard();
      }, 500);
    };
    
    window.addEventListener('xp-awarded', handleXPAwarded);
    console.log('👂 Leaderboard: Listening for xp-awarded events');
    
    return () => {
      window.removeEventListener('xp-awarded', handleXPAwarded);
      console.log('👋 Leaderboard: Removed xp-awarded event listener');
    };
  }, [loadLeaderboard]);

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
            className={`leaderboard-entry ${entry.isCurrentUser ? 'current-user' : ''} rank-${entry.rank}`}
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
                <span className="stat-item stat-xp">
                  <span className="stat-icon">⭐</span>
                  <strong>{entry.xp}</strong> XP
                </span>
                {entry.streaks > 0 && (
                  <span className="stat-item stat-streak">
                    <span className="stat-icon">🔥</span>
                    <strong>{entry.streaks}</strong> day streak
                  </span>
                )}
              </div>
              {entry.badges && entry.badges.length > 0 && (
                <div className="entry-badges">
                  {entry.badges.slice(0, 5).map((badge) => (
                    <div
                      key={badge.badgeId}
                      className="badge-item"
                      title={badge.description || badge.name}
                    >
                      {badge.iconUrl ? (
                        <img src={badge.iconUrl} alt={badge.name} className="badge-icon" />
                      ) : (
                        <span className="badge-icon-emoji">🏆</span>
                      )}
                      <span className="badge-name">{badge.name}</span>
                    </div>
                  ))}
                  {entry.badges.length > 5 && (
                    <div className="badge-more">+{entry.badges.length - 5} more</div>
                  )}
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Leaderboard;


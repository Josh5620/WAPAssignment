import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import GardenPath from '../components/GardenPath.jsx';
import { gardenPathData } from '../data/curriculum.js';
import '../styles/StudentDashboard.css';
import { useAuth } from '../context/AuthContext.jsx';
import { api } from '../services/apiService';

const StudentDashboard = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [progress, setProgress] = useState({
    completedChapterIds: [],
    currentChapterId: 1,
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchProgress = async () => {
      if (!user || !user.id) {
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        // Fetch real progress from API using user ID
        const progressData = await api.students.getStudentProgress(user.id);
        setProgress({
          completedChapterIds: progressData.completedChapterIds || [],
          currentChapterId: progressData.currentChapterId || 1,
        });
        setError(null);
      } catch (err) {
        console.error('Failed to load progress:', err);
        // Set default empty progress if API fails
        setProgress({
          completedChapterIds: [],
          currentChapterId: 1,
        });
        // Only show error if it's not a 404 (no progress yet)
        if (err.status !== 404) {
          setError('Unable to load your progress. Starting fresh!');
        }
      } finally {
        setLoading(false);
      }
    };

    fetchProgress();
  }, [user]);

  const displayName = useMemo(() => {
    if (!user) return 'student';
    return (
      user.full_name ||
      user.fullName ||
      user.FullName ||
      user.name ||
      user.displayName ||
      'student'
    );
  }, [user]);

  const greeting = useMemo(() => {
    return `Hi ${displayName}, welcome back to your garden!`;
  }, [displayName]);

  const handleChapterSelection = (chapter, status) => {
    if (status === 'is-locked') {
      return; // Don't navigate if locked
    }
    navigate(`/chapters/${chapter.id}`);
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="student-dashboard-loading">
          <div className="loading-spinner">🌱</div>
          <p>Loading your garden...</p>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <main className="student-dashboard-page">
        {error && (
          <div className="dashboard-notice">
            <span>ℹ️</span>
            <p>{error}</p>
          </div>
        )}
        <section className="student-dashboard-header">
          <h1>Your Garden</h1>
          <p>{greeting}</p>
        </section>

        <GardenPath
          chapters={gardenPathData}
          progress={progress}
          onChapterClick={handleChapterSelection}
        />
      </main>
    </>
  );
};

export default StudentDashboard;

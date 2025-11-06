import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';

const StudentProgress = ({ courseId }) => {
  const [progress, setProgress] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadProgress = async () => {
      try {
        setLoading(true);
        const userProfile = quickApi.getUserProfile();
        if (!userProfile || !userProfile.id) {
          setError('Please log in to view your progress.');
          return;
        }

        const data = await api.students.getStudentProgress(userProfile.id);
        setProgress(data);
        setError(null);
      } catch (err) {
        console.error('Failed to load progress:', err);
        setError('Failed to load progress. Please try again.');
      } finally {
        setLoading(false);
      }
    };

    loadProgress();
  }, [courseId]); // Include courseId so data reloads when courseId changes

  if (loading) {
    return <div className="progress-loading">Loading your progress...</div>;
  }

  const handleRetry = async () => {
    try {
      setLoading(true);
      setError(null);
      const userProfile = quickApi.getUserProfile();
      if (!userProfile || !userProfile.id) {
        setError('Please log in to view your progress.');
        return;
      }

      const data = await api.students.getStudentProgress(userProfile.id);
      setProgress(data);
    } catch (err) {
      console.error('Failed to load progress:', err);
      setError('Failed to load progress. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (error) {
    return (
      <div className="progress-error">
        <p>{error}</p>
        <button onClick={handleRetry}>Retry</button>
      </div>
    );
  }

  if (progress.length === 0) {
    return (
      <div className="progress-empty">
        <p>No progress data available. Start learning to track your progress!</p>
      </div>
    );
  }

  const filteredProgress = courseId 
    ? progress.filter(p => p.courseId === courseId)
    : progress;

  if (filteredProgress.length === 0) {
    return (
      <div className="progress-empty">
        <p>No progress data for this course yet.</p>
      </div>
    );
  }

  return (
    <div className="student-progress">
      <h3>Your Learning Progress</h3>
      <div className="progress-list">
        {filteredProgress.map((courseProgress) => (
          <div key={courseProgress.courseId} className="progress-item">
            <div className="progress-header">
              <h4>{courseProgress.courseTitle}</h4>
              <span className="progress-percentage">
                {courseProgress.progressPercentage.toFixed(1)}%
              </span>
            </div>
            
            <div className="progress-bar-container">
              <div
                className="progress-bar-fill"
                style={{ width: `${courseProgress.progressPercentage}%` }}
              />
            </div>

            <div className="progress-details">
              <div className="progress-stat">
                <span className="stat-label">Chapters Completed:</span>
                <span className="stat-value">
                  {courseProgress.completedChapters} / {courseProgress.totalChapters}
                </span>
              </div>
              
              {courseProgress.totalMcqsAttempted > 0 && (
                <>
                  <div className="progress-stat">
                    <span className="stat-label">Quiz Accuracy:</span>
                    <span className="stat-value">
                      {courseProgress.mcqAccuracy.toFixed(1)}%
                    </span>
                  </div>
                  <div className="progress-stat">
                    <span className="stat-label">Questions Attempted:</span>
                    <span className="stat-value">
                      {courseProgress.totalMcqsAttempted} ({courseProgress.totalMcqsCorrect} correct)
                    </span>
                  </div>
                </>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default StudentProgress;


import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import GuestRestrictionBanner from './GuestRestrictionBanner';
import GuestAccessPrompt from './GuestAccessPrompt';

const GuestCourseCatalog = () => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    loadCourseCatalog();
  }, []);

  const loadCourseCatalog = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getCourseCatalog();
      setCourses(data.courses || []);
      setError(null);
    } catch (err) {
      console.error('Failed to load course catalog:', err);
      setError('Failed to load courses. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleViewPreview = (courseId) => {
    navigate(`/guest/courses/${courseId}/preview`);
  };

  if (loading) {
    return <div className="guest-catalog-loading">Loading course catalog...</div>;
  }

  if (error) {
    return (
      <div className="guest-catalog-error">
        <p>{error}</p>
        <button onClick={loadCourseCatalog}>Retry</button>
      </div>
    );
  }

  return (
    <div className="guest-course-catalog">
      <GuestRestrictionBanner 
        message="You're viewing courses in preview mode. Register or log in to access full course content, quizzes, flashcards, and track your progress."
      />
      
      <div className="catalog-header">
        <h2>Course Catalog</h2>
        <p className="preview-notice">
          <strong>Preview Mode:</strong> Limited content available. Register for full access!
        </p>
      </div>

      {courses.length === 0 ? (
        <div className="catalog-empty">
          <p>No courses available at the moment.</p>
        </div>
      ) : (
        <div className="catalog-grid">
          {courses.map((course) => (
            <div key={course.courseId} className="guest-course-card">
              <div className="course-card-header">
                <h3 className="course-title">{course.title}</h3>
                {course.published && (
                  <span className="published-badge">Published</span>
                )}
              </div>

              <div className="course-card-content">
                <p className="course-description">
                  {course.description || 'No description available'}
                </p>

                {course.previewContent && (
                  <div className="course-preview">
                    <h4>Preview:</h4>
                    <p>{course.previewContent}</p>
                  </div>
                )}

                <div className="course-meta">
                  <span className="chapter-count">
                    {course.chapterCount || 0} Chapters
                  </span>
                </div>
              </div>

              <div className="course-card-actions">
                <button
                  className="preview-button"
                  onClick={() => handleViewPreview(course.courseId)}
                >
                  View Preview
                </button>
                <button
                  className="register-button"
                  onClick={() => navigate('/register')}
                >
                  Register for Full Access
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      <GuestAccessPrompt
        title="Ready to Start Learning?"
        message="Register now to unlock all courses, quizzes, flashcards, progress tracking, and more!"
        featureList={[
          'Full access to all course content',
          'Interactive quizzes and flashcards',
          'Progress tracking and achievements',
          'XP points and leaderboard',
          'Community forums',
          'Personalized learning dashboard'
        ]}
      />
    </div>
  );
};

export default GuestCourseCatalog;


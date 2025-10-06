import React, { useState, useEffect } from 'react';
import { api, quickApi } from '../services/apiService';
import '../styles/CourseDetails.css';

const CourseDetails = ({ courseId, userRole, onBack, onStartLearning }) => {
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isEnrolled, setIsEnrolled] = useState(false);

  useEffect(() => {
    if (courseId) {
      fetchCourseDetails();
    }
  }, [courseId]);

  const fetchCourseDetails = async () => {
    try {
      setLoading(true);
      const courseData = await quickApi.getCourse(courseId);
      setCourse(courseData);
      setError(null);
      
      // Check if user is enrolled
      const token = quickApi.getUserToken();
      if (token) {
        const enrolled = await api.enrollments.checkEnrollment(courseId, token);
        setIsEnrolled(enrolled);
      }
    } catch (err) {
      console.error('Failed to fetch course details:', err);
      setError('Failed to load course details. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleEnroll = async () => {
    try {
      const token = quickApi.getUserToken();
      if (!token) {
        alert('Please log in to enroll in courses');
        return;
      }
      
      await quickApi.enrollInCourse(courseId, token);
      setIsEnrolled(true);
      alert('Successfully enrolled in course!');
    } catch (err) {
      console.error('Failed to enroll:', err);
      alert('Failed to enroll in course. Please try again.');
    }
  };

  if (loading) {
    return <div className="course-details-loading">Loading course details...</div>;
  }

  if (error) {
    return (
      <div className="course-details-error">
        <p>{error}</p>
        <button onClick={fetchCourseDetails} className="retry-button">
          Try Again
        </button>
        <button onClick={onBack} className="back-button">
          Back to Courses
        </button>
      </div>
    );
  }

  if (!course) {
    return (
      <div className="course-not-found">
        <p>Course not found.</p>
        <button onClick={onBack} className="back-button">
          Back to Courses
        </button>
      </div>
    );
  }

  return (
    <div className="course-details-container">
      <div className="course-details-header">
        <button onClick={onBack} className="back-button">
          ← Back to Courses
        </button>
        
        <div className="course-title-section">
          <h1 className="course-title">{course.title}</h1>
          {course.published && (
            <span className="published-badge">Published</span>
          )}
        </div>
      </div>

      <div className="course-details-content">
        <div className="course-main-info">
          <div className="course-description-section">
            <h2>Course Description</h2>
            <p className="course-description">
              {course.description || 'No description available for this course.'}
            </p>
          </div>

          {course.previewContent && (
            <div className="course-preview-section">
              <h2>What You'll Learn</h2>
              <div className="preview-content">
                <p>{course.previewContent}</p>
              </div>
            </div>
          )}

          <div className="course-chapters-section">
            <h2>Course Content</h2>
            {course.chapters && course.chapters.length > 0 ? (
              <div className="chapters-list">
                {course.chapters.map((chapter, index) => (
                  <div key={chapter.id} className="chapter-item">
                    <span className="chapter-number">{chapter.number || index + 1}</span>
                    <div className="chapter-info">
                      <h3>{chapter.title}</h3>
                      {chapter.summary && <p>{chapter.summary}</p>}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p className="no-chapters">Course content is being prepared...</p>
            )}
          </div>
        </div>

        <div className="course-sidebar">
          <div className="enrollment-card">
            <h3>Course Enrollment</h3>
            
            {userRole === 'student' && (
              <>
                {isEnrolled ? (
                  <div className="enrolled-status">
                    <span className="enrolled-badge">✓ Enrolled</span>
                    <button 
                      className="btn-continue"
                      onClick={() => onStartLearning && onStartLearning(courseId)}
                    >
                      Continue Learning
                    </button>
                  </div>
                ) : (
                  <div className="enroll-section">
                    {course.published ? (
                      <>
                        <button className="btn-enroll" onClick={handleEnroll}>
                          Enroll in Course
                        </button>
                        <button 
                          className="btn-preview"
                          onClick={() => onStartLearning && onStartLearning(courseId)}
                        >
                          Preview Course
                        </button>
                      </>
                    ) : (
                      <p className="not-published">This course is not yet available for enrollment.</p>
                    )}
                  </div>
                )}
              </>
            )}

            {(userRole === 'admin' || userRole === 'teacher') && (
              <div className="admin-actions">
                <button className="btn-edit">Edit Course</button>
                <button className="btn-manage">Manage Content</button>
                <button className="btn-students">View Students</button>
              </div>
            )}
          </div>

          <div className="course-info-card">
            <h3>Course Information</h3>
            <div className="info-item">
              <strong>Status:</strong>
              <span className={course.published ? 'status-published' : 'status-draft'}>
                {course.published ? 'Published' : 'Draft'}
              </span>
            </div>
            <div className="info-item">
              <strong>Course ID:</strong>
              <span className="course-id">{course.id}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseDetails;
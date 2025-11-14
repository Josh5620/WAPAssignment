import React, { useState, useEffect, useMemo } from 'react';
import { api, quickApi } from '../services/apiService';
import '../styles/CourseDetails.css';

const CourseDetails = ({ courseId, userRole, onBack, onStartLearning }) => {
  const [course, setCourse] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isEnrolled, setIsEnrolled] = useState(false);

  const normalizedCourseId = useMemo(
    () =>
      course?.id || course?.Id || course?.courseId || course?.CourseId || courseId,
    [course, courseId],
  );

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
        const enrollmentId =
          courseData?.id ||
          courseData?.Id ||
          courseData?.courseId ||
          courseData?.CourseId ||
          courseId;
        const enrolled = await api.enrollments.checkEnrollment(enrollmentId, token);
        setIsEnrolled(enrolled);
      }
    } catch (err) {
      console.error('Failed to fetch course details:', err);
      setError('Failed to load course details. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const metadata = useMemo(() => {
    if (!course) return null;
    return {
      id: course.id || course.Id || course.courseId || course.CourseId || '',
      title: course.title || course.Title || 'Untitled Course',
      description: course.description || course.Description || '',
      previewContent: course.previewContent || course.PreviewContent || '',
      published:
        typeof course.published === 'boolean'
          ? course.published
          : typeof course.Published === 'boolean'
            ? course.Published
            : true,
      chapters:
        course.chapters ||
        course.Chapters ||
        [],
      chapterCount:
        course.chapterCount ??
        course.ChapterCount ??
        course.totalChapters ??
        course.TotalChapters ??
        (Array.isArray(course.chapters) ? course.chapters.length : null) ??
        (Array.isArray(course.Chapters) ? course.Chapters.length : null) ??
        0,
    };
  }, [course]);

  const handleEnroll = async () => {
    try {
      const token = quickApi.getUserToken();
      if (!token) {
        alert('Please log in to enroll in courses');
        return;
      }
      
      await quickApi.enrollInCourse(normalizedCourseId);
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

  if (!course || !metadata) {
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
          <h1 className="course-title">{metadata.title}</h1>
          {metadata.published && (
            <span className="published-badge">Published</span>
          )}
        </div>
      </div>

      <div className="course-details-content">
        <div className="course-main-info">
          <div className="course-description-section">
            <h2>Course Description</h2>
            <p className="course-description">
              {metadata.description || 'No description available for this course.'}
            </p>
          </div>

          {metadata.previewContent && (
            <div className="course-preview-section">
              <h2>What You'll Learn</h2>
              <div className="preview-content">
                <p>{metadata.previewContent}</p>
              </div>
            </div>
          )}

          <div className="course-chapters-section">
            <h2>Course Content</h2>
            {metadata.chapters && metadata.chapters.length > 0 ? (
              <div className="chapters-list">
                {metadata.chapters.map((chapter, index) => {
                  const chapterId =
                    chapter.id ||
                    chapter.Id ||
                    chapter.chapterId ||
                    chapter.ChapterId ||
                    index;
                  const chapterTitle = chapter.title || chapter.Title || `Chapter ${index + 1}`;
                  const chapterSummary = chapter.summary || chapter.Summary || '';
                  const chapterNumber = chapter.number || chapter.Number || index + 1;

                  return (
                    <div key={chapterId} className="chapter-item">
                      <span className="chapter-number">{chapterNumber}</span>
                      <div className="chapter-info">
                        <h3>{chapterTitle}</h3>
                        {chapterSummary && <p>{chapterSummary}</p>}
                      </div>
                    </div>
                  );
                })}
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
                      onClick={() =>
                        onStartLearning &&
                        onStartLearning(normalizedCourseId, metadata.title)
                      }
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
                          onClick={() =>
                            onStartLearning &&
                            onStartLearning(normalizedCourseId, metadata.title)
                          }
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
              <span className={metadata.published ? 'status-published' : 'status-draft'}>
                {metadata.published ? 'Published' : 'Draft'}
              </span>
            </div>
            <div className="info-item">
              <strong>Chapters:</strong>
              <span className="chapter-count-value">{metadata.chapterCount ?? 0}</span>
            </div>
            <div className="info-item">
              <strong>Course ID:</strong>
              <span className="course-id">{metadata.id}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseDetails;
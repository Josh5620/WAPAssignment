import React, { useState, useEffect } from 'react';
import { quickApi } from '../services/apiService';

const normalizeCourse = (course) => ({
  id: course?.id || course?.Id || course?.courseId || course?.CourseId || '',
  title: course?.title || course?.Title || 'Untitled Course',
  description: course?.description || course?.Description || '',
  previewContent: course?.previewContent || course?.PreviewContent || '',
  published:
    typeof course?.published === 'boolean'
      ? course.published
      : typeof course?.Published === 'boolean'
        ? course.Published
        : true,
  chapterCount:
    course?.chapterCount ??
    course?.ChapterCount ??
    course?.totalChapters ??
    course?.TotalChapters ??
    (Array.isArray(course?.chapters) ? course.chapters.length : null) ??
    (Array.isArray(course?.Chapters) ? course.Chapters.length : null) ??
    0,
});

const CourseList = ({ userRole, onCourseSelect, onStartLearning, onEnrollNow }) => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      setLoading(true);
      const coursesData = await quickApi.getCourses();
      setCourses(coursesData);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch courses:', err);
      setError('Failed to load courses. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="course-list-loading">Loading courses...</div>;
  }

  if (error) {
    return (
      <div className="course-list-error">
        <p>{error}</p>
        <button onClick={fetchCourses} className="retry-button">
          Try Again
        </button>
      </div>
    );
  }

  return (
    <div className="course-list-container">
      {courses.length === 0 ? (
        <div className="no-courses">
          <p>No courses available at the moment.</p>
        </div>
      ) : (
        <>
          {courses.map((rawCourse) => {
            const course = normalizeCourse(rawCourse);
            const courseId = course.id;
            return (
              <div key={courseId || course.title} className="course-card-large">
                <div className="course-card-header">
                  {course.published && (
                    <span className="course-badge">Published</span>
                  )}
                </div>

                <div className="course-card-body">
                  <h2>{course.title}</h2>
                  <p className="course-description">
                    {course.description || 'No description available'}
                  </p>

                  {course.previewContent && (
                    <div className="course-preview">
                      <h4>Preview:</h4>
                      <p>{course.previewContent}</p>
                    </div>
                  )}

                  <div className="course-meta-line">
                    <strong>Chapters:</strong> {course.chapterCount ?? 0}
                  </div>
                </div>

                <div className="course-card-actions">
                  <button
                    className="btn-primary"
                    onClick={() => onCourseSelect && onCourseSelect(courseId, course.title)}
                  >
                    View Details
                  </button>

                  {userRole === 'student' && course.published && (
                    <button
                      className="btn-secondary"
                      onClick={() => onEnrollNow && onEnrollNow(courseId, course.title)}
                    >
                      Enroll Now
                    </button>
                  )}

                  {(userRole === 'admin' || userRole === 'teacher') && (
                    <button
                      className="btn-edit"
                      onClick={() =>
                        onCourseSelect
                          ? onCourseSelect(courseId, course.title)
                          : console.log(`Edit course: ${courseId}`)
                      }
                    >
                      Edit Course
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </>
      )}
    </div>
  );
};

export default CourseList;
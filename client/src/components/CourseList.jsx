import React, { useState, useEffect } from 'react';
import { api, quickApi } from '../services/apiService';
import '../styles/CourseList.css';

const CourseList = ({ userRole }) => {
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

  const handleEnrollClick = (courseId) => {
    // Handle enrollment logic
    console.log(`Enrolling in course: ${courseId}`);
    // You would call an enrollment API here
  };

  const handleViewDetails = (courseId) => {
    // Navigate to course details page
    console.log(`Viewing course details: ${courseId}`);
    // You could use React Router here: navigate(`/courses/${courseId}`)
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
      <div className="course-list-header">
        <h2>Available Courses</h2>
        <p>Choose from our programming courses to enhance your skills</p>
      </div>

      {courses.length === 0 ? (
        <div className="no-courses">
          <p>No courses available at the moment.</p>
        </div>
      ) : (
        <div className="courses-grid">
          {courses.map((course) => (
            <div key={course.id} className="course-card">
              <div className="course-header">
                <h3 className="course-title">{course.title}</h3>
                {course.published && (
                  <span className="published-badge">Published</span>
                )}
              </div>
              
              <div className="course-content">
                <p className="course-description">
                  {course.description || 'No description available'}
                </p>
                
                {course.previewContent && (
                  <div className="course-preview">
                    <h4>Preview:</h4>
                    <p>{course.previewContent}</p>
                  </div>
                )}
              </div>

              <div className="course-actions">
                <button 
                  className="btn-primary"
                  onClick={() => handleViewDetails(course.id)}
                >
                  View Details
                </button>
                
                {userRole === 'student' && course.published && (
                  <button 
                    className="btn-secondary"
                    onClick={() => handleEnrollClick(course.id)}
                  >
                    Enroll Now
                  </button>
                )}
                
                {(userRole === 'admin' || userRole === 'teacher') && (
                  <button 
                    className="btn-edit"
                    onClick={() => console.log(`Edit course: ${course.id}`)}
                  >
                    Edit Course
                  </button>
                )}
              </div>

              <div className="course-meta">
                <small>Course ID: {course.id.substring(0, 8)}...</small>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default CourseList;
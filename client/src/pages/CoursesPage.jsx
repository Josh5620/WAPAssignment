import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import CourseList from '../components/CourseList';
import CourseDetails from '../components/CourseDetails';
import EnrollmentSuccessPopup from '../components/EnrollmentSuccessPopup';
import { quickApi, api } from '../services/apiService';
import '../styles/CoursesPage.css';

const CoursesPage = () => {
  const navigate = useNavigate();
  const [userRole, setUserRole] = useState('student');
  const [user, setUser] = useState(null);
  const [selectedCourseId, setSelectedCourseId] = useState(null);
  const [selectedCourseTitle, setSelectedCourseTitle] = useState(null);
  const [enrollmentPopup, setEnrollmentPopup] = useState({ isOpen: false, courseTitle: '' });

  // Redirect guests to guest courses page
  useEffect(() => {
    const currentUser = getUser();
    if (!currentUser) {
      navigate('/guest/courses', { replace: true });
      return;
    }
    
    setUser(currentUser);
    setUserRole(currentUser.role || currentUser.Role || 'student');
  }, [navigate]);

  const handleStartGarden = () => {
    if (userRole === 'student') {
      navigate('/student-dashboard');
    } else if (userRole === 'teacher') {
      navigate('/teacher-dashboard');
    } else if (userRole === 'admin') {
      navigate('/admin-dashboard');
    }
  };

  const handleManageCourse = () => {
    navigate('/manage-course');
  };

  const handleCourseSelect = (courseId, courseTitle) => {
    // Navigate directly to course preview page instead of showing CourseDetails
    navigate(`/courses/${courseId}/view`);
  };

  const handleBackToList = () => {
    setSelectedCourseId(null);
    setSelectedCourseTitle(null);
  };

  const handleEnrollNow = async (courseId, courseTitle) => {
    try {
      const token = quickApi.getUserToken();
      if (!token) {
        alert('Please log in to enroll in courses');
        return;
      }

      // Check if already enrolled
      const isEnrolled = await api.enrollments.checkEnrollment(courseId, token);
      if (isEnrolled) {
        // Already enrolled, just show popup
        setEnrollmentPopup({ isOpen: true, courseTitle });
        return;
      }

      // Enroll the user
      await quickApi.enrollInCourse(courseId);
      
      // Show success popup
      setEnrollmentPopup({ isOpen: true, courseTitle });
    } catch (err) {
      console.error('Failed to enroll:', err);
      alert('Failed to enroll in course. Please try again.');
    }
  };

  const handleStartLearning = async (courseId, courseTitle) => {
    try {
      // Check if user is enrolled, if not, enroll them first
      const token = quickApi.getUserToken();
      if (token && userRole === 'student') {
        const isEnrolled = await api.enrollments.checkEnrollment(courseId, token);
        
        if (!isEnrolled) {
          // Enroll the user first
          await quickApi.enrollInCourse(courseId);
        }
      }
      
      // Navigate to course viewer
      navigate(`/courses/${courseId}/view`);
    } catch (err) {
      console.error('Failed to start learning:', err);
      // Still navigate to course viewer even if enrollment check fails
      navigate(`/courses/${courseId}/view`);
    }
  };

  if (!user) {
    return null;
  }

  const displayName = user.full_name || user.fullName || user.FullName || user.name || 'there';

  // Show the course catalog
  return (
    <>
      <Navbar />
      <div className="courses-page">
        <div className="courses-hero">
          <div className="courses-hero-content">
            <h1>🌱 Explore Courses</h1>
            <p className="courses-subtitle">
              Welcome {displayName}! Browse our courses and start your learning journey.
            </p>
          </div>
        </div>

        <div className="courses-catalog-section">
          <CourseList
            userRole={userRole}
            onCourseSelect={handleCourseSelect}
            onStartLearning={handleStartLearning}
            onEnrollNow={handleEnrollNow}
          />
        </div>

        <EnrollmentSuccessPopup
          isOpen={enrollmentPopup.isOpen}
          courseTitle={enrollmentPopup.courseTitle}
          onClose={() => setEnrollmentPopup({ isOpen: false, courseTitle: '' })}
        />

        <div className="courses-cta">
          <h2>Ready to grow your Python skills?</h2>
          <p>Start your interactive learning journey today</p>
          <PrimaryButton size="lg" onClick={handleStartGarden}>
            {userRole === 'student' ? 'Go to My Garden' : 'Go to Dashboard'}
          </PrimaryButton>
        </div>
      </div>
    </>
  );
};

export default CoursesPage;
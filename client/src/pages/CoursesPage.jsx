import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import CourseList from '../components/CourseList';
import CourseDetails from '../components/CourseDetails';
import CourseViewer from '../components/CourseViewer';
import '../styles/CoursesPage.css';

const CoursesPage = () => {
  const navigate = useNavigate();
  const [currentView, setCurrentView] = useState('list'); // 'list', 'details', 'viewer'
  const [selectedCourseId, setSelectedCourseId] = useState(null);
  const [userRole, setUserRole] = useState('student');
  const [breadcrumb, setBreadcrumb] = useState(['Courses']);

  // Redirect guests to guest courses page
  useEffect(() => {
    const user = getUser();
    if (!user) {
      // User is not logged in, redirect to guest courses page
      navigate('/guest/courses', { replace: true });
      return;
    }
    
    // Get user role from localStorage or auth context
    setUserRole(user.role || user.Role || 'student');
  }, [navigate]);

  const handleCourseSelect = (courseId, courseName) => {
    setSelectedCourseId(courseId);
    setCurrentView('details');
    setBreadcrumb(['Courses', courseName || 'Course Details']);
  };

  const handleStartLearning = (courseId, courseName) => {
    setSelectedCourseId(courseId);
    setCurrentView('viewer');
    setBreadcrumb(['Courses', courseName || 'Course', 'Learn']);
  };

  const handleBackToList = () => {
    setCurrentView('list');
    setSelectedCourseId(null);
    setBreadcrumb(['Courses']);
  };

  const handleBackToDetails = () => {
    setCurrentView('details');
    setBreadcrumb(prev => prev.slice(0, -1));
  };

  return (
    <div className="courses-page">
      {/* Breadcrumb Navigation */}
      <div className="breadcrumb">
        {breadcrumb.map((item, index) => (
          <span key={index} className="breadcrumb-item">
            {index > 0 && <span className="breadcrumb-separator">›</span>}
            {item}
          </span>
        ))}
      </div>

      {/* Dynamic Content Based on Current View */}
      {currentView === 'list' && (
        <CourseList 
          userRole={userRole}
          onCourseSelect={handleCourseSelect}
          onStartLearning={handleStartLearning}
        />
      )}
      
      {currentView === 'details' && (
        <CourseDetails 
          courseId={selectedCourseId}
          userRole={userRole}
          onBack={handleBackToList}
          onStartLearning={handleStartLearning}
        />
      )}
      
      {currentView === 'viewer' && (
        <CourseViewer 
          courseId={selectedCourseId}
          userRole={userRole}
          onBack={handleBackToDetails}
        />
      )}
    </div>
  );
};

export default CoursesPage;
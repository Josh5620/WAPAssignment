import React from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import '../styles/EnrollmentSuccessPopup.css';

const EnrollmentSuccessPopup = ({ isOpen, courseTitle, onClose }) => {
  const navigate = useNavigate();
  const user = getUser();

  if (!isOpen) return null;

  const handleGoToDashboard = () => {
    if (user?.role === 'teacher') {
      navigate('/teacher-dashboard');
    } else if (user?.role === 'admin') {
      navigate('/admin-dashboard');
    } else {
      navigate('/student-dashboard');
    }
    onClose();
  };

  const handleOverlayClick = (e) => {
    if (e.target === e.currentTarget) onClose();
  };

  return (
    <div className="enrollment-popup-overlay" onClick={handleOverlayClick}>
      <div className="enrollment-popup-content">
        <div className="enrollment-popup-header">
          <h3>🌱 Successfully Enrolled!</h3>
          <button className="enrollment-close-button" onClick={onClose}>×</button>
        </div>
        <div className="enrollment-popup-body">
          <div className="enrollment-success-message">
            <p>You're now enrolled in:</p>
            <h4>{courseTitle || 'This course'}</h4>
            <p className="enrollment-submessage">Start your learning journey and watch your garden grow!</p>
          </div>
          <div className="enrollment-popup-actions">
            <button 
              className="enrollment-dashboard-button"
              onClick={handleGoToDashboard}
            >
              Go to Dashboard
            </button>
            <button 
              className="enrollment-close-button-secondary"
              onClick={onClose}
            >
              Stay Here
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default EnrollmentSuccessPopup;


import React from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';

const GuestRestrictionBanner = ({ message, showLogin = true }) => {
  const navigate = useNavigate();
  const isLoggedIn = getUser() !== null;

  if (isLoggedIn) {
    return null; // Don't show banner if user is logged in
  }

  return (
    <div className="guest-restriction-banner">
      <div className="banner-content">
        <div className="banner-icon">🔒</div>
        <div className="banner-text">
          <strong>Preview Mode</strong>
          <p>{message || 'Register or log in to access full content and features.'}</p>
        </div>
        <div className="banner-actions">
          <button
            className="banner-register-button"
            onClick={() => navigate('/register')}
          >
            Register Free
          </button>
          {showLogin && (
            <button
              className="banner-login-button"
              onClick={() => navigate('/login')}
            >
              Log In
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default GuestRestrictionBanner;


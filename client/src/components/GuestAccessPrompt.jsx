import React from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';

const GuestAccessPrompt = ({ 
  title = "Want Full Access?", 
  message = "Register now to unlock all features!",
  featureList = []
}) => {
  const navigate = useNavigate();
  const isLoggedIn = getUser() !== null;

  if (isLoggedIn) {
    return null; // Don't show prompt if user is logged in
  }

  return (
    <div className="guest-access-prompt">
      <div className="prompt-header">
        <h3>{title}</h3>
        <p>{message}</p>
      </div>

      {featureList.length > 0 && (
        <div className="prompt-features">
          <h4>Full Access Includes:</h4>
          <ul>
            {featureList.map((feature, index) => (
              <li key={index}>✓ {feature}</li>
            ))}
          </ul>
        </div>
      )}

      <div className="prompt-actions">
        <button
          className="prompt-register-button"
          onClick={() => navigate('/register')}
        >
          Register for Free
        </button>
        <button
          className="prompt-login-button"
          onClick={() => navigate('/login')}
        >
          Already have an account? Log In
        </button>
      </div>
    </div>
  );
};

export default GuestAccessPrompt;


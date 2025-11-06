import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import '../styles/Navbar.css';

const Navbar = () => {
  const [visible, setVisible] = useState(true);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const timerRef = useRef(null);
  const navigate = useNavigate();

  // Check login status and update on mount and when storage changes
  useEffect(() => {
    const checkLoginStatus = () => {
      const user = getUser();
      setIsLoggedIn(user !== null);
    };

    checkLoginStatus();
    
    // Listen for storage changes (when user logs in/out in another tab)
    window.addEventListener('storage', checkLoginStatus);
    
    // Also check periodically in case login happens in same tab
    const interval = setInterval(checkLoginStatus, 1000);
    
    return () => {
      window.removeEventListener('storage', checkLoginStatus);
      clearInterval(interval);
    };
  }, []);

  // Always show navbar at top, auto-hide when scrolled down
  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY === 0) {
        setVisible(true);
        clearTimeout(timerRef.current);
      }
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const showNavbar = () => {
    setVisible(true);
    clearTimeout(timerRef.current);
    if (window.scrollY !== 0) {
      timerRef.current = setTimeout(() => setVisible(false), 3000);
    }
  };

  // Hide after 3s when not at top
  useEffect(() => {
    if (visible && window.scrollY !== 0) {
      timerRef.current = setTimeout(() => setVisible(false), 3000);
    }
    return () => clearTimeout(timerRef.current);
  }, [visible]);

  const handleLogin = () => {
    navigate('/Login');
  };

  const handleRegister = () => {
    navigate('/register');
  };

  return (
    <nav
      className={`navbar${visible ? '' : ' navbar-hidden'}`}
      onMouseEnter={showNavbar}
      onClick={showNavbar}
    >
      <div className="nav-left">
        <Link to="/" className="logo" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
          <img src="/CodeSage.svg" alt="CodeSage" className="logo-text" />
          <img src="/CodeSageLogo.svg" alt="CodeSage Hat" className="logo-hat" />
        </Link>
        <div className="nav-links">
          <Link to="/" className="nav-link home-link">Home</Link>
          <Link 
            to={isLoggedIn ? "/courses" : "/guest/courses"} 
            className="nav-link"
          >
            Courses
          </Link>
          <Link to="/about" className="nav-link about-link">
            About
          </Link>
          <Link to="/faq" className="nav-link">
            FAQ
          </Link>
          {isLoggedIn && (
            <Link to="/student-dashboard" className="nav-link">
              Dashboard
            </Link>
          )}
        </div>
      </div>
      <div className="nav-right">
        {isLoggedIn ? (
          <>
            <Link to="/student-profile" className="nav-link">
              Profile
            </Link>
            <button 
              onClick={() => {
                localStorage.removeItem('access_token');
                localStorage.removeItem('user_profile');
                navigate('/');
                window.location.reload();
              }} 
              className="nav-login"
            >
              Logout
            </button>
          </>
        ) : (
          <>
            <button onClick={handleLogin} className="nav-login">Login</button>
            <button onClick={handleRegister} className="nav-register">Register</button>
          </>
        )}
      </div>
    </nav>
  );
};

export default Navbar;
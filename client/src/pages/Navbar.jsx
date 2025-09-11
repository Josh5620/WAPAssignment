import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import '../styles/Navbar.css';

const Navbar = () => {
  const [visible, setVisible] = useState(true);
  const timerRef = useRef(null);
  const navigate = useNavigate();

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
        <div className="logo">
          <img src="/CodeSage.svg" alt="CodeSage" className="logo-text" />
          <img src="/CodeSageLogo.svg" alt="CodeSage Hat" className="logo-hat" />
        </div>
        <div className="nav-links">
          <Link to="/" className="nav-link home-link">Home</Link>
          <div className="nav-item-dropdown">
            <span className="nav-link">
              Courses <span className="dropdown-arrow">▼</span>
            </span>
            <div className="dropdown-menu">
              <a href="#html" className="dropdown-item">HTML Basics</a>
              <a href="#javascript" className="dropdown-item">JavaScript Essentials</a>
              <a href="#python" className="dropdown-item">Python Basics</a>
              <a href="#css" className="dropdown-item">CSS Styling</a>
              <a href="#react" className="dropdown-item">React Fundamentals</a>
            </div>
          </div>
          <Link to="/about" className="nav-link about-link">About</Link>
          <a href="#faq" className="nav-link">FAQ</a>
        </div>
      </div>
      <div className="nav-right">
        <button onClick={handleLogin} className="nav-login">Login</button>
        <button onClick={handleRegister} className="nav-register">Register</button>
      </div>
    </nav>
  );
};

export default Navbar;
import React, { useEffect, useRef, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext.jsx';
import ThemeSelector from './ThemeSelector.jsx';
import '../styles/Navbar.css';

const getDashboardPath = (role) => {
  const normalized = typeof role === 'string' ? role.toLowerCase() : null;
  if (normalized === 'teacher') return '/teacher-dashboard';
  if (normalized === 'admin') return '/admin-dashboard';
  return '/student-dashboard';
};

const Navbar = () => {
  const [visible, setVisible] = useState(true);
  const timerRef = useRef(null);
  const navigate = useNavigate();
  const { isLoggedIn, role, logout } = useAuth();

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

  useEffect(() => {
    const handleShowNavbar = () => showNavbar();
    window.addEventListener('showNavbar', handleShowNavbar);
    return () => window.removeEventListener('showNavbar', handleShowNavbar);
  }, []);

  useEffect(() => {
    if (visible && window.scrollY !== 0) {
      timerRef.current = setTimeout(() => setVisible(false), 3000);
    }
    return () => clearTimeout(timerRef.current);
  }, [visible]);

  const handleLogin = () => navigate('/login');
  const handleRegister = () => navigate('/register');

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  const dashboardPath = getDashboardPath(role);

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
          <Link to="/" className="nav-link home-link">
            HOME
          </Link>
          <Link to={isLoggedIn ? '/courses' : '/guest/courses'} className="nav-link">
            COURSES
          </Link>
          <Link to="/about" className="nav-link about-link">
            ABOUT
          </Link>
          <Link to="/faq" className="nav-link">
            FAQ
          </Link>
          {isLoggedIn && (
            <Link to={dashboardPath} className="nav-link">
              Dashboard
            </Link>
          )}
        </div>
      </div>
      <div className="nav-right">
        <ThemeSelector />
        {isLoggedIn ? (
          <>
            <Link to="/student-profile" className="nav-link">
              Profile
            </Link>
            <button onClick={handleLogout} className="nav-login">
              Logout
            </button>
          </>
        ) : (
          <>
            <button onClick={handleLogin} className="nav-login">
              LOGIN
            </button>
            <button onClick={handleRegister} className="nav-register">
              REGISTER
            </button>
          </>
        )}
      </div>
    </nav>
  );
};

export default Navbar;

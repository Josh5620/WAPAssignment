import React, { useEffect, useState } from 'react';
import { Link, NavLink, useLocation, useNavigate } from 'react-router-dom';
import ThemeSelector from './ThemeSelector';
import PrimaryButton from './PrimaryButton';
import { useAuth } from '../context/AuthContext.jsx';
import '../styles/Navbar.css';

const getDashboardPath = (role) => {
  const normalized = typeof role === 'string' ? role.toLowerCase() : null;
  if (normalized === 'teacher') return '/teacher-dashboard';
  if (normalized === 'admin') return '/admin-dashboard';
  return '/student-dashboard';
};

const Navbar = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { isLoggedIn, role, logout } = useAuth();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 12);
    };

    handleScroll();
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    setIsMenuOpen(false);
  }, [location.pathname]);

  const dashboardPath = getDashboardPath(role);

  const navLinks = [
    { label: 'Home', to: '/' },
    { label: 'Courses', to: isLoggedIn ? '/courses' : '/guest/courses' },
    { label: 'About', to: '/about' },
    { label: 'FAQ', to: '/faq' },
  ];

  // Add Community link only for logged-in users
  if (isLoggedIn) {
    navLinks.splice(2, 0, { label: 'Community', to: '/forum' });
  }

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  return (
    <header className={`navbar ${isScrolled ? 'navbar--scrolled' : ''}`}>
      <div className="navbar__inner">
        <Link to="/" className="navbar__logo" aria-label="CodeSage Home">
          <img src="/CodeSage.svg" alt="CodeSage" className="navbar__logo-text" />
          <img src="/CodeSageLogo.svg" alt="CodeSage sprout" className="navbar__logo-icon" />
        </Link>

        <button
          className={`navbar__toggle ${isMenuOpen ? 'is-open' : ''}`}
          onClick={() => setIsMenuOpen((prev) => !prev)}
          aria-expanded={isMenuOpen}
          aria-controls="primary-navigation"
          aria-label="Toggle navigation"
        >
          <span />
          <span />
          <span />
        </button>

        <nav
          id="primary-navigation"
          className={`navbar__links ${isMenuOpen ? 'is-open' : ''}`}
          aria-label="Primary navigation"
        >
          {navLinks.map((link) => (
            <NavLink
              key={link.label}
              to={link.to}
              className={({ isActive }) =>
                `navbar__link${isActive ? ' navbar__link--active' : ''}`
              }
            >
              {link.label}
            </NavLink>
          ))}
          {isLoggedIn && (
            <NavLink
              to={dashboardPath}
              className={({ isActive }) =>
                `navbar__link navbar__link--dashboard${isActive ? ' navbar__link--active' : ''}`
              }
            >
              Dashboard
            </NavLink>
          )}
          <div className="navbar__mobile-actions">
            <ThemeSelector />
            {isLoggedIn ? (
              <PrimaryButton
                variant="outline"
                size="md"
                fullWidth
                onClick={handleLogout}
              >
                Log Out
              </PrimaryButton>
            ) : (
              <>
                <PrimaryButton
                  variant="secondary"
                  size="md"
                  fullWidth
                  onClick={() => navigate('/login')}
                >
                  Log In
                </PrimaryButton>
                <PrimaryButton
                  size="md"
                  fullWidth
                  onClick={() => navigate('/register')}
                >
                  Sign Up
                </PrimaryButton>
              </>
            )}
          </div>
        </nav>

        <div className="navbar__actions">
          <ThemeSelector />
          {isLoggedIn ? (
            <>
              <Link 
                to={role === 'teacher' ? '/teacher-profile' : '/student-profile'} 
                className="navbar__profile-link"
              >
                Profile
              </Link>
              <PrimaryButton
                variant="outline"
                size="sm"
                className="navbar__auth-btn"
                onClick={handleLogout}
              >
                Log Out
              </PrimaryButton>
            </>
          ) : (
            <>
              <PrimaryButton
                variant="ghost"
                size="sm"
                className="navbar__auth-btn"
                onClick={() => navigate('/login')}
              >
                Log In
              </PrimaryButton>
              <PrimaryButton
                size="sm"
                className="navbar__auth-btn"
                onClick={() => navigate('/register')}
              >
                Sign Up
              </PrimaryButton>
            </>
          )}
        </div>
      </div>
    </header>
  );
};

export default Navbar;

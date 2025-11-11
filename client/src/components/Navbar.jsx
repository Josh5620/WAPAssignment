import React, { useEffect, useRef, useState } from 'react';
import { Link, NavLink, useLocation, useNavigate } from 'react-router-dom';
import ThemeSelector from './ThemeSelector';
import PrimaryButton from './PrimaryButton';
import { useAuth } from '../context/AuthContext.jsx';
import '../styles/Navbar.css';
import { api } from '../services/apiService';

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
  const [notifications, setNotifications] = useState([]);
  const [notificationsLoading, setNotificationsLoading] = useState(false);
  const [notificationsOpen, setNotificationsOpen] = useState(false);
  const notificationsRef = useRef(null);

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
    setNotificationsOpen(false);
  }, [location.pathname]);

  useEffect(() => {
    if (!isLoggedIn) {
      setNotifications([]);
      return;
    }

    const loadNotifications = async () => {
      try {
        setNotificationsLoading(true);
        const response = await api.notifications.list(true);
        const items = Array.isArray(response?.notifications) ? response.notifications : [];
        setNotifications(items);
      } catch (error) {
        console.error('Failed to load notifications in navbar:', error);
      } finally {
        setNotificationsLoading(false);
      }
    };

    loadNotifications();
  }, [isLoggedIn]);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!notificationsOpen) return;
      if (notificationsRef.current && !notificationsRef.current.contains(event.target)) {
        setNotificationsOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [notificationsOpen]);

  const refreshNotifications = async () => {
    try {
      const response = await api.notifications.list(true);
      const items = Array.isArray(response?.notifications) ? response.notifications : [];
      setNotifications(items);
    } catch (error) {
      console.error('Failed to refresh notifications:', error);
    }
  };

  const handleMarkNotificationRead = async (notificationId) => {
    try {
      await api.notifications.markRead(notificationId);
      setNotifications((prev) =>
        prev.map((item) =>
          item.notificationId === notificationId ? { ...item, isRead: true } : item,
        ),
      );
    } catch (error) {
      console.error('Failed to mark navbar notification as read:', error);
    }
  };

  const handleMarkAllNotificationsRead = async () => {
    try {
      await api.notifications.markAllRead();
      refreshNotifications();
    } catch (error) {
      console.error('Failed to mark all navbar notifications as read:', error);
    }
  };

  const unreadCount = notifications.filter((item) => !item.isRead).length;

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
              <div
                className={`navbar__notifications ${notificationsOpen ? 'is-open' : ''}`}
                ref={notificationsRef}
              >
                <button
                  type="button"
                  className="notification-bell"
                  onClick={() => {
                    setNotificationsOpen((prev) => !prev);
                    if (!notificationsOpen) {
                      refreshNotifications();
                    }
                  }}
                  aria-label="Notifications"
                >
                  <span role="img" aria-hidden="true">
                    🔔
                  </span>
                  {unreadCount > 0 && <span className="notification-count">{unreadCount}</span>}
                </button>
                {notificationsOpen && (
                  <div className="notification-dropdown">
                    <div className="notification-dropdown__header">
                      <span>Garden Alerts</span>
                      <button
                        type="button"
                        onClick={handleMarkAllNotificationsRead}
                        disabled={!unreadCount}
                      >
                        Mark all read
                      </button>
                    </div>
                    <div className="notification-dropdown__body">
                      {notificationsLoading ? (
                        <div className="notification-dropdown__empty">Growing fresh updates…</div>
                      ) : notifications.length === 0 ? (
                        <div className="notification-dropdown__empty">
                          Nothing new to see — keep cultivating!
                        </div>
                      ) : (
                        notifications.slice(0, 5).map((item) => (
                          <div
                            key={item.notificationId}
                            className={`notification-dropdown__item ${
                              item.isRead ? 'is-read' : 'is-unread'
                            }`}
                          >
                            <p>{item.message}</p>
                            <div className="notification-dropdown__meta">
                              <span>
                                {new Date(item.createdAt).toLocaleTimeString([], {
                                  hour: '2-digit',
                                  minute: '2-digit',
                                })}
                              </span>
                              {!item.isRead && (
                                <button
                                  type="button"
                                  onClick={() => handleMarkNotificationRead(item.notificationId)}
                                >
                                  Done
                                </button>
                              )}
                            </div>
                          </div>
                        ))
                      )}
                    </div>
                  </div>
                )}
              </div>
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

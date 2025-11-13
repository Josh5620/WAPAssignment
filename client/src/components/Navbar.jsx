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
  const [unreadCount, setUnreadCount] = useState(0);
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
      setUnreadCount(0);
      return;
    }

    const loadNotifications = async () => {
      try {
        setNotificationsLoading(true);
        const response = await api.notifications.list(true);
        const items = Array.isArray(response?.notifications) ? response.notifications : [];
        setNotifications(items);
        setUnreadCount(response?.unread ?? items.length);
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
      setNotificationsLoading(true);
      const response = await api.notifications.list();
      const items = Array.isArray(response?.notifications) ? response.notifications : [];
      setNotifications(items);
      setUnreadCount(response?.unread ?? items.filter((item) => !item.isRead).length);
    } catch (error) {
      console.error('Failed to refresh notifications:', error);
    } finally {
      setNotificationsLoading(false);
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
      setUnreadCount((prev) => Math.max(0, prev - 1));
    } catch (error) {
      console.error('Failed to mark navbar notification as read:', error);
    }
  };

  const handleMarkAllNotificationsRead = async () => {
    try {
      await api.notifications.markAllRead();
      setNotifications((prev) => prev.map((item) => ({ ...item, isRead: true })));
      setUnreadCount(0);
    } catch (error) {
      console.error('Failed to mark all navbar notifications as read:', error);
    }
  };

  // Determine navigation path based on notification message
  const getNotificationPath = (message) => {
    if (!message) return null;
    
    const msg = message.toLowerCase();
    
    // Forum replies
    if (msg.includes('replied to your post') || msg.includes('replied to your comment')) {
      return '/forum';
    }
    
    // Course approval/rejection (for teachers)
    if (msg.includes('course') && (msg.includes('approved') || msg.includes('rejected'))) {
      if (role === 'teacher') {
        return '/manage-course';
      }
      return '/teacher-dashboard';
    }
    
    // Announcements
    if (msg.includes('📣') || msg.startsWith('📣')) {
      // Navigate to appropriate dashboard based on role
      if (role === 'admin') return '/admin-dashboard';
      if (role === 'teacher') return '/teacher-dashboard';
      return '/student-dashboard';
    }
    
    // Help request responses
    if (msg.includes('help request') || msg.includes('reply from your teacher')) {
      return '/student-dashboard';
    }
    
    // Default: go to appropriate dashboard
    if (role === 'admin') return '/admin-dashboard';
    if (role === 'teacher') return '/teacher-dashboard';
    return '/student-dashboard';
  };

  const handleNotificationClick = async (notification) => {
    try {
      // Mark as read if unread
      if (!notification.isRead) {
        await handleMarkNotificationRead(notification.notificationId);
      }
      
      // Get navigation path
      const path = getNotificationPath(notification.message);
      if (path) {
        setNotificationsOpen(false); // Close notification dropdown
        navigate(path);
      }
    } catch (error) {
      console.error('Failed to handle notification click:', error);
    }
  };

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
                  <img src="/bell.svg" alt="" aria-hidden="true" style={{ width: '20px', height: '20px' }} />
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
                            onClick={() => handleNotificationClick(item)}
                            style={{ cursor: 'pointer' }}
                            role="button"
                            tabIndex={0}
                            onKeyDown={(e) => {
                              if (e.key === 'Enter' || e.key === ' ') {
                                e.preventDefault();
                                handleNotificationClick(item);
                              }
                            }}
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
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    handleMarkNotificationRead(item.notificationId);
                                  }}
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

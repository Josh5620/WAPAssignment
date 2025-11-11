import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import GardenPath from '../components/GardenPath.jsx';
import { gardenPathData } from '../data/curriculum.js';
import '../styles/StudentDashboard.css';
import { useAuth } from '../context/AuthContext.jsx';
import { api } from '../services/apiService';

const StudentDashboard = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [progress, setProgress] = useState({
    completedChapterIds: [],
    currentChapterId: 1,
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [notifications, setNotifications] = useState([]);
  const [notificationsMeta, setNotificationsMeta] = useState({ total: 0, unread: 0 });
  const [notificationsLoading, setNotificationsLoading] = useState(true);
  const [notificationsError, setNotificationsError] = useState(null);

  useEffect(() => {
    const fetchProgress = async () => {
      if (!user || !user.id) {
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        // Fetch real progress from API using user ID
        const progressData = await api.students.getStudentProgress(user.id);
        setProgress({
          completedChapterIds: progressData.completedChapterIds || [],
          currentChapterId: progressData.currentChapterId || 1,
        });
        setError(null);
      } catch (err) {
        console.error('Failed to load progress:', err);
        // Set default empty progress if API fails
        setProgress({
          completedChapterIds: [],
          currentChapterId: 1,
        });
        // Only show error if it's not a 404 (no progress yet)
        if (err.status !== 404) {
          setError('Unable to load your progress. Starting fresh!');
        }
      } finally {
        setLoading(false);
      }
    };

    fetchProgress();
  }, [user]);

  const displayName = useMemo(() => {
    if (!user) return 'student';
    return (
      user.full_name ||
      user.fullName ||
      user.FullName ||
      user.name ||
      user.displayName ||
      'student'
    );
  }, [user]);

  const greeting = useMemo(() => {
    return `Hello ${displayName}, ready to keep your garden growing today?`;
  }, [displayName]);

  const fetchNotifications = async () => {
    if (!user) {
      setNotifications([]);
      setNotificationsMeta({ total: 0, unread: 0 });
      setNotificationsLoading(false);
      return;
    }

    try {
      setNotificationsLoading(true);
      const response = await api.notifications.list();
      const items = Array.isArray(response?.notifications) ? response.notifications : [];
      setNotifications(items);
      setNotificationsMeta({
        total: response?.total ?? items.length,
        unread: response?.unread ?? items.filter((item) => !item.isRead).length,
      });
      setNotificationsError(null);
    } catch (err) {
      console.error('Failed to load notifications:', err);
      setNotificationsError('Unable to refresh your latest updates right now.');
    } finally {
      setNotificationsLoading(false);
    }
  };

  useEffect(() => {
    fetchNotifications();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user]);

  const handleNotificationRead = async (notificationId) => {
    if (!notificationId) return;
    try {
      await api.notifications.markRead(notificationId);
      setNotifications((prev) =>
        prev.map((item) =>
          item.notificationId === notificationId ? { ...item, isRead: true } : item,
        ),
      );
      setNotificationsMeta((prev) => ({
        ...prev,
        unread: Math.max(0, prev.unread - 1),
      }));
    } catch (err) {
      console.error('Failed to mark notification as read:', err);
    }
  };

  const handleMarkAllNotifications = async () => {
    try {
      await api.notifications.markAllRead();
      setNotifications((prev) => prev.map((item) => ({ ...item, isRead: true })));
      setNotificationsMeta((prev) => ({
        ...prev,
        unread: 0,
      }));
    } catch (err) {
      console.error('Failed to mark all notifications as read:', err);
    }
  };

  const renderNotifications = () => {
    if (notificationsLoading) {
      return <li className="notification-item is-loading">Growing fresh updates…</li>;
    }

    if (notificationsError) {
      return <li className="notification-item is-error">{notificationsError}</li>;
    }

    if (!notifications.length) {
      return <li className="notification-item is-empty">No alerts yet — plant some progress to see blooms here!</li>;
    }

    return notifications.slice(0, 4).map((notification) => (
      <li
        key={notification.notificationId}
        className={`notification-item ${notification.isRead ? 'is-read' : 'is-unread'}`}
      >
        <div className="notification-message">{notification.message}</div>
        <div className="notification-meta">
          <span>{new Date(notification.createdAt).toLocaleString()}</span>
          {!notification.isRead && (
            <button
              type="button"
              className="btn-notification-read"
              onClick={() => handleNotificationRead(notification.notificationId)}
            >
              Mark as read
            </button>
          )}
        </div>
      </li>
    ));
  };

  const handleChapterSelection = (chapter, status) => {
    if (status === 'is-locked') {
      return; // Don't navigate if locked
    }
    navigate(`/chapters/${chapter.id}`);
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="student-dashboard-loading">
          <div className="loading-spinner">🌱</div>
          <p>Loading your garden...</p>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <main className="student-dashboard-page">
        {error && (
          <div className="dashboard-notice">
            <span>ℹ️</span>
            <p>{error}</p>
          </div>
        )}
        <section className="student-dashboard-header">
          <h1>Your Garden</h1>
          <p>{greeting}</p>
        </section>

        <section className="student-dashboard-notifications">
          <div className="notifications-card">
            <div className="notifications-header">
              <div>
                <h2>Garden Alerts</h2>
                <p>
                  {notificationsMeta.unread > 0
                    ? `You have ${notificationsMeta.unread} new ${
                        notificationsMeta.unread === 1 ? 'sprout' : 'sprouts'
                      } to check on.`
                    : 'All calm in the garden. Keep nurturing your growth!'}
                </p>
              </div>
              <button
                type="button"
                className="btn-notification-all"
                onClick={handleMarkAllNotifications}
                disabled={!notificationsMeta.unread}
              >
                Mark all read
              </button>
            </div>
            <ul className="notification-list">{renderNotifications()}</ul>
          </div>
        </section>

        <GardenPath
          chapters={gardenPathData}
          progress={progress}
          onChapterClick={handleChapterSelection}
        />
      </main>
    </>
  );
};

export default StudentDashboard;

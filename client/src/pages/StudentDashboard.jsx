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
  const [myCourses, setMyCourses] = useState([]);
  const [myCoursesLoading, setMyCoursesLoading] = useState(true);
  const [myCoursesError, setMyCoursesError] = useState(null);

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

  const loadMyCourses = async () => {
    if (!user) {
      setMyCourses([]);
      setMyCoursesLoading(false);
      return;
    }

    try {
      setMyCoursesLoading(true);
      const response = await api.students.listMyCourses();
      const courses = Array.isArray(response?.courses)
        ? response.courses
        : Array.isArray(response)
          ? response
          : [];
      setMyCourses(courses);
      setMyCoursesError(null);
    } catch (err) {
      console.error('Failed to load enrolled courses:', err);
      setMyCoursesError('We could not load your enrolled courses.');
    } finally {
      setMyCoursesLoading(false);
    }
  };

  useEffect(() => {
    fetchNotifications();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user]);

  useEffect(() => {
    loadMyCourses();
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

  const handleUnenroll = async (enrollmentId) => {
    if (!enrollmentId) return;

    try {
      await api.students.unenroll(enrollmentId);
      await loadMyCourses();
    } catch (err) {
      console.error('Failed to unenroll:', err);
      setMyCoursesError('Unable to update enrollment. Please try again.');
    }
  };

  const renderMyCourses = () => {
    if (myCoursesLoading) {
      return <li className="course-item is-loading">Loading your courses…</li>;
    }

    if (myCoursesError) {
      return <li className="course-item is-error">{myCoursesError}</li>;
    }

    if (!myCourses.length) {
      return (
        <li className="course-item is-empty">
          You are not enrolled in any courses yet. Explore the catalog to start growing!
        </li>
      );
    }

    return myCourses.map((course) => (
      <li key={course.enrollmentId || course.courseId} className="course-item">
        <div className="course-info">
          <h3>{course.courseTitle}</h3>
          {course.courseDescription && <p>{course.courseDescription}</p>}
          <small>
            Enrolled {course.enrolledAt ? new Date(course.enrolledAt).toLocaleDateString() : 'recently'}
          </small>
        </div>
        <div className="course-actions">
          <button
            type="button"
            className="btn-course-view"
            onClick={() => navigate(`/courses/${course.courseId}`)}
          >
            Continue
          </button>
          <button
            type="button"
            className="btn-course-unenroll"
            onClick={() => handleUnenroll(course.enrollmentId)}
          >
            Unenroll
          </button>
        </div>
      </li>
    ));
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
      return '/manage-course';
    }
    
    // Announcements
    if (msg.includes('📣') || msg.startsWith('📣')) {
      return '/student-dashboard';
    }
    
    // Help request responses
    if (msg.includes('help request') || msg.includes('reply from your teacher')) {
      return '/student-dashboard';
    }
    
    // Default: stay on dashboard
    return '/student-dashboard';
  };

  const handleNotificationClick = async (notification) => {
    try {
      // Mark as read if unread
      if (!notification.isRead) {
        await handleNotificationRead(notification.notificationId);
      }
      
      // Get navigation path
      const path = getNotificationPath(notification.message);
      if (path) {
        navigate(path);
      }
    } catch (error) {
      console.error('Failed to handle notification click:', error);
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
        onClick={() => handleNotificationClick(notification)}
        style={{ cursor: 'pointer' }}
        role="button"
        tabIndex={0}
        onKeyDown={(e) => {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            handleNotificationClick(notification);
          }
        }}
      >
        <div className="notification-message">{notification.message}</div>
        <div className="notification-meta">
          <span>{new Date(notification.createdAt).toLocaleString()}</span>
          {!notification.isRead && (
            <button
              type="button"
              className="btn-notification-read"
              onClick={(e) => {
                e.stopPropagation();
                handleNotificationRead(notification.notificationId);
              }}
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

  // Check if student is enrolled in any courses
  const isEnrolled = myCourses.length > 0;

  if (loading || myCoursesLoading) {
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

  // Show enrollment prompt if not enrolled
  if (!isEnrolled) {
    return (
      <>
        <Navbar />
        <main className="student-dashboard-page">
          <section className="student-dashboard-header">
            <h1>Welcome to Your Garden!</h1>
            <p>{greeting}</p>
          </section>

          <section className="student-dashboard-enrollment-prompt">
            <div className="enrollment-prompt-card">
              <div className="enrollment-prompt-icon">🌱</div>
              <h2>Start Your Learning Journey</h2>
              <p>
                You're not enrolled in any courses yet. Enroll in a course to unlock your garden and start growing your skills!
              </p>
              <button
                type="button"
                className="btn-enroll-now"
                onClick={() => navigate('/courses')}
              >
                Explore Courses
              </button>
            </div>
          </section>

          <section className="student-dashboard-courses">
            <div className="courses-card">
              <div className="courses-header">
                <div>
                  <h2>My Courses</h2>
                  <p>Enroll in a course to start your learning journey.</p>
                </div>
                <button
                  type="button"
                  className="btn-explore-courses"
                  onClick={() => navigate('/courses')}
                >
                  Explore Courses
                </button>
              </div>
              <ul className="courses-list">{renderMyCourses()}</ul>
            </div>
          </section>
        </main>
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

        <GardenPath
          chapters={gardenPathData}
          progress={progress}
          onChapterClick={handleChapterSelection}
        />

        <section className="student-dashboard-courses">
          <div className="courses-card">
            <div className="courses-header">
              <div>
                <h2>My Courses</h2>
                <p>
                  {myCourses.length > 0
                    ? `You are nurturing ${myCourses.length} course${myCourses.length === 1 ? '' : 's'}.`
                    : 'Enroll in a course to start your learning journey.'}
                </p>
              </div>
              <button
                type="button"
                className="btn-explore-courses"
                onClick={() => navigate('/courses')}
              >
                Explore Courses
              </button>
            </div>
            <ul className="courses-list">{renderMyCourses()}</ul>
          </div>
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
      </main>
    </>
  );
};

export default StudentDashboard;

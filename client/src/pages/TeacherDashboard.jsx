import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import FeedbackModal from '../components/FeedbackModal';
import TeacherForumManager from '../components/TeacherForumManager';
import TeacherFeedbackQueue from '../components/TeacherFeedbackQueue';
import '../styles/TeacherDashboard.css';
import { teacherCourseService, teacherAnalyticsService, adminService } from '../services/apiService';
import { useAuth } from '../context/AuthContext.jsx';

const initialForm = { title: '', description: '', level: '', tagsCsv: '' };

const TeacherDashboard = () => {
  const { user } = useAuth();
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [showCreate, setShowCreate] = useState(false);
  const [form, setForm] = useState(initialForm);
  const [activeTab, setActiveTab] = useState('courses');
  const [feedbackTarget, setFeedbackTarget] = useState(null);
  const [feedbackNotice, setFeedbackNotice] = useState(null);
  const [feedbackRefreshKey, setFeedbackRefreshKey] = useState(0);
  const navigate = useNavigate();

  const loadCourses = useCallback(async () => {
    setLoading(true);
    try {
      const data = await teacherCourseService.listMyCourses();
      const list = Array.isArray(data) ? data : [];
      setCourses(list);
      setError('');
      return list;
    } catch (err) {
      console.error('Failed to load courses', err);
      setError(err.message || 'Failed to load courses');
      setCourses([]);
      return [];
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadCourses();
  }, [loadCourses]);

  const openCreate = () => setShowCreate(true);
  const closeCreate = () => {
    setShowCreate(false);
    setForm(initialForm);
  };

  const handleChange = (event) => {
    const { name, value } = event.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const handleCreateCourse = async (event) => {
    event.preventDefault();
    try {
      const payload = {
        title: form.title.trim(),
        description: form.description.trim(),
        level: form.level.trim(),
        tagsCsv: form.tagsCsv.trim(),
      };

      if (!payload.title) {
        setError('Course title is required');
        return;
      }

      const created = await teacherCourseService.createCourse(payload);
      closeCreate();
      const list = await loadCourses();
      const createdId = created?.id || created?.Id;
      const matchByTitle = list.find((course) => (course.title || course.Title) === payload.title);
      const fallbackCourse = createdId ? null : matchByTitle || (list.length ? list[list.length - 1] : null);
      const fallbackId = createdId || fallbackCourse?.id || fallbackCourse?.Id;
      if (fallbackId) {
        navigate(`/teacher/courses/${fallbackId}`);
      }
    } catch (err) {
      console.error('Failed to create course', err);
      setError(err.message || 'Failed to create course');
    }
  };

  const handleDeleteCourse = async (courseId) => {
    if (!courseId) return;
    if (!window.confirm('Delete this course? This action cannot be undone.')) {
      return;
    }

    try {
      await teacherCourseService.deleteCourse(courseId);
      await loadCourses();
    } catch (err) {
      console.error('Failed to delete course', err);
      setError(err.message || 'Failed to delete course');
    }
  };

  const gotoManage = (courseId) => {
    if (!courseId) return;
    navigate(`/teacher/courses/${courseId}`);
  };

  const gotoPreview = (courseId) => {
    if (!courseId) return;
    navigate(`/courses/${courseId}/view`);
  };

  const gotoProgress = (courseId) => {
    if (!courseId) return;
    navigate(`/teacher/course-progress/${courseId}`);
  };

  const displayName = useMemo(() => {
    if (!user) return 'Teacher';
    return (
      user.full_name ||
      user.fullName ||
      user.FullName ||
      user.name ||
      user.displayName ||
      'Teacher'
    );
  }, [user]);

  const headerTitle = useMemo(() => {
    switch (activeTab) {
      case 'forum':
        return 'Forum Monitoring';
      case 'feedback':
        return 'Feedback Queue';
      default:
        return 'My Courses';
    }
  }, [activeTab]);

  const welcomeMessage = useMemo(
    () => `Hi ${displayName}, welcome back to your classroom garden.`,
    [displayName],
  );

  const headerSubtitle = useMemo(() => {
    if (activeTab === 'forum') {
      if (courses.length === 0) return 'Create a course to unlock forum discussions.';
      return 'Review discussions and keep your classroom community blooming.';
    }

    if (activeTab === 'feedback') {
      return 'Respond to student help requests and keep the learning path clear.';
    }

    if (loading) return 'Loading your courses...';
    if (courses.length === 0) return 'Plant your first course to begin mentoring.';
    return `You have ${courses.length} course${courses.length === 1 ? '' : 's'} ready to grow.`;
  }, [activeTab, courses.length, loading]);

  const setTransientNotice = (notice) => {
    setFeedbackNotice(notice);
    if (notice) {
      setTimeout(() => {
        setFeedbackNotice(null);
      }, 4000);
    }
  };

  const openFeedbackModal = useCallback((target) => {
    if (!target) return;
    const rawId =
      target.id ??
      target.Id ??
      target.requestId ??
      target.RequestId ??
      target.helpRequestId ??
      target.HelpRequestId ??
      target.profileId ??
      target.ProfileId ??
      target.studentId ??
      target.StudentId ??
      null;

    const studentName =
      target.studentName ||
      target.StudentName ||
      target.profile?.fullName ||
      target.Profile?.FullName ||
      target.profile?.full_name ||
      target.student?.fullName ||
      'Student';

    const context =
      target.context ||
      target.question ||
      target.Question ||
      target.content ||
      target.Content ||
      '';

    const chapterName = target.chapterName || target.ChapterName || target.chapter?.Title || '';

    const type =
      target.type ||
      (chapterName || target.question || target.Question ? 'help' : 'forum');

    setFeedbackTarget({
      id: rawId,
      studentName,
      context,
      chapterName,
      type,
      raw: target,
    });
  }, []);

  const closeFeedbackModal = () => {
    setFeedbackTarget(null);
  };

  const handleFeedbackSubmit = async (message) => {
    if (!feedbackTarget) return;

    try {
      if (feedbackTarget.type === 'help') {
        const requestId = feedbackTarget.id;
        if (!requestId) {
          throw new Error('Help request is missing an identifier.');
        }
        await adminService.replyToHelpRequest(requestId, message);
        setTransientNotice({ type: 'success', message: 'Reply sent to the help request.' });
        setFeedbackRefreshKey((prev) => prev + 1);
      } else {
        if (!feedbackTarget.id) {
          throw new Error('Student information missing for feedback message.');
        }
        await teacherAnalyticsService.sendFeedback({
          studentId: feedbackTarget.id,
          message,
          context: feedbackTarget.context,
        });
        setTransientNotice({ type: 'success', message: 'Feedback sent successfully.' });
      }
    } catch (err) {
      console.error('Failed to send feedback', err);
      setTransientNotice({ type: 'error', message: err.message || 'Failed to send feedback.' });
    } finally {
      closeFeedbackModal();
    }
  };

  const renderCoursesTab = () => {
    if (loading) {
      return <div className="td-state">Loading courses...</div>;
    }

    if (error && courses.length === 0) {
      return <div className="td-state td-error">{error}</div>;
    }

    if (courses.length === 0) {
      return <div className="td-state">No courses yet. Tap "Create Course" to begin.</div>;
    }

    return (
      <div className="td-table-wrapper">
        <table className="td-course-table">
          <thead>
            <tr>
              <th>Title</th>
              <th>Level</th>
              <th>Chapters</th>
              <th className="td-actions-heading">Actions</th>
            </tr>
          </thead>
          <tbody>
            {courses.map((course) => {
              const id = course.id || course.Id;
              const level = course.level || course.Level || 'N/A';
              const chapterCount =
                course.chapterCount ??
                course.ChapterCount ??
                (Array.isArray(course.chapters) ? course.chapters.length : 0) ??
                (Array.isArray(course.Chapters) ? course.Chapters.length : 0);

              return (
                <tr key={id || course.title}>
                  <td>
                    <div className="td-course-title">
                      <span className="td-course-name">{course.title || course.Title}</span>
                      {(course.description || course.Description) && (
                        <span className="td-course-description">{course.description || course.Description}</span>
                      )}
                    </div>
                  </td>
                  <td>{level || 'N/A'}</td>
                  <td>{chapterCount ?? 0}</td>
                  <td className="td-course-actions">
                    <PrimaryButton size="sm" variant="secondary" onClick={() => gotoManage(id)}>
                      Edit Content
                    </PrimaryButton>
                    <PrimaryButton size="sm" variant="ghost" onClick={() => gotoPreview(id)}>
                      Preview
                    </PrimaryButton>
                    <PrimaryButton size="sm" onClick={() => gotoProgress(id)}>
                      View Progress
                    </PrimaryButton>
                    <PrimaryButton
                      size="sm"
                      variant="ghost"
                      className="td-btn-danger"
                      onClick={() => handleDeleteCourse(id)}
                    >
                      Delete
                    </PrimaryButton>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  };

  const renderActiveTab = () => {
    switch (activeTab) {
      case 'forum':
        return (
          <div className="td-content">
            <TeacherForumManager courses={courses} onReplyClick={openFeedbackModal} />
          </div>
        );
      case 'feedback':
        return (
          <div className="td-content">
            <TeacherFeedbackQueue
              onReplyClick={openFeedbackModal}
              refreshToken={feedbackRefreshKey}
            />
          </div>
        );
      default:
        return <div className="td-content">{renderCoursesTab()}</div>;
    }
  };

  return (
    <>
      <Navbar />
      <main className="teacher-dashboard-page">
        <div className="teacher-dashboard-shell">
          <header className="dashboard-header">
            <div className="dashboard-heading">
              <p className="dashboard-kicker">{welcomeMessage}</p>
              <h1>{headerTitle}</h1>
              <p className="dashboard-subtitle">{headerSubtitle}</p>
            </div>
            {activeTab === 'courses' && (
              <PrimaryButton size="md" onClick={openCreate}>
                Create New Course
              </PrimaryButton>
            )}
          </header>

          <nav className="td-tabs" aria-label="Teacher dashboard sections">
            <PrimaryButton
              variant={activeTab === 'courses' ? 'primary' : 'ghost'}
              size="sm"
              className={`td-tab ${activeTab === 'courses' ? 'is-active' : ''}`}
              onClick={() => setActiveTab('courses')}
            >
              My Courses
            </PrimaryButton>
            <PrimaryButton
              variant={activeTab === 'forum' ? 'primary' : 'ghost'}
              size="sm"
              className={`td-tab ${activeTab === 'forum' ? 'is-active' : ''}`}
              onClick={() => setActiveTab('forum')}
            >
              Forum Monitoring
            </PrimaryButton>
            <PrimaryButton
              variant={activeTab === 'feedback' ? 'primary' : 'ghost'}
              size="sm"
              className={`td-tab ${activeTab === 'feedback' ? 'is-active' : ''}`}
              onClick={() => setActiveTab('feedback')}
            >
              Feedback Queue
            </PrimaryButton>
          </nav>

          {activeTab === 'courses' && error && courses.length > 0 && (
            <div className="td-alert td-error">{error}</div>
          )}

          {feedbackNotice && (
            <div className={`td-alert ${feedbackNotice.type === 'error' ? 'td-error' : 'td-success'}`}>
              {feedbackNotice.message}
            </div>
          )}

          {renderActiveTab()}
        </div>
      </main>

      {(showCreate && activeTab === 'courses') && (
        <div className="td-modal-backdrop" role="dialog" aria-modal="true">
          <div className="td-modal">
            <h2>Create Course</h2>
            <form onSubmit={handleCreateCourse} className="td-form">
              <label>
                <span>Title</span>
                <input
                  name="title"
                  type="text"
                  value={form.title}
                  onChange={handleChange}
                  required
                />
              </label>
              <label>
                <span>Description</span>
                <textarea
                  name="description"
                  value={form.description}
                  onChange={handleChange}
                  rows={3}
                />
              </label>
              <label>
                <span>Level</span>
                <input
                  name="level"
                  type="text"
                  value={form.level}
                  onChange={handleChange}
                  placeholder="Beginner / Intermediate / Advanced"
                />
              </label>
              <label>
                <span>Tags (comma separated)</span>
                <input
                  name="tagsCsv"
                  type="text"
                  value={form.tagsCsv}
                  onChange={handleChange}
                  placeholder="python, programming, data science"
                />
              </label>
              <div className="td-modal-actions">
                <PrimaryButton variant="ghost" onClick={closeCreate}>
                  Cancel
                </PrimaryButton>
                <PrimaryButton type="submit">
                  Create Course
                </PrimaryButton>
              </div>
            </form>
          </div>
        </div>
      )}

      <FeedbackModal
        isOpen={Boolean(feedbackTarget)}
        onClose={closeFeedbackModal}
        onSubmit={handleFeedbackSubmit}
        studentName={feedbackTarget?.studentName || 'Student'}
        context={feedbackTarget ? [
          feedbackTarget.chapterName ? `Chapter: ${feedbackTarget.chapterName}` : null,
          feedbackTarget.context,
        ].filter(Boolean).join('\n') : ''}
      />
    </>
  );
};

export default TeacherDashboard;

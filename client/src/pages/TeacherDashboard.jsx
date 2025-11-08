import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/TeacherDashboard.css';
import ReturnHome from '../components/ReturnHome';
import { teacherCourseService } from '../services/apiService';
import TeacherForumManager from '../components/TeacherForumManager';

const initialForm = { title: '', description: '', level: '', tagsCsv: '' };

const TeacherDashboard = () => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [showCreate, setShowCreate] = useState(false);
  const [form, setForm] = useState(initialForm);
  const [activeTab, setActiveTab] = useState('courses');
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

  const headerTitle = activeTab === 'courses' ? 'My Courses' : 'Forum Moderation';

  const headerSubtitle = useMemo(() => {
    if (activeTab === 'forum') {
      if (courses.length === 0) return 'Create a course to unlock forum discussions.';
      return 'Review discussions and keep your classroom community on track.';
    }

    if (loading) return 'Loading your courses...';
    if (courses.length === 0) return 'Create your first course to get started.';
    return `You have ${courses.length} course${courses.length === 1 ? '' : 's'} ready.`;
  }, [activeTab, courses.length, loading]);

  const renderCourses = () => {
    if (loading) {
      return <div className="td-state">Loading courses...</div>;
    }

    if (error && courses.length === 0) {
      return <div className="td-state td-error">{error}</div>;
    }

    if (courses.length === 0) {
      return <div className="td-state">No courses yet. Click "Create Course" to begin.</div>;
    }

    return (
      <div className="td-table-wrapper">
        <table className="td-course-table">
          <thead>
            <tr>
              <th>Title</th>
              <th>Level</th>
              <th>Chapters</th>
              <th>Actions</th>
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
                    <button type="button" onClick={() => gotoManage(id)}>Edit Content</button>
                    <button type="button" onClick={() => gotoPreview(id)}>Preview</button>
                    <button type="button" onClick={() => gotoProgress(id)}>View Progress</button>
                    <button type="button" className="td-danger" onClick={() => handleDeleteCourse(id)}>
                      Delete
                    </button>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  };

  return (
    <div className="teacher-dashboard">
      <ReturnHome />
      <div className="dashboard-container">
        <header className="dashboard-header td-header">
          <div>
            <h1>{headerTitle}</h1>
            <p>{headerSubtitle}</p>
          </div>
          {activeTab === 'courses' && (
            <button type="button" className="td-primary" onClick={openCreate}>
              Create Course
            </button>
          )}
        </header>

        <nav className="td-tabs">
          <button
            type="button"
            className={`td-tab ${activeTab === 'courses' ? 'active' : ''}`}
            onClick={() => setActiveTab('courses')}
          >
            My Courses
          </button>
          <button
            type="button"
            className={`td-tab ${activeTab === 'forum' ? 'active' : ''}`}
            onClick={() => setActiveTab('forum')}
          >
            Forum Moderation
          </button>
        </nav>

        {activeTab === 'courses' && error && courses.length > 0 && (
          <div className="td-alert td-error">{error}</div>
        )}

        {activeTab === 'courses' ? renderCourses() : <TeacherForumManager courses={courses} />}
      </div>

      {showCreate && activeTab === 'courses' && (
        <div className="td-modal-backdrop" role="dialog" aria-modal="true">
          <div className="td-modal">
            <h2>Create Course</h2>
            <form onSubmit={handleCreateCourse} className="td-form">
              <label>
                Title
                <input
                  name="title"
                  type="text"
                  value={form.title}
                  onChange={handleChange}
                  required
                />
              </label>
              <label>
                Description
                <textarea
                  name="description"
                  value={form.description}
                  onChange={handleChange}
                  rows={3}
                />
              </label>
              <label>
                Level
                <input
                  name="level"
                  type="text"
                  value={form.level}
                  onChange={handleChange}
                  placeholder="Beginner / Intermediate / Advanced"
                />
              </label>
              <label>
                Tags (comma separated)
                <input
                  name="tagsCsv"
                  type="text"
                  value={form.tagsCsv}
                  onChange={handleChange}
                  placeholder="python, programming, data science"
                />
              </label>
              <div className="td-modal-actions">
                <button type="button" onClick={closeCreate}>
                  Cancel
                </button>
                <button type="submit" className="td-primary">
                  Create
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default TeacherDashboard;

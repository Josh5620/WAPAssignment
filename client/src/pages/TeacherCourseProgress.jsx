import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import ReturnHome from '../components/ReturnHome';
import FeedbackModal from '../components/FeedbackModal';
import { teacherAnalyticsService, teacherCourseService } from '../services/apiService';
import '../styles/TeacherDashboard.css';

const TeacherCourseProgress = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState(null);
  const [progress, setProgress] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [feedbackTarget, setFeedbackTarget] = useState(null);
  const [feedbackStatus, setFeedbackStatus] = useState('');

  useEffect(() => {
    if (!courseId) return;

    const loadData = async () => {
      setLoading(true);
      try {
        const [courseResponse, progressResponse] = await Promise.all([
          teacherCourseService.getCourse(courseId),
          teacherAnalyticsService.getCourseProgress(courseId),
        ]);

        setCourse(courseResponse || null);
        setProgress(Array.isArray(progressResponse) ? progressResponse : []);
        setError('');
      } catch (err) {
        console.error('Failed to load course progress', err);
        setError(err.message || 'Failed to load course progress');
        setProgress([]);
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [courseId]);

  const courseTitle = useMemo(() => {
    if (!course) return 'Course Progress';
    return course.title || course.Title || 'Course Progress';
  }, [course]);

  const handleOpenFeedback = (student) => {
    setFeedbackTarget(student);
  };

  const handleCloseFeedback = () => {
    setFeedbackTarget(null);
  };

  const handleSendFeedback = async (message) => {
    if (!feedbackTarget) return;

    try {
      await teacherAnalyticsService.sendFeedback({
        studentId: feedbackTarget.studentId,
        message,
      });
      setFeedbackStatus('Feedback sent successfully.');
    } catch (err) {
      console.error('Failed to send feedback', err);
      setFeedbackStatus(err.message || 'Failed to send feedback');
    } finally {
      setFeedbackTarget(null);
      setTimeout(() => setFeedbackStatus(''), 3000);
    }
  };

  const renderContent = () => {
    if (loading) {
      return <div className="td-state">Loading progress...</div>;
    }

    if (error) {
      return <div className="td-state td-error">{error}</div>;
    }

    if (!progress.length) {
      return <div className="td-state">No student progress recorded yet.</div>;
    }

    return (
      <div className="td-table-wrapper">
        <table className="td-course-table">
          <thead>
            <tr>
              <th>Student</th>
              <th>Email</th>
              <th>Progress</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {progress.map((entry) => {
              const studentId = entry.studentId || entry.StudentId;
              const studentName = entry.studentName || entry.StudentName || 'Student';
              const studentEmail = entry.studentEmail || entry.StudentEmail || 'N/A';
              const completed = entry.completedChapters ?? entry.CompletedChapters ?? 0;
              const total = entry.totalChapters ?? entry.TotalChapters ?? 0;

              return (
                <tr key={studentId}>
                  <td>{studentName}</td>
                  <td>{studentEmail}</td>
                  <td>
                    {completed}/{total}
                  </td>
                  <td>
                    <button
                      type="button"
                      className="td-primary"
                      onClick={() =>
                        handleOpenFeedback({ studentId, studentName })
                      }
                    >
                      Send Feedback
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
            <h1>{courseTitle}</h1>
            <p>Monitor student completion and share targeted feedback.</p>
          </div>
          <button type="button" onClick={() => navigate(-1)}>
            Back
          </button>
        </header>

        {feedbackStatus && (
          <div
            className="td-alert"
            style={{ background: '#dcfce7', color: '#166534' }}
          >
            {feedbackStatus}
          </div>
        )}

        {renderContent()}
      </div>

      <FeedbackModal
        isOpen={Boolean(feedbackTarget)}
        onClose={handleCloseFeedback}
        onSubmit={handleSendFeedback}
        studentName={feedbackTarget?.studentName || 'Student'}
      />
    </div>
  );
};

export default TeacherCourseProgress;

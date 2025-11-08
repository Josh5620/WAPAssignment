import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import FeedbackModal from '../components/FeedbackModal';
import PrimaryButton from '../components/PrimaryButton';
import { teacherAnalyticsService, teacherCourseService } from '../services/apiService';
import '../styles/TeacherCourseProgress.css';

const TeacherCourseProgress = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState(null);
  const [progress, setProgress] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [feedbackTarget, setFeedbackTarget] = useState(null);
  const [feedbackStatus, setFeedbackStatus] = useState(null);

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
      setFeedbackStatus({ type: 'success', message: 'Feedback sent successfully.' });
    } catch (err) {
      console.error('Failed to send feedback', err);
      setFeedbackStatus({ type: 'error', message: err.message || 'Failed to send feedback' });
    } finally {
      setFeedbackTarget(null);
      setTimeout(() => setFeedbackStatus(null), 3000);
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
                  <td className="td-course-actions">
                    <PrimaryButton
                      size="sm"
                      variant="outline"
                      onClick={() => handleOpenFeedback({ studentId, studentName })}
                    >
                      Send Feedback
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

  return (
    <>
      <Navbar />
      <main className="teacher-progress-page">
        <div className="teacher-dashboard">
          <div className="dashboard-container">
            <header className="dashboard-header teacher-progress__header">
              <div className="teacher-progress__heading">
                <p className="teacher-progress__eyebrow">Growth Tracker</p>
                <h1>{courseTitle}</h1>
                <p>Monitor student completion and share targeted feedback.</p>
              </div>
              <PrimaryButton variant="ghost" size="sm" onClick={() => navigate(-1)}>
                Back
              </PrimaryButton>
            </header>

            {feedbackStatus && (
              <div
                className={`td-alert ${
                  feedbackStatus.type === 'error' ? 'td-alert--error' : 'td-alert--success'
                }`}
              >
                {feedbackStatus.message}
              </div>
            )}

            {renderContent()}
          </div>
        </div>

        <FeedbackModal
          isOpen={Boolean(feedbackTarget)}
          onClose={handleCloseFeedback}
          onSubmit={handleSendFeedback}
          studentName={feedbackTarget?.studentName || 'Student'}
        />
      </main>
    </>
  );
};

export default TeacherCourseProgress;

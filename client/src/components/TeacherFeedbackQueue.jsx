import React, { useEffect, useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { api } from '../services/apiService';
import '../styles/TeacherFeedbackQueue.css';

const TeacherFeedbackQueue = () => {
  const [requests, setRequests] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchRequests = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await api.teachers.getHelpRequests();
      // Backend returns { helpRequests: [...], totalPending, teacherId }
      const helpRequests = response?.helpRequests || [];
      setRequests(Array.isArray(helpRequests) ? helpRequests : []);
    } catch (err) {
      console.error('Failed to load help requests', err);
      setError(err.message || 'Unable to load help requests.');
      setRequests([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRequests();
  }, []);

  const handleResolve = async (requestId) => {
    try {
      await api.teachers.respondToTeacherHelpRequest(
        requestId,
        'Your teacher has reviewed and resolved your request.'
      );
      setRequests((prev) => prev.filter((request) => request.helpRequestId !== requestId));
    } catch (err) {
      console.error('Failed to resolve help request', err);
      alert(err.message || 'Unable to mark the request as resolved. Please try again.');
    }
  };

  return (
    <div className="feedback-queue">
      <header className="feedback-header">
        <h2>Help Queue</h2>
        <p>
          These help requests are pulled directly from your students so you can stay on top of their needs in real time.
        </p>
      </header>

      {loading ? (
        <div className="feedback-list" role="status">
          <div className="feedback-empty">Loading help requests...</div>
        </div>
      ) : error ? (
        <div className="feedback-list" role="alert">
          <div className="feedback-empty">{error}</div>
        </div>
      ) : (
        <div className="feedback-list" role="list">
          {requests.length === 0 ? (
            <div className="feedback-empty" role="listitem">
              All caught up! Every student is back on the learning path.
            </div>
          ) : (
            requests.map((request) => (
              <article key={request.helpRequestId} className="feedback-item" role="listitem">
                <header>
                  <h3>{request?.studentName || 'Student'}</h3>
                  <p className="feedback-item__chapter">Chapter: {request?.chapterTitle || 'Unknown chapter'}</p>
                  <p className="feedback-item__timestamp">
                    Requested: {request?.createdAt ? new Date(request.createdAt).toLocaleString() : 'Unknown'}
                  </p>
                </header>
                <p className="feedback-item__question">{request?.question}</p>
                <PrimaryButton size="sm" onClick={() => handleResolve(request.helpRequestId)}>
                  Mark as Resolved
                </PrimaryButton>
              </article>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default TeacherFeedbackQueue;

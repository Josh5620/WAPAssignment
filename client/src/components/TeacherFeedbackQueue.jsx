import React, { useCallback, useEffect, useMemo, useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { adminService } from '../services/apiService';
import '../styles/TeacherFeedbackQueue.css';

const TeacherFeedbackQueue = ({ onReplyClick, refreshToken = 0 }) => {
  const [requests, setRequests] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const loadRequests = useCallback(async () => {
    setLoading(true);
    try {
      const data = await adminService.getHelpRequests();
      let items = [];
      if (Array.isArray(data)) {
        items = data;
      } else if (Array.isArray(data?.data)) {
        items = data.data;
      } else if (Array.isArray(data?.items)) {
        items = data.items;
      } else if (Array.isArray(data?.results)) {
        items = data.results;
      }
      setRequests(items);
      setError('');
    } catch (err) {
      console.error('Failed to load help requests', err);
      setError(err.message || 'Unable to load help requests.');
      setRequests([]);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadRequests();
  }, [loadRequests, refreshToken]);

  const pendingRequests = useMemo(() => {
    return requests.filter((request) => {
      const resolvedFlag =
        request.isResolved ??
        request.IsResolved ??
        request.resolved ??
        request.Resolved ??
        (typeof request.status === 'string' && request.status.toLowerCase() === 'resolved') ??
        false;
      return !resolvedFlag;
    });
  }, [requests]);

  if (loading) {
    return <div className="td-state">Loading help requests...</div>;
  }

  if (error) {
    return <div className="td-state td-error">{error}</div>;
  }

  if (pendingRequests.length === 0) {
    return <div className="feedback-empty-note">No pending help requests. Enjoy the sunshine!</div>;
  }

  return (
    <div className="feedback-list">
      {pendingRequests.map((request) => {
        const requestId =
          request.id ||
          request.Id ||
          request.helpRequestId ||
          request.HelpRequestId ||
          request.requestId ||
          request.RequestId;

        const studentName =
          request.studentName ||
          request.StudentName ||
          request.profile?.FullName ||
          request.profile?.fullName ||
          request.student?.fullName ||
          'Student';

        const chapterName =
          request.chapterName ||
          request.ChapterName ||
          request.chapter?.Title ||
          request.chapter?.title ||
          'Chapter';

        const question =
          request.question ||
          request.Question ||
          request.prompt ||
          request.message ||
          request.Message ||
          '';

        return (
          <article key={requestId || question} className="feedback-item">
            <h4>{studentName}</h4>
            <div className="feedback-meta">
              <span>Chapter: {chapterName}</span>
              {request.createdAt && (
                <span>
                  {new Date(request.createdAt || request.CreatedAt).toLocaleString()}
                </span>
              )}
            </div>
            <p className="feedback-question">{question}</p>
            <PrimaryButton
              size="sm"
              onClick={() => onReplyClick?.({
                ...request,
                id: requestId,
                studentName,
                chapterName,
                question,
                context: question,
                type: 'help',
              })}
            >
              Reply
            </PrimaryButton>
          </article>
        );
      })}
    </div>
  );
};

export default TeacherFeedbackQueue;

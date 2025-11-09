import React, { useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { api } from '../services/apiService';
import '../styles/StudentHelpRequest.css';

const StudentHelpRequest = ({ chapterId }) => {
  const [question, setQuestion] = useState('');
  const [status, setStatus] = useState(null);
  const [submitting, setSubmitting] = useState(false);

  const storePendingQuestion = (payload) => {
    try {
      const key = 'pending_help_requests';
      const existing = JSON.parse(localStorage.getItem(key) || '[]');
      existing.push({ ...payload, savedAt: new Date().toISOString() });
      localStorage.setItem(key, JSON.stringify(existing));
    } catch (storageError) {
      console.warn('Failed to persist help request locally', storageError);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    const trimmed = question.trim();
    if (!trimmed) {
      setStatus({ type: 'error', message: 'Please share a question before sending.' });
      return;
    }

    try {
      setSubmitting(true);
      await api.students.createHelpRequest(chapterId, trimmed);
      setQuestion('');
      setStatus({
        type: 'success',
        message: 'Your question has been shared with your teacher. Watch for a reply soon!',
      });
    } catch (error) {
      console.error('Failed to send help request', error);
      storePendingQuestion({ chapterId, question: trimmed });
      setStatus({
        type: 'info',
        message:
          'We’re still planting this feature! Your question has been saved locally and will be sent once the teacher inbox is ready.',
      });
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <section className="student-help-request">
      <header>
        <h3>Ask the Teacher</h3>
        <p>
          Stuck on this chapter? Tell us what&apos;s unclear and your teacher will send a note to
          guide you forward.
        </p>
      </header>
      <form onSubmit={handleSubmit}>
        <label htmlFor="help-question">Your Question</label>
        <textarea
          id="help-question"
          value={question}
          onChange={(event) => setQuestion(event.target.value)}
          placeholder="Describe what you need help with..."
          rows={5}
        />
        {status && (
          <div className={`help-status help-status--${status.type || 'info'}`}>{status.message}</div>
        )}
        <PrimaryButton type="submit" disabled={submitting}>
          {submitting ? 'Sending...' : 'Send to Teacher'}
        </PrimaryButton>
      </form>
    </section>
  );
};

export default StudentHelpRequest;

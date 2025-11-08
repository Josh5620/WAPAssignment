import React, { useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { api } from '../services/apiService';
import '../styles/StudentHelpRequest.css';

const StudentHelpRequest = ({ chapterId }) => {
  const [question, setQuestion] = useState('');
  const [status, setStatus] = useState(null);
  const [submitting, setSubmitting] = useState(false);

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
      setStatus({
        type: 'error',
        message: error.message || 'We could not send your request. Please try again shortly.',
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
          <div
            className={`help-alert ${
              status.type === 'error' ? 'help-error' : 'help-success'
            }`}
          >
            {status.message}
          </div>
        )}
        <PrimaryButton type="submit" disabled={submitting}>
          {submitting ? 'Sending...' : 'Send to Teacher'}
        </PrimaryButton>
      </form>
    </section>
  );
};

export default StudentHelpRequest;

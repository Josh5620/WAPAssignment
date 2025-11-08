import React, { useEffect, useState } from 'react';
import PrimaryButton from './PrimaryButton';

const FeedbackModal = ({ isOpen, onClose, onSubmit, studentName, context }) => {
  const [message, setMessage] = useState('');

  useEffect(() => {
    if (isOpen) {
      setMessage('');
    }
  }, [isOpen, studentName]);

  if (!isOpen) {
    return null;
  }

  const handleSend = (event) => {
    event.preventDefault();
    const trimmed = message.trim();
    if (!trimmed) {
      return;
    }
    onSubmit(trimmed);
  };

  return (
    <div className="td-modal-backdrop" role="dialog" aria-modal="true">
      <div className="td-modal">
        <h2>Send Feedback</h2>
        <p>To: {studentName}</p>
        {context && (
          <div className="feedback-context">
            <p>{context}</p>
          </div>
        )}
        <form className="td-form" onSubmit={handleSend}>
          <label>
            <span>Message</span>
            <textarea
              value={message}
              onChange={(event) => setMessage(event.target.value)}
              rows={4}
              placeholder="Share encouragement, suggestions, or next steps."
              required
            />
          </label>
          <div className="td-modal-actions">
            <PrimaryButton variant="ghost" onClick={onClose}>
              Cancel
            </PrimaryButton>
            <PrimaryButton type="submit">
              Send
            </PrimaryButton>
          </div>
        </form>
      </div>
    </div>
  );
};

export default FeedbackModal;

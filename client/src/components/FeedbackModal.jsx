import React, { useEffect, useState } from 'react';

const FeedbackModal = ({ isOpen, onClose, onSubmit, studentName }) => {
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
            <button type="button" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" className="td-primary">
              Send
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default FeedbackModal;

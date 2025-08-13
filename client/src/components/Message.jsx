import React from 'react';
import '../styles/Message.css';

const Message = ({ message }) => {
  const formatTime = (timestamp) => {
    return timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  return (
    <div className={`message ${message.sender}`}>
      <div className="message-content">
        <div className="message-text">{message.text}</div>
        <div className="message-time">{formatTime(message.timestamp)}</div>
      </div>
      {message.sender === 'bot' && (
        <div className="message-avatar">🤖</div>
      )}
      {message.sender === 'user' && (
        <div className="message-avatar">👤</div>
      )}
    </div>
  );
};

export default Message;

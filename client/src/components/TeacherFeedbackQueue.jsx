import React, { useState } from 'react';
import PrimaryButton from './PrimaryButton';
import '../styles/TeacherFeedbackQueue.css';

const initialRequests = [
  {
    id: 'req-1',
    studentName: 'Noah Patel',
    chapterName: 'Variables & Seed Packets',
    question: 'My variable keeps resetting each time I run the watering function. What am I missing?',
  },
  {
    id: 'req-2',
    studentName: 'Sofia Liang',
    chapterName: 'Conditional Greenhouses',
    question: 'How do I stop my else-if from triggering when both soil and sunlight are perfect?',
  },
  {
    id: 'req-3',
    studentName: 'Elliott Rivers',
    chapterName: 'Arrays in Bloom',
    question: 'I sorted my flower beds but the rare orchid disappears. How can I preserve it while sorting?',
  },
];

const TeacherFeedbackQueue = () => {
  const [requests, setRequests] = useState(initialRequests);

  const handleResolve = (requestId) => {
    setRequests((prev) => prev.filter((request) => request.id !== requestId));
  };

  return (
    <div className="feedback-queue">
      <header className="feedback-header">
        <h2>Help Queue</h2>
        <p>
          These help requests are simulated so you can demonstrate the resolution flow without waiting on real
          student submissions.
        </p>
      </header>

      <div className="feedback-list" role="list">
        {requests.length === 0 ? (
          <div className="feedback-empty" role="listitem">
            All caught up! Every student is back on the learning path.
          </div>
        ) : (
          requests.map((request) => (
            <article key={request.id} className="feedback-item" role="listitem">
              <header>
                <h3>{request.studentName}</h3>
                <p className="feedback-item__chapter">Chapter: {request.chapterName}</p>
              </header>
              <p className="feedback-item__question">{request.question}</p>
              <PrimaryButton size="sm" onClick={() => handleResolve(request.id)}>
                Mark as Resolved
              </PrimaryButton>
            </article>
          ))
        )}
      </div>
    </div>
  );
};

export default TeacherFeedbackQueue;

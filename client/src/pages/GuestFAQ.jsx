import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import GuestRestrictionBanner from '../components/GuestRestrictionBanner';
import GuestAccessPrompt from '../components/GuestAccessPrompt';
import { api } from '../services/apiService';
import '../styles/FAQ.css';

const GuestFAQ = () => {
  const navigate = useNavigate();
  const [faqs, setFaqs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [expandedIndex, setExpandedIndex] = useState(null);

  useEffect(() => {
    loadFAQs();
  }, []);

  const loadFAQs = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getFAQs();
      setFaqs(data.faqs || []);
      setError(null);
    } catch (err) {
      console.error('Failed to load FAQs:', err);
      setError('Failed to load FAQs. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const toggleFAQ = (index) => {
    setExpandedIndex(expandedIndex === index ? null : index);
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <TestingNav />
        <div className="faq-loading">Loading FAQs...</div>
      </>
    );
  }

  if (error) {
    return (
      <>
        <Navbar />
        <TestingNav />
        <div className="faq-error">
          <p>{error}</p>
          <button onClick={loadFAQs}>Retry</button>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <TestingNav />
      <GuestRestrictionBanner 
        message="You're viewing public FAQs. Register or log in to access full course content, quizzes, flashcards, and track your progress."
      />
      <div className="faq-page">
        <div className="faq-container">
          <header className="faq-header">
            <h1>Frequently Asked Questions</h1>
            <p>Find answers to common questions about CodeSage</p>
            <p className="faq-preview-notice">
              <strong>Public Information:</strong> These FAQs are available to everyone. Register for full platform access.
            </p>
          </header>

          <div className="faq-content">
            {faqs.length === 0 ? (
              <div className="faq-empty">
                <p>No FAQs available at the moment.</p>
              </div>
            ) : (
              faqs.map((faq, index) => (
                <div
                  key={faq.id || index}
                  className={`faq-item ${expandedIndex === index ? 'expanded' : ''}`}
                >
                  <div
                    className="faq-question-header"
                    onClick={() => toggleFAQ(index)}
                  >
                    <h3 className="faq-question">{faq.question}</h3>
                    <span className="faq-toggle">
                      {expandedIndex === index ? '−' : '+'}
                    </span>
                  </div>
                  {expandedIndex === index && (
                    <div className="faq-answer">
                      <p>{faq.answer}</p>
                    </div>
                  )}
                </div>
              ))
            )}
          </div>

          <div className="contact-section">
            <h2>Still have questions?</h2>
            <p>Can't find what you're looking for? Feel free to contact our support team.</p>
            <button
              className="contact-btn"
              onClick={() => navigate('/register')}
            >
              Register to Get Support
            </button>
          </div>

          <GuestAccessPrompt
            title="Want Full Platform Access?"
            message="Register now to unlock all courses, quizzes, flashcards, progress tracking, and more!"
            featureList={[
              'Full access to all course content',
              'Interactive quizzes with instant feedback',
              'Flashcards for practice and review',
              'Track your learning progress',
              'Earn XP points and climb the leaderboard',
              'Participate in community forums',
              'Personalized learning dashboard'
            ]}
          />
        </div>
      </div>
    </>
  );
};

export default GuestFAQ;


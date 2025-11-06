import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import GuestRestrictionBanner from '../components/GuestRestrictionBanner';
import GuestAccessPrompt from '../components/GuestAccessPrompt';
import { api } from '../services/apiService';
import '../styles/About.css';

const GuestAbout = () => {
  const navigate = useNavigate();
  const [aboutContent, setAboutContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const isLoggedIn = getUser() !== null;

  useEffect(() => {
    loadAboutContent();
  }, []);

  const loadAboutContent = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getAbout();
      setAboutContent(data);
      setError(null);
    } catch (err) {
      console.error('Failed to load about content:', err);
      setError('Failed to load about content. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <TestingNav />
        <div className="about-loading">Loading about content...</div>
      </>
    );
  }

  if (error) {
    return (
      <>
        <Navbar />
        <TestingNav />
        <div className="about-error">
          <p>{error}</p>
          <button onClick={loadAboutContent}>Retry</button>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <TestingNav />
      <GuestRestrictionBanner 
        message="You're viewing public information. Register or log in to access full course content, quizzes, flashcards, and track your progress."
      />
      <div className="about-page-wrapper">
        <h1>{aboutContent?.title || 'About CodeSage'}</h1>

        {aboutContent?.content && (
          <>
            <section className="about-section">
              <h3>Our Mission</h3>
              <p>{aboutContent.content.mission}</p>
            </section>

            <section className="about-section">
              <h3>Our Vision</h3>
              <p>{aboutContent.content.vision}</p>
            </section>

            {aboutContent.content.features && (
              <section className="about-section">
                <h3>What We Offer</h3>
                <ul className="features-list">
                  {aboutContent.content.features.map((feature, index) => (
                    <li key={index}>{feature}</li>
                  ))}
                </ul>
              </section>
            )}
          </>
        )}

        <section className="about-section">
          <h3>Join Us!</h3>
          <p>
            Start your Python journey today!{' '}
            <a href="/register" className="about-cta" onClick={(e) => {
              e.preventDefault();
              navigate('/register');
            }}>
              Sign up for free
            </a>{' '}
            and begin learning.
          </p>
        </section>

        <GuestAccessPrompt
          title="Ready to Start Learning?"
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
    </>
  );
};

export default GuestAbout;


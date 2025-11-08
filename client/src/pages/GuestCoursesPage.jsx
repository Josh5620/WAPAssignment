import React from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import GuestCourseCatalog from '../components/GuestCourseCatalog';
import GuestSearch from '../components/GuestSearch';
import GuestAccessPrompt from '../components/GuestAccessPrompt';
import '../styles/GuestCoursesPage.css';

const GuestCoursesPage = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = React.useState('catalog'); // 'catalog' or 'search'
  const isLoggedIn = getUser() !== null;

  // If user is logged in, redirect to regular courses page
  React.useEffect(() => {
    if (isLoggedIn) {
      navigate('/courses');
    }
  }, [isLoggedIn, navigate]);

  if (isLoggedIn) {
    return null; // Will redirect
  }

  return (
    <>
      <Navbar />
      <div className="guest-courses-page">
        <div className="page-header">
          <h1>Explore Our Courses</h1>
          <p className="page-subtitle">
            <strong>Preview Mode:</strong> Browse course catalog and preview content. 
            <a href="/register" onClick={(e) => { e.preventDefault(); navigate('/register'); }}>
              Register
            </a> or{' '}
            <a href="/login" onClick={(e) => { e.preventDefault(); navigate('/login'); }}>
              log in
            </a> to access full courses!
          </p>
        </div>

        <div className="tabs-container">
          <button
            className={`tab-button ${activeTab === 'catalog' ? 'active' : ''}`}
            onClick={() => setActiveTab('catalog')}
          >
            Course Catalog
          </button>
          <button
            className={`tab-button ${activeTab === 'search' ? 'active' : ''}`}
            onClick={() => setActiveTab('search')}
          >
            Search
          </button>
        </div>

        <div className="tab-content">
          {activeTab === 'catalog' && <GuestCourseCatalog />}
          {activeTab === 'search' && <GuestSearch />}
        </div>

        <div className="register-cta-section">
          <GuestAccessPrompt
            title="Ready to Start Learning?"
            message="Register now for free and unlock the full learning experience!"
            featureList={[
              'Complete access to all courses',
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

export default GuestCoursesPage;


import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import Testimonials from '../components/Testimonials';
import { api } from '../services/apiService';
import '../styles/GuestLandingPage.css';

const GuestLandingPage = () => {
  const navigate = useNavigate();
  const user = getUser();
  const [courseData, setCourseData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Redirect if already logged in
  useEffect(() => {
    if (user) {
      navigate('/dashboard');
    }
  }, [user, navigate]);

  useEffect(() => {
    const loadCoursePreview = async () => {
      try {
        setLoading(true);
        // Get the Python course (we know it's the only one)
        const catalog = await api.guests.getCourseCatalog();
        const pythonCourse = catalog.courses?.[0];
        
        if (!pythonCourse) {
          setError('Course not available at this time.');
          return;
        }

        // Get detailed preview with chapters
        const preview = await api.guests.getCoursePreview(pythonCourse.courseId);
        setCourseData(preview);
        setError('');
      } catch (err) {
        console.error('Failed to load course preview:', err);
        setError('Unable to load course preview. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    loadCoursePreview();
  }, []);

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="guest-landing-loading">
          <div className="loading-spinner">🌱</div>
          <p>Loading course preview...</p>
        </div>
      </>
    );
  }

  if (error || !courseData) {
    return (
      <>
        <Navbar />
        <div className="guest-landing-error">
          <h2>Oops!</h2>
          <p>{error || 'Something went wrong.'}</p>
          <PrimaryButton onClick={() => window.location.reload()}>
            Try Again
          </PrimaryButton>
        </div>
      </>
    );
  }

  const { title, description, totalChapters, chapters = [] } = courseData;
  const previewChapters = chapters.slice(0, 3); // Show only first 3 chapters
  const lockedChapters = totalChapters - 3;

  return (
    <>
      <Navbar />
      
      <div className="guest-landing">
        {/* Hero Section */}
        <section className="guest-hero">
          <div className="guest-hero__content">
            <div className="hero-badge">Free Preview</div>
            <h1>{title}</h1>
            <p className="hero-description">{description}</p>
            
            <div className="hero-stats">
              <div className="stat">
                <span className="stat-number">{totalChapters}</span>
                <span className="stat-label">Chapters</span>
              </div>
              <div className="stat">
                <span className="stat-number">3</span>
                <span className="stat-label">Free Preview</span>
              </div>
              <div className="stat">
                <span className="stat-number">{lockedChapters}</span>
                <span className="stat-label">Unlock with Signup</span>
              </div>
            </div>

            <div className="hero-actions">
              <PrimaryButton 
                size="lg" 
                onClick={() => navigate('/register')}
              >
                Start Learning Free
              </PrimaryButton>
              <PrimaryButton 
                variant="ghost" 
                size="md"
                onClick={() => navigate('/login')}
              >
                Already a member? Log in
              </PrimaryButton>
            </div>
          </div>

          <div className="guest-hero__visual">
            <div className="hero-illustration">
              <img src="/python.svg" alt="Python Course" />
            </div>
          </div>
        </section>

        {/* Preview Chapters Section */}
        <section className="guest-chapters">
          <div className="section-header">
            <h2>Preview the First 3 Chapters</h2>
            <p>Access notes and flashcards for free. Sign up to unlock challenges, quizzes, and all {totalChapters} chapters!</p>
          </div>

          <div className="chapters-grid">
            {previewChapters.map((chapter, index) => (
              <article key={chapter.chapterId} className="chapter-card">
                <div className="chapter-header">
                  <div className="chapter-number">
                    <span className="number">{chapter.number}</span>
                  </div>
                  <div className="chapter-status free">Free Preview</div>
                </div>
                
                <h3>{chapter.title}</h3>
                <p>{chapter.summary || 'Explore the fundamentals and build your foundation.'}</p>
                
                <div className="chapter-footer">
                  <button 
                    className="chapter-preview-btn"
                    onClick={() => navigate(`/guest/courses/${courseData.courseId}/chapters/${chapter.chapterId}`)}
                  >
                    View Chapter →
                  </button>
                </div>
              </article>
            ))}
          </div>
        </section>

        {/* What You'll Learn Section */}
        <section className="guest-benefits">
          <div className="section-header">
            <h2>What You'll Get With Full Access</h2>
            <p>Unlock all features and take your learning to the next level</p>
          </div>

          <div className="benefits-grid">
            <div className="benefit-card">
              <div className="benefit-icon">📚</div>
              <h3>All {totalChapters} Chapters</h3>
              <p>Complete curriculum from basics to advanced topics with full notes and flashcards</p>
            </div>

            <div className="benefit-card">
              <div className="benefit-icon">🏆</div>
              <h3>Coding Challenges</h3>
              <p>Test your skills with interactive challenges and earn XP for each completion</p>
            </div>

            <div className="benefit-card">
              <div className="benefit-icon">🎯</div>
              <h3>Progress Tracking</h3>
              <p>Monitor your learning journey with XP, badges, and achievements</p>
            </div>

            <div className="benefit-card">
              <div className="benefit-icon">💬</div>
              <h3>Help Requests & Forums</h3>
              <p>Get instant help from instructors and collaborate with fellow learners</p>
            </div>

            <div className="benefit-card">
              <div className="benefit-icon">🎮</div>
              <h3>Gamified Learning</h3>
              <p>Earn XP, unlock badges, and climb the leaderboard as you progress</p>
            </div>

            <div className="benefit-card">
              <div className="benefit-icon">📊</div>
              <h3>Quizzes & Assessments</h3>
              <p>Test your knowledge and get instant feedback on your understanding</p>
            </div>
          </div>
        </section>

        {/* Testimonials */}
        <section className="guest-testimonials">
          <div className="section-header">
            <h2>What Students Are Saying</h2>
            <p>Join thousands of learners who started their Python journey with us</p>
          </div>
          <Testimonials courseId={courseData.courseId} limit={3} />
        </section>

        {/* Final CTA */}
        <section className="guest-cta">
          <div className="cta-content">
            <h2>Ready for More?</h2>
            <p>Unlock <strong>{lockedChapters} additional chapters</strong> covering advanced topics, hands-on projects, and real-world applications.</p>
            <div className="cta-actions">
              <PrimaryButton 
                size="lg"
                onClick={() => navigate('/register')}
              >
                Unlock Full Course
              </PrimaryButton>
            </div>
          </div>
        </section>
      </div>
    </>
  );
};

export default GuestLandingPage;

import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/CoursesPage.css';

const CoursesPage = () => {
  const navigate = useNavigate();
  const [userRole, setUserRole] = useState('student');
  const [user, setUser] = useState(null);

  // Redirect guests to guest courses page
  useEffect(() => {
    const currentUser = getUser();
    if (!currentUser) {
      navigate('/guest/courses', { replace: true });
      return;
    }
    
    setUser(currentUser);
    setUserRole(currentUser.role || currentUser.Role || 'student');
  }, [navigate]);

  const handleStartGarden = () => {
    if (userRole === 'student') {
      navigate('/student-dashboard');
    } else if (userRole === 'teacher') {
      navigate('/teacher-dashboard');
    } else if (userRole === 'admin') {
      navigate('/admin-dashboard');
    }
  };

  const handleManageCourse = () => {
    navigate('/manage-course');
  };

  if (!user) {
    return null;
  }

  const displayName = user.full_name || user.fullName || user.FullName || user.name || 'there';

  return (
    <>
      <Navbar />
      <div className="courses-page">
        <div className="courses-hero">
          <div className="courses-hero-content">
            <h1>🌱 Your Python Learning Journey</h1>
            <p className="courses-subtitle">
              Welcome {displayName}! Grow your coding skills through our interactive Python garden.
            </p>
          </div>
        </div>

        <div className="course-showcase">
          <div className="course-card-large">
            <div className="course-card-header">
              <div className="course-icon">🐍</div>
              <div className="course-badge">Featured Course</div>
            </div>
            
            <div className="course-card-body">
              <h2>Introduction to Python</h2>
              <p className="course-description">
                Master Python fundamentals through an immersive garden-themed learning experience. 
                Complete interactive chapters, earn achievements, and watch your knowledge bloom.
              </p>

              <div className="course-features">
                <div className="feature-item">
                  <span className="feature-icon">📚</span>
                  <div className="feature-text">
                    <strong>10 Chapters</strong>
                    <span>From basics to advanced topics</span>
                  </div>
                </div>
                <div className="feature-item">
                  <span className="feature-icon">⏱️</span>
                  <div className="feature-text">
                    <strong>Self-paced</strong>
                    <span>Learn at your own speed</span>
                  </div>
                </div>
                <div className="feature-item">
                  <span className="feature-icon">🎯</span>
                  <div className="feature-text">
                    <strong>Interactive</strong>
                    <span>Quizzes, flashcards & coding</span>
                  </div>
                </div>
                <div className="feature-item">
                  <span className="feature-icon">🏆</span>
                  <div className="feature-text">
                    <strong>Achievements</strong>
                    <span>Earn XP and badges</span>
                  </div>
                </div>
              </div>

              <div className="course-topics">
                <h3>What you'll learn:</h3>
                <ul className="topics-grid">
                  <li>🌿 Python basics & syntax</li>
                  <li>🌿 Variables & data types</li>
                  <li>🌿 Control flow & loops</li>
                  <li>🌿 Functions & modules</li>
                  <li>🌿 Data structures</li>
                  <li>🌿 Object-oriented programming</li>
                  <li>🌿 File handling</li>
                  <li>🌿 Error handling</li>
                </ul>
              </div>
            </div>

            <div className="course-card-actions">
              {userRole === 'student' && (
                <PrimaryButton size="lg" onClick={handleStartGarden}>
                  Continue Your Garden →
                </PrimaryButton>
              )}
              {(userRole === 'teacher' || userRole === 'admin') && (
                <>
                  <PrimaryButton size="lg" onClick={handleManageCourse}>
                    Manage Course Content
                  </PrimaryButton>
                  <PrimaryButton variant="outline" size="md" onClick={() => navigate('/teacher-dashboard')}>
                    View Dashboard
                  </PrimaryButton>
                </>
              )}
            </div>
          </div>

          {userRole === 'student' && (
            <div className="course-sidebar">
              <div className="sidebar-card">
                <h3>🎓 Your Progress</h3>
                <p>Track your growth as you complete each chapter of your Python journey.</p>
                <PrimaryButton variant="outline" onClick={handleStartGarden}>
                  View My Garden
                </PrimaryButton>
              </div>

              <div className="sidebar-card">
                <h3>💬 Need Help?</h3>
                <p>Join discussions with fellow learners and get support from teachers.</p>
                <PrimaryButton variant="outline" onClick={() => navigate('/student-dashboard')}>
                  Community Forum
                </PrimaryButton>
              </div>

              <div className="sidebar-card">
                <h3>📊 Leaderboard</h3>
                <p>See how you rank among other Python learners in the garden.</p>
                <PrimaryButton variant="outline" onClick={() => navigate('/student-dashboard')}>
                  View Rankings
                </PrimaryButton>
              </div>
            </div>
          )}
        </div>

        <div className="courses-cta">
          <h2>Ready to grow your Python skills?</h2>
          <p>Start your interactive learning journey today</p>
          <PrimaryButton size="lg" onClick={handleStartGarden}>
            {userRole === 'student' ? 'Go to My Garden' : 'Go to Dashboard'}
          </PrimaryButton>
        </div>
      </div>
    </>
  );
};

export default CoursesPage;
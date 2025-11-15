import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import StudentFlashcardComponent from '../components/StudentFlashcardComponent.jsx';
import PrimaryButton from '../components/PrimaryButton';
import { api } from '../services/apiService.js';
import { getChapterNotes } from '../data/chapterNotes';
import '../styles/GuestChapterViewer.css';

const GuestChapterViewer = () => {
  const { courseId, chapterId } = useParams();
  const navigate = useNavigate();
  
  const [activeTab, setActiveTab] = useState('notes');
  const [chapterData, setChapterData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchChapterPreview = async () => {
      try {
        setLoading(true);
        setError(null);
        
        // Get course preview which includes the first 3 chapters with resources
        const preview = await api.guests.getCoursePreview(courseId);
        
        // Find the requested chapter in the preview
        const chapter = preview.chapters?.find(ch => ch.chapterId === chapterId);
        
        if (!chapter) {
          setError('This chapter is not available in preview mode. Sign up to access all chapters!');
          return;
        }
        
        setChapterData(chapter);
      } catch (err) {
        console.error('Failed to load chapter preview:', err);
        setError('Unable to load chapter preview. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    fetchChapterPreview();
  }, [courseId, chapterId]);

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="guest-chapter-loading">
          <div className="loading-spinner">🌱</div>
          <p>Loading chapter preview...</p>
        </div>
      </>
    );
  }

  if (error || !chapterData) {
    return (
      <>
        <Navbar />
        <div className="guest-chapter-error">
          <h2>⚠️ Preview Not Available</h2>
          <p>{error || 'This chapter is not available for preview.'}</p>
          <div className="error-actions">
            <PrimaryButton onClick={() => navigate(`/guest/courses`)}>
              Back to Course
            </PrimaryButton>
            <PrimaryButton variant="outline" onClick={() => navigate('/register')}>
              Sign Up for Full Access
            </PrimaryButton>
          </div>
        </div>
      </>
    );
  }

  // Use fake notes from local data instead of API
  const notes = getChapterNotes(chapterId);
  const flashcards = chapterData?.previewResources?.filter(r => r.type === 'flashcard') || [];

  return (
    <>
      <Navbar />
      <main className="guest-chapter-viewer">
        {/* Chapter Header */}
        <header className="guest-chapter-header">
          <button 
            className="back-button"
            onClick={() => navigate(`/guest/courses`)}
          >
            ← Back to Course
          </button>
          <div className="chapter-title-section">
            <div className="chapter-number-badge">Chapter {chapterData.number}</div>
            <h1>{chapterData.title}</h1>
            {chapterData.summary && <p className="chapter-summary">{chapterData.summary}</p>}
          </div>
        </header>

        {/* Tab Navigation */}
        <div className="guest-chapter-tabs">
          <button
            type="button"
            className={`guest-tab ${activeTab === 'notes' ? 'active' : ''}`}
            onClick={() => setActiveTab('notes')}
          >
            <span className="tab-icon">📝</span>
            <span>Notes</span>
            <span className="tab-badge">{notes.length}</span>
          </button>
          <button
            type="button"
            className={`guest-tab ${activeTab === 'flashcards' ? 'active' : ''}`}
            onClick={() => setActiveTab('flashcards')}
          >
            <span className="tab-icon">🎴</span>
            <span>Flashcards</span>
            <span className="tab-badge">{flashcards.length}</span>
          </button>
          <button
            type="button"
            className="guest-tab locked"
            onClick={() => navigate('/register')}
          >
            <span className="tab-icon">🏆</span>
            <span>Challenges</span>
            <span className="tab-lock">🔒</span>
          </button>
          <button
            type="button"
            className="guest-tab locked"
            onClick={() => navigate('/register')}
          >
            <span className="tab-icon">💬</span>
            <span>Help</span>
            <span className="tab-lock">🔒</span>
          </button>
        </div>

        {/* Content Panel */}
        <div className="guest-chapter-content">
          {activeTab === 'notes' && (
            <div className="notes-section">
              {notes.length === 0 ? (
                <div className="empty-state">
                  <p>📚 No notes available for this chapter yet.</p>
                </div>
              ) : (
                notes.map((note) => (
                  <article key={note.resourceId} className="note-card">
                    <h3>{note.title}</h3>
                    <div 
                      className="note-content"
                      dangerouslySetInnerHTML={{ __html: note.content }}
                    />
                  </article>
                ))
              )}
              
              {/* Upgrade CTA */}
              <div className="upgrade-cta">
                <h3>🌟 Want More?</h3>
                <p>Sign up to unlock interactive challenges, quizzes, progress tracking, and more!</p>
                <PrimaryButton onClick={() => navigate('/register')}>
                  Create Free Account
                </PrimaryButton>
              </div>
            </div>
          )}

          {activeTab === 'flashcards' && (
            <div className="flashcards-section">
              {flashcards.length === 0 ? (
                <div className="empty-state">
                  <p>🎴 No flashcards available for this chapter yet.</p>
                </div>
              ) : (
                flashcards.map((flashcard) => (
                  <div key={flashcard.resourceId} className="flashcard-wrapper">
                    <h3 className="flashcard-title">{flashcard.title}</h3>
                    <StudentFlashcardComponent 
                      resourceId={flashcard.resourceId}
                      isGuest={true}
                    />
                  </div>
                ))
              )}
              
              {/* Upgrade CTA */}
              <div className="upgrade-cta">
                <h3>🎯 Level Up Your Learning</h3>
                <p>Track your progress, compete on leaderboards, and earn XP with a free account!</p>
                <PrimaryButton onClick={() => navigate('/register')}>
                  Sign Up Now
                </PrimaryButton>
              </div>
            </div>
          )}
        </div>

        {/* Chapter Navigation */}
        <div className="guest-chapter-navigation">
          <button 
            className="nav-button prev"
            onClick={() => navigate(`/guest/courses`)}
          >
            ← Back to Course Overview
          </button>
          <PrimaryButton 
            size="lg"
            onClick={() => navigate('/register')}
          >
            Unlock Full Course →
          </PrimaryButton>
        </div>
      </main>
    </>
  );
};

export default GuestChapterViewer;

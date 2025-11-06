import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { api } from '../services/apiService';
import GuestRestrictionBanner from './GuestRestrictionBanner';
import GuestAccessPrompt from './GuestAccessPrompt';

const GuestCoursePreview = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [preview, setPreview] = useState(null);
  const [sampleChapter, setSampleChapter] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showSample, setShowSample] = useState(false);

  useEffect(() => {
    if (courseId) {
      loadCoursePreview();
    }
  }, [courseId]);

  const loadCoursePreview = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getCoursePreview(courseId);
      setPreview(data);
      setError(null);
    } catch (err) {
      console.error('Failed to load course preview:', err);
      setError(err.message || 'Failed to load course preview. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const loadSampleChapter = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getSampleChapter(courseId);
      setSampleChapter(data);
      setShowSample(true);
    } catch (err) {
      console.error('Failed to load sample chapter:', err);
      alert('Failed to load sample chapter. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  if (loading && !preview) {
    return <div className="guest-preview-loading">Loading course preview...</div>;
  }

  if (error) {
    return (
      <div className="guest-preview-error">
        <p>{error}</p>
        <button onClick={() => navigate('/guest/courses')}>Back to Catalog</button>
      </div>
    );
  }

  if (!preview) {
    return (
      <div className="guest-preview-not-found">
        <p>Course preview not found.</p>
        <button onClick={() => navigate('/guest/courses')}>Back to Catalog</button>
      </div>
    );
  }

  return (
    <div className="guest-course-preview">
      <GuestRestrictionBanner 
        message="This is a preview. Register or log in to access full course content, quizzes, flashcards, and track your progress."
      />

      <div className="preview-header">
        <button
          className="back-button"
          onClick={() => navigate('/guest/courses')}
        >
          ← Back to Catalog
        </button>
        <div className="preview-title-section">
          <h1>{preview.title}</h1>
          <span className="preview-badge">🔒 Preview Mode - Limited Content</span>
        </div>
      </div>

      <div className="preview-content">
        <div className="preview-main">
          <div className="preview-section">
            <h2>Course Description</h2>
            <p>{preview.description || 'No description available'}</p>
          </div>

          {preview.previewContent && (
            <div className="preview-section">
              <h2>What You'll Learn</h2>
              <p>{preview.previewContent}</p>
            </div>
          )}

          <div className="preview-section">
            <h2>Course Content ({preview.totalChapters} Chapters)</h2>
            {preview.chapterTitles && preview.chapterTitles.length > 0 ? (
              <div className="chapters-preview">
                {preview.chapterTitles.map((chapter) => (
                  <div key={chapter.chapterId} className="chapter-preview-item">
                    <span className="chapter-number">Chapter {chapter.number}</span>
                    <div className="chapter-info">
                      <h3>{chapter.title}</h3>
                      {chapter.summary && <p>{chapter.summary}</p>}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p>No chapters available yet.</p>
            )}
          </div>

          {!showSample && (
            <div className="preview-section">
              <div className="sample-chapter-prompt">
                <p className="sample-notice">
                  <strong>Preview Only:</strong> You can view a sample chapter to get a taste of the course content.
                </p>
                <button
                  className="sample-chapter-button"
                  onClick={loadSampleChapter}
                  disabled={loading}
                >
                  {loading ? 'Loading...' : 'View Sample Chapter (Limited)'}
                </button>
                <p className="sample-upgrade-note">
                  Register to access all chapters and full content!
                </p>
              </div>
            </div>
          )}

          {showSample && sampleChapter && (
            <div className="preview-section sample-chapter-section">
              <div className="sample-header">
                <h2>📖 Sample Chapter Preview</h2>
                <span className="sample-badge">Limited Preview - Register for Full Access</span>
              </div>
              <div className="sample-chapter-content">
                <h3>
                  Chapter {sampleChapter.chapter.number}: {sampleChapter.chapter.title}
                </h3>
                {sampleChapter.chapter.summary && (
                  <p className="chapter-summary">{sampleChapter.chapter.summary}</p>
                )}

                {sampleChapter.chapter.sampleResources &&
                  sampleChapter.chapter.sampleResources.length > 0 && (
                    <div className="sample-resources">
                      <h4>Sample Content:</h4>
                      {sampleChapter.chapter.sampleResources.map((resource) => (
                        <div key={resource.resourceId} className="sample-resource">
                          <div className="resource-content">
                            {resource.content}
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
              </div>
            </div>
          )}
        </div>

        <div className="preview-sidebar">
          <GuestAccessPrompt
            title="Unlock Full Course Access"
            message="Register now to access all chapters, quizzes, flashcards, and track your learning progress!"
            featureList={[
              'All course chapters and content',
              'Interactive quizzes with feedback',
              'Flashcards for practice',
              'Progress tracking',
              'XP points and achievements',
              'Community forum access'
            ]}
          />

          <div className="preview-info-card">
            <h3>⚠️ Preview Limitations</h3>
            <ul>
              <li>❌ Limited chapter content (sample only)</li>
              <li>❌ No quizzes or flashcards</li>
              <li>❌ No progress tracking</li>
              <li>❌ No forum access</li>
              <li>❌ No XP points or achievements</li>
            </ul>
            <p className="upgrade-note">
              <strong>Register to unlock all features!</strong>
            </p>
          </div>
        </div>
      </div>

      <div className="preview-footer">
        <p className="preview-message">{preview.message}</p>
      </div>
    </div>
  );
};

export default GuestCoursePreview;


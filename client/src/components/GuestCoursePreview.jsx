import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import GuestRestrictionBanner from './GuestRestrictionBanner';
import GuestAccessPrompt from './GuestAccessPrompt';
import PrimaryButton from './PrimaryButton';
import Testimonials from './Testimonials';
import { api } from '../services/apiService';
import '../styles/GuestCoursePreview.css';

const GuestCoursePreview = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [preview, setPreview] = useState(null);
  const [chapterPreview, setChapterPreview] = useState(null);
  const [loading, setLoading] = useState(true);
  const [chapterLoading, setChapterLoading] = useState(false);
  const [error, setError] = useState('');
  const [chapterError, setChapterError] = useState('');

  useEffect(() => {
    if (!courseId) return;
    let isMounted = true;

    const loadPreview = async () => {
      try {
        setLoading(true);
        const data = await api.guests.getCoursePreview(courseId);
        if (!isMounted) return;
        setPreview(data);
        setError('');
      } catch (err) {
        console.error('Failed to load course preview:', err);
        if (isMounted) {
          setError('We could not load this course preview right now. Please try again.');
        }
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    };

    loadPreview();
    return () => {
      isMounted = false;
    };
  }, [courseId]);

  const handlePreviewChapter = async (chapterId) => {
    if (!courseId || !chapterId) return;
    try {
      setChapterLoading(true);
      setChapterError('');
      const data = await api.guests.getChapterPreview(courseId, chapterId);
      setChapterPreview(data);
    } catch (err) {
      console.error('Failed to load chapter preview:', err);
      setChapterError('Unable to load this chapter preview right now.');
    } finally {
      setChapterLoading(false);
    }
  };

  const previewChapters = useMemo(() => preview?.previewChapters || [], [preview]);
  const additionalChapterCount = Math.max((preview?.course?.totalChapters || 0) - previewChapters.length, 0);

  if (loading) {
    return (
      <div className="guest-preview guest-preview--loading">
        <GuestRestrictionBanner />
        <div className="guest-preview__loading-card">Loading course preview…</div>
      </div>
    );
  }

  if (error || !preview || !preview.course) {
    return (
      <div className="guest-preview guest-preview--error">
        <GuestRestrictionBanner />
        <div className="guest-preview__error-card">
          <p>{error || 'Course preview not found.'}</p>
          <PrimaryButton variant="outline" onClick={() => navigate('/guest/courses')}>
            Back to courses
          </PrimaryButton>
        </div>
      </div>
    );
  }

  const { course, learningObjectives = [] } = preview;
  const difficultyLabel = course.difficulty
    ? course.difficulty.charAt(0).toUpperCase() + course.difficulty.slice(1)
    : 'Beginner';

  return (
    <div className="guest-preview">
      <GuestRestrictionBanner />

      <header className="guest-preview__hero">
        <button className="guest-preview__back" onClick={() => navigate('/guest/courses')}>
          ← Back to catalog
        </button>
        <div className="guest-preview__headline">
          <span className="guest-preview__difficulty">{difficultyLabel}</span>
          <h1>{course.title}</h1>
          <p>{course.description}</p>
          <ul className="guest-preview__meta">
            <li>
              <strong>{course.totalChapters}</strong>
              <span>Chapters</span>
            </li>
            {course.estimatedHours && (
              <li>
                <strong>{course.estimatedHours}</strong>
                <span>Estimated hours</span>
              </li>
            )}
            {typeof course.enrollmentCount === 'number' && (
              <li>
                <strong>{course.enrollmentCount.toLocaleString()}</strong>
                <span>Learners</span>
              </li>
            )}
            {course.rating && (
              <li>
                <strong>{course.rating.toFixed(1)}</strong>
                <span>Average rating</span>
              </li>
            )}
          </ul>
          <div className="guest-preview__actions">
            <PrimaryButton size="md" onClick={() => navigate('/register')}>
              Get Started
            </PrimaryButton>
            <PrimaryButton variant="ghost" size="sm" onClick={() => navigate('/login')}>
              Already a member? Log in
            </PrimaryButton>
          </div>
        </div>
        <div className="guest-preview__prompt">
          <GuestAccessPrompt
            title="Unlock Full Access"
            message="Register to unlock the complete curriculum, quizzes, flashcards, and personalized progress tracking."
            featureList={[
              'All course chapters',
              'Hands-on coding challenges',
              'Interactive quizzes with feedback',
              'Achievement badges and XP',
              'Community discussions',
            ]}
          />
        </div>
      </header>

      <section className="guest-preview__curriculum" aria-labelledby="curriculum-heading">
        <div className="section-heading">
          <h2 id="curriculum-heading">What you will learn</h2>
          <p>Preview the opening chapters before joining the full course.</p>
        </div>
        <div className="guest-preview__chapters">
          {previewChapters.map((chapter, index) => {
            const chapterNumber = chapter.number || index + 1;
            const isUnlocked = index === 0;
            return (
              <article
                key={chapter.id || chapter.chapterId || chapterNumber}
                className={`preview-chapter${isUnlocked ? ' preview-chapter--open' : ' preview-chapter--locked'}`}
              >
                <div className="preview-chapter__meta">
                  <span className="chapter-index">Chapter {chapterNumber}</span>
                  {chapter.estimatedMinutes && <span>{chapter.estimatedMinutes} mins</span>}
                </div>
                <h3>{chapter.title}</h3>
                <p>{chapter.description}</p>
                <div className="preview-chapter__actions">
                  {isUnlocked ? (
                    <PrimaryButton
                      size="sm"
                      onClick={() => handlePreviewChapter(chapter.id || chapter.chapterId)}
                    >
                      Preview chapter
                    </PrimaryButton>
                  ) : (
                    <span className="preview-chapter__locked">Log in to access this chapter</span>
                  )}
                </div>
              </article>
            );
          })}
        </div>
        {additionalChapterCount > 0 && (
          <div className="preview-more">
            🔒 {additionalChapterCount} more chapters waiting in the full course. Sign up to unlock!
          </div>
        )}
      </section>

      {learningObjectives.length > 0 && (
        <section className="guest-preview__objectives" aria-labelledby="objectives-heading">
          <div className="section-heading">
            <h2 id="objectives-heading">Learning objectives</h2>
            <p>By the end of the course you will be able to:</p>
          </div>
          <ul className="objective-list">
            {learningObjectives.map((objective, index) => (
              <li key={index}>{objective}</li>
            ))}
          </ul>
        </section>
      )}

      {chapterPreview && (
        <section className="guest-preview__chapter" aria-labelledby="chapter-preview-heading">
          <div className="section-heading">
            <h2 id="chapter-preview-heading">Chapter preview</h2>
            <p>{chapterPreview.chapter?.title}</p>
          </div>
          {chapterError && <div className="chapter-preview__error">{chapterError}</div>}
          {chapterLoading && <div className="chapter-preview__loading">Loading chapter preview…</div>}
          {!chapterLoading && (
            <div className="chapter-preview__content">
              <p>{chapterPreview.chapter?.description}</p>
              {chapterPreview.content && <pre>{chapterPreview.content}</pre>}
            </div>
          )}
          <div className="chapter-preview__cta">
            <PrimaryButton size="md" onClick={() => navigate('/register')}>
              Continue learning
            </PrimaryButton>
          </div>
        </section>
      )}

      <section className="guest-preview__testimonials" aria-labelledby="preview-testimonials">
        <div className="section-heading">
          <h2 id="preview-testimonials">What students say about this course</h2>
          <p>These learners previewed the course and decided to grow with CodeSage.</p>
        </div>
        <Testimonials courseId={courseId} limit={3} />
      </section>
    </div>
  );
};

export default GuestCoursePreview;

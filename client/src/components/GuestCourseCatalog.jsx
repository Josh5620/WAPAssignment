import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import PrimaryButton from './PrimaryButton';
import { api } from '../services/apiService';

const normalizeCourse = (course) => ({
  id: course?.id ?? course?.courseId ?? course?.CourseId ?? course?.Id,
  title: course?.title ?? course?.Title ?? 'Untitled Course',
  description: course?.description ?? course?.Description ?? 'No description available yet.',
  difficulty: (course?.difficulty ?? course?.Difficulty ?? 'beginner').toLowerCase(),
  chapterCount:
    course?.chapterCount ??
    course?.ChapterCount ??
    course?.totalChapters ??
    course?.TotalChapters ??
    (Array.isArray(course?.chapters) ? course.chapters.length : undefined) ??
    (Array.isArray(course?.Chapters) ? course.Chapters.length : undefined) ??
    0,
  enrollmentCount: course?.enrollmentCount ?? course?.EnrollmentCount ?? course?.students ?? null,
  estimatedHours: course?.estimatedHours ?? course?.EstimatedHours ?? null,
  previewContent: course?.previewContent ?? course?.PreviewContent ?? '',
  thumbnailUrl: course?.thumbnailUrl ?? course?.ThumbnailUrl ?? '/python.svg',
  published: Boolean(course?.published ?? course?.Published ?? true),
});

const difficultyLabel = {
  beginner: 'Beginner',
  intermediate: 'Intermediate',
  advanced: 'Advanced',
};

const formatNumber = (value) => {
  if (value == null) return null;
  return Intl.NumberFormat('en', { notation: 'compact' }).format(value);
};

const GuestCourseCatalog = ({ courses: providedCourses, limit, compact = false }) => {
  const navigate = useNavigate();
  const [courses, setCourses] = useState(() =>
    (providedCourses || []).map(normalizeCourse)
  );
  const [loading, setLoading] = useState(!providedCourses);
  const [error, setError] = useState('');

  useEffect(() => {
    if (providedCourses) {
      setCourses((providedCourses || []).map(normalizeCourse));
      setLoading(false);
      setError('');
      return;
    }

    let isMounted = true;

    const loadCourseCatalog = async () => {
      try {
        setLoading(true);
        const data = await api.guests.getCourseCatalog();
        if (!isMounted) return;
        const normalized = (data.courses || data || []).map(normalizeCourse);
        setCourses(normalized);
        setError('');
      } catch (err) {
        console.error('Failed to load course catalog:', err);
        if (isMounted) {
          setError('We could not load courses right now. Please try again.');
        }
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    };

    loadCourseCatalog();
    return () => {
      isMounted = false;
    };
  }, [providedCourses]);

  const visibleCourses = useMemo(() => {
    const source = limit ? courses.slice(0, limit) : courses;
    return source;
  }, [courses, limit]);

  const handleViewPreview = (courseId) => {
    if (!courseId) return;
    navigate(`/guest/courses/${courseId}/preview`);
  };

  if (loading) {
    return <div className="guest-catalog-loading">Loading course catalog…</div>;
  }

  if (error) {
    return (
      <div className="guest-catalog-error">
        <p>{error}</p>
        {!providedCourses && (
          <PrimaryButton onClick={() => window.location.reload()} variant="outline">
            Retry
          </PrimaryButton>
        )}
      </div>
    );
  }

  if (visibleCourses.length === 0) {
    return (
      <div className="guest-catalog-empty">
        <p>No courses available at the moment. Check back soon!</p>
      </div>
    );
  }

  return (
    <div className={`guest-course-catalog${compact ? ' guest-course-catalog--compact' : ''}`}>
      <div className="catalog-grid">
        {visibleCourses.map((course) => {
          const difficulty = difficultyLabel[course.difficulty] || course.difficulty;
          const enrollment = formatNumber(course.enrollmentCount);
          return (
            <article key={course.id} className="guest-course-card">
              <div className="guest-course-card__badge">
                <span>{difficulty}</span>
              </div>
              <div className="guest-course-card__heading">
                <h3>{course.title}</h3>
                <p>{course.description}</p>
              </div>
              <div className="guest-course-card__meta">
                <span>{course.chapterCount} chapters</span>
                {course.estimatedHours && <span>{course.estimatedHours} hrs</span>}
                {enrollment && <span>{enrollment} learners</span>}
              </div>
              <div className="guest-course-card__cta">
                <PrimaryButton size="sm" onClick={() => handleViewPreview(course.id)}>
                  Preview
                </PrimaryButton>
              </div>
            </article>
          );
        })}
      </div>
    </div>
  );
};

export default GuestCourseCatalog;


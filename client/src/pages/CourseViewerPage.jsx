import React, { useCallback, useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { getUser } from '../utils/auth';
import Navbar from '../components/Navbar';
import ReturnHome from '../components/ReturnHome';
import StudentQuizComponent from '../components/StudentQuizComponent';
import StudentFlashcardComponent from '../components/StudentFlashcardComponent';
import {
  teacherCourseService,
  chapterManagementService,
  resourceManagementService,
  api,
} from '../services/apiService';
import '../styles/CourseViewerPage.css';

const CourseViewerPage = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  
  // Redirect guests to guest preview page
  useEffect(() => {
    const user = getUser();
    if (!user && courseId) {
      navigate(`/guest/courses/${courseId}/preview`, { replace: true });
    }
  }, [courseId, navigate]);
  const [course, setCourse] = useState(null);
  const [chapters, setChapters] = useState([]);
  const [selectedChapterId, setSelectedChapterId] = useState(null);
  const [resources, setResources] = useState([]);
  const [loading, setLoading] = useState(true);
  const [resourcesLoading, setResourcesLoading] = useState(false);
  const [error, setError] = useState('');
  const [userProgress, setUserProgress] = useState(null);
  const [chapterProgressMap, setChapterProgressMap] = useState({}); // Map of chapterId -> { completed, chapterNumber }

  const loadResources = useCallback(
    async (chapterId, { silent = false } = {}) => {
      if (!chapterId) {
        setResources([]);
        return;
      }
      if (!silent) {
        setResourcesLoading(true);
      }
      try {
        const data = await resourceManagementService.list(chapterId);
        setResources(Array.isArray(data) ? data : []);
        setError('');
      } catch (err) {
        console.error('Failed to load resources', err);
        setResources([]);
        setError(err.message || 'Failed to load resources');
      } finally {
        if (!silent) {
          setResourcesLoading(false);
        }
      }
    },
    [],
  );

  const loadCourse = useCallback(async () => {
    console.log('loadCourse called, courseId:', courseId);
    setLoading(true);
    setError('');
    try {
      const [courseData, chapterData] = await Promise.all([
        teacherCourseService.getCourse(courseId),
        chapterManagementService.list(courseId),
      ]);
      const chapterList = Array.isArray(chapterData) ? chapterData : [];
      setCourse(courseData);
      setChapters(chapterList);
      // Don't auto-select first chapter - show summary view by default
      setSelectedChapterId(null);
      setResources([]);
      setError('');

      // Fetch user progress if user is a student (non-blocking)
      const user = getUser();
      if (user && user.id && (user.role === 'student' || !user.role)) {
        // Fetch progress asynchronously without blocking course load
        (async () => {
          try {
            // Fetch all chapter progress in parallel for better performance
            const progressPromises = chapterList.map(async (chapter) => {
              const chapterId = chapter.id || chapter.Id;
              const chapterNumber = chapter.number || chapter.Number || 0;
              try {
                const chapterProgress = await api.students.getChapterProgress(user.id, chapterId);
                return {
                  chapterId,
                  chapterNumber,
                  completed: chapterProgress.completed || false
                };
              } catch (err) {
                // If progress doesn't exist, chapter is not completed
                return {
                  chapterId,
                  chapterNumber,
                  completed: false
                };
              }
            });

            const progressResults = await Promise.all(progressPromises);
            const progressMap = {};
            progressResults.forEach(result => {
              progressMap[result.chapterId] = {
                completed: result.completed,
                chapterNumber: result.chapterNumber
              };
            });

            setChapterProgressMap(progressMap);
          } catch (progressErr) {
            // If progress fetch fails, just continue without progress data
            console.log('Could not load progress:', progressErr);
            setChapterProgressMap({});
          }
        })();
      }
    } catch (err) {
      console.error('Failed to load course', err);
      setError(err.message || 'Failed to load course details. Please try again.');
    } finally {
      setLoading(false);
    }
  }, [courseId]);

  useEffect(() => {
    loadCourse();
  }, [loadCourse]);

  const handleSelectChapter = async (chapterId) => {
    setSelectedChapterId(chapterId);
    await loadResources(chapterId);
  };

  // Check if a chapter is unlocked based on quiz completion
  // A chapter unlocks only if the previous chapter's quiz is completed
  const isChapterUnlocked = (chapterNumber, chapterId) => {
    // Chapter 1 is always unlocked
    if (chapterNumber === 1) {
      return true;
    }
    
    // Check if previous chapter (chapterNumber - 1) is completed
    const previousChapterNumber = chapterNumber - 1;
    
    // Find the previous chapter in the chapters list
    const previousChapter = chapters.find(
      ch => (ch.number || ch.Number || 0) === previousChapterNumber
    );
    
    if (!previousChapter) {
      // If previous chapter doesn't exist, unlock this one (shouldn't happen normally)
      return true;
    }
    
    const previousChapterId = previousChapter.id || previousChapter.Id;
    const previousChapterProgress = chapterProgressMap[previousChapterId];
    
    // Chapter is unlocked if the previous chapter's quiz is completed
    return previousChapterProgress?.completed === true;
  };

  const handleStartLearning = (chapterId, chapterNumber) => {
    const user = getUser();
    const isTeacherOrAdmin = user && (user.role === 'teacher' || user.role === 'admin');
    const isStudent = user && (user.role === 'student' || !user.role);
    
    if (isTeacherOrAdmin) {
      // Navigate to manage-course page with chapter editing for teachers/admins
      navigate(`/manage-course?courseId=${courseId}&chapterId=${chapterId}`);
    } else if (isStudent && isChapterUnlocked(chapterNumber, chapterId)) {
      // Navigate to dashboard if chapter is unlocked (quiz completed for previous chapter)
      navigate('/student-dashboard');
    } else {
      // Navigate to chapter page if locked (previous chapter's quiz not completed)
      // Note: This uses numeric chapter IDs from the static garden path
      navigate(`/chapters/${chapterNumber}`);
    }
  };

  const renderResource = (resource) => {
    const type = resource.type || resource.Type || 'text';
    const content = resource.content || resource.Content || '';
    const user = getUser();
    const isStudent = user && user.role === 'student';

    // Render quiz component for MCQ resources (students only)
    if (type === 'mcq' && isStudent && selectedChapterId) {
      return (
        <div className="course-viewer__quiz-container">
          <StudentQuizComponent 
            chapterId={selectedChapterId}
            onQuizComplete={(result) => {
              console.log('Quiz completed:', result);
              // Optionally refresh progress or show success message
            }}
          />
        </div>
      );
    }

    // Render flashcard component for flashcard resources (students only)
    if (type === 'flashcard' && isStudent && selectedChapterId) {
      return (
        <div className="course-viewer__flashcard-container">
          <StudentFlashcardComponent chapterId={selectedChapterId} />
        </div>
      );
    }

    // For teachers or non-interactive resources, show content
    if (type === 'text' || type === 'note') {
      return <div className="course-viewer__text" dangerouslySetInnerHTML={{ __html: content }} />;
    }

    if (type === 'link') {
      return (
        <a href={content} target="_blank" rel="noopener noreferrer" className="course-viewer__link">
          {content}
        </a>
      );
    }

    if (type === 'file') {
      return (
        <a href={content} target="_blank" rel="noopener noreferrer" className="course-viewer__file">
          Download file
        </a>
      );
    }

    // For MCQ/flashcard resources when not a student, show a message
    if ((type === 'mcq' || type === 'flashcard') && !isStudent) {
      return (
        <div className="course-viewer__restricted">
          <p>This is a {type === 'mcq' ? 'quiz' : 'flashcard'} resource. Interactive content is available to students only.</p>
        </div>
      );
    }

    return <pre className="course-viewer__text">{content}</pre>;
  };

  // Show error page if there's an error and no course data
  if (error && !course && !loading) {
    const handleRetry = async () => {
      console.log('Retry button clicked, courseId:', courseId);
      setError('');
      setLoading(true);
      try {
        const [courseData, chapterData] = await Promise.all([
          teacherCourseService.getCourse(courseId),
          chapterManagementService.list(courseId),
        ]);
        const chapterList = Array.isArray(chapterData) ? chapterData : [];
        setCourse(courseData);
        setChapters(chapterList);
        setSelectedChapterId(null);
        setResources([]);
        setError('');

        // Fetch user progress if user is a student (non-blocking)
        const user = getUser();
        if (user && user.id && (user.role === 'student' || !user.role)) {
          (async () => {
            try {
              const progressPromises = chapterList.map(async (chapter) => {
                const chapterId = chapter.id || chapter.Id;
                const chapterNumber = chapter.number || chapter.Number || 0;
                try {
                  const chapterProgress = await api.students.getChapterProgress(user.id, chapterId);
                  return {
                    chapterId,
                    chapterNumber,
                    completed: chapterProgress.completed || false
                  };
                } catch (err) {
                  return {
                    chapterId,
                    chapterNumber,
                    completed: false
                  };
                }
              });

              const progressResults = await Promise.all(progressPromises);
              const progressMap = {};
              progressResults.forEach(result => {
                progressMap[result.chapterId] = {
                  completed: result.completed,
                  chapterNumber: result.chapterNumber
                };
              });
              setChapterProgressMap(progressMap);
            } catch (progressErr) {
              console.log('Could not load progress:', progressErr);
              setChapterProgressMap({});
            }
          })();
        }
      } catch (err) {
        console.error('Failed to load course on retry:', err);
        setError(err.message || 'Failed to load course details. Please try again.');
      } finally {
        setLoading(false);
      }
    };

    return (
      <>
        <Navbar />
        <div className="course-viewer-page">
          <ReturnHome />
          <div className="course-viewer__container">
            <div className="course-viewer__error">
              <h2>Failed to Load Course</h2>
              <p>{error}</p>
              <div className="course-viewer__error-actions">
                <button 
                  type="button" 
                  className="retry-button"
                  onClick={handleRetry}
                >
                  Try Again
                </button>
                <button 
                  type="button" 
                  className="back-button"
                  onClick={() => {
                    const user = getUser();
                    if (user?.role === 'teacher') {
                      navigate('/teacher-dashboard');
                    } else {
                      navigate('/student-dashboard');
                    }
                  }}
                >
                  Back to Dashboard
                </button>
              </div>
            </div>
          </div>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <div className="course-viewer-page">
        <ReturnHome />
        <div className="course-viewer__container">
          <header className="course-viewer__header">
            <div>
              <h1>{course?.title || course?.Title || 'Course Preview'}</h1>
              {(course?.description || course?.Description) && <p>{course.description || course.Description}</p>}
            </div>
            <button 
              type="button" 
              onClick={() => {
                const user = getUser();
                if (user?.role === 'teacher') {
                  navigate('/teacher-dashboard');
                } else {
                  navigate('/student-dashboard');
                }
              }}
            >
              Back to Dashboard
            </button>
          </header>

          {error && course && <div className="course-viewer__alert">{error}</div>}

        {loading ? (
          <div className="course-viewer__loading">Loading course...</div>
        ) : (
          <div className="course-viewer__body">
            {selectedChapterId && (
              <aside className="course-viewer__sidebar">
                <h2>Chapters</h2>
                <ul>
                  {chapters.map((chapter) => {
                    const id = chapter.id || chapter.Id;
                    const isActive = id === selectedChapterId;
                    return (
                      <li key={id} className={isActive ? 'is-active' : ''}>
                        <button type="button" onClick={() => handleSelectChapter(id)}>
                          {chapter.title || chapter.Title}
                        </button>
                      </li>
                    );
                  })}
                  {chapters.length === 0 && <li className="course-viewer__empty">No chapters yet.</li>}
                </ul>
              </aside>
            )}

            <main className="course-viewer__content">
              <div className="course-viewer__chapter-summary-view">
                <div className="chapter-summary-header">
                  <h2>Course Overview</h2>
                  <p>Explore all chapters in this course. Click on any chapter to expand and view its content.</p>
                </div>
                <div className="chapters-summary-grid">
                  {chapters
                    .sort((a, b) => (a.number || a.Number || 0) - (b.number || b.Number || 0))
                    .map((chapter) => {
                      const id = chapter.id || chapter.Id;
                      const number = chapter.number || chapter.Number || 0;
                      const title = chapter.title || chapter.Title || 'Untitled Chapter';
                      const summary = chapter.summary || chapter.Summary || 'No summary available.';
                      const isExpanded = id === selectedChapterId;
                      
                      return (
                        <div
                          key={id}
                          className={`chapter-summary-card ${isExpanded ? 'is-expanded' : ''}`}
                        >
                          <div 
                            className="chapter-summary-card-header"
                            onClick={() => {
                              if (isExpanded) {
                                setSelectedChapterId(null);
                              } else {
                                setSelectedChapterId(id);
                              }
                            }}
                          >
                            <div className="chapter-summary-number">
                              <span>{number}</span>
                            </div>
                            <div className="chapter-summary-content">
                              <h3>{title}</h3>
                              <p>{summary}</p>
                            </div>
                            <div className="chapter-summary-action">
                              <span>{isExpanded ? '↑' : '→'}</span>
                            </div>
                          </div>
                          
                          {isExpanded && (() => {
                            const user = getUser();
                            const isTeacherOrAdmin = user && (user.role === 'teacher' || user.role === 'admin');
                            return (
                              <div className="chapter-summary-expanded-content">
                                <div className="chapter-expanded-summary">
                                  <h4>{isTeacherOrAdmin ? 'Chapter Overview' : 'What You\'ll Study'}</h4>
                                  <p>{summary}</p>
                                </div>
                                <div className="chapter-expanded-actions">
                                  <button
                                    type="button"
                                    className="chapter-start-learning-btn"
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      handleStartLearning(id, number);
                                    }}
                                  >
                                    {isTeacherOrAdmin ? 'Edit Chapter →' : 'Start Learning →'}
                                  </button>
                                </div>
                              </div>
                            );
                          })()}
                        </div>
                      );
                    })}
                  {chapters.length === 0 && (
                    <div className="chapter-summary-empty">
                      <p>No chapters available yet.</p>
                    </div>
                  )}
                </div>
              </div>
            </main>
          </div>
        )}
        </div>
      </div>
    </>
  );
};

export default CourseViewerPage;

import React, { useCallback, useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import TestingNav from '../components/TestingNav';
import ReturnHome from '../components/ReturnHome';
import {
  teacherCourseService,
  chapterManagementService,
  resourceManagementService,
} from '../services/apiService';
import '../styles/CourseViewerPage.css';

const CourseViewerPage = () => {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState(null);
  const [chapters, setChapters] = useState([]);
  const [selectedChapterId, setSelectedChapterId] = useState(null);
  const [resources, setResources] = useState([]);
  const [loading, setLoading] = useState(true);
  const [resourcesLoading, setResourcesLoading] = useState(false);
  const [error, setError] = useState('');

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

  useEffect(() => {
    let ignore = false;
    const load = async () => {
      setLoading(true);
      try {
        const [courseData, chapterData] = await Promise.all([
          teacherCourseService.getCourse(courseId),
          chapterManagementService.list(courseId),
        ]);
        if (ignore) return;
        const chapterList = Array.isArray(chapterData) ? chapterData : [];
        setCourse(courseData);
        setChapters(chapterList);
        if (chapterList.length) {
          const firstId = chapterList[0].id || chapterList[0].Id;
          setSelectedChapterId(firstId);
          await loadResources(firstId, { silent: true });
        } else {
          setSelectedChapterId(null);
          setResources([]);
        }
        setError('');
      } catch (err) {
        if (!ignore) {
          console.error('Failed to load course', err);
          setError(err.message || 'Failed to load course');
        }
      } finally {
        if (!ignore) {
          setLoading(false);
        }
      }
    };

    load();
    return () => {
      ignore = true;
    };
  }, [courseId, loadResources]);

  const handleSelectChapter = async (chapterId) => {
    setSelectedChapterId(chapterId);
    await loadResources(chapterId);
  };

  const renderResource = (resource) => {
    const type = resource.type || resource.Type || 'text';
    const content = resource.content || resource.Content || '';

    if (type === 'text') {
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

    return <pre className="course-viewer__text">{content}</pre>;
  };

  return (
    <div className="course-viewer-page">
      <TestingNav />
      <ReturnHome />
      <div className="course-viewer__container">
        <header className="course-viewer__header">
          <div>
            <h1>{course?.title || course?.Title || 'Course Preview'}</h1>
            {(course?.description || course?.Description) && <p>{course.description || course.Description}</p>}
          </div>
          <button type="button" onClick={() => navigate('/teacher-dashboard')}>
            Back to Dashboard
          </button>
        </header>

        {error && <div className="course-viewer__alert">{error}</div>}

        {loading ? (
          <div className="course-viewer__loading">Loading course...</div>
        ) : (
          <div className="course-viewer__body">
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

            <main className="course-viewer__content">
              {resourcesLoading ? (
                <div className="course-viewer__loading">Loading resources...</div>
              ) : resources.length ? (
                resources.map((resource) => {
                  const id = resource.id || resource.Id;
                  return (
                    <article key={id} className="course-viewer__resource">
                      <header>
                        <h3>{resource.title || resource.Title || 'Resource'}</h3>
                      </header>
                      <div className="course-viewer__resource-body">{renderResource(resource)}</div>
                    </article>
                  );
                })
              ) : (
                <div className="course-viewer__empty">No resources for this chapter yet.</div>
              )}
            </main>
          </div>
        )}
      </div>
    </div>
  );
};

export default CourseViewerPage;

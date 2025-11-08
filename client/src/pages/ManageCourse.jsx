import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import {
  teacherCourseService,
  chapterManagementService,
  resourceManagementService,
} from '../services/apiService';
import '../styles/ManageCourse.css';

const ManageCourse = () => {
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
          const existing = chapterList.find((chapter) => (chapter.id || chapter.Id) === selectedChapterId);
          const initialId = existing ? selectedChapterId : chapterList[0].id || chapterList[0].Id;
          setSelectedChapterId(initialId || null);
          if (initialId) {
            await loadResources(initialId, { silent: true });
          }
        } else {
          setSelectedChapterId(null);
          setResources([]);
        }
        setError('');
      } catch (err) {
        if (!ignore) {
          console.error('Failed to initialise course management', err);
          setError(err.message || 'Failed to load course data');
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

  const refreshChapters = useCallback(
    async (preferredId) => {
      try {
        const updated = await chapterManagementService.list(courseId);
        const list = Array.isArray(updated) ? updated : [];
        setChapters(list);
        const desiredId =
          preferredId ||
          (list.find((chapter) => (chapter.id || chapter.Id) === selectedChapterId)
            ? selectedChapterId
            : list[0]?.id || list[0]?.Id || null);
        setSelectedChapterId(desiredId || null);
        if (desiredId) {
          await loadResources(desiredId);
        } else {
          setResources([]);
        }
      } catch (err) {
        console.error('Failed to refresh chapters', err);
        setError(err.message || 'Failed to refresh chapters');
      }
    },
    [courseId, loadResources, selectedChapterId],
  );

  const selectChapter = async (chapterId) => {
    setSelectedChapterId(chapterId);
    await loadResources(chapterId);
  };

  const createChapter = async () => {
    const title = window.prompt('Chapter title');
    if (!title) return;
    const summary = window.prompt('Chapter summary (optional)', '') ?? '';
    const numbers = chapters.map((chapter) => chapter.number ?? chapter.Number ?? 0);
    const nextNumber = numbers.length ? Math.max(...numbers) + 1 : 1;

    try {
      await chapterManagementService.create(courseId, {
        title,
        summary,
        number: nextNumber,
      });
      await refreshChapters();
    } catch (err) {
      console.error('Failed to create chapter', err);
      setError(err.message || 'Failed to create chapter');
    }
  };

  const editChapter = async (chapter) => {
    const currentTitle = chapter.title || chapter.Title;
    const currentSummary = chapter.summary || chapter.Summary || '';
    const title = window.prompt('Chapter title', currentTitle);
    if (title === null) return;
    const summary = window.prompt('Chapter summary', currentSummary);
    if (summary === null) return;
    try {
      await chapterManagementService.update(chapter.id || chapter.Id, {
        title: title.trim(),
        summary: summary.trim(),
      });
      await refreshChapters(chapter.id || chapter.Id);
    } catch (err) {
      console.error('Failed to update chapter', err);
      setError(err.message || 'Failed to update chapter');
    }
  };

  const deleteChapter = async (chapter) => {
    if (!window.confirm('Delete this chapter and all of its resources?')) {
      return;
    }
    try {
      await chapterManagementService.deleteChapter(chapter.id || chapter.Id);
      await refreshChapters();
    } catch (err) {
      console.error('Failed to delete chapter', err);
      setError(err.message || 'Failed to delete chapter');
    }
  };

  const createResource = async () => {
    if (!selectedChapterId) return;
    const typeInput = window.prompt('Resource type (text, link, file)', 'text');
    if (!typeInput) return;
    const type = typeInput.trim().toLowerCase();
    const promptLabel = type === 'text' ? 'Enter HTML content for this resource' : 'Enter resource URL';
    const defaultValue = type === 'text' ? '<p>New resource content</p>' : 'https://';
    const content = window.prompt(promptLabel, defaultValue);
    if (content === null) return;

    try {
      await resourceManagementService.create(selectedChapterId, {
        id: globalThis.crypto?.randomUUID?.() ?? `${Date.now()}`,
        type,
        content,
      });
      await loadResources(selectedChapterId);
    } catch (err) {
      console.error('Failed to create resource', err);
      setError(err.message || 'Failed to create resource');
    }
  };

  const editResource = async (resource) => {
    const typeInput = window.prompt('Resource type', resource.type || resource.Type || 'text');
    if (typeInput === null) return;
    const type = typeInput.trim().toLowerCase();
    const contentDefault = resource.content || resource.Content || '';
    const contentPrompt = type === 'text' ? 'Update HTML content' : 'Update resource URL';
    const content = window.prompt(contentPrompt, contentDefault);
    if (content === null) return;

    try {
      await resourceManagementService.update(resource.id || resource.Id, {
        type,
        content,
      });
      await loadResources(selectedChapterId);
    } catch (err) {
      console.error('Failed to update resource', err);
      setError(err.message || 'Failed to update resource');
    }
  };

  const deleteResource = async (resource) => {
    if (!window.confirm('Delete this resource?')) {
      return;
    }
    try {
      await resourceManagementService.deleteResource(resource.id || resource.Id);
      await loadResources(selectedChapterId);
    } catch (err) {
      console.error('Failed to delete resource', err);
      setError(err.message || 'Failed to delete resource');
    }
  };

  const selectedChapter = useMemo(
    () => chapters.find((chapter) => (chapter.id || chapter.Id) === selectedChapterId) || null,
    [chapters, selectedChapterId],
  );

  return (
    <>
      <Navbar />
      <main className="manage-course">
        <div className="manage-course__shell">
          <div className="manage-course__container">
            <header className="manage-course__header">
              <div className="manage-course__header-copy">
                <p className="manage-course__eyebrow">Course Garden Tools</p>
                <h1>{course?.title || course?.Title || 'Manage Course'}</h1>
                {(course?.description || course?.Description) && (
                  <p className="manage-course__subtitle">{course.description || course.Description}</p>
                )}
              </div>
              <div className="manage-course__header-actions">
                <PrimaryButton
                  variant="secondary"
                  size="sm"
                  onClick={() => navigate(`/courses/${courseId}/view`)}
                >
                  Preview Course
                </PrimaryButton>
                <PrimaryButton
                  variant="ghost"
                  size="sm"
                  onClick={() => navigate('/teacher-dashboard')}
                >
                  Back to Dashboard
                </PrimaryButton>
              </div>
            </header>

            {error && <div className="manage-course__alert">{error}</div>}

            {loading ? (
              <div className="manage-course__state">Loading course...</div>
            ) : (
              <div className="manage-course__body">
                <section className="manage-course__panel">
                  <div className="manage-course__panel-header">
                    <h2>Chapters</h2>
                    <PrimaryButton size="sm" onClick={createChapter}>
                      Add Chapter
                    </PrimaryButton>
                  </div>
                  <ul className="manage-course__list">
                    {chapters.map((chapter) => {
                      const id = chapter.id || chapter.Id;
                      const isActive = id === selectedChapterId;
                      return (
                        <li
                          key={id}
                          className={`manage-course__list-item${isActive ? ' is-active' : ''}`}
                          onClick={() => selectChapter(id)}
                          tabIndex={0}
                          role="button"
                          aria-pressed={isActive}
                          onKeyDown={(event) => {
                            if (event.key === 'Enter' || event.key === ' ') {
                              event.preventDefault();
                              selectChapter(id);
                            }
                          }}
                        >
                          <div className="manage-course__list-info">
                            <span className="manage-course__list-title">{chapter.title || chapter.Title}</span>
                            {(chapter.summary || chapter.Summary) && (
                              <span className="manage-course__list-subtitle">{chapter.summary || chapter.Summary}</span>
                            )}
                          </div>
                          <div
                            className="manage-course__list-actions"
                            onClick={(event) => event.stopPropagation()}
                          >
                            <PrimaryButton
                              variant="outline"
                              size="sm"
                              className="manage-course__action-button"
                              onClick={() => editChapter(chapter)}
                            >
                              Edit
                            </PrimaryButton>
                            <PrimaryButton
                              variant="outline"
                              size="sm"
                              className="manage-course__action-button manage-course__action-button--danger"
                              onClick={() => deleteChapter(chapter)}
                            >
                              Delete
                            </PrimaryButton>
                          </div>
                        </li>
                      );
                    })}
                    {chapters.length === 0 && <li className="manage-course__empty">No chapters yet.</li>}
                  </ul>
                </section>

                <section className="manage-course__panel">
                  <div className="manage-course__panel-header">
                    <h2>Resources</h2>
                    <PrimaryButton
                      size="sm"
                      onClick={createResource}
                      disabled={!selectedChapterId}
                    >
                      Add Resource
                    </PrimaryButton>
                  </div>
                  {selectedChapter ? (
                    <div className="manage-course__resources">
                      <h3>{selectedChapter.title || selectedChapter.Title}</h3>
                      {resourcesLoading ? (
                        <div className="manage-course__state">Loading resources...</div>
                      ) : resources.length ? (
                        <ul className="manage-course__list">
                          {resources.map((resource) => (
                            <li key={resource.id || resource.Id} className="manage-course__list-item">
                              <div className="manage-course__list-info">
                                <span className="manage-course__list-title">{resource.type || resource.Type}</span>
                                {(resource.content || resource.Content) && (
                                  <span className="manage-course__list-subtitle manage-course__resource-snippet">
                                    {resource.content || resource.Content}
                                  </span>
                                )}
                              </div>
                              <div className="manage-course__list-actions">
                                <PrimaryButton
                                  variant="outline"
                                  size="sm"
                                  className="manage-course__action-button"
                                  onClick={() => editResource(resource)}
                                >
                                  Edit
                                </PrimaryButton>
                                <PrimaryButton
                                  variant="outline"
                                  size="sm"
                                  className="manage-course__action-button manage-course__action-button--danger"
                                  onClick={() => deleteResource(resource)}
                                >
                                  Delete
                                </PrimaryButton>
                              </div>
                            </li>
                          ))}
                        </ul>
                      ) : (
                        <div className="manage-course__empty">No resources for this chapter.</div>
                      )}
                    </div>
                  ) : (
                    <div className="manage-course__empty">Select a chapter to manage its resources.</div>
                  )}
                </section>
              </div>
            )}
          </div>
        </div>
      </main>
    </>
  );
};

export default ManageCourse;

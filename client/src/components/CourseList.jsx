import React, { useState, useEffect } from 'react';
import { quickApi } from '../services/apiService';
import { chapterDetails } from '../data/chapterDetails';
import '../styles/EditCoursePopup.css';

const normalizeCourse = (course) => ({
  id: course?.id || course?.Id || course?.courseId || course?.CourseId || '',
  title: course?.title || course?.Title || 'Untitled Course',
  description: course?.description || course?.Description || '',
  previewContent: course?.previewContent || course?.PreviewContent || '',
  published:
    typeof course?.published === 'boolean'
      ? course.published
      : typeof course?.Published === 'boolean'
        ? course.Published
        : true,
  chapterCount:
    course?.chapterCount ??
    course?.ChapterCount ??
    course?.totalChapters ??
    course?.TotalChapters ??
    (Array.isArray(course?.chapters) ? course.chapters.length : null) ??
    (Array.isArray(course?.Chapters) ? course.Chapters.length : null) ??
    0,
});

const CourseList = ({ userRole, onCourseSelect, onStartLearning, onEnrollNow }) => {
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [editingCourse, setEditingCourse] = useState(null);
  const [editForm, setEditForm] = useState({
    title: '',
    description: '',
    previewContent: '',
    chapterEdits: {} // Will store edits for each chapter
  });
  const [showChapterEdit, setShowChapterEdit] = useState(false);
  const [selectedChapter, setSelectedChapter] = useState(1);

  const chapters = [
    { id: 1, name: 'Chapter 1: Getting Started' },
    { id: 2, name: 'Chapter 2: Variables and Data Types' },
    { id: 3, name: 'Chapter 3: Collections' },
    { id: 4, name: 'Chapter 4: Conditionals' },
    { id: 5, name: 'Chapter 5: Loops' },
    { id: 6, name: 'Chapter 6: Functions' },
    { id: 7, name: 'Chapter 7: File I/O' },
    { id: 8, name: 'Chapter 8: Error Handling' },
    { id: 9, name: 'Chapter 9: Classes' },
    { id: 10, name: 'Chapter 10: Final Project' },
  ];

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      setLoading(true);
      const coursesData = await quickApi.getCourses();
      setCourses(coursesData);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch courses:', err);
      setError('Failed to load courses. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleEditClick = (course) => {
    setEditingCourse(course);
    
    // Load from localStorage if exists
    const storageKey = `course_edit_${course.id}`;
    const savedData = localStorage.getItem(storageKey);
    const parsedData = savedData ? JSON.parse(savedData) : null;
    
    setEditForm({
      title: parsedData?.title || course.title,
      description: parsedData?.description || course.description || '',
      previewContent: parsedData?.previewContent || course.previewContent || '',
      chapterEdits: parsedData?.chapterEdits || {}
    });
    setShowChapterEdit(false);
    setSelectedChapter(1);
  };

  const handleCloseEdit = () => {
    setEditingCourse(null);
    setEditForm({ title: '', description: '', previewContent: '', chapterEdits: {} });
    setShowChapterEdit(false);
    setSelectedChapter(1);
  };

  const handleFormChange = (field, value) => {
    setEditForm(prev => ({ ...prev, [field]: value }));
  };

  const handleChapterContentChange = (chapterId, value) => {
    setEditForm(prev => ({
      ...prev,
      chapterEdits: {
        ...prev.chapterEdits,
        [chapterId]: value
      }
    }));
  };

  const getCurrentChapterContent = () => {
    // Check if there's saved content in localStorage
    const savedContent = editForm.chapterEdits[selectedChapter];
    if (savedContent) {
      return savedContent;
    }
    
    // Otherwise, format the content from chapterDetails
    const chapter = chapterDetails[selectedChapter];
    if (!chapter) return '';
    
    let content = '';
    
    // Title
    content += `# ${chapters.find(c => c.id === selectedChapter)?.name}\n\n`;
    
    // Overview
    if (chapter.overview) {
      content += `## Overview\n${chapter.overview}\n\n`;
    }
    
    // Learning Objectives
    if (chapter.learningObjectives && chapter.learningObjectives.length > 0) {
      content += `## Learning Objectives\n`;
      chapter.learningObjectives.forEach(obj => {
        content += `- ${obj}\n`;
      });
      content += '\n';
    }
    
    // Sections
    if (chapter.sections && chapter.sections.length > 0) {
      chapter.sections.forEach(section => {
        content += `## ${section.heading}\n`;
        if (Array.isArray(section.body)) {
          section.body.forEach(paragraph => {
            content += `${paragraph}\n\n`;
          });
        }
      });
    }
    
    // Practice Lab
    if (chapter.practiceLab) {
      content += `## Practice Lab: ${chapter.practiceLab.title}\n\n`;
      if (chapter.practiceLab.instructions && chapter.practiceLab.instructions.length > 0) {
        content += `### Instructions\n`;
        chapter.practiceLab.instructions.forEach((instruction, idx) => {
          content += `${idx + 1}. ${instruction}\n`;
        });
        content += '\n';
      }
      if (chapter.practiceLab.starterCode) {
        content += `### Starter Code\n\`\`\`${chapter.practiceLab.language || 'python'}\n${chapter.practiceLab.starterCode}\n\`\`\`\n\n`;
      }
    }
    
    // Practice Exercises
    if (chapter.practice && chapter.practice.length > 0) {
      content += `## Practice Exercises\n`;
      chapter.practice.forEach((exercise, idx) => {
        content += `${idx + 1}. ${exercise}\n`;
      });
      content += '\n';
    }
    
    return content;
  };

  const handleSaveEdit = () => {
    // Update course in local state
    setCourses(prevCourses =>
      prevCourses.map(c => {
        const normalized = normalizeCourse(c);
        if (normalized.id === editingCourse.id) {
          return {
            ...c,
            title: editForm.title,
            description: editForm.description,
            previewContent: editForm.previewContent
          };
        }
        return c;
      })
    );
    
    // Store in localStorage for persistence (including chapter content)
    const storageKey = `course_edit_${editingCourse.id}`;
    localStorage.setItem(storageKey, JSON.stringify(editForm));
    
    handleCloseEdit();
  };

  const toggleChapterEdit = () => {
    setShowChapterEdit(!showChapterEdit);
  };

  if (loading) {
    return <div className="course-list-loading">Loading courses...</div>;
  }

  if (error) {
    return (
      <div className="course-list-error">
        <p>{error}</p>
        <button onClick={fetchCourses} className="retry-button">
          Try Again
        </button>
      </div>
    );
  }

  return (
    <>
      <div className="course-list-container">
        {courses.length === 0 ? (
        <div className="no-courses">
          <p>No courses available at the moment.</p>
        </div>
      ) : (
        <>
          {courses.map((rawCourse) => {
            const course = normalizeCourse(rawCourse);
            const courseId = course.id;
            return (
              <div key={courseId || course.title} className="course-card-large">
                <div className="course-card-header">
                  {course.published && (
                    <span className="course-badge">Published</span>
                  )}
                </div>

                <div className="course-card-body">
                  <h2>{course.title}</h2>
                  <p className="course-description">
                    {course.description || 'No description available'}
                  </p>

                  {course.previewContent && (
                    <div className="course-preview">
                      <h4>Preview:</h4>
                      <p>{course.previewContent}</p>
                    </div>
                  )}

                  <div className="course-meta-line">
                    <strong>Chapters:</strong> {course.chapterCount ?? 0}
                  </div>
                </div>

                <div className="course-card-actions">
                  <button
                    className="btn-primary"
                    onClick={() => onCourseSelect && onCourseSelect(courseId, course.title)}
                  >
                    View Details
                  </button>

                  {userRole === 'student' && course.published && (
                    <button
                      className="btn-secondary"
                      onClick={() => onEnrollNow && onEnrollNow(courseId, course.title)}
                    >
                      Enroll Now
                    </button>
                  )}

                  {(userRole === 'admin' || userRole === 'teacher') && (
                    <button
                      className="btn-edit"
                      onClick={() => handleEditClick(course)}
                    >
                      Edit Course
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </>
      )}
      </div>

      {editingCourse && (
        <div className="edit-course-overlay" onClick={handleCloseEdit}>
          <div className="edit-course-popup" onClick={(e) => e.stopPropagation()}>
            <div className="edit-course-header">
              <h2>🌱 Edit Course</h2>
              <button className="close-btn" onClick={handleCloseEdit}>✕</button>
            </div>

            <div className="edit-course-body">
              <div className="edit-tabs">
                <button 
                  className={`edit-tab ${!showChapterEdit ? 'active' : ''}`}
                  onClick={() => setShowChapterEdit(false)}
                >
                  📚 Course Info
                </button>
                <button 
                  className={`edit-tab ${showChapterEdit ? 'active' : ''}`}
                  onClick={toggleChapterEdit}
                >
                  📖 Chapter 1 Content
                </button>
              </div>

              {!showChapterEdit ? (
                <>
                  <div className="form-group">
                    <label htmlFor="course-title">Course Title</label>
                    <input
                      id="course-title"
                      type="text"
                      className="form-input"
                      value={editForm.title}
                      onChange={(e) => handleFormChange('title', e.target.value)}
                      placeholder="Enter course title..."
                    />
                  </div>

                  <div className="form-group">
                    <label htmlFor="course-description">Description</label>
                    <textarea
                      id="course-description"
                      className="form-textarea"
                      value={editForm.description}
                      onChange={(e) => handleFormChange('description', e.target.value)}
                      placeholder="Enter course description..."
                      rows={4}
                    />
                  </div>

                  <div className="form-group">
                    <label htmlFor="course-preview">Preview Content</label>
                    <textarea
                      id="course-preview"
                      className="form-textarea"
                      value={editForm.previewContent}
                      onChange={(e) => handleFormChange('previewContent', e.target.value)}
                      placeholder="Enter preview content..."
                      rows={3}
                    />
                  </div>
                </>
              ) : (
                <>
                  <div className="form-group">
                    <label htmlFor="chapter-select">Select Chapter</label>
                    <select
                      id="chapter-select"
                      className="form-select"
                      value={selectedChapter}
                      onChange={(e) => setSelectedChapter(Number(e.target.value))}
                    >
                      {chapters.map(chapter => (
                        <option key={chapter.id} value={chapter.id}>
                          {chapter.name}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="form-group">
                    <label htmlFor="chapter-content">
                      {chapters.find(c => c.id === selectedChapter)?.name} Content
                    </label>
                    <div className="chapter-hint">
                      <span className="hint-icon">💡</span>
                      <span>Edit the main content for this chapter. You can use markdown formatting!</span>
                    </div>
                    <textarea
                      id="chapter-content"
                      className="form-textarea chapter-textarea"
                      value={getCurrentChapterContent()}
                      onChange={(e) => handleChapterContentChange(selectedChapter, e.target.value)}
                      placeholder={`# ${chapters.find(c => c.id === selectedChapter)?.name}&#10;&#10;## Introduction&#10;Write your chapter content here...&#10;&#10;### Section 1&#10;Add sections, code examples, and explanations...`}
                      rows={12}
                    />
                  </div>
                </>
              )}

            </div>

            <div className="edit-course-footer">
              <button className="btn-cancel" onClick={handleCloseEdit}>
                Cancel
              </button>
              <button className="btn-save" onClick={handleSaveEdit}>
                Save Changes
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default CourseList;
import React, { useEffect, useMemo, useState } from 'react';
import { forumModerationService } from '../services/apiService';

const TeacherForumManager = ({ courses }) => {
  const [selectedCourseId, setSelectedCourseId] = useState('');
  const [forumPosts, setForumPosts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const courseOptions = useMemo(() => {
    if (!Array.isArray(courses)) return [];
    return courses
      .map((course) => ({
        id: course.id || course.Id,
        title: course.title || course.Title || 'Untitled Course',
      }))
      .filter((course) => !!course.id);
  }, [courses]);

  useEffect(() => {
    if (!selectedCourseId && courseOptions.length > 0) {
      setSelectedCourseId(courseOptions[0].id);
    }
  }, [courseOptions, selectedCourseId]);

  useEffect(() => {
    if (selectedCourseId) {
      loadForumPosts(selectedCourseId);
    }
  }, [selectedCourseId]);

  const loadForumPosts = async (courseId) => {
    setLoading(true);
    try {
      const posts = await forumModerationService.listForCourse(courseId);
      setForumPosts(Array.isArray(posts) ? posts : []);
      setError('');
    } catch (err) {
      console.error('Failed to load forum posts', err);
      setError(err.message || 'Failed to load forum posts');
      setForumPosts([]);
    } finally {
      setLoading(false);
    }
  };

  const handleDeletePost = async (postId) => {
    if (!postId) return;
    if (!window.confirm('Are you sure you want to delete this forum post? This action cannot be undone.')) {
      return;
    }

    try {
      await forumModerationService.deletePost(postId);
      setForumPosts((prev) =>
        prev.filter((post) => (post.forumId || post.ForumId || post.id || post.Id) !== postId)
      );
    } catch (err) {
      console.error('Failed to delete forum post', err);
      setError(err.message || 'Failed to delete forum post');
    }
  };

  if (!courseOptions.length) {
    return <div className="td-state">No courses available for moderation.</div>;
  }

  return (
    <div className="posts-tab">
      <div className="td-form" style={{ maxWidth: '320px' }}>
        <label>
          Select Course
          <select
            value={selectedCourseId}
            onChange={(event) => setSelectedCourseId(event.target.value)}
          >
            {courseOptions.map((course) => (
              <option key={course.id} value={course.id}>
                {course.title}
              </option>
            ))}
          </select>
        </label>
      </div>

      {error && (
        <div className="td-alert td-error">
          {error}
          <button type="button" onClick={() => setError('')}>
            ×
          </button>
        </div>
      )}

      {loading ? (
        <div className="td-state">Loading forum posts...</div>
      ) : forumPosts.length === 0 ? (
        <div className="td-state">No forum posts yet for this course.</div>
      ) : (
        <div className="posts-list">
          {forumPosts.map((post) => {
            const postId = post.forumId || post.ForumId || post.id || post.Id;
            const content = post.content || post.Content || '';
            const author =
              post.profile?.fullName ||
              post.Profile?.FullName ||
              post.profile?.full_name ||
              'Unknown student';
            const createdAt = post.createdAt || post.CreatedAt;
            const createdDate = createdAt ? new Date(createdAt).toLocaleString() : '';

            return (
              <div key={postId} className="post-item">
                <div className="post-header">
                  <h4>{author}</h4>
                  {createdDate && <span className="post-date">{createdDate}</span>}
                </div>
                <p className="post-content">{content}</p>
                <div className="post-actions">
                  <button
                    type="button"
                    onClick={() => handleDeletePost(postId)}
                    className="btn-danger btn-sm"
                  >
                    Delete Post
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default TeacherForumManager;

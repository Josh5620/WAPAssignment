import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';
import { quickApi } from '../services/apiService';

const StudentForum = ({ courseId }) => {
  const [posts, setPosts] = useState([]);
  const [newPostContent, setNewPostContent] = useState('');
  const [loading, setLoading] = useState(true);
  const [posting, setPosting] = useState(false);
  const [error, setError] = useState(null);
  const [showPostForm, setShowPostForm] = useState(false);

  useEffect(() => {
    if (courseId) {
      loadForumPosts();
    }
  }, [courseId]);

  const loadForumPosts = async () => {
    try {
      setLoading(true);
      const data = await api.students.getForumPosts(courseId);
      setPosts(data);
      setError(null);
    } catch (err) {
      console.error('Failed to load forum posts:', err);
      setError('Failed to load forum posts. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmitPost = async (e) => {
    e.preventDefault();
    
    if (!newPostContent.trim()) {
      alert('Please enter some content for your post.');
      return;
    }

    const userProfile = quickApi.getUserProfile();
    if (!userProfile || !userProfile.id) {
      alert('Please log in to post in the forum.');
      return;
    }

    try {
      setPosting(true);
      await api.students.createForumPost(userProfile.id, courseId, newPostContent);
      setNewPostContent('');
      setShowPostForm(false);
      await loadForumPosts();
    } catch (err) {
      console.error('Failed to create post:', err);
      alert('Failed to create post. Please try again.');
    } finally {
      setPosting(false);
    }
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  if (loading) {
    return <div className="forum-loading">Loading forum posts...</div>;
  }

  if (error && posts.length === 0) {
    return (
      <div className="forum-error">
        <p>{error}</p>
        <button onClick={loadForumPosts}>Retry</button>
      </div>
    );
  }

  return (
    <div className="student-forum">
      <div className="forum-header">
        <h3>Discussion Forum</h3>
        <button
          className="new-post-button"
          onClick={() => setShowPostForm(!showPostForm)}
        >
          {showPostForm ? 'Cancel' : '+ New Post'}
        </button>
      </div>

      {showPostForm && (
        <form className="forum-post-form" onSubmit={handleSubmitPost}>
          <textarea
            className="post-content-input"
            value={newPostContent}
            onChange={(e) => setNewPostContent(e.target.value)}
            placeholder="Share your thoughts, ask questions, or help others..."
            rows={5}
          />
          <div className="post-form-actions">
            <button
              type="submit"
              className="submit-post-button"
              disabled={posting || !newPostContent.trim()}
            >
              {posting ? 'Posting...' : 'Post'}
            </button>
            <button
              type="button"
              className="cancel-post-button"
              onClick={() => {
                setShowPostForm(false);
                setNewPostContent('');
              }}
            >
              Cancel
            </button>
          </div>
        </form>
      )}

      {error && posts.length > 0 && (
        <div className="forum-warning">
          <p>{error}</p>
          <button onClick={loadForumPosts}>Retry</button>
        </div>
      )}

      <div className="forum-posts">
        {posts.length === 0 ? (
          <div className="forum-empty">
            <p>No posts yet. Be the first to start a discussion!</p>
          </div>
        ) : (
          posts.map((post) => (
            <div key={post.forumId} className="forum-post">
              <div className="post-header">
                <div className="post-author">
                  <span className="author-name">{post.userName || 'Anonymous'}</span>
                  <span className="author-email">{post.userEmail}</span>
                </div>
                <span className="post-date">{formatDate(post.createdAt)}</span>
              </div>
              <div className="post-content">{post.content}</div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default StudentForum;


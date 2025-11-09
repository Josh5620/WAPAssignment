import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import { api } from '../services/apiService';
import { useAuth } from '../context/AuthContext';
import '../styles/ForumPage.css';
import useOnlineStatus from '../hooks/useOnlineStatus';

const ForumPage = () => {
  const navigate = useNavigate();
  const { user, role } = useAuth();
  const [posts, setPosts] = useState([]);
  const [newPostContent, setNewPostContent] = useState('');
  const [newPostTitle, setNewPostTitle] = useState('');
  const [loading, setLoading] = useState(true);
  const [posting, setPosting] = useState(false);
  const [error, setError] = useState(null);
  const [showPostForm, setShowPostForm] = useState(false);
  const [info, setInfo] = useState(null);
  const isOnline = useOnlineStatus();

  const COURSE_ID = 'code-garden-python';
  const storageKey = `forum_posts_${COURSE_ID}`;

  const samplePosts = useMemo(
    () => [
      {
        id: 'sample-1',
        userName: 'Luna',
        userRole: 'student',
        createdAt: new Date(Date.now() - 1000 * 60 * 60 * 8).toISOString(),
        content: 'What’s your favorite way to remember the difference between lists and tuples?',
      },
      {
        id: 'sample-2',
        userName: 'Theo',
        userRole: 'teacher',
        createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24).toISOString(),
        content:
          'Try grouping related flashcards into themes. Plant metaphors work great for remembering data structures!',
      },
    ],
    [],
  );

  const getLocalPosts = () => {
    try {
      const stored = localStorage.getItem(storageKey);
      return stored ? JSON.parse(stored) : [];
    } catch (storageError) {
      console.warn('Failed to read saved forum posts', storageError);
      return [];
    }
  };

  const saveLocalPosts = (items) => {
    try {
      localStorage.setItem(storageKey, JSON.stringify(items));
    } catch (storageError) {
      console.warn('Failed to persist forum posts locally', storageError);
    }
  };

  useEffect(() => {
    if (!user) {
      navigate('/login');
      return;
    }
    loadForumPosts();
  }, [user, navigate]);

  const loadForumPosts = async () => {
    try {
      setLoading(true);
      setInfo(null);
      const data = await api.students.getForumPosts(COURSE_ID);
      const normalized = Array.isArray(data) ? data : [];
      setPosts(normalized);
      saveLocalPosts(normalized);
      setError(null);
    } catch (err) {
      console.error('Failed to load forum posts:', err);
      const local = getLocalPosts();
      if (local.length) {
        setPosts(local);
        setInfo(
          isOnline
            ? 'The forum service is still growing. Showing saved discussions for now.'
            : 'You are offline. Showing saved discussions until you reconnect.',
        );
        setError(null);
      } else if (samplePosts.length) {
        setPosts(samplePosts);
        setInfo('Showing sample discussions until the community begins chatting.');
        setError(null);
      } else {
        setError('Failed to load forum posts. Please try again.');
        setPosts([]);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleSubmitPost = async (e) => {
    e.preventDefault();
    
    if (!newPostTitle.trim() || !newPostContent.trim()) {
      alert('Please enter both a title and content for your post.');
      return;
    }

    if (!user || !user.id) {
      alert('Please log in to post in the forum.');
      return;
    }

    try {
      setPosting(true);
      await api.students.createForumPost(
        user.id,
        COURSE_ID,
        `**${newPostTitle}**\n\n${newPostContent}`,
      );
      setNewPostTitle('');
      setNewPostContent('');
      setShowPostForm(false);
      await loadForumPosts();
    } catch (err) {
      console.error('Failed to create post:', err);
      const local = getLocalPosts();
      const localPost = {
        id: `local-${Date.now()}`,
        userName: user?.full_name || user?.email || 'You',
        userRole: role || 'student',
        createdAt: new Date().toISOString(),
        content: `**${newPostTitle}**\n\n${newPostContent}`,
        userEmail: user?.email || null,
      };
      const updated = [localPost, ...local];
      saveLocalPosts(updated);
      setPosts(updated);
      setInfo(
        isOnline
          ? 'The forum service is still growing. We saved your discussion locally and will publish it once it is ready.'
          : 'You appear to be offline. We saved your discussion locally and will send it once you reconnect.',
      );
      setShowPostForm(false);
      setNewPostTitle('');
      setNewPostContent('');
    } finally {
      setPosting(false);
    }
  };

  const handleDeletePost = async (postId) => {
    if (!window.confirm('Are you sure you want to delete this post?')) {
      return;
    }

    try {
      // Add delete API call here when available
      alert('Delete functionality coming soon!');
      // await api.forum.deletePost(postId);
      // await loadForumPosts();
    } catch (err) {
      console.error('Failed to delete post:', err);
      alert('Failed to delete post. Please try again.');
    }
  };

  const formatDate = (dateString) => {
    if (!dateString) return 'Just now';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getRoleBadge = (userRole) => {
    const normalizedRole = (userRole || '').toLowerCase();
    if (normalizedRole === 'teacher') return { label: 'Teacher', className: 'badge-teacher' };
    if (normalizedRole === 'admin') return { label: 'Admin', className: 'badge-admin' };
    return { label: 'Student', className: 'badge-student' };
  };

  const canModerate = () => {
    const normalizedRole = (role || '').toLowerCase();
    return normalizedRole === 'admin' || normalizedRole === 'teacher';
  };

  if (loading) {
    return (
      <>
        <Navbar />
        <div className="forum-page">
          <div className="forum-loading">
            <div className="loading-spinner">💬</div>
            <p>Loading community discussions...</p>
          </div>
        </div>
      </>
    );
  }

  return (
    <>
      <Navbar />
      <div className="forum-page">
        <div className="forum-container">
          <div className="forum-hero">
            <h1>🌱 Community Garden</h1>
            <p>Ask questions, share insights, and grow together with fellow Python learners</p>
          </div>

          <div className="forum-header">
            <div className="forum-stats">
              <span className="stat-item">
                <strong>{posts.length}</strong> Discussion{posts.length !== 1 ? 's' : ''}
              </span>
              {role && (
                <span className="role-badge">
                  {getRoleBadge(role).label}
                </span>
              )}
            </div>
            <button
              className="btn-new-post"
              onClick={() => setShowPostForm(!showPostForm)}
            >
              {showPostForm ? '✕ Cancel' : '+ New Discussion'}
            </button>
          </div>

          {showPostForm && (
            <form className="forum-post-form" onSubmit={handleSubmitPost}>
              <h3>Start a New Discussion</h3>
              <input
                type="text"
                className="post-title-input"
                value={newPostTitle}
                onChange={(e) => setNewPostTitle(e.target.value)}
                placeholder="Discussion title..."
                maxLength={150}
              />
              <textarea
                className="post-content-input"
                value={newPostContent}
                onChange={(e) => setNewPostContent(e.target.value)}
                placeholder="Share your thoughts, ask questions, or help others learn Python..."
                rows={6}
              />
              <div className="post-form-actions">
                <button
                  type="submit"
                  className="btn-submit-post"
                  disabled={posting || !newPostTitle.trim() || !newPostContent.trim()}
                >
                  {posting ? 'Posting...' : 'Post Discussion'}
                </button>
                <button
                  type="button"
                  className="btn-cancel-post"
                  onClick={() => {
                    setShowPostForm(false);
                    setNewPostTitle('');
                    setNewPostContent('');
                  }}
                >
                  Cancel
                </button>
              </div>
            </form>
          )}

          {error && posts.length === 0 && (
            <div className="forum-error">
              <p>{error}</p>
              <button onClick={loadForumPosts} className="btn-retry">
                Try Again
              </button>
            </div>
          )}

          {info && <div className="forum-info">{info}</div>}

          <div className="forum-posts">
            {posts.length === 0 ? (
              <div className="forum-empty">
                <div className="empty-icon">🌱</div>
                <h3>No discussions yet</h3>
                <p>Be the first to start a conversation and help our community grow!</p>
                <button
                  className="btn-first-post"
                  onClick={() => setShowPostForm(true)}
                >
                  Start First Discussion
                </button>
              </div>
            ) : (
              posts.map((post) => {
                const badge = getRoleBadge(post.userRole);
                return (
                  <article key={post.forumId || post.id} className="forum-post-card">
                    <div className="post-header">
                      <div className="post-author-info">
                        <div className="author-avatar">
                          {(post.userName || 'U').charAt(0).toUpperCase()}
                        </div>
                        <div className="author-details">
                          <div className="author-name-row">
                            <span className="author-name">{post.userName || 'Anonymous'}</span>
                            <span className={`role-badge ${badge.className}`}>
                              {badge.label}
                            </span>
                          </div>
                          <span className="post-date">{formatDate(post.createdAt)}</span>
                        </div>
                      </div>
                      {canModerate() && (
                        <button
                          className="btn-delete-post"
                          onClick={() => handleDeletePost(post.forumId || post.id)}
                          title="Delete post"
                        >
                          🗑️
                        </button>
                      )}
                    </div>
                    <div className="post-content">
                      {post.content}
                    </div>
                    {post.userEmail && canModerate() && (
                      <div className="post-meta">
                        <small>Contact: {post.userEmail}</small>
                      </div>
                    )}
                  </article>
                );
              })
            )}
          </div>
        </div>
      </div>
    </>
  );
};

export default ForumPage;

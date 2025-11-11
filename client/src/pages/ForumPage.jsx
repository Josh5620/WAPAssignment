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
  const [activeThreadKey, setActiveThreadKey] = useState(null);
  const [threadState, setThreadState] = useState({});
  const [replyDrafts, setReplyDrafts] = useState({});
  const [replyTargets, setReplyTargets] = useState({});
  const [resolvedCourseId, setResolvedCourseId] = useState(
    () => localStorage.getItem('forumCourseId') || null,
  );
  const isOnline = useOnlineStatus();

  const FALLBACK_COURSE_ID = 'code-garden-python';
  const storageKey = useMemo(
    () => `forum_posts_${resolvedCourseId || 'offline'}`,
    [resolvedCourseId],
  );

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

  const isGuid = (value) =>
    typeof value === 'string' &&
    /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$/.test(value);

  const normalizeForumPost = (post) => {
    if (!post) return null;
    const possibleForumIds = [
      post.forumId,
      post.forumID,
      post.ForumId,
      post.ForumID,
      post.id,
      post.Id,
    ].filter(Boolean);

    const resolvedForumId =
      possibleForumIds.find((candidate) => typeof candidate === 'string' && candidate) || null;
    const hasValidServerId = resolvedForumId ? isGuid(resolvedForumId) : false;

    const possibleCourseIds = [
      post.courseId,
      post.courseID,
      post.CourseId,
      post.CourseID,
      post.course_id,
    ].filter(Boolean);

    const courseIdCandidate =
      possibleCourseIds.find((candidate) => typeof candidate === 'string' && candidate) ||
      resolvedCourseId ||
      FALLBACK_COURSE_ID;

    const threadKey =
      (hasValidServerId ? resolvedForumId : null) ||
      post.id ||
      post.Id ||
      post.localKey ||
      post.content;

    return {
      forumId: hasValidServerId ? resolvedForumId : null,
      courseId: courseIdCandidate,
      hasServerId: hasValidServerId,
      threadKey,
      userId: post.userId || post.authorId || null,
      userName: post.userName || post.user?.name || post.author || 'Anonymous',
      userRole: post.userRole || post.user?.role || post.userRoleLabel || 'student',
      userEmail: post.userEmail || post.user?.email || post.email || null,
      content: post.content || post.body || '',
      createdAt: post.createdAt || post.date || new Date().toISOString(),
      commentCount:
        typeof post.commentCount === 'number'
          ? post.commentCount
          : Array.isArray(post.comments)
          ? post.comments.length
          : 0,
    };
  };

  const rememberCourseId = (courseId) => {
    if (!courseId) {
      localStorage.removeItem('forumCourseId');
      setResolvedCourseId(null);
      return;
    }
    if (resolvedCourseId !== courseId) {
      localStorage.setItem('forumCourseId', courseId);
      setResolvedCourseId(courseId);
    }
  };

  useEffect(() => {
    if (!user) {
      navigate('/login');
      return;
    }

    const resolveCourseId = async () => {
      try {
        const courses = await api.courses.getAll();

        if (Array.isArray(courses)) {
          const firstGuid = courses
            .map((course) => {
              const ids = [course.courseId, course.courseID, course.id, course.Id].filter(Boolean);
              return ids.find((candidate) => typeof candidate === 'string' && isGuid(candidate));
            })
            .find(Boolean);

          if (firstGuid) {
            rememberCourseId(firstGuid);
            return;
          }
        }
      } catch (err) {
        console.warn('Unable to resolve course id from API, falling back to offline mode.', err);
      }
      if (!resolvedCourseId) {
        rememberCourseId(FALLBACK_COURSE_ID);
      }
    };

    resolveCourseId();
  }, [user, navigate]);

  useEffect(() => {
    if (!user || !resolvedCourseId) {
      return;
    }
    loadForumPosts(resolvedCourseId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user, resolvedCourseId]);

  const loadForumPosts = async (courseId) => {
    try {
      setLoading(true);
      setInfo(null);
      const data = await api.students.getForumPosts(courseId);
      const normalized = Array.isArray(data) ? data.map((item) => normalizeForumPost(item)).filter(Boolean) : [];
      if (!resolvedCourseId || resolvedCourseId === FALLBACK_COURSE_ID) {
        const firstServerBackedPost = normalized.find((post) => post.hasServerId);
        if (firstServerBackedPost && firstServerBackedPost.courseId && firstServerBackedPost.courseId !== resolvedCourseId) {
          rememberCourseId(firstServerBackedPost.courseId);
        }
      }
      setPosts(normalized);
      saveLocalPosts(normalized);
      setError(null);
      setThreadState({});
      setActivePostId(null);
    } catch (err) {
      console.error('Failed to load forum posts:', err);
      const local = getLocalPosts();
      if (local.length) {
        setPosts(local.map((item) => normalizeForumPost(item)).filter(Boolean));
        setInfo(
          isOnline
            ? 'The forum service is still growing. Showing saved discussions for now.'
            : 'You are offline. Showing saved discussions until you reconnect.',
        );
        setError(null);
      } else if (samplePosts.length) {
        setPosts(samplePosts.map((item) => normalizeForumPost(item)).filter(Boolean));
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

    if (!resolvedCourseId || !isGuid(resolvedCourseId)) {
      setInfo(
        'We saved your discussion locally and will post it to the community garden once the course syncs.',
      );
    }

    try {
      setPosting(true);
      if (resolvedCourseId && isGuid(resolvedCourseId)) {
        await api.students.createForumPost(
          user.id,
          resolvedCourseId,
          `**${newPostTitle}**\n\n${newPostContent}`,
        );
        setNewPostTitle('');
        setNewPostContent('');
        setShowPostForm(false);
        await loadForumPosts(resolvedCourseId);
        return;
      }
      throw new Error('OfflineMode');
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
        courseId: resolvedCourseId || FALLBACK_COURSE_ID,
      };
      const updated = [localPost, ...local];
      saveLocalPosts(updated);
      setPosts(updated.map((item) => normalizeForumPost(item)).filter(Boolean));
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

  const handleReplyDraftChange = (threadKey, value) => {
    setReplyDrafts((prev) => ({
      ...prev,
      [threadKey]: value,
    }));
  };

  const handleSetReplyTarget = (threadKey, commentId = null, userName = '') => {
    setReplyTargets((prev) => ({
      ...prev,
      [threadKey]: commentId ? { commentId, name: userName } : null,
    }));
  };

  const handleSubmitComment = async (event, forumId, threadKey) => {
    event.preventDefault();
    const key = threadKey || forumId;
    if (!key || !forumId) return;
    const draft = (replyDrafts[key] || '').trim();
    if (!draft) return;

    const parentCommentId = replyTargets[key]?.commentId ?? null;

    try {
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          ...(prev[key] || {}),
          submitting: true,
          error: null,
        },
      }));

      await api.students.createForumComment(forumId, draft, parentCommentId);
      handleReplyDraftChange(key, '');
      handleSetReplyTarget(key, null, '');
      await fetchComments(forumId, key);
    } catch (err) {
      console.error('Failed to submit comment:', err);
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          ...(prev[key] || {}),
          submitting: false,
          error: err.message || 'Failed to post your reply. Please try again.',
        },
      }));
    } finally {
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          ...(prev[key] || {}),
          submitting: false,
        },
      }));
    }
  };

  const renderCommentTree = (items, threadKey, depth = 0) => {
    if (!items || !items.length) {
      return null;
    }

    return (
      <div className="comment-thread">
        {items.map((comment) => {
          const authorName = comment.user?.fullName || comment.user?.email || 'Community Member';
          return (
            <div
              key={comment.commentId || comment.id}
              className="comment-node"
              style={{ marginLeft: depth * 20 }}
            >
              <div className="comment-header">
                <div className="comment-avatar">
                  {authorName.charAt(0).toUpperCase()}
                </div>
                <div className="comment-meta">
                  <span className="comment-author">{authorName}</span>
                  <span className="comment-date">{formatDate(comment.createdAt)}</span>
                </div>
              </div>
              <div className="comment-body">
                {comment.content}
              </div>
              <div className="comment-actions">
                <button
                  type="button"
                  className="btn-reply"
                  onClick={() => handleSetReplyTarget(threadKey, comment.commentId, authorName)}
                >
                  Reply
                </button>
              </div>
              {comment.replies && comment.replies.length > 0 && renderCommentTree(comment.replies, threadKey, depth + 1)}
            </div>
          );
        })}
      </div>
    );
  };

  const fetchComments = async (forumId, stateKey) => {
    if (!forumId) return;
    const key = stateKey || forumId;
    setThreadState((prev) => ({
      ...prev,
      [key]: {
        ...(prev[key] || {}),
        loading: true,
        error: null,
      },
    }));
    try {
      const response = await api.students.getForumComments(forumId);
      const comments = Array.isArray(response?.comments) ? response.comments : [];
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          comments,
          loading: false,
          error: null,
        },
      }));
    } catch (err) {
      console.error('Failed to load comments:', err);
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          comments: prev[key]?.comments || [],
          loading: false,
          error: err.message || 'Failed to load replies.',
        },
      }));
    }
  };

  const toggleThread = async (threadKey, forumId) => {
    if (activeThreadKey === threadKey) {
      setActiveThreadKey(null);
      return;
    }
    setActiveThreadKey(threadKey);
    if (!threadState[threadKey] && forumId) {
      await fetchComments(forumId, threadKey);
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
                const threadKey = post.threadKey;
                const badge = getRoleBadge(post.userRole);
                return (
                  <article key={threadKey} className="forum-post-card">
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
                          onClick={() => handleDeletePost(threadKey)}
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
                    <div className="post-footer">
                      <button
                        type="button"
                        className="btn-view-comments"
                        onClick={() => toggleThread(threadKey, post.hasServerId ? post.forumId : null)}
                        disabled={!post.hasServerId}
                        title={
                          !post.hasServerId
                            ? 'Replies will pop up once this discussion syncs with the live community.'
                            : undefined
                        }
                      >
                        {post.hasServerId
                          ? activeThreadKey === threadKey
                            ? 'Hide Replies'
                            : `View Replies (${post.commentCount || 0})`
                          : 'Replies unavailable offline'}
                      </button>
                    </div>
                    {activeThreadKey === threadKey && (
                      <div className="thread-panel">
                        {threadState[threadKey]?.loading && (
                          <div className="thread-loading">Sprouting replies…</div>
                        )}
                        {threadState[threadKey]?.error && (
                          <div className="thread-error">
                            {threadState[threadKey]?.error}
                            <button
                              type="button"
                              onClick={() => fetchComments(post.forumId, threadKey)}
                              className="btn-retry-comments"
                            >
                              Try again
                            </button>
                          </div>
                        )}
                        {post.hasServerId ? (
                          renderCommentTree(threadState[threadKey]?.comments, threadKey)
                        ) : (
                          <div className="thread-placeholder">
                            Replies are available once this discussion sprouts in the live forum.
                          </div>
                        )}
                        <form
                          className="comment-form"
                          onSubmit={(event) => handleSubmitComment(event, post.forumId, threadKey)}
                        >
                          {replyTargets[threadKey] && (
                            <div className="reply-target">
                              Replying to {replyTargets[threadKey]?.name}
                              <button
                                type="button"
                                className="btn-clear-reply"
                                onClick={() => handleSetReplyTarget(threadKey)}
                              >
                                Cancel
                              </button>
                            </div>
                          )}
                          <textarea
                            className="comment-input"
                            rows={3}
                            placeholder="Share a tip, ask a follow-up question, or cheer them on…"
                            value={replyDrafts[threadKey] || ''}
                            onChange={(event) =>
                              handleReplyDraftChange(threadKey, event.target.value)
                            }
                            disabled={!post.hasServerId}
                          />
                          <button
                            type="submit"
                            className="btn-submit-comment"
                            disabled={
                              !post.hasServerId ||
                              threadState[threadKey]?.submitting ||
                              !(replyDrafts[threadKey] || '').trim()
                            }
                          >
                            {threadState[threadKey]?.submitting ? 'Posting…' : 'Post Reply'}
                          </button>
                        </form>
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

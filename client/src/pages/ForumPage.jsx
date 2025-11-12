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

        if (Array.isArray(courses) && courses.length > 0) {
          const firstGuid = courses
            .map((course) => {
              const ids = [course.courseId, course.courseID, course.id, course.Id, course.CourseId].filter(Boolean);
              return ids.find((candidate) => typeof candidate === 'string' && isGuid(candidate));
            })
            .find(Boolean);

          if (firstGuid) {
            rememberCourseId(firstGuid);
            return;
          }
        }
        // If no valid course found, don't set fallback - let loadForumPosts handle it
        console.warn('No valid course ID found in courses list');
      } catch (err) {
        console.warn('Unable to resolve course id from API:', err);
        // Don't set fallback on error - let the error be handled in loadForumPosts
      }
    };

    resolveCourseId();
  }, [user, navigate]);

  useEffect(() => {
    if (!user) {
      return;
    }
    // Load posts if we have a valid courseId, otherwise loadForumPosts will try to resolve it
    if (resolvedCourseId && isGuid(resolvedCourseId)) {
      loadForumPosts(resolvedCourseId);
    } else if (resolvedCourseId === null) {
      // Only try to load if courseId is explicitly null (not the fallback string)
      // This will trigger the courseId resolution in loadForumPosts
      loadForumPosts(null);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user, resolvedCourseId]);

  const loadForumPosts = async (courseId) => {
    try {
      setLoading(true);
      setInfo(null); // Clear any info messages
      setError(null); // Clear any errors
      
      // Validate courseId before making the request
      if (!courseId || !isGuid(courseId)) {
        console.warn('Invalid courseId, attempting to resolve...', courseId);
        // Try to resolve courseId again
        const courses = await api.courses.getAll();
        if (Array.isArray(courses) && courses.length > 0) {
          const firstGuid = courses
            .map((course) => {
              const ids = [course.courseId, course.courseID, course.id, course.Id, course.CourseId].filter(Boolean);
              return ids.find((candidate) => typeof candidate === 'string' && isGuid(candidate));
            })
            .find(Boolean);
          
          if (firstGuid) {
            rememberCourseId(firstGuid);
            courseId = firstGuid;
          } else {
            throw new Error('No valid course ID found. Please ensure you have at least one course.');
          }
        } else {
          throw new Error('No courses available. Please create a course first.');
        }
      }
      
      console.log('Loading forum posts for courseId:', courseId);
      const data = await api.students.getForumPosts(courseId);
      console.log('Received forum posts data:', data);
      
      const normalized = Array.isArray(data) ? data.map((item) => normalizeForumPost(item)).filter(Boolean) : [];
      
      // Update courseId if we found a valid one from server posts
      if (!resolvedCourseId || resolvedCourseId === FALLBACK_COURSE_ID) {
        const firstServerBackedPost = normalized.find((post) => post.hasServerId);
        if (firstServerBackedPost && firstServerBackedPost.courseId && isGuid(firstServerBackedPost.courseId)) {
          rememberCourseId(firstServerBackedPost.courseId);
        }
      }
      
      setPosts(normalized);
      saveLocalPosts(normalized);
      setError(null);
      setInfo(null); // Clear info on successful load
      // Don't clear threadState here - preserve open threads and their comments
    } catch (err) {
      console.error('Failed to load forum posts:', err);
      
      // Only show offline message if we're actually offline
      if (!isOnline) {
        const local = getLocalPosts();
        if (local.length) {
          setPosts(local.map((item) => normalizeForumPost(item)).filter(Boolean));
          setInfo('You are offline. Showing saved discussions until you reconnect.');
          setError(null);
        } else {
          setError('You are offline and no saved discussions found.');
          setPosts([]);
        }
      } else {
        // Online but API failed - show detailed error
        const errorMessage = err.message || err.data?.error || 'Failed to load forum posts';
        setError(`${errorMessage}. Please try again.`);
        setPosts([]);
        setInfo(null);
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

    // Check if we have a valid course ID
    if (!resolvedCourseId || !isGuid(resolvedCourseId)) {
      alert('Unable to determine course. Please refresh the page and try again.');
      return;
    }

    try {
      setPosting(true);
      setInfo(null); // Clear any previous messages
      
      // Create the post on the server
      const result = await api.students.createForumPost(
        user.id,
        resolvedCourseId,
        `**${newPostTitle}**\n\n${newPostContent}`,
      );
      
      console.log('Post created successfully:', result);
      
      // Clear form
      setNewPostTitle('');
      setNewPostContent('');
      setShowPostForm(false);
      setInfo(null); // Clear info message on success
      
      // Reload posts to show the new one
      await loadForumPosts(resolvedCourseId);
    } catch (err) {
      console.error('Failed to create post:', err);
      
      // Extract error message from response
      let errorMessage = 'Failed to create post';
      
      if (err.data?.error) {
        errorMessage = err.data.error;
      } else if (err.message) {
        errorMessage = err.message;
      }
      
      // Check if it's a network error
      if (errorMessage.includes('Failed to fetch') || errorMessage.includes('Network')) {
        setInfo('Network error. Please check your connection and try again.');
      } else if (errorMessage.includes('500') || errorMessage.includes('Internal Server Error')) {
        // Server error - show more helpful message
        alert(`Server error: ${errorMessage}\n\nPlease check:\n1. You are logged in\n2. The course exists\n3. Try refreshing the page`);
      } else {
        alert(`Failed to create post: ${errorMessage}`);
      }
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
    event.stopPropagation(); // Prevent any event bubbling that might cause reload
    
    const key = threadKey || forumId;
    if (!key || !forumId) {
      console.warn('Missing key or forumId:', { key, forumId });
      return;
    }
    
    const draft = (replyDrafts[key] || '').trim();
    if (!draft) {
      console.warn('Empty draft, not submitting');
      return;
    }

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

      console.log('Submitting comment:', { forumId, key, draft, parentCommentId });
      
      // Create the comment
      const result = await api.students.createForumComment(forumId, draft, parentCommentId);
      console.log('Comment created successfully:', result);
      
      // Clear the draft and reply target
      handleReplyDraftChange(key, '');
      handleSetReplyTarget(key, null, '');
      
      // Ensure thread stays open
      if (activeThreadKey !== key) {
        setActiveThreadKey(key);
      }
      
      // Small delay to ensure backend has saved the comment
      await new Promise(resolve => setTimeout(resolve, 300));
      
      // Refresh comments immediately to show the new comment
      await fetchComments(forumId, key);
      
      // Update the post's comment count without reloading all posts (which would clear thread state)
      // Just update the specific post in the posts array
      setPosts((prevPosts) => 
        prevPosts.map((post) => {
          if (post.forumId === forumId || post.threadKey === threadKey) {
            return {
              ...post,
              commentCount: (post.commentCount || 0) + 1
            };
          }
          return post;
        })
      );
      
      console.log('Comment submitted and refreshed successfully');
    } catch (err) {
      console.error('Failed to submit comment:', err);
      setThreadState((prev) => ({
        ...prev,
        [key]: {
          ...(prev[key] || {}),
          submitting: false,
          error: err.message || err.data?.error || 'Failed to post your reply. Please try again.',
        },
      }));
    } finally {
      // Ensure submitting state is cleared
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
      return (
        <div className="comment-thread-empty">
          <p>No replies yet. Be the first to respond!</p>
        </div>
      );
    }

    return (
      <div className="comment-thread">
        {items.map((comment) => {
          // Handle different response formats from backend
          const authorName = comment.user?.fullName || 
                           comment.user?.name || 
                           comment.userName || 
                           'Community Member';
          const commentId = comment.commentId || comment.id;
          const commentContent = comment.content || comment.text || '';
          const createdAt = comment.createdAt || comment.date;
          
          return (
            <div
              key={commentId}
              className="comment-node"
              style={{ marginLeft: depth * 20 }}
            >
              <div className="comment-header">
                <div className="comment-avatar">
                  {authorName.charAt(0).toUpperCase()}
                </div>
                <div className="comment-meta">
                  <span className="comment-author">{authorName}</span>
                  <span className="comment-date">{formatDate(createdAt)}</span>
                </div>
              </div>
              <div className="comment-body">
                {commentContent}
              </div>
              <div className="comment-actions">
                <button
                  type="button"
                  className="btn-reply"
                  onClick={() => handleSetReplyTarget(threadKey, commentId, authorName)}
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
      console.log('Fetched comments response:', response);
      const comments = Array.isArray(response?.comments) ? response.comments : [];
      console.log('Parsed comments:', comments);
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
          error: err.message || err.data?.error || 'Failed to load replies.',
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
                        {threadState[threadKey]?.error && !threadState[threadKey]?.loading && (
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
                        {!threadState[threadKey]?.loading && !threadState[threadKey]?.error && post.hasServerId && (
                          renderCommentTree(threadState[threadKey]?.comments, threadKey)
                        )}
                        {!post.hasServerId && (
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

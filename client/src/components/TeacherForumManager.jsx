import React, { useEffect, useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { adminService, api } from '../services/apiService';
import '../styles/TeacherForumManager.css';

const TeacherForumManager = () => {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [activeThreadKey, setActiveThreadKey] = useState(null);
  const [threadState, setThreadState] = useState({});
  const [replyDrafts, setReplyDrafts] = useState({});
  const [replyTargets, setReplyTargets] = useState({});

  const normalizeForumPost = (post) => {
    // Normalize the post data to ensure consistent property names
    const forumId = post.forumId || post.id || post.ForumId;
    const userId = post.userId || post.UserId;
    const userName = post.authorName || post.user?.fullName || post.user?.name || 'Student';
    const content = post.content || post.Content || '';
    const createdAt = post.createdAt || post.CreatedAt;
    const commentCount = typeof post.commentCount === 'number' ? post.commentCount : 0;
    
    return {
      forumId,
      userId,
      userName,
      content,
      createdAt,
      commentCount,
      user: post.user || { fullName: userName }
    };
  };

  const fetchPosts = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await adminService.getAllForumPosts();
      if (response?.success === false) {
        throw new Error(response?.message || 'Unable to load forum posts.');
      }
      const data = Array.isArray(response?.data) ? response.data : [];
      // Normalize all posts to ensure consistent property names
      const normalizedPosts = data.map(normalizeForumPost);
      setPosts(normalizedPosts);
    } catch (err) {
      console.error('Failed to load forum posts', err);
      setError(err.message || 'Unable to load forum posts.');
      setPosts([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  const handleDeletePost = async (postId) => {
    const confirmed = window.confirm('Are you sure you want to delete this post?');
    if (!confirmed) {
      return;
    }

    try {
      const response = await adminService.deleteForumPost(postId);
      if (response?.success === false) {
        throw new Error(response?.message || 'Unable to delete forum post.');
      }
      setPosts((prev) => prev.filter((post) => post.forumId !== postId));
    } catch (err) {
      console.error('Failed to delete forum post', err);
      alert(err.message || 'Unable to delete the post. Please try again.');
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
    event.stopPropagation();
    
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
      
      const result = await api.students.createForumComment(forumId, draft, parentCommentId);
      console.log('Comment created successfully:', result);
      
      handleReplyDraftChange(key, '');
      handleSetReplyTarget(key, null, '');
      
      if (activeThreadKey !== key) {
        setActiveThreadKey(key);
      }
      
      await new Promise(resolve => setTimeout(resolve, 300));
      
      await fetchComments(forumId, key);
      
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

  return (
    <div className="forum-manager">
      <header className="forum-header">
        <h2>Community Forum Moderation</h2>
        <p>Monitor and moderate live community posts from your students. You can reply to discussions and delete inappropriate posts.</p>
      </header>

      {loading ? (
        <div className="forum-list" role="status">
          <div className="forum-empty">Loading forum posts...</div>
        </div>
      ) : error ? (
        <div className="forum-list" role="alert">
          <div className="forum-empty">{error}</div>
        </div>
      ) : (
        <div className="forum-list" role="list">
          {posts.length === 0 ? (
            <div className="forum-empty" role="listitem">
              No forum posts to review right now.
            </div>
          ) : (
            posts.map((post) => {
              const threadKey = post.forumId || post.threadKey;
              const commentCount = post.commentCount || 0;
              
              // Safety check for forumId
              if (!post.forumId) {
                console.warn('Post missing forumId:', post);
                return null;
              }
              
              return (
                <article key={post.forumId} className="forum-post" role="listitem">
                  <header className="forum-post__header">
                    <div>
                      <h3>{post?.userName || post?.user?.fullName || 'Student'}</h3>
                      <p className="forum-post__timestamp">
                        Posted: {formatDate(post?.createdAt)}
                      </p>
                    </div>
                  </header>
                  <p className="forum-post__question">{post?.content}</p>
                  
                  <div className="forum-post__actions">
                    <PrimaryButton 
                      size="sm" 
                      onClick={() => toggleThread(threadKey, post.forumId)}
                    >
                      {activeThreadKey === threadKey ? 'Hide Replies' : `View Replies (${commentCount})`}
                    </PrimaryButton>
                    <PrimaryButton 
                      size="sm" 
                      onClick={() => handleDeletePost(post.forumId)}
                      variant="danger"
                    >
                      Delete Post
                    </PrimaryButton>
                  </div>

                  {activeThreadKey === threadKey && (
                    <div className="thread-panel">
                      {threadState[threadKey]?.loading && (
                        <div className="thread-loading">Loading replies…</div>
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
                      {!threadState[threadKey]?.loading && !threadState[threadKey]?.error && (
                        renderCommentTree(threadState[threadKey]?.comments, threadKey)
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
                          placeholder="Provide guidance, answer questions, or encourage your students…"
                          value={replyDrafts[threadKey] || ''}
                          onChange={(event) =>
                            handleReplyDraftChange(threadKey, event.target.value)
                          }
                        />
                        <button
                          type="submit"
                          className="btn-submit-comment"
                          disabled={
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
            }).filter(Boolean)
          )}
        </div>
      )}
    </div>
  );
};

export default TeacherForumManager;

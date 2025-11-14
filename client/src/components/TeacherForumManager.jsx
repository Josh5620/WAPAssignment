import React, { useEffect, useState } from 'react';
import PrimaryButton from './PrimaryButton';
import { adminService } from '../services/apiService';
import '../styles/TeacherForumManager.css';

const TeacherForumManager = () => {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchPosts = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await adminService.getAllForumPosts();
      if (response?.success === false) {
        throw new Error(response?.message || 'Unable to load forum posts.');
      }
      const data = Array.isArray(response?.data) ? response.data : [];
      setPosts(data);
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

  return (
    <div className="forum-manager">
      <header className="forum-header">
        <h2>Community Forum Moderation</h2>
        <p>Monitor and moderate live community posts from your students.</p>
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
            posts.map((post) => (
              <article key={post.forumId} className="forum-post" role="listitem">
                <header className="forum-post__header">
                  <div>
                    <h3>{post?.user?.fullName || 'Student'}</h3>
                    <p className="forum-post__timestamp">
                      Posted: {post?.createdAt ? new Date(post.createdAt).toLocaleString() : 'Unknown'}
                    </p>
                  </div>
                </header>
                <p className="forum-post__question">{post?.content}</p>
                <PrimaryButton size="sm" onClick={() => handleDeletePost(post.forumId)}>
                  Delete Post
                </PrimaryButton>
              </article>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default TeacherForumManager;

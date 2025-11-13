import React, { useState } from 'react';
import PrimaryButton from './PrimaryButton';
import '../styles/TeacherForumManager.css';

const initialPosts = [
  {
    id: 'post-1',
    studentName: 'Lena Park',
    chapter: 'Loops in the Garden',
    question:
      'I keep watering the same flower twice in my loop. How can I track which plants have already been watered?',
    replies: [
      {
        id: 'reply-1',
        author: 'You',
        message:
          'Try using an array to remember each plot you have watered. You can check before watering again.',
        timestamp: '2 hours ago',
      },
    ],
  },
  {
    id: 'post-2',
    studentName: 'Mateo Alvarez',
    chapter: 'Functions & Pollinators',
    question:
      'My helper function works, but the flowers still wilt after the main function runs. What should I inspect?',
    replies: [],
  },
  {
    id: 'post-3',
    studentName: 'Amina Bashir',
    chapter: 'Debugging Garden Pests',
    question:
      "The console keeps warning about an undefined 'gardenPlan'. How do I trace where it disappears?",
    replies: [],
  },
];

const TeacherForumManager = () => {
  const [posts, setPosts] = useState(initialPosts);
  const [replyDrafts, setReplyDrafts] = useState(() => {
    const drafts = {};
    initialPosts.forEach((post) => {
      drafts[post.id] = '';
    });
    return drafts;
  });

  const handleDraftChange = (postId, value) => {
    setReplyDrafts((prev) => ({ ...prev, [postId]: value }));
  };

  const handlePostReply = (postId) => {
    setPosts((prevPosts) => {
      const draft = replyDrafts[postId]?.trim();
      if (!draft) {
        return prevPosts;
      }

      return prevPosts.map((post) => {
        if (post.id !== postId) return post;

        const newReply = {
          id: `${postId}-reply-${post.replies.length + 1}`,
          author: 'You',
          message: draft,
          timestamp: 'just now',
        };

        return {
          ...post,
          replies: [...post.replies, newReply],
        };
      });
    });

    setReplyDrafts((prev) => ({ ...prev, [postId]: '' }));
  };

  return (
    <div className="forum-manager">
      <header className="forum-header">
        <h2>Student Forum</h2>
        <p>
          These threads are simulated to demonstrate how you can coach discussions while the student app is
          still wired to static content.
        </p>
      </header>

      <div className="forum-list" role="list">
        {posts.map((post) => (
          <article key={post.id} className="forum-post" role="listitem">
            <header className="forum-post__header">
              <div>
                <h3>{post.studentName}</h3>
                <p className="forum-post__chapter">Chapter: {post.chapter}</p>
              </div>
            </header>
            <p className="forum-post__question">{post.question}</p>

            <section className="forum-replies" aria-label={`Replies to ${post.studentName}'s question`}>
              {post.replies.length === 0 ? (
                <p className="forum-replies__empty">No replies yet. Be the first to help this student bloom!</p>
              ) : (
                post.replies.map((reply) => (
                  <div key={reply.id} className="forum-reply">
                    <span className="forum-reply__meta">{reply.author}</span>
                    <p>{reply.message}</p>
                    <span className="forum-reply__timestamp">{reply.timestamp}</span>
                  </div>
                ))
              )}
            </section>

            <div className="forum-reply-form">
              <label htmlFor={`${post.id}-reply`} className="sr-only">
                Add a reply to {post.studentName}'s post
              </label>
              <textarea
                id={`${post.id}-reply`}
                rows="3"
                placeholder="Type your coaching note here..."
                value={replyDrafts[post.id] ?? ''}
                onChange={(event) => handleDraftChange(post.id, event.target.value)}
              />
              <PrimaryButton size="sm" onClick={() => handlePostReply(post.id)}>
                Post Reply
              </PrimaryButton>
            </div>
          </article>
        ))}
      </div>
    </div>
  );
};

export default TeacherForumManager;

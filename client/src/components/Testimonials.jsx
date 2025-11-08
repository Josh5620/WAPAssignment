import React, { useCallback, useEffect, useState } from 'react';
import { api } from '../services/apiService';
import { getUser } from '../utils/auth';
import '../styles/Testimonials.css';  

const Testimonials = ({ courseId, limit }) => {
  const user = getUser();
  const isLoggedIn = user !== null;
  const [testimonials, setTestimonials] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showAddForm, setShowAddForm] = useState(false);
  const [newTestimonial, setNewTestimonial] = useState({
    content: '',
    rating: 5,
  });
  const [submitting, setSubmitting] = useState(false);

  const loadTestimonials = useCallback(async () => {
    try {
      setLoading(true);
      const data = await api.guests.getTestimonials({ courseId, limit });
      setTestimonials(data.testimonials || []);
      setError(null);
    } catch (err) {
      console.error('Failed to load testimonials:', err);
      setError('Failed to load testimonials. Please try again.');
    } finally {
      setLoading(false);
    }
  }, [courseId, limit]);

  useEffect(() => {
    loadTestimonials();
  }, [loadTestimonials]);

  const renderStars = (rating) => {
    return '⭐'.repeat(rating);
  };

  if (loading) {
    return <div className="testimonials-loading">Loading testimonials...</div>;
  }

  if (error) {
    return (
      <div className="testimonials-error">
        <p>{error}</p>
        <button onClick={loadTestimonials}>Retry</button>
      </div>
    );
  }

  if (testimonials.length === 0) {
    return (
      <div className="testimonials-empty">
        <p>No testimonials available at the moment.</p>
      </div>
    );
  }

  const handleAddTestimonial = async (e) => {
    e.preventDefault();
    if (!isLoggedIn) {
      alert('Please log in to add a testimonial');
      return;
    }

    if (!newTestimonial.content.trim()) {
      alert('Please enter your testimonial');
      return;
    }

    setSubmitting(true);
    try {
      // TODO: Add API endpoint for students to submit testimonials
      // For now, just show a message
      alert('Thank you for your testimonial! (Note: Backend endpoint to be implemented)');
      setNewTestimonial({ content: '', rating: 5 });
      setShowAddForm(false);
      // Reload testimonials after adding
      loadTestimonials();
    } catch (err) {
      console.error('Failed to submit testimonial:', err);
      alert('Failed to submit testimonial. Please try again.');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="testimonials">
      <div className="testimonials-header">
        {isLoggedIn && (
          <button
            className="add-testimonial-btn"
            onClick={() => setShowAddForm(!showAddForm)}
          >
            {showAddForm ? 'Cancel' : '+ Add Testimonial'}
          </button>
        )}
      </div>

      {isLoggedIn && showAddForm && (
        <div className="add-testimonial-form">
          <form onSubmit={handleAddTestimonial}>
            <div className="form-group">
              <label>Your Testimonial</label>
              <textarea
                value={newTestimonial.content}
                onChange={(e) => setNewTestimonial({ ...newTestimonial, content: e.target.value })}
                placeholder="Share your experience with CodeSage..."
                rows="4"
                required
              />
            </div>
            <div className="form-group">
              <label>Rating</label>
              <select
                value={newTestimonial.rating}
                onChange={(e) => setNewTestimonial({ ...newTestimonial, rating: parseInt(e.target.value) })}
              >
                <option value={5}>5 ⭐</option>
                <option value={4}>4 ⭐</option>
                <option value={3}>3 ⭐</option>
                <option value={2}>2 ⭐</option>
                <option value={1}>1 ⭐</option>
              </select>
            </div>
            <button type="submit" disabled={submitting}>
              {submitting ? 'Submitting...' : 'Submit Testimonial'}
            </button>
          </form>
        </div>
      )}

      <div className="testimonials-grid">
        {testimonials.map((testimonial) => (
          <div key={testimonial.id} className="testimonial-card">
            <div className="testimonial-header">
              <div className="testimonial-author">
                <h4>{testimonial.name}</h4>
                <p className="testimonial-role">{testimonial.role}</p>
              </div>
              {testimonial.rating && (
                <div className="testimonial-rating">
                  {renderStars(testimonial.rating)}
                </div>
              )}
            </div>
            <div className="testimonial-content">
              <p>"{testimonial.content}"</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Testimonials;


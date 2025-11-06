import React, { useState, useEffect } from 'react';
import { api } from '../services/apiService';

const GuestTestimonials = () => {
  const [testimonials, setTestimonials] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadTestimonials();
  }, []);

  const loadTestimonials = async () => {
    try {
      setLoading(true);
      const data = await api.guests.getTestimonials();
      setTestimonials(data.testimonials || []);
      setError(null);
    } catch (err) {
      console.error('Failed to load testimonials:', err);
      setError('Failed to load testimonials. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const renderStars = (rating) => {
    return '⭐'.repeat(rating);
  };

  if (loading) {
    return <div className="guest-testimonials-loading">Loading testimonials...</div>;
  }

  if (error) {
    return (
      <div className="guest-testimonials-error">
        <p>{error}</p>
        <button onClick={loadTestimonials}>Retry</button>
      </div>
    );
  }

  if (testimonials.length === 0) {
    return (
      <div className="guest-testimonials-empty">
        <p>No testimonials available at the moment.</p>
      </div>
    );
  }

  return (
    <div className="guest-testimonials">
      <h2>What Our Students Say</h2>
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

export default GuestTestimonials;


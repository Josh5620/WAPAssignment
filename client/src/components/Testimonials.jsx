import React, { useCallback, useEffect, useState } from 'react';
import { api } from '../services/apiService';
import '../styles/Testimonials.css';  

const Testimonials = ({ courseId, limit }) => {
  const [testimonials, setTestimonials] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

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

  return (
    <div className="testimonials">
      <div className="testimonials-header">
      </div>

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


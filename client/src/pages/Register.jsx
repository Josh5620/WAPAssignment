import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/forms.css';
import '../styles/Register.css';
import ReturnHome from '../components/ReturnHome';
import { api } from '../services/apiService';

const Register = () => {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    confirmPassword: '',
    fullName: '',
    role: 'student',
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [emailChecking, setEmailChecking] = useState(false);
  const navigate = useNavigate();

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
    if (error) {
      setError('');
    }
  };

  const handleEmailBlur = async () => {
    if (!formData.email) return;
    try {
      setEmailChecking(true);
      const result = await api.guests.checkEmailAvailability(formData.email);
      if (!result.available) {
        setError('This email is already registered');
      }
    } catch (err) {
      console.error('Email check error:', err);
    } finally {
      setEmailChecking(false);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setLoading(true);
    setError('');

    if (formData.password !== formData.confirmPassword) {
      setError('Passwords do not match');
      setLoading(false);
      return;
    }

    try {
      await api.guests.register({
        fullName: formData.fullName,
        email: formData.email,
        password: formData.password,
        role: formData.role,
      });

      alert('Registration successful! You can now log in.');
      navigate('/login');
    } catch (err) {
      setError(err.message || 'Registration failed. Please try again.');
      console.error('Registration error:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="form-page register-page">
      <ReturnHome />
      <div className="form-card register-card">
        <div className="form-header">
          <div className="form-logo register-logo">
            <img src="/CodeSage.svg" alt="CodeSage" />
            <img src="/CodeSageLogo.svg" alt="CodeSage Hat" />
          </div>
          <div className="form-title register-title">Register</div>
        </div>

        {error && <div className="form-error">{error}</div>}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <input
              type="text"
              name="fullName"
              placeholder="full name"
              value={formData.fullName}
              onChange={handleChange}
              required
              className="form-input"
            />
          </div>

          <div className="form-group">
            <input
              type="email"
              name="email"
              placeholder="email"
              value={formData.email}
              onChange={handleChange}
              onBlur={handleEmailBlur}
              required
              className="form-input"
            />
            {emailChecking && <span className="checking-indicator">Checking...</span>}
          </div>

          <div className="form-group">
            <div className="password-field">
              <input
                type={showPassword ? 'text' : 'password'}
                name="password"
                placeholder="password"
                value={formData.password}
                onChange={handleChange}
                required
                className="form-input"
              />
              <button
                type="button"
                className="password-toggle"
                onClick={() => setShowPassword((prev) => !prev)}
                aria-label={showPassword ? 'Hide password' : 'Show password'}
              >
                <img src="/crosseye.svg" alt="Toggle password visibility" />
              </button>
            </div>
          </div>

          <div className="form-group">
            <div className="password-field">
              <input
                type={showConfirmPassword ? 'text' : 'password'}
                name="confirmPassword"
                placeholder="confirm password"
                value={formData.confirmPassword}
                onChange={handleChange}
                required
                className="form-input"
              />
              <button
                type="button"
                className="password-toggle"
                onClick={() => setShowConfirmPassword((prev) => !prev)}
                aria-label={showConfirmPassword ? 'Hide confirm password' : 'Show confirm password'}
              >
                <img src="/crosseye.svg" alt="Toggle confirm password visibility" />
              </button>
            </div>
          </div>

          <div className="form-group">
            <select
              name="role"
              value={formData.role}
              onChange={handleChange}
              className="form-select role-select"
            >
              <option value="student">Student</option>
              <option value="teacher">Teacher</option>
            </select>
          </div>

          <button type="submit" disabled={loading} className="form-button">
            {loading ? 'Signing up…' : 'Sign Up'}
          </button>
        </form>

        <div className="terms-text">
          By signing up, I agree to CodeSage's <a href="#terms">Terms</a>.
        </div>

        <div className="form-divider">
          <span>OR</span>
        </div>

        <div className="social-buttons">
          <button className="social-btn" type="button" aria-label="Sign up with Google">
            <img src="/google.svg" alt="Google" style={{ width: '24px', height: '24px' }} />
          </button>
          <button className="social-btn" type="button" aria-label="Sign up with Apple">
            <img src="/apple.svg" alt="Apple" style={{ width: '24px', height: '24px' }} />
          </button>
          <button className="social-btn" type="button" aria-label="Sign up with Facebook">
            <img src="/facebook.svg" alt="Facebook" style={{ width: '24px', height: '24px' }} />
          </button>
        </div>

        <div className="signin-link">
          Already have an account?{' '}
          <a
            href="#"
            onClick={(event) => {
              event.preventDefault();
              navigate('/login');
            }}
          >
            Sign In
          </a>
        </div>
      </div>
    </div>
  );
};

export default Register;

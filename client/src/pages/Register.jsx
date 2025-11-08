import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/Login.css';
import '../styles/Register.css';
import { api } from '../services/apiService';

const validatePassword = (value) => {
  if (!value || value.length < 8) return false;
  const hasUpper = /[A-Z]/.test(value);
  const hasLower = /[a-z]/.test(value);
  const hasNumber = /\d/.test(value);
  return hasUpper && hasLower && hasNumber;
};

const Register = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    password: '',
    confirmPassword: '',
    role: 'student',
    agreeToTerms: false,
  });
  const [errors, setErrors] = useState({});
  const [apiError, setApiError] = useState('');
  const [success, setSuccess] = useState(false);
  const [loading, setLoading] = useState(false);
  const [checkingEmail, setCheckingEmail] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  useEffect(() => {
    if (success) {
      const timer = setTimeout(() => navigate('/login'), 1800);
      return () => clearTimeout(timer);
    }
    return undefined;
  }, [success, navigate]);

  const validate = () => {
    const nextErrors = {};

    if (!formData.fullName.trim()) {
      nextErrors.fullName = 'Please enter your full name';
    } else if (formData.fullName.trim().length < 2) {
      nextErrors.fullName = 'Full name must be at least 2 characters';
    }

    if (!formData.email) {
      nextErrors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      nextErrors.email = 'Please enter a valid email address';
    }

    if (!formData.password) {
      nextErrors.password = 'Password is required';
    } else if (!validatePassword(formData.password)) {
      nextErrors.password = 'Password must include uppercase, lowercase, and a number';
    }

    if (formData.confirmPassword !== formData.password) {
      nextErrors.confirmPassword = 'Passwords do not match';
    }

    if (!formData.agreeToTerms) {
      nextErrors.agreeToTerms = 'You must agree to the terms and conditions';
    }

    setErrors(nextErrors);
    return Object.keys(nextErrors).length === 0;
  };

  const handleChange = (event) => {
    const { name, value, type, checked } = event.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));
  };

  const handleEmailBlur = async () => {
    if (!formData.email || !/\S+@\S+\.\S+/.test(formData.email)) return;
    try {
      setCheckingEmail(true);
      const result = await api.guests.checkEmailAvailability(formData.email);
      if (!result.available) {
        setErrors((prev) => ({ ...prev, email: 'This email is already registered' }));
      }
    } catch (error) {
      console.error('Email check error:', error);
    } finally {
      setCheckingEmail(false);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!validate()) {
      return;
    }

    setLoading(true);
    setApiError('');

    try {
      await api.guests.register({
        fullName: formData.fullName,
        email: formData.email,
        password: formData.password,
        role: formData.role,
      });
      setSuccess(true);
    } catch (err) {
      console.error('Registration failed:', err);
      setApiError(err.message || 'Registration failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <Navbar />
      <main className="auth-page__container">
        <section className="auth-card register-card">
          <div className="auth-card__header">
            <img src="/CodeSageLogo.svg" alt="CodeSage sprout" className="auth-card__icon" />
            <h1>Join CodeSage</h1>
            <p>Start your Python learning journey today.</p>
          </div>

          {apiError && <div className="auth-card__error">{apiError}</div>}
          {success && <div className="auth-card__success">Account created! Redirecting to login…</div>}

          <form className="auth-form" onSubmit={handleSubmit} noValidate>
            <div className={`auth-field${errors.fullName ? ' has-error' : ''}`}>
              <label htmlFor="register-name">Full Name</label>
              <input
                id="register-name"
                type="text"
                name="fullName"
                placeholder="Enter your full name"
                value={formData.fullName}
                onChange={handleChange}
                autoComplete="name"
                required
              />
              {errors.fullName && <span className="auth-field__error">{errors.fullName}</span>}
            </div>

            <div className={`auth-field${errors.email ? ' has-error' : ''}`}>
              <label htmlFor="register-email">Email</label>
              <input
                id="register-email"
                type="email"
                name="email"
                placeholder="Enter your email"
                value={formData.email}
                onChange={handleChange}
                onBlur={handleEmailBlur}
                autoComplete="email"
                required
              />
              {checkingEmail && <span className="auth-field__note">Checking availability…</span>}
              {errors.email && <span className="auth-field__error">{errors.email}</span>}
            </div>

            <div className={`auth-field auth-field--password${errors.password ? ' has-error' : ''}`}>
              <label htmlFor="register-password">Password</label>
              <div className="auth-password">
                <input
                  id="register-password"
                  type={showPassword ? 'text' : 'password'}
                  name="password"
                  placeholder="Create a password"
                  value={formData.password}
                  onChange={handleChange}
                  autoComplete="new-password"
                  required
                />
                <button
                  type="button"
                  className="auth-password__toggle"
                  onClick={() => setShowPassword((prev) => !prev)}
                  aria-label={showPassword ? 'Hide password' : 'Show password'}
                >
                  <img src={showPassword ? '/eye.svg' : '/crosseye.svg'} alt="Toggle password visibility" />
                </button>
              </div>
              <p className="auth-field__hint">Use at least 8 characters with uppercase, lowercase, and a number.</p>
              {errors.password && <span className="auth-field__error">{errors.password}</span>}
            </div>

            <div className={`auth-field auth-field--password${errors.confirmPassword ? ' has-error' : ''}`}>
              <label htmlFor="register-confirm">Confirm Password</label>
              <div className="auth-password">
                <input
                  id="register-confirm"
                  type={showConfirmPassword ? 'text' : 'password'}
                  name="confirmPassword"
                  placeholder="Re-enter your password"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  autoComplete="new-password"
                  required
                />
                <button
                  type="button"
                  className="auth-password__toggle"
                  onClick={() => setShowConfirmPassword((prev) => !prev)}
                  aria-label={showConfirmPassword ? 'Hide password' : 'Show password'}
                >
                  <img src={showConfirmPassword ? '/eye.svg' : '/crosseye.svg'} alt="Toggle confirm password visibility" />
                </button>
              </div>
              {errors.confirmPassword && <span className="auth-field__error">{errors.confirmPassword}</span>}
            </div>

            <div className="register-role">
              <span className="register-role__label">I am a…</span>
              <label className={`register-role__option${formData.role === 'student' ? ' is-active' : ''}`}>
                <input
                  type="radio"
                  name="role"
                  value="student"
                  checked={formData.role === 'student'}
                  onChange={handleChange}
                />
                <div>
                  <strong>Student</strong>
                  <p>Learn Python at your own pace</p>
                </div>
              </label>
              <label className={`register-role__option${formData.role === 'teacher' ? ' is-active' : ''}`}>
                <input
                  type="radio"
                  name="role"
                  value="teacher"
                  checked={formData.role === 'teacher'}
                  onChange={handleChange}
                />
                <div>
                  <strong>Teacher</strong>
                  <p>Create and manage courses</p>
                </div>
              </label>
            </div>

            <label className={`register-terms${errors.agreeToTerms ? ' has-error' : ''}`}>
              <input
                type="checkbox"
                name="agreeToTerms"
                checked={formData.agreeToTerms}
                onChange={handleChange}
              />
              I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.
            </label>
            {errors.agreeToTerms && <span className="auth-field__error">{errors.agreeToTerms}</span>}

            <PrimaryButton type="submit" fullWidth disabled={loading || success}>
              {loading ? 'Creating account…' : 'Create Account'}
            </PrimaryButton>
          </form>

          <div className="auth-divider">
            <span>Or sign up with</span>
          </div>

          <div className="auth-social">
            <button type="button" aria-label="Sign up with Google">
              <img src="/google.svg" alt="Google" />
            </button>
            <button type="button" aria-label="Sign up with Apple">
              <img src="/apple.svg" alt="Apple" />
            </button>
            <button type="button" aria-label="Sign up with Facebook">
              <img src="/facebook.svg" alt="Facebook" />
            </button>
          </div>

          <p className="auth-switch">
            Already have an account? <Link to="/login">Log in</Link>
          </p>
        </section>
      </main>
    </div>
  );
};

export default Register;

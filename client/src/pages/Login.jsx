import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/Login.css';
import { login as loginRequest } from '../services/apiService';
import { useAuth } from '../context/AuthContext.jsx';

const validateEmail = (value) => /\S+@\S+\.\S+/.test(value);

const Login = () => {
  const navigate = useNavigate();
  const { login } = useAuth();
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    rememberMe: false,
  });
  const [errors, setErrors] = useState({});
  const [apiError, setApiError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

  const validate = () => {
    const nextErrors = {};
    if (!formData.email) {
      nextErrors.email = 'Email is required';
    } else if (!validateEmail(formData.email)) {
      nextErrors.email = 'Please enter a valid email address';
    }

    if (!formData.password) {
      nextErrors.password = 'Password is required';
    } else if (formData.password.length < 8) {
      nextErrors.password = 'Password must be at least 8 characters';
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

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!validate()) {
      return;
    }

    setLoading(true);
    setApiError('');

    try {
      const userData = await loginRequest(formData.email, formData.password);
      console.log('🔐 Login response data:', userData);
      
      login(userData);

      // Extract role from multiple possible locations
      const resolvedRole = userData?.role ?? userData?.user?.role ?? userData?.Role ?? '';
      const normalizedRole = typeof resolvedRole === 'string' ? resolvedRole.toLowerCase().trim() : '';
      
      console.log('👔 Resolved role:', resolvedRole, '→ Normalized:', normalizedRole);
      
      // Navigate based on role
      if (normalizedRole === 'admin') {
        console.log('➡️ Redirecting to admin dashboard');
        navigate('/admin-dashboard');
      } else if (normalizedRole === 'teacher') {
        console.log('➡️ Redirecting to teacher dashboard');
        navigate('/teacher-dashboard');
      } else {
        console.log('➡️ Redirecting to student dashboard (default)');
        navigate('/student-dashboard');
      }
    } catch (err) {
      console.error('❌ Login failed:', err);
      setApiError(err.message || 'Invalid email or password');
      setFormData((prev) => ({ ...prev, password: '' }));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <Navbar />
      <main className="auth-page__container">
        <section className="auth-card">
          <div className="auth-card__header">
            <div className="auth-card__logo">
              <span className="auth-card__logo-text">CodeSage</span>
              <img src="/CodeSageLogo.svg" alt="CodeSage sprout" className="auth-card__logo-icon" />
            </div>
            <div className="auth-card__divider"></div>
            <h1>Welcome Back</h1>
            <div className="auth-card__divider"></div>
            <p>Log in to continue your learning journey.</p>
          </div>

          {apiError && <div className="auth-card__error">{apiError}</div>}

          <form className="auth-form" onSubmit={handleSubmit} noValidate>
            <div className={`auth-field${errors.email ? ' has-error' : ''}`}>
              <label htmlFor="login-email">Email</label>
              <input
                id="login-email"
                type="email"
                name="email"
                placeholder="yingxinn18@gmail.com"
                value={formData.email}
                onChange={handleChange}
                autoComplete="email"
                required
              />
              {errors.email && <span className="auth-field__error">{errors.email}</span>}
            </div>

            <div className={`auth-field${errors.password ? ' has-error' : ''}`}>
              <label htmlFor="login-password">Password</label>
              <div className="auth-password">
                <input
                  id="login-password"
                  type={showPassword ? 'text' : 'password'}
                  name="password"
                  placeholder="••••••••••"
                  value={formData.password}
                  onChange={handleChange}
                  autoComplete="current-password"
                  required
                  minLength={8}
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
              {errors.password && <span className="auth-field__error">{errors.password}</span>}
            </div>

            <div className="auth-options">
              <label className="auth-remember">
                <input
                  type="checkbox"
                  name="rememberMe"
                  checked={formData.rememberMe}
                  onChange={handleChange}
                />
                Remember Me
              </label>
              <Link to="#" className="auth-link">
                Forgot Password?
              </Link>
            </div>

            <div className="auth-submit">
              <button type="submit" disabled={loading}>
                {loading ? 'LOGGING IN...' : 'LOGIN'}
              </button>
            </div>
          </form>

          <div className="auth-divider">Or</div>

          <div className="auth-social">
            <button type="button" className="auth-social__button" aria-label="Continue with Google">
              <img src="/google.svg" alt="Google" />
            </button>
            <button type="button" className="auth-social__button" aria-label="Continue with Apple">
              <img src="/apple.svg" alt="Apple" />
            </button>
            <button type="button" className="auth-social__button" aria-label="Continue with Facebook">
              <img src="/facebook.svg" alt="Facebook" />
            </button>
          </div>

          <p className="auth-footer">
            Don&apos;t have an account? <Link to="/register">Sign Up</Link>
          </p>
        </section>
      </main>
    </div>
  );
};

export default Login;

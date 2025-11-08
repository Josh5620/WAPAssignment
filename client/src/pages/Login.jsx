import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/forms.css';
import '../styles/Login.css';
import ReturnHome from '../components/ReturnHome';
import { login as loginRequest } from '../services/apiService';
import { useAuth } from '../context/AuthContext.jsx';

const Login = () => {
  const [formData, setFormData] = useState({
    identifier: '',
    password: '',
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();
  const { login } = useAuth();

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const togglePasswordVisibility = () => {
    setShowPassword((prev) => !prev);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setLoading(true);
    setError('');

    try {
      const userData = await loginRequest(formData.identifier, formData.password);
      login(userData);

      const resolvedRole = userData?.role ?? userData?.user?.role ?? userData?.Role ?? '';
      const normalizedRole = typeof resolvedRole === 'string' ? resolvedRole.toLowerCase() : '';
      if (normalizedRole === 'admin') {
        navigate('/admin-dashboard');
      } else if (normalizedRole === 'teacher') {
        navigate('/teacher-dashboard');
      } else {
        navigate('/student-dashboard');
      }
    } catch (err) {
      console.error('Login failed:', err);
      setError(`Login failed: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="form-page login-page">
      <ReturnHome />
      <div className="form-card login-card">
        <div className="form-header">
          <div className="form-logo login-logo">
            <img src="/CodeSage.svg" alt="CodeSage" className="logo-text" />
            <img src="/CodeSageLogo.svg" alt="CodeSage Hat" className="logo-hat" />
          </div>
          <div className="form-title login-title">Welcome Back</div>
        </div>

        {error && <div className="form-error">{error}</div>}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <input
              type="text"
              name="identifier"
              placeholder="email or username"
              value={formData.identifier}
              onChange={handleChange}
              required
              className="form-input"
            />
          </div>

          <div className="form-group password-field">
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
              onClick={togglePasswordVisibility}
              aria-label={showPassword ? 'Hide password' : 'Show password'}
            >
              <img src={showPassword ? '/eye.svg' : '/crosseye.svg'} alt="Toggle password visibility" />
            </button>
          </div>

          <div className="form-options login-options">
            <label className="remember-me">
              <input type="checkbox" /> Remember Me
            </label>
            <a href="#" className="forgot-password">
              Forgot Password?
            </a>
          </div>

          <button type="submit" className="form-button login-btn" disabled={loading}>
            {loading ? 'Logging in…' : 'Login'}
          </button>
        </form>

        <div className="form-divider">
          <span>OR</span>
        </div>

        <div className="social-buttons">
          <button className="social-btn" type="button" aria-label="Continue with Google">
            <img src="/google.svg" alt="Google" />
          </button>
          <button className="social-btn" type="button" aria-label="Continue with Apple">
            <img src="/apple.svg" alt="Apple" />
          </button>
          <button className="social-btn" type="button" aria-label="Continue with Facebook">
            <img src="/facebook.svg" alt="Facebook" />
          </button>
        </div>

        <div className="signup-link">
          Don't have an account? <a href="/register">Sign Up</a>
        </div>
      </div>
    </div>
  );
};

export default Login;

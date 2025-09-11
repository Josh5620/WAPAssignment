import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/Login.css';
import ReturnHome from '../components/ReturnHome';
import { authService } from '../services/apiService';

const Login = () => {
    const [formData, setFormData] = useState({
        email: '',
        password: ''
    });
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleChange = (e) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        try {
            const result = await authService.login(formData);
            
            if (result.success) {
                // Redirect based on user role
                const user = result.data.user;
                if (user.isAdmin) {
                    navigate('/admin-dashboard');
                } else if (user.isTeacher) {
                    navigate('/teacher-dashboard');
                } else {
                    navigate('/student-dashboard');
                }
            } else {
                setError(result.message || 'Login failed');
            }
        } catch (error) {
            setError('An error occurred during login');
            console.error('Login error:', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="login-container">
            <div className="login-card">
                <div className="login-header">
                    <div className="login-logo">
                        <img src="/CodeSage.svg" alt="CodeSage" className="logo-text" />
                        <img src="/CodeSageLogo.svg" alt="CodeSage Hat" className="logo-hat" />
                    </div>
                    <div className="login-welcome">WELCOME BACK</div>
                </div>
                
                {error && <div className="error">{error}</div>}
                
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <input 
                            type="email" 
                            name="email"
                            placeholder="email/username"
                            value={formData.email}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    
                    <div className="form-group password-field">
                        <input 
                            type="password" 
                            name="password"
                            placeholder="password"
                            value={formData.password}
                            onChange={handleChange}
                            required
                        />
                        <button type="button" className="password-toggle">
                            <img src="/crosseye.svg" alt="Show/Hide Password" />
                        </button>
                    </div>
                    
                    <div className="form-options">
                        <label className="remember-me">
                            <input type="checkbox" /> Remember Me
                        </label>
                        <a href="#" className="forgot-password">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" className="login-btn" disabled={loading}>
                        {loading ? 'Logging in...' : 'LOGIN'}
                    </button>
                </form>
                
                <div className="social-divider">OR</div>
                
                <div className="social-buttons">
                    <button className="social-btn">
                        <img src="/google.svg" alt="Google" />
                    </button>
                    <button className="social-btn">
                        <img src="/apple.svg" alt="Apple" />
                    </button>
                    <button className="social-btn">
                        <img src="/facebook.svg" alt="Facebook" />
                    </button>
                </div>
                
                <div className="signup-link">
                    Don't have an account? <a href="/register">Sign Up</a>
                </div>
                
                <ReturnHome />
            </div>
        </div>
    );
};

export default Login;

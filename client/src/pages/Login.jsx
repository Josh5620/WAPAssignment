import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/Login.css';
import ReturnHome from '../components/ReturnHome';
import TestingNav from '../components/TestingNav';
import { login } from '../services/apiService';

const Login = () => {
    const [formData, setFormData] = useState({
        identifier: '',
        password: ''
    });
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false); 
    const navigate = useNavigate();

    const handleChange = (e) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value
        });
    };

    const togglePasswordVisibility = () => {
        setShowPassword(!showPassword);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        try {
            const userData = await login(formData.identifier, formData.password);
            
            console.log("Login success:", userData);
            
            // Store the token in localStorage for future API calls
            localStorage.setItem('access_token', userData.access_token);
            localStorage.setItem('user_profile', JSON.stringify(userData));
            
            // Redirect based on user role
            if (userData.role === 'admin') {
                navigate('/admin-dashboard');
            } else if (userData.role === 'teacher') {
                navigate('/teacher-dashboard');
            } else {
                navigate('/student-dashboard');
            }
        } catch (error) {
            console.error("Login failed:", error);
            setError('Login failed: ' + error.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="login-container">
            <ReturnHome />
            <TestingNav />
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
                            type="text" 
                            name="identifier"
                            placeholder="Email or Username"
                            value={formData.identifier}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    
                    <div className="form-group password-field">
                        <input 
                            type={showPassword ? "text" : "password"}
                            name="password"
                            placeholder="password"
                            value={formData.password}
                            onChange={handleChange}
                            required
                        />
                        <button 
                            type="button" 
                            className="password-toggle"
                            onClick={togglePasswordVisibility}
                        >
                            <img 
                                src={showPassword ? "/eye.svg" : "/crosseye.svg"}
                                alt="Show/Hide Password" 
                            />
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
                
                <div className="divider">
                    <span>OR</span>
                </div>
                
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
            </div>
        </div>
    );
};

export default Login;

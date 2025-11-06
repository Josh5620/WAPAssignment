import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/Register.css';
import ReturnHome from '../components/ReturnHome';
import TestingNav from '../components/TestingNav';
import { api } from '../services/apiService';

const Register = () => {
    const [formData, setFormData] = useState({
        email: '',
        password: '',
        confirmPassword: '',
        fullName: '',
        role: 'student'
    });
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [emailChecking, setEmailChecking] = useState(false);
    const navigate = useNavigate();

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
        
        // Clear error when user types
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
            // Don't show error for check failures, just log
        } finally {
            setEmailChecking(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        // Check if passwords match
        if (formData.password !== formData.confirmPassword) {
            setError('Passwords do not match');
            setLoading(false);
            return;
        }

        try {
            const result = await api.guests.register({
                fullName: formData.fullName,
                email: formData.email,
                password: formData.password,
                role: formData.role
            });
            
            // Registration successful
            alert('Registration successful! You can now log in.');
            navigate('/login');
        } catch (err) {
            setError(err.message || 'Registration failed. Please try again.');
            console.error('Registration error:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleSignIn = () => {
        navigate('/login');
    };

    return (
        <div className="register-container">
            <ReturnHome /> 
            <TestingNav />
            <div className="register-card">
                <div className="register-header">
                    <div className="register-logo">
                        <img src="/CodeSage.svg" alt="CodeSage" />
                        <img src="/CodeSageLogo.svg" alt="CodeSage Hat" />
                    </div>
                    <div className="register-register">REGISTER</div>
                </div>
                
                {error && <div className="error">{error}</div>}
                
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <input 
                            type="text" 
                            name="fullName"
                            placeholder="full name"
                            value={formData.fullName}
                            onChange={handleChange}
                            required
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
                        />
                        {emailChecking && <span className="checking-indicator">Checking...</span>}
                    </div>
                    
                    <div className="form-group">
                        <div className="password-container">
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
                                onClick={() => setShowPassword(!showPassword)}
                            >
                                <img src="/crosseye.svg" alt="Toggle Password" style={{width: '20px', height: '20px'}} />
                            </button>
                        </div>
                    </div>
                    
                    <div className="form-group">
                        <div className="password-container">
                            <input 
                                type={showConfirmPassword ? "text" : "password"}
                                name="confirmPassword"
                                placeholder="confirm password"
                                value={formData.confirmPassword}
                                onChange={handleChange}
                                required
                            />
                            <button 
                                type="button"
                                className="password-toggle"
                                onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                            >
                                <img src="/crosseye.svg" alt="Toggle Password" style={{width: '20px', height: '20px'}} />
                            </button>
                        </div>
                    </div>
                    
                    <button type="submit" disabled={loading}>
                        {loading ? 'SIGNING UP...' : 'SIGN UP'}
                    </button>
                </form>
                
                <div className="terms-text">
                    By signing up, I agree to CodeSage's <a href="#terms">Terms</a>.
                </div>
                
                <div className="divider">
                    <span>OR</span>
                </div>
                
                <div className="social-buttons">
                    <button className="social-btn" type="button">
                        <img src="/google.svg" alt="Google" style={{width: '24px', height: '24px'}} />
                    </button>
                    <button className="social-btn" type="button">
                        <img src="/apple.svg" alt="Apple" style={{width: '24px', height: '24px'}} />
                    </button>
                    <button className="social-btn" type="button">
                        <img src="/facebook.svg" alt="Facebook" style={{width: '24px', height: '24px'}} />
                    </button>
                </div>
                
                <div className="signin-link">
                    Already have an account? <a href="#" onClick={handleSignIn}>Sign In</a>
                </div>
                
                {/* Remove ReturnHome from here */}
            </div>
        </div>
    );
}

export default Register;

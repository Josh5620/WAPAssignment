import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/Register.css';
import ReturnHome from '../components/ReturnHome';
import { authService } from '../services/apiService';

const Register = () => {
    const [formData, setFormData] = useState({
        username: '',
        password: '',
        confirmPassword: '',
        fullName: '',
        role: 'student'
    });
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
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

        // Check if passwords match
        if (formData.password !== formData.confirmPassword) {
            setError('Passwords do not match');
            setLoading(false);
            return;
        }

        try {
            const result = await authService.register({
                email: formData.email,
                password: formData.password,
                fullName: formData.fullName,
                role: formData.role
            });
            
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
                setError(result.message || 'Registration failed');
            }
        } catch (error) {
            setError('An error occurred during registration');
            console.error('Registration error:', error);
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
                            type="text" 
                            name="username"
                            placeholder="username"
                            value={formData.username}
                            onChange={handleChange}
                            required
                        />
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

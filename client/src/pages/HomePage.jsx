import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/HomePage.css';

const HomePage = () => {
    const navigate = useNavigate();

    const handleStartLearning = () => {
        // Navigate to student login for learning
        navigate('/studentLogin');
    };

    const handleLogin = () => {
        navigate('/teacherLogin');
    };

    const handleRegister = () => {
        navigate('/register');
    };

    return (
        <div className="homepage">
            {/* Navigation Bar */}
            <nav className="navbar">
                <div className="nav-left">
                    <div className="logo">Logo</div>
                    <div className="nav-links">
                        <a href="#home" className="nav-link active">Home</a>
                        <a href="#courses" className="nav-link">
                            Courses <span className="dropdown-arrow">▼</span>
                        </a>
                        <a href="#about" className="nav-link">About</a>
                        <a href="#faq" className="nav-link">FAQ</a>
                    </div>
                </div>
                <div className="nav-right">
                    <button onClick={handleLogin} className="nav-login">Login</button>
                    <button onClick={handleRegister} className="nav-register">Register</button>
                </div>
            </nav>

            {/* Hero Section */}
            <section className="hero">
                <div className="hero-content">
                    <div className="hero-left">
                        <h1 className="hero-title">
                            Learn Smart,<br />
                            Learn Fun!
                        </h1>
                        <p className="hero-description">
                            Join thousands of students<br />
                            mastering web skills
                        </p>
                        <div className="hero-buttons">
                            <button className="btn-primary" onClick={handleStartLearning}>Start Learning</button>
                            <button className="btn-secondary">Watch Demo</button>
                        </div>
                    </div>
                    <div className="hero-right">
                        <div className="hero-illustration">
                            <div className="illustration-circle">
                                <img 
                                    src="/codegirl.png" 
                                    alt="Girl coding with laptop" 
                                    className="hero-image"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Featured Courses Section */}
            <section className="featured-courses">
                <h2 className="featured-title">Featured Courses</h2>
                <div className="courses-grid">
                    <div className="course-card">
                        <div className="course-icon">
                            <div className="html-icon">
                                <span className="icon-text">HTML</span>
                                <span className="icon-number">5</span>
                            </div>
                        </div>
                        <h3 className="course-title">HTML Basics</h3>
                        <button className="course-button">Try Lesson 1</button>
                    </div>
                    <div className="course-card">
                        <div className="course-icon">
                            <div className="js-icon">
                                <span className="icon-text">JS</span>
                            </div>
                        </div>
                        <h3 className="course-title">JavaScript Essentials</h3>
                        <button className="course-button">Preview</button>
                    </div>
                    <div className="course-card">
                        <div className="course-icon">
                            <div className="python-icon">
                                <span className="python-symbol">🐍</span>
                            </div>
                        </div>
                        <h3 className="course-title">Python Basics</h3>
                        <button className="course-button">Try Lesson 1</button>
                    </div>
                </div>
            </section>

            {/* Testimonials Section */}
            <section className="testimonials">
                <h2 className="testimonials-title">Testimonials</h2>
                <div className="testimonials-grid">
                    <div className="testimonial-card">
                        <div className="testimonial-photo">
                            <span>photo</span>
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                    <div className="testimonial-card">
                        <div className="testimonial-photo">
                            <span>photo</span>
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                    <div className="testimonial-card">
                        <div className="testimonial-photo">
                            <span>photo</span>
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default HomePage;

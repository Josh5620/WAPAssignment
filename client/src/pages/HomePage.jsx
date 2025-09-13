import React from 'react';
import { useNavigate } from 'react-router-dom'; 
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import '../styles/HomePage.css';

const HomePage = () => {
    const navigate = useNavigate();

    const handleStartLearning = () => {
        navigate('/studentLogin');
    };

    return (
        <div className="homepage">
            <Navbar /> {/* <-- Use Navbar component here */}
            <TestingNav />

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
                            <div className="illustration-container-1"></div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Featured Courses Section */}
            <section className="featured-courses">
                <h2 className="featured-title">Featured Courses</h2>
                <div className="courses-grid">
                    <div className="course-card">
                        <img 
                            src="/html5.svg" 
                            alt="HTML5 Logo" 
                            className="course-icon"
                        />
                        <h3 className="course-title">HTML Basics</h3>
                        <p className="course-description">Learn the fundamentals of web structure</p>
                        <button className="course-button">Try Lesson 1</button>
                    </div>
                    <div className="course-card">
                        <img 
                            src="/javascript.svg" 
                            alt="JavaScript Logo" 
                            className="course-icon"
                        />
                        <h3 className="course-title">JavaScript Essentials</h3>
                        <p className="course-description">Master interactive web programming</p>
                        <button className="course-button">Preview</button>
                    </div>
                    <div className="course-card">
                        <img 
                            src="/python.svg" 
                            alt="Python Logo" 
                            className="course-icon"
                        />
                        <h3 className="course-title">Python Basics</h3>
                        <p className="course-description">Start your programming journey</p>
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
                            {/* Removed photo SVG */}
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                    <div className="testimonial-card">
                        <div className="testimonial-photo">
                            {/* Removed photo SVG */}
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                    <div className="testimonial-card">
                        <div className="testimonial-photo">
                            {/* Removed photo SVG */}
                        </div>
                        <p className="testimonial-text">CodeSage has helped me grow so much!</p>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default HomePage;

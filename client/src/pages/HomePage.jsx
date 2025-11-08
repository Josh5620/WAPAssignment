import React from 'react';
import { useNavigate } from 'react-router-dom'; 
import Navbar from '../components/Navbar';
import Testimonials from '../components/Testimonials';
import '../styles/HomePage.css';

const HomePage = () => {
    const navigate = useNavigate();

    return (
        <div className="homepage">
            <Navbar /> {/* <-- Use Navbar component here */}

            {/* Hero Section */}
            <section className="hero">
                <div className="hero-content">
                    <div className="hero-left">
                        <h1 className="hero-title">Grow Your Python Skills</h1>
                    </div>
                    <div className="hero-right">
                        <div className="snake-visual-placeholder"></div>
                    </div>
                </div>
            </section>

            <section className="why-python-section">
                <h2>Why Python?</h2>
                <p>
                    From automating tasks to building amazing applications, Python is your seed to possibilities.
                    Join our garden and watch your skills blossom!
                </p>
            </section>

            {/* Start Your Journey Section */}
            <section className="featured-courses">
                <h2 className="featured-title">Start Your Python Journey</h2>
                <p style={{ textAlign: 'center', fontSize: '1.1rem', marginBottom: '2rem', color: 'var(--cs-brown)' }}>
                    Master Python from the ground up with our comprehensive course
                </p>
                <div className="courses-grid">
                    <div className="course-card">
                        <img
                            src="/python.svg"
                            alt="Python Logo"
                            className="course-icon"
                        />
                        <h3 className="course-title">Python Basics: The Garden Path</h3>
                        <p className="course-description">
                            10 chapters from beginner to confident coder. Learn variables, loops, functions, and more!
                        </p>
                        <button
                            className="course-button"
                            onClick={() => navigate('/python')}
                        >
                            Explore the Course
                        </button>
                    </div>
                </div>
            </section>

            {/* Testimonials Section */}
            <section className="testimonials">
                <h2 className="testimonials-title">Testimonials</h2>
                <Testimonials />
            </section>
        </div>
    );
};

export default HomePage;

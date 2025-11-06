import React from 'react';
import { useNavigate } from 'react-router-dom'; 
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import GuestTestimonials from '../components/GuestTestimonials';
import '../styles/HomePage.css';

const HomePage = () => {
    const navigate = useNavigate();

    return (
        <div className="homepage">
            <Navbar /> {/* <-- Use Navbar component here */}
            <TestingNav />

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

            {/* Featured Course Section */}
            <section className="featured-courses">
                <h2 className="featured-title">Featured Course</h2>
                <div className="courses-grid">
                    <div className="course-card">
                        <img
                            src="/python.svg"
                            alt="Python Logo"
                            className="course-icon"
                        />
                        <h3 className="course-title">The Gardener's Assistant: Python Basics</h3>
                        <p className="course-description">Chapter 1: Planting Your First Seed</p>
                        <button
                            className="course-button"
                            onClick={() => navigate('/python')}
                        >
                            Start Planting
                        </button>
                    </div>
                </div>
            </section>

            {/* Testimonials Section */}
            <section className="testimonials">
                <h2 className="testimonials-title">Testimonials</h2>
                <GuestTestimonials />
            </section>
        </div>
    );
};

export default HomePage;

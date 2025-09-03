import React from 'react';
import '../styles/About.css';
import Navbar from '../pages/Navbar';


const About = () => (
  <>
    <Navbar />
    <div className="about-page-wrapper">
      <h1>CodeSage: Coding for All!</h1>
      <h2 className="about-tagline">Learn coding step by step, anywhere, anytime.</h2>

      <section className="about-section">
      <h3>Our Mission</h3>
      <p>
        Our mission is to make coding accessible to everyone by providing simple, engaging, and practical learning resources.
      </p>
    </section>

    <section className="about-section">
      <h3>Who Is CodeSage For?</h3>
      <p>
        CodeSage is designed for beginners, students, teachers, hobbyists, and professionals looking to upskill in programming.
      </p>
    </section>

    <section className="about-section">
      <h3>What We Offer</h3>
      <p>
        Tutorials, coding exercises, self-assessments, problem-solving challenges, virtual labs, and interactive features like quizzes and projects.
      </p>
    </section>

    <section className="about-section">
      <h3>Our Story</h3>
      <p>
        CodeSage was built to help students who struggle with coding basics. Our team wanted to create a supportive space for everyone to learn and grow.
      </p>
    </section>

    <section className="about-section">
      <h3>Meet the Team</h3>
      <p>
        Created by a group of Computer Science students passionate about making coding fun and accessible.
      </p>
      {/* You can add team member bios or images here if you want */}
    </section>

    <section className="about-section">
      <h3>Future Goals</h3>
      <p>
        We aim to expand our tutorials, add new programming languages, and introduce AI-powered coding buddies to help you learn even faster!
      </p>
    </section>

    <section className="about-section">
      <h3>Join Us!</h3>
      <p>
        Start your coding journey today! <a href="/register" className="about-cta">Sign up for free</a> and begin learning.
      </p>
    </section>
  </div>
</>

);

export default About;
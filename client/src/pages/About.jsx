import React from 'react';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/About.css';

const benefits = [
  {
    icon: '🎮',
    title: 'Gamified Learning',
    description: 'Turn coding into an adventure with garden-themed progress, badges, and gentle challenges.',
  },
  {
    icon: '📈',
    title: 'Track Progress',
    description: 'Visual dashboards let you watch your skills grow from seedling to canopy across every path.',
  },
  {
    icon: '💡',
    title: 'Interactive Content',
    description: 'Learn by doing with hands-on code labs, walkthroughs, and practice quizzes with instant feedback.',
  },
  {
    icon: '👥',
    title: 'Supportive Community',
    description: 'Join students and teachers who share tips, celebrate milestones, and keep each other motivated.',
  },
];

const steps = [
  {
    number: '01',
    title: 'Choose Your Path',
    description: 'Pick a course that matches your goals—from fundamentals to automation and data science.',
  },
  {
    number: '02',
    title: 'Complete Chapters',
    description: 'Work through lessons, practice in the browser, and reinforce knowledge with garden-themed quests.',
  },
  {
    number: '03',
    title: 'Practice & Test',
    description: 'Apply what you learn through projects, quizzes, and flashcards that adapt to your progress.',
  },
  {
    number: '04',
    title: 'Watch Your Garden Grow',
    description: 'Every milestone nurtures your digital garden as you unlock achievements and new challenges.',
  },
];

const About = () => (
  <div className="about-page">
    <Navbar />
    <main className="about-content">
      <section className="about-hero">
        <div className="about-hero__copy">
          <span className="about-hero__eyebrow">About CodeSage</span>
          <h1>Nurturing Python skills through storytelling and play</h1>
          <p>
            CodeSage blends structured curriculum with a vibrant garden theme to make Python approachable for every learner.
            We believe progress feels best when it is visual, rewarding, and rooted in community.
          </p>
        </div>
        <div className="about-hero__card">
          <h2>Our Mission</h2>
          <p>
            To make Python learning accessible, engaging, and sustainable by combining interactive practice with mindful pacing.
          </p>
          <PrimaryButton to="/register" size="md">
            Start learning free
          </PrimaryButton>
        </div>
      </section>

      <section className="about-benefits" aria-label="Why CodeSage">
        {benefits.map((benefit) => (
          <article key={benefit.title} className="about-benefit-card">
            <span className="about-benefit-card__icon" aria-hidden>
              {benefit.icon}
            </span>
            <h3>{benefit.title}</h3>
            <p>{benefit.description}</p>
          </article>
        ))}
      </section>

      <section className="about-how" aria-labelledby="how-it-works">
        <div className="section-heading">
          <h2 id="how-it-works">How CodeSage works</h2>
          <p>Follow a clear path from your first line of code to building full projects.</p>
        </div>
        <div className="about-steps">
          {steps.map((step) => (
            <div key={step.number} className="about-step">
              <span className="about-step__number">{step.number}</span>
              <h3>{step.title}</h3>
              <p>{step.description}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="about-story" aria-labelledby="our-story">
        <div className="section-heading">
          <h2 id="our-story">Our story</h2>
        </div>
        <div className="about-story__content">
          <p>
            CodeSage began as a passion project among teachers and developers who saw students struggle with traditional coding
            tutorials. We built a platform where practice feels playful, progress is celebrated, and every learner has space to
            grow at their own pace. Today we continue to expand the garden with new courses, seasonal events, and community-led
            workshops.
          </p>
        </div>
      </section>

      <section className="about-cta" aria-labelledby="about-cta-heading">
        <div className="about-cta__card">
          <h2 id="about-cta-heading">Ready to start your Python journey?</h2>
          <p>Join CodeSage for free to unlock interactive courses, track progress, and grow with the community.</p>
          <div className="about-cta__actions">
            <PrimaryButton size="lg" to="/register">
              Join CodeSage
            </PrimaryButton>
            <PrimaryButton variant="ghost" size="sm" to="/guest/courses">
              Browse courses
            </PrimaryButton>
          </div>
        </div>
      </section>
    </main>
  </div>
);

export default About;

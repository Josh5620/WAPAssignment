import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import Testimonials from '../components/Testimonials';
import ThemeSelector from '../components/ThemeSelector';
import PrimaryButton from '../components/PrimaryButton';
import GuestCourseCatalog from '../components/GuestCourseCatalog';
import { api } from '../services/apiService';
import '../styles/HomePage.css';

const featureHighlights = [
  {
    icon: '🌱',
    title: 'Gamified Learning',
    description: 'Watch your knowledge garden grow with XP, badges, and themed milestones.',
  },
  {
    icon: '💻',
    title: 'Interactive Coding',
    description: 'Practice Python in real time with hands-on exercises and instant feedback.',
  },
  {
    icon: '📊',
    title: 'Track Progress',
    description: 'See your skills bloom with dashboards that visualise growth over time.',
  },
  {
    icon: '🎓',
    title: 'Expert Curriculum',
    description: 'Follow a structured path crafted by teachers to take you from basics to mastery.',
  },
];

const howItWorksSteps = [
  {
    step: '01',
    title: 'Sign Up',
    description: 'Create your free account and join the CodeSage garden.',
  },
  {
    step: '02',
    title: 'Choose Your Path',
    description: 'Browse curated courses and pick the journey that fits your goals.',
  },
  {
    step: '03',
    title: 'Grow & Learn',
    description: 'Complete interactive chapters and watch your progress flourish.',
  },
];

const HomePage = () => {
  const navigate = useNavigate();
  const [featuredCourses, setFeaturedCourses] = useState([]);
  const [loadingFeatured, setLoadingFeatured] = useState(true);
  const [featuredError, setFeaturedError] = useState('');

  useEffect(() => {
    let isMounted = true;
    const fetchFeaturedCourses = async () => {
      try {
        setLoadingFeatured(true);
        const data = await api.guests.getFeaturedCourses(6);
        if (isMounted) {
          setFeaturedCourses(data.courses || data || []);
          setFeaturedError('');
        }
      } catch (error) {
        console.error('Failed to load featured courses:', error);
        if (isMounted) {
          setFeaturedError('Featured courses are taking a moment to bloom. Please try again.');
        }
      } finally {
        if (isMounted) {
          setLoadingFeatured(false);
        }
      }
    };

    fetchFeaturedCourses();
    return () => {
      isMounted = false;
    };
  }, []);

  const heroCTAs = useMemo(
    () => [
      {
        label: 'Get Started Free',
        action: () => navigate('/register'),
        variant: 'primary',
      },
      {
        label: 'Browse Courses',
        action: () => navigate('/guest/courses'),
        variant: 'secondary',
      },
    ],
    [navigate],
  );

  return (
    <div className="homepage">
      <Navbar />
      <main className="homepage__content">
        <section className="hero">
          <div className="hero__copy">
            <h1>Learn Python Through an Interactive Garden Journey</h1>
            <p>
              CodeSage blends storytelling, gamification, and hands-on coding so that every chapter you complete nurtures a
              thriving digital garden. Start small, stay consistent, and grow something extraordinary.
            </p>
            <div className="hero__actions">
              {heroCTAs.map((cta) => (
                <PrimaryButton
                  key={cta.label}
                  onClick={cta.action}
                  variant={cta.variant}
                  size="lg"
                >
                  {cta.label}
                </PrimaryButton>
              ))}
            </div>
          </div>
          <div className="hero__visual" aria-hidden>
            <div className="hero__illustration">
              <img src="/code.gif" alt="Animated code editor" />
              <div className="hero__badge">🌿 150K+ garden actions logged</div>
            </div>
          </div>
        </section>

        <section className="features" aria-label="Platform highlights">
          {featureHighlights.map((feature) => (
            <article key={feature.title} className="feature-card">
              <span className="feature-card__icon" aria-hidden>
                {feature.icon}
              </span>
              <h3>{feature.title}</h3>
              <p>{feature.description}</p>
            </article>
          ))}
        </section>

        <section className="course-preview" aria-labelledby="course-preview-title">
          <div className="section-heading">
            <h2 id="course-preview-title">Popular Python Journeys</h2>
            <p>Preview a curated selection of courses that visitors love exploring.</p>
          </div>
          <div className="course-preview__grid">
            {loadingFeatured && <div className="course-preview__skeleton">Loading featured courses…</div>}
            {!loadingFeatured && featuredError && (
              <div className="course-preview__error">{featuredError}</div>
            )}
            {!loadingFeatured && !featuredError && featuredCourses.length > 0 && (
              <GuestCourseCatalog courses={featuredCourses} limit={6} compact />
            )}
          </div>
          <div className="course-preview__actions">
            <PrimaryButton size="md" onClick={() => navigate('/guest/courses')}>
              View All Courses
            </PrimaryButton>
          </div>
        </section>

        <section className="how-it-works" aria-labelledby="how-it-works-title">
          <div className="section-heading">
            <h2 id="how-it-works-title">How It Works</h2>
            <p>Getting started is simple—follow these steps and start planting new skills today.</p>
          </div>
          <div className="how-it-works__steps">
            {howItWorksSteps.map((item) => (
              <div key={item.step} className="how-step">
                <span className="how-step__index">{item.step}</span>
                <h3>{item.title}</h3>
                <p>{item.description}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="testimonials-section" aria-labelledby="testimonials-heading">
          <div className="section-heading">
            <h2 id="testimonials-heading">What Students Are Saying</h2>
            <p>Join thousands of learners who are turning curiosity into confidence.</p>
          </div>
          <Testimonials />
        </section>

        <section className="final-cta" aria-labelledby="final-cta-title">
          <div className="final-cta__card">
            <h2 id="final-cta-title">Ready to Start Your Python Journey?</h2>
            <p>Unlock the full garden experience by creating your free account today.</p>
            <div className="final-cta__actions">
              <PrimaryButton size="lg" onClick={() => navigate('/register')}>
                Sign Up Now
              </PrimaryButton>
              <PrimaryButton
                variant="ghost"
                size="md"
                onClick={() => navigate('/login')}
              >
                Already have an account? Log in
              </PrimaryButton>
            </div>
          </div>
        </section>
      </main>

      <footer className="homepage__footer" aria-label="Site footer">
        <div className="footer__links">
          <a href="/about">About</a>
          <a href="/faq">FAQ</a>
          <a href="/guest/courses">Courses</a>
          <a href="mailto:hello@codesage.com">Contact</a>
        </div>
        <ThemeSelector />
        <p className="footer__copy">© {new Date().getFullYear()} CodeSage. All rights reserved.</p>
      </footer>
    </div>
  );
};

export default HomePage;

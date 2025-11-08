import React, { useMemo, useState } from 'react';
import Navbar from '../components/Navbar';
import PrimaryButton from '../components/PrimaryButton';
import '../styles/FAQ.css';

const faqCategories = [
  {
    title: 'Getting Started',
    items: [
      {
        question: 'What is CodeSage?',
        answer:
          'CodeSage is an interactive Python learning platform where your progress grows like a garden. Complete chapters, earn badges, and cultivate confidence step by step.',
      },
      {
        question: 'Do I need programming experience?',
        answer:
          'Not at all. Our seedling path starts with the basics—setting up Python, writing your first script, and understanding core concepts.',
      },
      {
        question: 'Is CodeSage free to use?',
        answer:
          'Yes! Visitors can preview courses and registered students get access to interactive chapters, quizzes, and tracking at no cost.',
      },
      {
        question: 'How do I create an account?',
        answer:
          'Click “Sign Up” on any page, choose the student or teacher role, and complete the quick registration form. You will receive instant access to the platform.',
      },
    ],
  },
  {
    title: 'Using the Platform',
    items: [
      {
        question: 'How does the garden theme help me learn?',
        answer:
          'Every milestone waters your digital garden. Visual progress tracking keeps you motivated while reinforcing consistent practice.',
      },
      {
        question: 'Can I track my progress?',
        answer:
          'Yes. Registered students unlock dashboards that show chapter completion, badges earned, streaks, and personalized recommendations.',
      },
      {
        question: 'What are badges and XP?',
        answer:
          'Badges celebrate major milestones, while XP rewards consistent effort. Both help you see growth beyond just finished lessons.',
      },
      {
        question: 'Does CodeSage work on mobile devices?',
        answer:
          'Absolutely. The entire platform is responsive, so you can learn from desktop, tablet, or phone without missing a feature.',
      },
    ],
  },
  {
    title: 'Courses & Content',
    items: [
      {
        question: 'How many courses are available?',
        answer:
          'We curate a growing library covering fundamentals, data structures, OOP, web development, automation, and data science.',
      },
      {
        question: 'Can I preview a course before enrolling?',
        answer:
          'Yes. Visitors can preview the first chapters of every course to see the structure, pacing, and learning objectives.',
      },
      {
        question: 'Are new courses added regularly?',
        answer:
          'We release seasonal content drops and community-requested lessons so your garden always has something new to explore.',
      },
      {
        question: 'Can I suggest a topic?',
        answer:
          'We welcome suggestions! Reach out to our team and let us know which paths you would like to see in bloom next.',
      },
    ],
  },
  {
    title: 'Account & Roles',
    items: [
      {
        question: 'How do I reset my password?',
        answer:
          'On the login page select “Forgot password?”. We will email you steps to reset and re-enter the garden safely.',
      },
      {
        question: 'Can I switch between student and teacher roles?',
        answer:
          'Yes. Contact support to adjust your role. Teachers gain access to course creation and classroom tools.',
      },
      {
        question: 'How do teachers use CodeSage?',
        answer:
          'Teachers build courses, assign chapters, and track student growth in real time through dedicated dashboards.',
      },
    ],
  },
  {
    title: 'Support',
    items: [
      {
        question: 'Who do I contact for help?',
        answer:
          'Our support team is available via email and in-app chat. We respond within one business day and often sooner.',
      },
      {
        question: 'The site is not loading properly. What should I do?',
        answer:
          'Try refreshing the page or clearing your cache. If issues persist, let us know which browser and device you are using.',
      },
      {
        question: 'Do you offer classroom or enterprise plans?',
        answer:
          'Yes. Teachers and organizations can request tailored plans that include classroom management and reporting.',
      },
    ],
  },
];

const createId = (category, question) => `${category}-${question}`.toLowerCase().replace(/[^a-z0-9]+/g, '-');

const FAQ = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [expandedId, setExpandedId] = useState(null);

  const filteredFaqs = useMemo(() => {
    if (!searchQuery.trim()) {
      return faqCategories;
    }
    const normalized = searchQuery.trim().toLowerCase();
    return faqCategories
      .map((category) => ({
        title: category.title,
        items: category.items.filter((item) =>
          item.question.toLowerCase().includes(normalized) ||
          item.answer.toLowerCase().includes(normalized),
        ),
      }))
      .filter((category) => category.items.length > 0);
  }, [searchQuery]);

  const handleToggle = (id) => {
    setExpandedId((current) => (current === id ? null : id));
  };

  const hasResults = filteredFaqs.some((category) => category.items.length > 0);

  return (
    <div className="faq-page">
      <Navbar />
      <main className="faq-content">
        <header className="faq-header">
          <h1>Frequently Asked Questions</h1>
          <p>Your guide to getting the most from CodeSage.</p>
        </header>

        <div className="faq-search">
          <input
            type="search"
            value={searchQuery}
            onChange={(event) => setSearchQuery(event.target.value)}
            placeholder="Search FAQs…"
            aria-label="Search frequently asked questions"
          />
        </div>

        {hasResults ? (
          filteredFaqs.map((category) => (
            <section key={category.title} className="faq-category">
              <h2>{category.title}</h2>
              <div className="faq-list">
                {category.items.map((item) => {
                  const id = createId(category.title, item.question);
                  const isOpen = expandedId === id;
                  return (
                    <div key={id} className={`faq-item${isOpen ? ' is-open' : ''}`}>
                      <button
                        className="faq-question"
                        onClick={() => handleToggle(id)}
                        aria-expanded={isOpen}
                        aria-controls={`${id}-answer`}
                      >
                        <span>{item.question}</span>
                        <span className="faq-icon" aria-hidden>
                          {isOpen ? '−' : '+'}
                        </span>
                      </button>
                      {isOpen && (
                        <div id={`${id}-answer`} className="faq-answer">
                          <p>{item.answer}</p>
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </section>
          ))
        ) : (
          <div className="faq-empty">
            <p>No questions matched “{searchQuery}”. Try different keywords or browse the categories below.</p>
          </div>
        )}

        <section className="faq-contact">
          <h2>Still need help?</h2>
          <p>Our support team and community mentors are here to guide you.</p>
          <div className="faq-contact__actions">
            <PrimaryButton size="md" variant="outline" to="mailto:hello@codesage.com">
              Email Support
            </PrimaryButton>
            <PrimaryButton size="md" to="/register">
              Join the Community
            </PrimaryButton>
          </div>
        </section>
      </main>
    </div>
  );
};

export default FAQ;

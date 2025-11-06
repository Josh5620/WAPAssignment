import React from 'react';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import '../styles/FAQ.css';

const FAQ = () => {
  const faqs = [
    {
      question: "What is CodeSage?",
      answer: "CodeSage is an interactive learning platform designed to help students master Python programming through hands-on tutorials and interactive exercises."
    },
    {
      question: "How do I enroll in a course?",
      answer: "Simply browse our course catalog, select a course you're interested in, and click the 'Enroll' button. You'll need to create an account first if you haven't already."
    },
    {
      question: "Are the courses free?",
      answer: "Yes! All courses on CodeSage are completely free. Our mission is to make quality programming education accessible to everyone."
    },
    {
      question: "Can I access courses offline?",
      answer: "Currently, all courses require an internet connection to access the interactive content and track your progress. However, you can bookmark important code examples for reference."
    },
    {
      question: "How do I track my progress?",
      answer: "Your progress is automatically saved as you complete sections and chapters. You can view your overall progress from your dashboard."
    },
    {
      question: "What programming languages do you offer?",
      answer: "We currently focus on Python programming, providing comprehensive courses from basics to advanced topics."
    },
    {
      question: "Is there a mobile app?",
      answer: "Not yet, but our website is fully responsive and works great on mobile devices. You can learn on any device with a web browser."
    },
    {
      question: "How can I get help if I'm stuck?",
      answer: "Use our built-in chatbot for quick questions, or contact our support team. We also have community forums where you can ask questions and help others."
    },
    {
      question: "Can teachers create their own courses?",
      answer: "Yes! Teachers can create and manage their own courses through the teacher dashboard. Contact us for more information about becoming a course creator."
    },
    {
      question: "How often is the content updated?",
      answer: "We regularly update our content to reflect the latest best practices and industry standards. Course updates are automatically available to all enrolled students."
    }
  ];

  return (
    <>
      <Navbar />
      <TestingNav />
      <div className="faq-page">
        <div className="faq-container">
        <header className="faq-header">
          <h1>Frequently Asked Questions</h1>
          <p>Find answers to common questions about CodeSage</p>
        </header>

        <div className="faq-content">
          {faqs.map((faq, index) => (
            <div key={index} className="faq-item">
              <h3 className="faq-question">{faq.question}</h3>
              <p className="faq-answer">{faq.answer}</p>
            </div>
          ))}
        </div>

        <div className="contact-section">
          <h2>Still have questions?</h2>
          <p>Can't find what you're looking for? Feel free to contact our support team.</p>
          <button className="contact-btn">Contact Support</button>
        </div>
      </div>
    </div>
    </>
  );
};

export default FAQ;

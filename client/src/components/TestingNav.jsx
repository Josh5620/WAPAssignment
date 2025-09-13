import React, { useState } from "react";
import { Link } from "react-router-dom";
import "../styles/TestingNav.css";

const TestingNav = () => {
  const [isOpen, setIsOpen] = useState(false);

  const toggleNav = () => {
    setIsOpen(!isOpen);
  };

  const closeNav = () => {
    setIsOpen(false);
  };

  const navigationLinks = [
    { path: "/", label: "Home Page" },
    { path: "/login", label: "Login" },
    { path: "/register", label: "Register" },
    { path: "/admin", label: "Admin Login" },
    { path: "/admin-dashboard", label: "Admin Dashboard" },
    { path: "/user-dashboard", label: "User Dashboard" },
    { path: "/teacher-dashboard", label: "Teacher Dashboard" },
    { path: "/courses", label: "Courses" },
    { path: "/html", label: "Learn HTML" },
    { path: "/python", label: "Learn Python" },
    { path: "/java", label: "Learn Java" },
    { path: "/explainTest", label: "Explain Test" },
    { path: "/about", label: "About" },
  ];

  return (
    <>
      {/* Toggle Button */}
      <button
        className={`testing-nav-toggle-btn ${isOpen ? "testing-nav-open" : ""}`}
        onClick={toggleNav}
        aria-label="Toggle Navigation"
      >
        <span className="testing-nav-hamburger-line"></span>
        <span className="testing-nav-hamburger-line"></span>
        <span className="testing-nav-hamburger-line"></span>
      </button>

      {/* Overlay */}
      {isOpen && <div className="testing-nav-overlay" onClick={closeNav}></div>}

      {/* Navigation Popup */}
      <div
        className={`testing-nav-popup ${
          isOpen ? "testing-nav-popup-open" : ""
        }`}
      >
        <div className="testing-nav-header">
          <h3>Navigation</h3>
          <button className="testing-nav-close-btn" onClick={closeNav}>
            ×
          </button>
        </div>

        <div className="testing-nav-links">
          {navigationLinks.map((link, index) => (
            <Link
              key={index}
              to={link.path}
              className="testing-nav-link"
              onClick={closeNav}
            >
              {link.label}
            </Link>
          ))}
        </div>
      </div>
    </>
  );
};

export default TestingNav;

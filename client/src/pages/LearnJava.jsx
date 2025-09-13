import React from 'react';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import '../styles/LearnJava.css';

const Java = () => {
  return (
    <>
      <Navbar />
      <TestingNav />
      <div className="java-container">
        {/* Your Java course content goes here */}
        <h1>Java Essentials Course</h1>
        <p>Welcome to the Java Essentials course!</p>
      </div>
    </>
  );
};

export default Java;

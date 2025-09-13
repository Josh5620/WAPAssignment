import React from 'react';
import Navbar from '../components/Navbar';
import TestingNav from '../components/TestingNav';
import '../styles/LearnPython.css';

const Python = () => {
  return (
    <>
      <Navbar />
      <TestingNav />
      <div className="python-container">
        {/* Your Python course content goes here */}
        <h1>Python Basics Course</h1>
        <p>Welcome to the Python Basics course!</p>
      </div>
    </>
  );
};

export default Python;

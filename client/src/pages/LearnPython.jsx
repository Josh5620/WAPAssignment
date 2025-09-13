import React from 'react';
import Navbar from './Navbar';
import '../styles/LearnPython.css';

const Python = () => {
  return (
    <>
      <Navbar />
      <div className="python-container">
        {/* Your Python course content goes here */}
        <h1>Python Basics Course</h1>
        <p>Welcome to the Python Basics course!</p>
      </div>
    </>
  );
};

export default Python;

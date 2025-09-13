import React from 'react';
import Navbar from './Navbar';
import '../styles/LearnHTML.css';

const HTML = () => {
  return (
    <>
      <Navbar />
      <div className="html-container">
        {/* Your HTML course content goes here */}
        <h1>HTML Basics Course</h1>
        <p>Welcome to the HTML Basics course!</p>
      </div>
    </>
  );
};

export default HTML;
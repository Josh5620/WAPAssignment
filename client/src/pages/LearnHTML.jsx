import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import ReturnHome from '../components/ReturnHome';
import '../styles/LearnHTML.css';

const LearnHTML = () => {
  const navigate = useNavigate();
  const [currentSection, setCurrentSection] = useState(0);
  const [progress, setProgress] = useState(0);

  const sections = [
    {
      title: "Introduction to HTML",
      content: `
        <h3>What is HTML?</h3>
        <p>HTML (HyperText Markup Language) is the standard markup language for creating web pages. It describes the structure of a web page using markup.</p>
        <h4>Key Points:</h4>
        <ul>
          <li>HTML uses tags to define elements</li>
          <li>Tags are enclosed in angle brackets &lt; &gt;</li>
          <li>Most tags come in pairs (opening and closing)</li>
          <li>HTML documents have a specific structure</li>
        </ul>
      `,
      code: `<!DOCTYPE html>
<html>
<head>
    <title>My First HTML Page</title>
</head>
<body>
    <h1>Hello World!</h1>
    <p>This is my first HTML page.</p>
</body>
</html>`
    },
    {
      title: "HTML Document Structure",
      content: `
        <h3>Basic HTML Structure</h3>
        <p>Every HTML document follows a standard structure with essential elements.</p>
        <h4>Essential Elements:</h4>
        <ul>
          <li><strong>&lt;!DOCTYPE html&gt;</strong> - Declares document type</li>
          <li><strong>&lt;html&gt;</strong> - Root element</li>
          <li><strong>&lt;head&gt;</strong> - Contains metadata</li>
          <li><strong>&lt;body&gt;</strong> - Contains visible content</li>
        </ul>
      `,
      code: `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Structure</title>
</head>
<body>
    <header>
        <h1>Welcome to My Website</h1>
    </header>
    <main>
        <p>This is the main content area.</p>
    </main>
    <footer>
        <p>&copy; 2024 My Website</p>
    </footer>
</body>
</html>`
    },
    {
      title: "HTML Headings and Paragraphs",
      content: `
        <h3>Text Elements</h3>
        <p>HTML provides various elements for structuring text content.</p>
        <h4>Heading Levels:</h4>
        <ul>
          <li>&lt;h1&gt; - Main heading (largest)</li>
          <li>&lt;h2&gt; to &lt;h6&gt; - Subheadings (decreasing size)</li>
          <li>&lt;p&gt; - Paragraphs</li>
          <li>&lt;br&gt; - Line breaks</li>
        </ul>
      `,
      code: `<h1>This is a Main Heading</h1>
<h2>This is a Subheading</h2>
<h3>This is a Smaller Subheading</h3>

<p>This is a paragraph of text. It can contain multiple sentences and will wrap automatically based on the container width.</p>

<p>This is another paragraph.<br>
This line comes after a line break.</p>

<h4>More Subheadings</h4>
<h5>Even Smaller</h5>
<h6>The Smallest Heading</h6>`
    },
    {
      title: "HTML Links and Images",
      content: `
        <h3>Links and Media</h3>
        <p>HTML allows you to create links to other pages and embed images.</p>
        <h4>Link Attributes:</h4>
        <ul>
          <li><strong>href</strong> - The URL or path to link to</li>
          <li><strong>target</strong> - Where to open the link</li>
        </ul>
        <h4>Image Attributes:</h4>
        <ul>
          <li><strong>src</strong> - Path to the image file</li>
          <li><strong>alt</strong> - Alternative text for accessibility</li>
        </ul>
      `,
      code: `<!-- Links -->
<a href="https://www.google.com">Visit Google</a>
<a href="https://www.github.com" target="_blank">GitHub (opens in new tab)</a>
<a href="mailto:someone@example.com">Send Email</a>

<!-- Images -->
<img src="logo.png" alt="Company Logo" width="200" height="100">
<img src="https://via.placeholder.com/300x200" alt="Placeholder Image">

<!-- Image with Link -->
<a href="https://www.example.com">
    <img src="clickable-banner.jpg" alt="Click here to visit our site">
</a>`
    },
    {
      title: "HTML Lists",
      content: `
        <h3>Creating Lists</h3>
        <p>HTML provides three types of lists for organizing information.</p>
        <h4>List Types:</h4>
        <ul>
          <li><strong>Unordered Lists (&lt;ul&gt;)</strong> - Bullet points</li>
          <li><strong>Ordered Lists (&lt;ol&gt;)</strong> - Numbered items</li>
          <li><strong>Description Lists (&lt;dl&gt;)</strong> - Term and description pairs</li>
        </ul>
      `,
      code: `<!-- Unordered List -->
<ul>
    <li>Apple</li>
    <li>Banana</li>
    <li>Orange</li>
</ul>

<!-- Ordered List -->
<ol>
    <li>First step</li>
    <li>Second step</li>
    <li>Third step</li>
</ol>

<!-- Nested Lists -->
<ul>
    <li>Fruits
        <ul>
            <li>Apple</li>
            <li>Orange</li>
        </ul>
    </li>
    <li>Vegetables
        <ul>
            <li>Carrot</li>
            <li>Broccoli</li>
        </ul>
    </li>
</ul>`
    }
  ];

  useEffect(() => {
    const newProgress = ((currentSection + 1) / sections.length) * 100;
    setProgress(newProgress);
  }, [currentSection, sections.length]);

  const nextSection = () => {
    if (currentSection < sections.length - 1) {
      setCurrentSection(currentSection + 1);
    }
  };

  const prevSection = () => {
    if (currentSection > 0) {
      setCurrentSection(currentSection - 1);
    }
  };

  const copyCode = () => {
    navigator.clipboard.writeText(sections[currentSection].code);
    alert('Code copied to clipboard!');
  };

  return (
    <div className="learn-html">
      <ReturnHome />
      
      <div className="learn-container">
        <header className="learn-header">
          <h1>Learn HTML</h1>
          <div className="progress-bar">
            <div 
              className="progress-fill" 
              style={{ width: `${progress}%` }}
            ></div>
          </div>
          <p className="progress-text">
            Section {currentSection + 1} of {sections.length} ({Math.round(progress)}% complete)
          </p>
        </header>

        <div className="section-navigation">
          <button 
            onClick={prevSection} 
            disabled={currentSection === 0}
            className="nav-btn prev-btn"
          >
            ← Previous
          </button>
          
          <h2 className="section-title">{sections[currentSection].title}</h2>
          
          <button 
            onClick={nextSection} 
            disabled={currentSection === sections.length - 1}
            className="nav-btn next-btn"
          >
            Next →
          </button>
        </div>

        <div className="content-area">
          <div className="theory-section">
            <div 
              className="content" 
              dangerouslySetInnerHTML={{ __html: sections[currentSection].content }}
            />
          </div>

          <div className="code-section">
            <div className="code-header">
              <h3>Example Code</h3>
              <button onClick={copyCode} className="copy-btn">
                📋 Copy Code
              </button>
            </div>
            <pre className="code-block">
              <code>{sections[currentSection].code}</code>
            </pre>
          </div>
        </div>

        <div className="section-dots">
          {sections.map((_, index) => (
            <button
              key={index}
              className={`dot ${index === currentSection ? 'active' : ''}`}
              onClick={() => setCurrentSection(index)}
            >
              {index + 1}
            </button>
          ))}
        </div>

        {currentSection === sections.length - 1 && (
          <div className="completion-message">
            <h3>🎉 Congratulations!</h3>
            <p>You've completed the HTML basics course!</p>
            <button 
              onClick={() => navigate('/courses')} 
              className="continue-learning-btn"
            >
              Continue Learning
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default LearnHTML;
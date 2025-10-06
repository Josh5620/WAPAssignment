import React, { useState, useEffect } from 'react';
import { api, quickApi } from '../services/apiService';
import CodeBlock from './CodeBlock';
import ChapterNavigation from './ChapterNavigation';
import '../styles/CourseViewer.css';

const CourseViewer = ({ courseId, userRole, onBack }) => {
  const [course, setCourse] = useState(null);
  const [chapters, setChapters] = useState([]);
  const [currentChapter, setCurrentChapter] = useState(null);
  const [currentChapterIndex, setCurrentChapterIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [userProgress, setUserProgress] = useState({});

  useEffect(() => {
    if (courseId) {
      fetchCourseContent();
    }
  }, [courseId]);

  const fetchCourseContent = async () => {
    try {
      setLoading(true);
      
      // Fetch course details
      const courseData = await quickApi.getCourse(courseId);
      setCourse(courseData);

      // Fetch chapters for the course
      const chaptersData = await api.courses.getChapters(courseId);
      setChapters(chaptersData);
      
      if (chaptersData.length > 0) {
        setCurrentChapter(chaptersData[0]);
      }

      // TODO: Fetch user progress if logged in
      // const token = quickApi.getUserToken();
      // if (token) {
      //   const progress = await getUserProgress(courseId, token);
      //   setUserProgress(progress);
      // }

      setError(null);
    } catch (err) {
      console.error('Failed to fetch course content:', err);
      setError('Failed to load course content. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleChapterChange = (chapterIndex) => {
    setCurrentChapterIndex(chapterIndex);
    setCurrentChapter(chapters[chapterIndex]);
  };

  const handlePreviousChapter = () => {
    if (currentChapterIndex > 0) {
      handleChapterChange(currentChapterIndex - 1);
    }
  };

  const handleNextChapter = () => {
    if (currentChapterIndex < chapters.length - 1) {
      handleChapterChange(currentChapterIndex + 1);
    }
  };

  const markChapterComplete = async () => {
    try {
      // TODO: Implement chapter completion API
      console.log(`Marking chapter ${currentChapter.id} as complete`);
      setUserProgress(prev => ({
        ...prev,
        [currentChapter.id]: { completed: true, completedAt: new Date() }
      }));
    } catch (err) {
      console.error('Failed to mark chapter complete:', err);
    }
  };

  if (loading) {
    return <div className="course-viewer-loading">Loading course content...</div>;
  }

  if (error) {
    return (
      <div className="course-viewer-error">
        <h2>Error Loading Course</h2>
        <p>{error}</p>
        <button onClick={fetchCourseContent} className="retry-button">
          Try Again
        </button>
        <button onClick={onBack} className="back-button">
          Back to Courses
        </button>
      </div>
    );
  }

  if (!course) {
    return (
      <div className="course-not-found">
        <h2>Course Not Found</h2>
        <button onClick={onBack} className="back-button">
          Back to Courses
        </button>
      </div>
    );
  }

  return (
    <div className="course-viewer">
      {/* Header */}
      <div className="course-viewer-header">
        <button onClick={onBack} className="back-button">
          ← Back to Courses
        </button>
        <div className="course-title-section">
          <h1>{course.title}</h1>
          <p className="course-subtitle">{course.description}</p>
        </div>
      </div>

      <div className="course-viewer-content">
        {/* Sidebar Navigation */}
        <div className="course-sidebar">
          <ChapterNavigation
            chapters={chapters}
            currentChapterIndex={currentChapterIndex}
            userProgress={userProgress}
            onChapterSelect={handleChapterChange}
          />
          
          <div className="progress-section">
            <h3>Your Progress</h3>
            <div className="progress-bar">
              <div 
                className="progress-fill" 
                style={{ 
                  width: `${(Object.keys(userProgress).length / chapters.length) * 100}%` 
                }}
              ></div>
            </div>
            <p>{Object.keys(userProgress).length} of {chapters.length} chapters completed</p>
          </div>
        </div>

        {/* Main Content Area */}
        <div className="course-main-content">
          {currentChapter ? (
            <div className="chapter-content">
              <div className="chapter-header">
                <div className="chapter-info">
                  <span className="chapter-number">Chapter {currentChapter.number}</span>
                  <h2 className="chapter-title">{currentChapter.title}</h2>
                </div>
                <div className="chapter-actions">
                  {!userProgress[currentChapter.id]?.completed && (
                    <button 
                      className="mark-complete-btn"
                      onClick={markChapterComplete}
                    >
                      Mark as Complete
                    </button>
                  )}
                  {userProgress[currentChapter.id]?.completed && (
                    <span className="completed-badge">✓ Completed</span>
                  )}
                </div>
              </div>

              <div className="chapter-body">
                {currentChapter.summary && (
                  <div className="chapter-summary">
                    <h3>Overview</h3>
                    <p>{currentChapter.summary}</p>
                  </div>
                )}

                {/* Sample Content - In real implementation, this would come from Resources */}
                <div className="lesson-content">
                  {renderLessonContent(currentChapter, course.title)}
                </div>
              </div>

              {/* Chapter Navigation */}
              <div className="chapter-navigation">
                <button 
                  className="nav-btn prev-btn"
                  onClick={handlePreviousChapter}
                  disabled={currentChapterIndex === 0}
                >
                  ← Previous: {currentChapterIndex > 0 ? chapters[currentChapterIndex - 1].title : ''}
                </button>
                
                <button 
                  className="nav-btn next-btn"
                  onClick={handleNextChapter}
                  disabled={currentChapterIndex === chapters.length - 1}
                >
                  Next: {currentChapterIndex < chapters.length - 1 ? chapters[currentChapterIndex + 1].title : ''}→
                </button>
              </div>
            </div>
          ) : (
            <div className="no-chapters">
              <h2>No content available</h2>
              <p>This course doesn't have any chapters yet.</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// Helper function to render lesson content based on course and chapter
const renderLessonContent = (chapter, courseTitle) => {
  // This is sample content - in a real implementation, you'd fetch this from the Resources table
  if (courseTitle.toLowerCase().includes('javascript')) {
    return renderJavaScriptContent(chapter);
  } else if (courseTitle.toLowerCase().includes('python')) {
    return renderPythonContent(chapter);
  } else {
    return renderGenericContent(chapter);
  }
};

const renderJavaScriptContent = (chapter) => {
  if (chapter.number === 1) {
    return (
      <div className="lesson-sections">
        <section className="lesson-section">
          <h3>JavaScript Variables</h3>
          <p>Variables are containers for storing data values. In JavaScript, you can create variables using <code>var</code>, <code>let</code>, or <code>const</code>.</p>
          
          <div className="example-box">
            <h4>Example</h4>
            <CodeBlock 
              language="javascript"
              code={`// Creating variables
let name = "John";
const age = 30;
var city = "New York";

console.log(name); // Output: John
console.log(age);  // Output: 30
console.log(city); // Output: New York`}
            />
          </div>

          <div className="info-box">
            <h4>💡 Best Practice</h4>
            <p>Use <code>const</code> for values that won't change, <code>let</code> for values that will change, and avoid <code>var</code> in modern JavaScript.</p>
          </div>
        </section>

        <section className="lesson-section">
          <h3>Data Types</h3>
          <p>JavaScript has several data types:</p>
          
          <ul className="data-types-list">
            <li><strong>String:</strong> Text data - <code>"Hello World"</code></li>
            <li><strong>Number:</strong> Numeric data - <code>42</code> or <code>3.14</code></li>
            <li><strong>Boolean:</strong> True or false - <code>true</code> or <code>false</code></li>
            <li><strong>Array:</strong> List of values - <code>[1, 2, 3]</code></li>
            <li><strong>Object:</strong> Key-value pairs - <code>{`{name: "John"}`}</code></li>
          </ul>

          <div className="example-box">
            <h4>Try it yourself</h4>
            <CodeBlock 
              language="javascript"
              code={`// Different data types
let message = "Hello, World!";     // String
let count = 42;                    // Number  
let isActive = true;               // Boolean
let colors = ["red", "green"];     // Array
let person = {                     // Object
  name: "Alice",
  age: 25
};

// Check the type of a variable
console.log(typeof message);  // "string"
console.log(typeof count);    // "number"
console.log(typeof isActive); // "boolean"`}
            />
          </div>
        </section>

        <section className="lesson-section">
          <h3>Interactive Exercise</h3>
          <div className="exercise-box">
            <h4>🏋️ Practice Exercise</h4>
            <p>Create variables for the following:</p>
            <ol>
              <li>Your favorite programming language (string)</li>
              <li>The number of years you've been coding (number)</li>
              <li>Whether you enjoy coding (boolean)</li>
            </ol>
            <p>Then use <code>console.log()</code> to display each variable.</p>
          </div>
        </section>
      </div>
    );
  }

  return renderGenericContent(chapter);
};

const renderPythonContent = (chapter) => {
  if (chapter.number === 1) {
    return (
      <div className="lesson-sections">
        <section className="lesson-section">
          <h3>Python Basics</h3>
          <p>Python is a high-level, interpreted programming language known for its simplicity and readability.</p>
          
          <div className="example-box">
            <h4>Your First Python Program</h4>
            <CodeBlock 
              language="python"
              code={`# This is a comment
print("Hello, World!")

# Variables in Python
name = "Alice"
age = 30
height = 5.6

print(f"My name is {name}")
print(f"I am {age} years old")
print(f"I am {height} feet tall")`}
            />
          </div>
        </section>

        <section className="lesson-section">
          <h3>Python Data Types</h3>
          <p>Python has several built-in data types:</p>
          
          <div className="example-box">
            <h4>Common Data Types</h4>
            <CodeBlock 
              language="python"
              code={`# String
text = "Hello Python"

# Integer
number = 42

# Float
decimal = 3.14

# Boolean
is_python_fun = True

# List
fruits = ["apple", "banana", "cherry"]

# Dictionary
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# Print types
print(type(text))      # <class 'str'>
print(type(number))    # <class 'int'>
print(type(decimal))   # <class 'float'>`}
            />
          </div>
        </section>
      </div>
    );
  }

  return renderGenericContent(chapter);
};

const renderGenericContent = (chapter) => {
  return (
    <div className="lesson-sections">
      <section className="lesson-section">
        <h3>Chapter Content</h3>
        <p>This is the content for <strong>{chapter.title}</strong>.</p>
        
        {chapter.summary && (
          <div className="summary-box">
            <h4>Chapter Summary</h4>
            <p>{chapter.summary}</p>
          </div>
        )}

        <div className="placeholder-content">
          <p>📚 Course content will be loaded from the Resources table in your database.</p>
          <p>This includes:</p>
          <ul>
            <li>📝 Notes and explanations</li>
            <li>💻 Code examples</li>
            <li>📋 Interactive exercises</li>
            <li>🧠 Flashcards for review</li>
            <li>❓ Multiple choice questions</li>
          </ul>
        </div>
      </section>
    </div>
  );
};

export default CourseViewer;
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import ReturnHome from '../components/ReturnHome';
import '../styles/LearnPython.css';

const LearnPython = () => {
  const navigate = useNavigate();
  const [currentSection, setCurrentSection] = useState(0);
  const [progress, setProgress] = useState(0);

  const sections = [
    {
      title: "Introduction to Python",
      content: `
        <h3>What is Python?</h3>
        <p>Python is a high-level, interpreted programming language with dynamic semantics. It's known for its simple, easy-to-learn syntax.</p>
        <h4>Key Features:</h4>
        <ul>
          <li>Easy to read and write</li>
          <li>Dynamically typed</li>
          <li>Interpreted language</li>
          <li>Extensive standard library</li>
          <li>Cross-platform compatibility</li>
        </ul>
      `,
      code: `# This is a Python comment
print("Hello, World!")

# Python is case-sensitive
name = "Python"
print("Welcome to", name, "programming!")

# No semicolons needed at the end of statements
# Indentation matters in Python`
    },
    {
      title: "Variables and Data Types",
      content: `
        <h3>Python Data Types</h3>
        <p>Python has several built-in data types that are commonly used.</p>
        <h4>Basic Data Types:</h4>
        <ul>
          <li><strong>int</strong> - Integer numbers</li>
          <li><strong>float</strong> - Decimal numbers</li>
          <li><strong>str</strong> - Text strings</li>
          <li><strong>bool</strong> - True/False values</li>
          <li><strong>list</strong> - Ordered collections</li>
          <li><strong>dict</strong> - Key-value pairs</li>
        </ul>
      `,
      code: `# Variables and Data Types
name = "Alice"          # String
age = 25               # Integer
height = 5.6           # Float
is_student = True      # Boolean

# Lists (arrays)
fruits = ["apple", "banana", "orange"]
numbers = [1, 2, 3, 4, 5]

# Dictionaries (objects)
person = {
    "name": "Bob",
    "age": 30,
    "city": "New York"
}

# Check data type
print(type(name))      # <class 'str'>
print(type(age))       # <class 'int'>
print(type(fruits))    # <class 'list'>`
    },
    {
      title: "Control Structures",
      content: `
        <h3>If Statements and Loops</h3>
        <p>Control structures allow you to control the flow of your program.</p>
        <h4>Control Flow:</h4>
        <ul>
          <li><strong>if/elif/else</strong> - Conditional execution</li>
          <li><strong>for loops</strong> - Iterate over sequences</li>
          <li><strong>while loops</strong> - Repeat while condition is true</li>
          <li><strong>break/continue</strong> - Control loop execution</li>
        </ul>
      `,
      code: `# If statements
age = 18
if age >= 18:
    print("You are an adult")
elif age >= 13:
    print("You are a teenager")
else:
    print("You are a child")

# For loops
fruits = ["apple", "banana", "orange"]
for fruit in fruits:
    print(f"I like {fruit}")

# Range function
for i in range(5):
    print(f"Number: {i}")

# While loop
count = 0
while count < 3:
    print(f"Count: {count}")
    count += 1`
    },
    {
      title: "Functions",
      content: `
        <h3>Defining Functions</h3>
        <p>Functions are reusable blocks of code that perform specific tasks.</p>
        <h4>Function Features:</h4>
        <ul>
          <li>Defined with <strong>def</strong> keyword</li>
          <li>Can accept parameters</li>
          <li>Can return values</li>
          <li>Support default parameters</li>
          <li>Support keyword arguments</li>
        </ul>
      `,
      code: `# Basic function
def greet(name):
    return f"Hello, {name}!"

# Function with default parameter
def introduce(name, age=25):
    return f"Hi, I'm {name} and I'm {age} years old"

# Function with multiple parameters
def calculate_area(length, width):
    area = length * width
    return area

# Using functions
message = greet("Alice")
print(message)

intro = introduce("Bob")
print(intro)

intro2 = introduce("Carol", 30)
print(intro2)

area = calculate_area(5, 3)
print(f"Area: {area}")`
    },
    {
      title: "Lists and Dictionaries",
      content: `
        <h3>Working with Collections</h3>
        <p>Lists and dictionaries are fundamental data structures in Python.</p>
        <h4>List Operations:</h4>
        <ul>
          <li>append() - Add items</li>
          <li>remove() - Remove items</li>
          <li>len() - Get length</li>
          <li>Indexing with []</li>
        </ul>
        <h4>Dictionary Operations:</h4>
        <ul>
          <li>keys() - Get all keys</li>
          <li>values() - Get all values</li>
          <li>items() - Get key-value pairs</li>
        </ul>
      `,
      code: `# Working with Lists
shopping_list = ["apples", "bread", "milk"]

# Add items
shopping_list.append("eggs")
shopping_list.append("cheese")

# Access items
first_item = shopping_list[0]
print(f"First item: {first_item}")

# Loop through list
for item in shopping_list:
    print(f"Buy: {item}")

# Working with Dictionaries
student = {
    "name": "Emma",
    "grade": "A",
    "subjects": ["Math", "Science", "English"]
}

# Access values
print(f"Student name: {student['name']}")
print(f"Grade: {student['grade']}")

# Add new key-value pair
student["age"] = 16

# Loop through dictionary
for key, value in student.items():
    print(f"{key}: {value}")`
    },
    {
      title: "File Handling and Modules",
      content: `
        <h3>Working with Files and Modules</h3>
        <p>Python makes it easy to work with files and import external modules.</p>
        <h4>File Operations:</h4>
        <ul>
          <li>open() - Open files</li>
          <li>read() - Read content</li>
          <li>write() - Write content</li>
          <li>close() - Close files</li>
        </ul>
        <h4>Popular Modules:</h4>
        <ul>
          <li>math - Mathematical functions</li>
          <li>random - Random numbers</li>
          <li>datetime - Date and time</li>
          <li>os - Operating system interface</li>
        </ul>
      `,
      code: `# File handling
# Writing to a file
with open("example.txt", "w") as file:
    file.write("Hello, Python!")
    file.write("\\nThis is a new line")

# Reading from a file
with open("example.txt", "r") as file:
    content = file.read()
    print(content)

# Using modules
import math
import random
from datetime import datetime

# Math module
print(f"Square root of 16: {math.sqrt(16)}")
print(f"Pi value: {math.pi}")

# Random module
random_number = random.randint(1, 10)
print(f"Random number: {random_number}")

# DateTime module
now = datetime.now()
print(f"Current time: {now}")`
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

  const runCode = () => {
    alert('In a real implementation, this would execute the Python code in a sandbox environment.');
  };

  return (
    <div className="learn-python">
      <ReturnHome />
      
      <div className="learn-container">
        <header className="learn-header">
          <h1>Learn Python</h1>
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
              <div className="code-actions">
                <button onClick={copyCode} className="copy-btn">
                  📋 Copy
                </button>
                <button onClick={runCode} className="run-btn">
                  ▶️ Run Code
                </button>
              </div>
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
            <h3>🐍 Excellent Work!</h3>
            <p>You've completed the Python basics course!</p>
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

export default LearnPython;
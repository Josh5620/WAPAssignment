import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import ReturnHome from '../components/ReturnHome';
import '../styles/LearnJava.css';

const LearnJava = () => {
  const navigate = useNavigate();
  const [currentSection, setCurrentSection] = useState(0);
  const [progress, setProgress] = useState(0);

  const sections = [
    {
      title: "Introduction to Java",
      content: `
        <h3>What is Java?</h3>
        <p>Java is a high-level, object-oriented programming language that is platform-independent. It follows the principle of "Write Once, Run Anywhere" (WORA).</p>
        <h4>Key Features:</h4>
        <ul>
          <li>Object-oriented programming</li>
          <li>Platform independent</li>
          <li>Strongly typed</li>
          <li>Automatic memory management</li>
          <li>Rich standard library</li>
          <li>Multithreading support</li>
        </ul>
      `,
      code: `// This is a single-line comment
/* This is a 
   multi-line comment */

public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        System.out.println("Welcome to Java programming!");
    }
}

// Every Java program starts with the main method
// Java is case-sensitive
// Semicolons are required at the end of statements`
    },
    {
      title: "Variables and Data Types",
      content: `
        <h3>Java Data Types</h3>
        <p>Java has two categories of data types: primitive and reference types.</p>
        <h4>Primitive Data Types:</h4>
        <ul>
          <li><strong>int</strong> - Integer numbers (32-bit)</li>
          <li><strong>double</strong> - Double-precision floating point</li>
          <li><strong>boolean</strong> - true/false values</li>
          <li><strong>char</strong> - Single characters</li>
          <li><strong>long</strong> - Long integers (64-bit)</li>
          <li><strong>float</strong> - Single-precision floating point</li>
        </ul>
        <h4>Reference Types:</h4>
        <ul>
          <li><strong>String</strong> - Text sequences</li>
          <li><strong>Arrays</strong> - Collections of elements</li>
          <li><strong>Objects</strong> - Class instances</li>
        </ul>
      `,
      code: `public class Variables {
    public static void main(String[] args) {
        // Primitive data types
        int age = 25;
        double height = 5.9;
        boolean isStudent = true;
        char grade = 'A';
        long population = 7800000000L;
        float price = 19.99f;
        
        // Reference types
        String name = "Alice";
        String message = "Hello, " + name + "!";
        
        // Arrays
        int[] numbers = {1, 2, 3, 4, 5};
        String[] fruits = {"apple", "banana", "orange"};
        
        // Printing variables
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Height: " + height);
        System.out.println("Is student: " + isStudent);
    }
}`
    },
    {
      title: "Control Structures",
      content: `
        <h3>Conditional Statements and Loops</h3>
        <p>Java provides various control structures to control the flow of program execution.</p>
        <h4>Conditional Statements:</h4>
        <ul>
          <li><strong>if/else if/else</strong> - Conditional execution</li>
          <li><strong>switch</strong> - Multi-way branching</li>
          <li><strong>ternary operator (?:)</strong> - Compact conditional</li>
        </ul>
        <h4>Loops:</h4>
        <ul>
          <li><strong>for</strong> - Counter-controlled loops</li>
          <li><strong>while</strong> - Condition-controlled loops</li>
          <li><strong>do-while</strong> - Post-test loops</li>
          <li><strong>enhanced for</strong> - For collections</li>
        </ul>
      `,
      code: `public class ControlStructures {
    public static void main(String[] args) {
        // If statements
        int score = 85;
        if (score >= 90) {
            System.out.println("Grade: A");
        } else if (score >= 80) {
            System.out.println("Grade: B");
        } else if (score >= 70) {
            System.out.println("Grade: C");
        } else {
            System.out.println("Grade: F");
        }
        
        // Switch statement
        char letterGrade = 'B';
        switch (letterGrade) {
            case 'A':
                System.out.println("Excellent!");
                break;
            case 'B':
                System.out.println("Good job!");
                break;
            case 'C':
                System.out.println("Average");
                break;
            default:
                System.out.println("Keep trying!");
        }
        
        // For loop
        for (int i = 1; i <= 5; i++) {
            System.out.println("Count: " + i);
        }
        
        // Enhanced for loop (for arrays)
        String[] colors = {"red", "green", "blue"};
        for (String color : colors) {
            System.out.println("Color: " + color);
        }
        
        // While loop
        int count = 0;
        while (count < 3) {
            System.out.println("While count: " + count);
            count++;
        }
    }
}`
    },
    {
      title: "Methods (Functions)",
      content: `
        <h3>Creating Methods in Java</h3>
        <p>Methods are blocks of code that perform specific tasks and can be reused throughout the program.</p>
        <h4>Method Components:</h4>
        <ul>
          <li><strong>Access modifier</strong> - public, private, protected</li>
          <li><strong>static keyword</strong> - For class-level methods</li>
          <li><strong>Return type</strong> - Data type returned (or void)</li>
          <li><strong>Method name</strong> - Identifier for the method</li>
          <li><strong>Parameters</strong> - Input values</li>
        </ul>
      `,
      code: `public class Methods {
    // Method with no parameters and void return
    public static void greetUser() {
        System.out.println("Hello, welcome to Java!");
    }
    
    // Method with parameters and return value
    public static String createGreeting(String name, int age) {
        return "Hello, " + name + "! You are " + age + " years old.";
    }
    
    // Method to calculate area
    public static double calculateRectangleArea(double length, double width) {
        return length * width;
    }
    
    // Method with boolean return
    public static boolean isEven(int number) {
        return number % 2 == 0;
    }
    
    // Method overloading - same name, different parameters
    public static double calculateArea(double radius) {
        return Math.PI * radius * radius; // Circle area
    }
    
    public static double calculateArea(double length, double width) {
        return length * width; // Rectangle area
    }
    
    public static void main(String[] args) {
        // Calling methods
        greetUser();
        
        String greeting = createGreeting("Bob", 25);
        System.out.println(greeting);
        
        double area = calculateRectangleArea(5.0, 3.0);
        System.out.println("Rectangle area: " + area);
        
        boolean evenCheck = isEven(10);
        System.out.println("Is 10 even? " + evenCheck);
        
        // Method overloading examples
        double circleArea = calculateArea(5.0);
        double rectArea = calculateArea(4.0, 6.0);
        System.out.println("Circle area: " + circleArea);
        System.out.println("Rectangle area: " + rectArea);
    }
}`
    },
    {
      title: "Arrays and Collections",
      content: `
        <h3>Working with Arrays</h3>
        <p>Arrays are collections of elements of the same data type stored in contiguous memory locations.</p>
        <h4>Array Features:</h4>
        <ul>
          <li>Fixed size once created</li>
          <li>Elements accessed by index (0-based)</li>
          <li>Can be single or multi-dimensional</li>
          <li>length property gives array size</li>
        </ul>
        <h4>Common Array Operations:</h4>
        <ul>
          <li>Declaration and initialization</li>
          <li>Accessing elements</li>
          <li>Iterating through arrays</li>
          <li>Finding length</li>
        </ul>
      `,
      code: `import java.util.Arrays;

public class ArraysExample {
    public static void main(String[] args) {
        // Array declaration and initialization
        int[] numbers = {10, 20, 30, 40, 50};
        String[] names = new String[3];
        names[0] = "Alice";
        names[1] = "Bob";
        names[2] = "Charlie";
        
        // Accessing array elements
        System.out.println("First number: " + numbers[0]);
        System.out.println("Last number: " + numbers[numbers.length - 1]);
        
        // Iterating through arrays
        System.out.println("All numbers:");
        for (int i = 0; i < numbers.length; i++) {
            System.out.println("Index " + i + ": " + numbers[i]);
        }
        
        // Enhanced for loop
        System.out.println("All names:");
        for (String name : names) {
            System.out.println("Name: " + name);
        }
        
        // Array methods
        System.out.println("Numbers array: " + Arrays.toString(numbers));
        
        // Finding maximum value
        int max = numbers[0];
        for (int num : numbers) {
            if (num > max) {
                max = num;
            }
        }
        System.out.println("Maximum value: " + max);
        
        // 2D Array
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        System.out.println("2D Array:");
        for (int row = 0; row < matrix.length; row++) {
            for (int col = 0; col < matrix[row].length; col++) {
                System.out.print(matrix[row][col] + " ");
            }
            System.out.println();
        }
    }
}`
    },
    {
      title: "Object-Oriented Programming Basics",
      content: `
        <h3>Classes and Objects</h3>
        <p>Java is fundamentally an object-oriented language. Everything revolves around classes and objects.</p>
        <h4>OOP Concepts:</h4>
        <ul>
          <li><strong>Class</strong> - Blueprint for creating objects</li>
          <li><strong>Object</strong> - Instance of a class</li>
          <li><strong>Attributes</strong> - Variables in a class</li>
          <li><strong>Methods</strong> - Functions in a class</li>
          <li><strong>Constructor</strong> - Special method for object creation</li>
        </ul>
        <h4>Access Modifiers:</h4>
        <ul>
          <li><strong>public</strong> - Accessible from anywhere</li>
          <li><strong>private</strong> - Only within the same class</li>
          <li><strong>protected</strong> - Within package and subclasses</li>
          <li><strong>default</strong> - Within the same package</li>
        </ul>
      `,
      code: `// Class definition
class Student {
    // Private attributes (encapsulation)
    private String name;
    private int age;
    private double gpa;
    
    // Constructor
    public Student(String name, int age, double gpa) {
        this.name = name;
        this.age = age;
        this.gpa = gpa;
    }
    
    // Getter methods
    public String getName() {
        return name;
    }
    
    public int getAge() {
        return age;
    }
    
    public double getGpa() {
        return gpa;
    }
    
    // Setter methods
    public void setName(String name) {
        this.name = name;
    }
    
    public void setAge(int age) {
        if (age > 0) {
            this.age = age;
        }
    }
    
    public void setGpa(double gpa) {
        if (gpa >= 0.0 && gpa <= 4.0) {
            this.gpa = gpa;
        }
    }
    
    // Method to display student info
    public void displayInfo() {
        System.out.println("Student: " + name);
        System.out.println("Age: " + age);
        System.out.println("GPA: " + gpa);
    }
    
    // Method to check if student is honor roll
    public boolean isHonorRoll() {
        return gpa >= 3.5;
    }
}

public class OOPExample {
    public static void main(String[] args) {
        // Creating objects
        Student student1 = new Student("Alice", 20, 3.8);
        Student student2 = new Student("Bob", 22, 3.2);
        
        // Using object methods
        student1.displayInfo();
        System.out.println("Honor roll: " + student1.isHonorRoll());
        System.out.println();
        
        student2.displayInfo();
        System.out.println("Honor roll: " + student2.isHonorRoll());
        
        // Using setter methods
        student2.setGpa(3.6);
        System.out.println("After GPA update:");
        student2.displayInfo();
        System.out.println("Honor roll: " + student2.isHonorRoll());
    }
}`
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

  const compileCode = () => {
    alert('In a real implementation, this would compile and run the Java code in a sandbox environment.');
  };

  return (
    <div className="learn-java">
      <ReturnHome />
      
      <div className="learn-container">
        <header className="learn-header">
          <h1>Learn Java</h1>
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
                <button onClick={compileCode} className="compile-btn">
                  ⚙️ Compile & Run
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
            <h3>☕ Outstanding Achievement!</h3>
            <p>You've completed the Java basics course!</p>
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

export default LearnJava;
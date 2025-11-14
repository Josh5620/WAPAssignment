
-- Seed for Chapter 1: Basics (Syntax, Variables, Data Types, I/O)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('6726025c-c216-4846-a277-7c4474860331', 'Basics (Syntax, Variables, Data Types, I/O)', N'Python is an interpreted, high-level programming language known for its readability and 
simplicity. Unlike languages such as C or Java, Python relies on indentation (whitespace) to 
define blocks of ...', 1, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 2: Control Flow (if/elif, loops, comprehensions)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('88a180a2-2c08-42a7-a890-1e8747b30031', 'Control Flow (if/elif, loops, comprehensions)', N'Control flow determines how Python executes code based on conditions or repetition. 
Conditional Statements 
• if/elif/else → used for decision making. 
*insert code example below* 
age = 20 
if age >...', 2, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 3: Functions & Modules
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('4a1ba0c6-6dc2-4ca9-8e77-c34ca3ae8f35', 'Functions & Modules', N'Functions let you organise code into reusable blocks, while modules allow you to reuse 
code across programs. 
Defining Functions 
• Use def keyword: 
*insert code example below* 
def greet(name): 
  ...', 3, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 4: Data Structures (Lists, Tuples, Dicts, Sets)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('d03876a5-8c5d-46b4-bdb8-f416f291cae0', 'Data Structures (Lists, Tuples, Dicts, Sets)', N'Data structures are containers that store and organise data. Python provides powerful built-
ins: 
Lists 
• Ordered, mutable sequences. 
• Common operations: 
*insert code example below* 
nums = [1,2,...', 4, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 5: OOP & Exceptions
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('52e3d2b6-b7a2-46a7-9a9c-99e80cef3275', 'OOP & Exceptions', N'Object-Oriented Programming (OOP) in Python helps you model real-world entities using 
classes and objects. Exceptions let you handle errors gracefully. 
Classes & Objects 
• Class → blueprint for obj...', 5, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 6: File Handling and Exceptions
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('32026dab-05cf-411c-8688-9e820d7f81a8', 'File Handling and Exceptions', N'In Python, you can read and write files easily by using the open() function. This allows your 
programs  to  store  information  permanently,  instead  of  losing  data  each  time  the  program 
stop...', 6, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 7: Using Python Libraries (Math, Random, and NumPy)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('8e4fa95b-511c-4ecd-9759-8b60c1dd4c11', 'Using Python Libraries (Math, Random, and NumPy)', N'Python  has  many  built-in  and  external  libraries  that  make  coding  easier  and  more  powerful. 
A library is  a  collection  of  ready-made  functions  and  modules  that  help  you  perform ...', 7, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 8: Advanced Object-Oriented Programming (OOP)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('7e7d010e-97a9-4689-91f2-fc8ed2bbdc31', 'Advanced Object-Oriented Programming (OOP)', N'Object-Oriented  Programming  (OOP)  helps  organize  code  by  grouping  data  and  behaviors 
into reusable structures called classes. 
Objects  are  created  from  these  classes  and  can  interac...', 8, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 9: Working with Data (JSON, CSV, and APIs)
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('6e3d42c0-7adf-4c39-8206-38c4b4dc2e27', 'Working with Data (JSON, CSV, and APIs)', N'Modern  Python  programs  often  need  to store, read,  and exchange data  between  different 
systems or applications. 
The most common formats for this purpose are JSON (JavaScript Object Notation),...', 9, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO

-- Seed for Chapter 10: Graphical User Interface (GUI) and Game Basics using Tkinter and Pygame
INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
VALUES ('b7360b9c-a840-40f9-af2d-40e9e3b14be8', 'Graphical User Interface (GUI) and Game Basics using Tkinter and Pygame', N'Python  is  not  limited  to  text-based  programs — you  can  also  build  visual  applications  and 
games. 
Two popular tools for this are Tkinter, which is used for creating Graphical User Interfa...', 10, '66bb020d-fb25-4841-a3d9-9b837baca542');
GO
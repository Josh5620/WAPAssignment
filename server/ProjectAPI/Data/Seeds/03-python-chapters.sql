
-- Seed for Chapter 1: Basics (Syntax, Variables, Data Types, I/O)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = 'a174faa7-02b8-4d5d-8c98-9ba1cb6a0445')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('a174faa7-02b8-4d5d-8c98-9ba1cb6a0445', 'Basics (Syntax, Variables, Data Types, I/O)', N'Python is an interpreted, high-level programming language known for its readability and 
simplicity. Unlike languages such as C or Java, Python relies on indentation (whitespace) to 
define blocks of code, rather than braces {}. Variables 
• Variables in Python are created when a value is assigned to a name. Key topics include: Type Conversion.', 1, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 2: Control Flow (if/elif, loops, comprehensions)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '4ff8d615-3666-4311-82f9-ee1a0e92a2c9')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('4ff8d615-3666-4311-82f9-ee1a0e92a2c9', 'Control Flow (if/elif, loops, comprehensions)', N'Control flow determines how Python executes code based on conditions or repetition. Conditional Statements 
• if/elif/else → used for decision making. *insert code example below* 
for i in range(3): 
    print(i)   # 0,1,2 
• while loop → continues until condition is False. Key topics include: Conditional Statements, Loop Control Keywords, Truthy and Falsy Values.', 2, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 3: Functions & Modules
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '01f3739c-27ea-4156-9010-b783291a1fa8')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('01f3739c-27ea-4156-9010-b783291a1fa8', 'Functions & Modules', N'Functions let you organise code into reusable blocks, while modules allow you to reuse 
code across programs. Defining Functions 
• Use def keyword: 
*insert code example below* 
def greet(name): 
    return f"Hello, {name}!" 
Parameters & Arguments 
• Positional arguments → passed in order. • **kwargs → packs extra keyword arguments as a dict. Key topics include: Defining Functions, Return Values.', 3, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 4: Data Structures (Lists, Tuples, Dicts, Sets)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = 'dc7ac71b-5111-4e79-a5a0-5f1d4a75985b')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('dc7ac71b-5111-4e79-a5a0-5f1d4a75985b', 'Data Structures (Lists, Tuples, Dicts, Sets)', N'Data structures are containers that store and organise data. Python provides powerful built-
ins: 
Lists 
• Ordered, mutable sequences. *insert code example below* 
point = (3,4) 
print(point[0])   # 3 
Dictionaries 
• Key-value mappings. Key topics include: Dictionaries.', 4, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 5: OOP & Exceptions
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = 'b2ec6ebd-c44c-4f2c-b397-a65240c517b1')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('b2ec6ebd-c44c-4f2c-b397-a65240c517b1', 'OOP & Exceptions', N'Object-Oriented Programming (OOP) in Python helps you model real-world entities using 
classes and objects. Classes & Objects 
• Class → blueprint for objects. • Class methods → take cls, defined with @classmethod. Key topics include: Encapsulation.', 5, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 6: File Handling and Exceptions
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = 'a370e0b9-1d9b-4842-a153-1e4703e4b6a1')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('a370e0b9-1d9b-4842-a153-1e4703e4b6a1', 'File Handling and Exceptions', N'In Python, you can read and write files easily by using the open() function. This allows your 
programs  to  store  information  permanently,  instead  of  losing  data  each  time  the  program 
stops. Exception   handling   helps   you   prevent   your   program   from   crashing   when   an 
unexpected error occurs, such as a missing file or invalid input.', 6, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 7: Using Python Libraries (Math, Random, and NumPy)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '62544299-ee99-4cc1-8c1b-c18b6b7ce52e')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('62544299-ee99-4cc1-8c1b-c18b6b7ce52e', 'Using Python Libraries (Math, Random, and NumPy)', N'Python  has  many  built-in  and  external  libraries  that  make  coding  easier  and  more  powerful. A library is  a  collection  of  ready-made  functions  and  modules  that  help  you  perform  tasks 
without writing all the code yourself. You can import these libraries using the import statement. Key topics include: Using the math Library, Function Description Example, Function Description Example.', 7, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 8: Advanced Object-Oriented Programming (OOP)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '3623e7c0-270e-45e8-949a-ba7c2a50f791')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('3623e7c0-270e-45e8-949a-ba7c2a50f791', 'Advanced Object-Oriented Programming (OOP)', N'Object-Oriented  Programming  (OOP)  helps  organize  code  by  grouping  data  and  behaviors 
into reusable structures called classes. Objects  are  created  from  these  classes  and  can  interact  with  each  other,  just  like  real-world 
entities. In  this  chapter,  we  will  look  deeper  into  advanced  OOP  concepts  such  as inheritance, 
polymorphism, encapsulation, and abstraction.', 8, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 9: Working with Data (JSON, CSV, and APIs)
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '2c5a4390-d024-4291-aa1f-074d1048e5c9')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('2c5a4390-d024-4291-aa1f-074d1048e5c9', 'Working with Data (JSON, CSV, and APIs)', N'Modern  Python  programs  often  need  to store, read,  and exchange data  between  different 
systems or applications. The most common formats for this purpose are JSON (JavaScript Object Notation), CSV 
(Comma-Separated Values), and APIs (Application Programming Interfaces). These  tools  allow  Python  programs  to  communicate  with  files,  databases,  or  web  servers 
efficiently.', 9, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO

-- Seed for Chapter 10: Graphical  User  Interface  (GUI)  and  Game  Basics  using  Tkinter  and Pygame
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE ChapterId = '88e2d775-9a23-4616-b76c-8a5a8925af82')
BEGIN
    INSERT INTO Chapters (ChapterId, Title, Summary, Number, CourseId)
    VALUES ('88e2d775-9a23-4616-b76c-8a5a8925af82', 'Graphical  User  Interface  (GUI)  and  Game  Basics  using  Tkinter  and Pygame', N'Python  is  not  limited  to  text-based  programs — you  can  also  build  visual  applications  and 
games. Two popular tools for this are Tkinter, which is used for creating Graphical User Interfaces 
(GUIs), and Pygame, which is used for making simple 2D games. Introduction to GUI 
A Graphical User Interface (GUI) allows users to interact with programs using buttons, text 
boxes, menus, and other visual elements instead of typing commands.', 10, '6a4c772d-a5d8-406c-8154-548e06da11e9');
END
GO
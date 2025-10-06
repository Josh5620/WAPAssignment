IF NOT EXISTS (SELECT 1 FROM Courses WHERE Title = 'Java')
INSERT INTO Courses (Id, Title, Description, PreviewContent, Published)
VALUES (NEWID(), 'Java', 'Auto-generated description', 'Preview: Intro to Java', 1);


-- Chapter 1
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Java');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 1, 'Basics (Syntax, Variables, Data Types, I/O)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Basics (Syntax, Variables, Data Types, I/O)\nFull Notes\nJava is a compiled, strongly typed, object-oriented language widely used for application\ndevelopment.\nStructure of a Java Program\n• Every program must have a class.\n• The entry point is public static void main(String[] args).\n*insert code example below*\npublic class HelloWorld {\npublic static void main(String[] args) {\nSystem.out.println("Hello, World!");\n}\n}\nVariables\n• Must be declared with type before use.\n*insert code example below*\nint age = 20;\ndouble pi = 3.14;\nString name = "Ali";\nData Types\n• Primitive types: int, double, char, boolean, byte, short, long, float.\n• Reference types: String, arrays, objects.\nOperators\n• Arithmetic: + - * / %\n• Comparison: == != > < >= <=\n• Logical: && || !\nInput & Output\n• Output: System.out.println("text").\n• Input: use Scanner class.\n*insert code example below*\nimport java.util.Scanner;\nScanner sc = new Scanner(System.in);\nint x = sc.nextInt();\nComments\n• Single-line: //\n• Multi-line: /* ... */\n• Documentation: /** ... */\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Basics (Syntax, Variables, Data Types, I/O)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What does JVM stand for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What does JVM stand for?', 'Java Virtual Machine\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What does JDK stand for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What does JDK stand for?', 'Java Development Kit\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What does JRE stand for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What does JRE stand for?', 'Java Runtime Environment\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which method is the entry point of a Java program?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which method is the entry point of a Java program?', 'public static void main(String[] args)\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which symbol ends a Java statement?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which symbol ends a Java statement?', 'Semicolon ;\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is the file extension of a compiled Java class?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is the file extension of a compiled Java class?', '.class\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which command compiles Java source code?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which command compiles Java source code?', 'javac\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which command runs compiled Java code?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which command runs compiled Java code?', 'java\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is the default value of an uninitialized int in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is the default value of an uninitialized int in Java?', '0\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Can Java run on any platform?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Can Java run on any platform?', 'Yes, because of JVM (platform-independent)\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Basics (Syntax, Variables, Data Types, I/O)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method is the entry point in Java?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method is the entry point in Java?', 'easy', 'It must be public static void main.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method is the entry point in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='main()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'main()', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method is the entry point in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='start()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'start()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method is the entry point in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='run()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'run()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method is the entry point in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='init()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'init()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a primitive type?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is a primitive type?', 'easy', 'Lowercase keywords are primitives.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a primitive type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='String')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'String', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a primitive type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Array')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Array', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a primitive type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a primitive type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Object', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the correct way to print in Java?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is the correct way to print in Java?', 'easy', 'Uses System.out.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the correct way to print in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print("hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print("hi")', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the correct way to print in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='System.print("hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'System.print("hi")', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the correct way to print in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='System.out.println("hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'System.out.println("hi")', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the correct way to print in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='echo("hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'echo("hi")', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What symbol begins a single-line comment?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What symbol begins a single-line comment?', 'easy', 'Like C/C++.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What symbol begins a single-line comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='#')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '#', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What symbol begins a single-line comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='//')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '//', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What symbol begins a single-line comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<!-- -->')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<!-- -->', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What symbol begins a single-line comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='--')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '--', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator checks equality?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which operator checks equality?', 'easy', '= assigns, == compares.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator checks equality?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='=')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '=', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator checks equality?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='==')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '==', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator checks equality?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='equals')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'equals', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator checks equality?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='===')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '===', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does this code output?', 'easy', 'int/int = int division.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2.5')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2.5', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to define a class?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used to define a class?', 'easy', 'Always lowercase.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to define a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'object', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to define a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to define a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='struct')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'struct', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to define a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='define')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'define', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which package contains Scanner?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which package contains Scanner?', 'easy', 'Think “utilities”.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which package contains Scanner?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='java.io')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'java.io', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which package contains Scanner?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='java.util')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'java.util', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which package contains Scanner?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='java.lang')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'java.lang', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which package contains Scanner?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='java.scanner')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'java.scanner', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will happen?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will happen?', 'easy', 'Logical NOT inverts.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will happen?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='true')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'true', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will happen?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='false')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'false', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will happen?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='1')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '1', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will happen?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid variable name?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is valid variable name?', 'easy', 'Cannot start with digit or keyword.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid variable name?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='1name')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '1name', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid variable name?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='my-age')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'my-age', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid variable name?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='_score')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '_score', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid variable name?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct to read an int using Scanner sc?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct to read an int using Scanner sc?', 'easy', 'nextInt() method.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct to read an int using Scanner sc?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='sc.readInt()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'sc.readInt()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct to read an int using Scanner sc?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='sc.inputInt()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'sc.inputInt()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct to read an int using Scanner sc?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='sc.nextInt()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'sc.nextInt()', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct to read an int using Scanner sc?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='sc.getInt()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'sc.getInt()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', '+ with string = concatenation.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='10')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '10', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='55')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '55', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='5')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '5', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which primitive type uses least memory?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which primitive type uses least memory?', 'easy', '8 bits only.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which primitive type uses least memory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='byte')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'byte', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which primitive type uses least memory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='short')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'short', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which primitive type uses least memory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which primitive type uses least memory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='long')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'long', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the default value of a boolean variable (class member)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is the default value of a boolean variable (class member)?', 'easy', 'false by default.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the default value of a boolean variable (class member)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='true')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'true', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the default value of a boolean variable (class member)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='false')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'false', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the default value of a boolean variable (class member)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the default value of a boolean variable (class member)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='null')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'null', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator is used for modulus?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which operator is used for modulus?', 'easy', 'Remainder operator.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator is used for modulus?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='%')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '%', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator is used for modulus?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='mod')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'mod', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator is used for modulus?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='/')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '/', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator is used for modulus?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='//')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '//', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', '+= adds to variable.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='5')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '5', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='8')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '8', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which statement is correct?', 'easy', 'Compiled to bytecode, interpreted by JVM.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Java is compiled and interpreted.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Java is compiled and interpreted.', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Java is only interpreted.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Java is only interpreted.', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Java is only compiled.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Java is only compiled.', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Java is not portable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Java is not portable.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which type can store 10.5?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which type can store 10.5?', 'easy', 'Decimal values.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which type can store 10.5?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which type can store 10.5?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='double')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'double', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which type can store 10.5?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='boolean')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'boolean', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which type can store 10.5?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='char')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'char', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allocates memory for an object?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword allocates memory for an object?', 'easy', 'Java’s object creator.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allocates memory for an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allocates memory for an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alloc')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alloc', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allocates memory for an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allocates memory for an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='malloc')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'malloc', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT a Java feature?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is NOT a Java feature?', 'easy', 'Java avoids multiple class inheritance.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT a Java feature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Platform independence')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Platform independence', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT a Java feature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Garbage collection')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Garbage collection', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT a Java feature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Multiple inheritance (classes)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Multiple inheritance (classes)', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT a Java feature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Object-oriented')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Object-oriented', 0);


-- Chapter 2
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Java');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Control Flow (if/else, loops, switch)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 2, 'Control Flow (if/else, loops, switch)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/else, loops, switch)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Control Flow (if/else, loops, switch)\nFull Notes\nControl flow statements in Java decide which code executes and how often.\nIf/Else\n• Basic decision making:\n*insert code example below*\nint age = 18;\nif (age >= 18) {\nSystem.out.println("Adult");\n} else {\nSystem.out.println("Minor");\n}\n• else if for multiple conditions.\nLoops\n• for loop → known iterations.\n*insert code example below*\nfor (int i = 0; i < 5; i++) {\nSystem.out.println(i);\n}\n• while loop → runs while condition is true.\n*insert code example below*\nint x = 0;\nwhile (x < 3) {\nSystem.out.println(x);\nx++;\n}\n• do-while loop → runs at least once.\n*insert code example below*\nint y = 0;\ndo {\nSystem.out.println(y);\ny++;\n} while (y < 3);\nSwitch\n• Multi-branch selection.\n*insert code example below*\nint day = 2;\nswitch(day) {\ncase 1: System.out.println("Mon"); break;\ncase 2: System.out.println("Tue"); break;\ndefault: System.out.println("Other");\n}\nJump Statements\n• break → exits loop/switch.\n• continue → skips current iteration.\n• return → exits method.\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/else, loops, switch)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Control Flow (if/else, loops, switch)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword starts a conditional block in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword starts a conditional block in Java?', 'if\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword provides an alternative condition?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword provides an alternative condition?', 'else if\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used when all other conditions fail?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used when all other conditions fail?', 'else\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used for multiple fixed choices?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used for multiple fixed choices?', 'switch\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword defines cases inside a switch?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword defines cases inside a switch?', 'case\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword exits a loop or switch immediately?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword exits a loop or switch immediately?', 'break\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword skips to the next loop iteration?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword skips to the next loop iteration?', 'continue\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which loop runs at least once even if the condition is false?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which loop runs at least once even if the condition is false?', 'do-while\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which loop is typically used with an index counter?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which loop is typically used with an index counter?', 'for loop\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which loop is used to iterate directly over arrays or collections?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which loop is used to iterate directly over arrays or collections?', 'Enhanced for loop (for-each)\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/else, loops, switch)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Control Flow (if/else, loops, switch)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop executes at least once?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which loop executes at least once?', 'easy', 'Condition checked after execution.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop executes at least once?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop executes at least once?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop executes at least once?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='do-while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'do-while', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop executes at least once?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What keyword exits a loop?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What keyword exits a loop?', 'easy', 'Same as in Python.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What keyword exits a loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='exit')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'exit', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What keyword exits a loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='stop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'stop', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What keyword exits a loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What keyword exits a loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='end')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'end', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true for while loop?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is true for while loop?', 'easy', 'Pre-check loop.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true for while loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Condition checked before running')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Condition checked before running', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true for while loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs at least once')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs at least once', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true for while loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Always infinite')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Always infinite', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true for while loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Cannot use break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Cannot use break', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be printed?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will be printed?', 'easy', 'No spaces.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be printed?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0 1 2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0 1 2', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be printed?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='012')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '012', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be printed?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='123')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '123', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be printed?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used in switch for unmatched cases?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used in switch for unmatched cases?', 'easy', 'Acts like else.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used in switch for unmatched cases?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='null')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'null', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used in switch for unmatched cases?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='default')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'default', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used in switch for unmatched cases?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='else')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'else', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used in switch for unmatched cases?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will be output?', 'easy', 'Iterates i=0,');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='01')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '01', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='012')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '012', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Infinite loop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Infinite loop', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for array iteration in Java?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which loop is best for array iteration in Java?', 'easy', 'Index controlled loop.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for array iteration in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for array iteration in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for array iteration in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='do-while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'do-while', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for array iteration in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='goto')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'goto', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is missing?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is missing?', 'easy', 'Without it, fall-through occurs.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='default')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'default', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='else')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'else', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='stop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'stop', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator combines conditions in if?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which operator combines conditions in if?', 'easy', 'Logical AND.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator combines conditions in if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='=')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '=', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator combines conditions in if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='==')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '==', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator combines conditions in if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='&&')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '&&', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operator combines conditions in if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct?', 'easy', '== compares.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if(x=5)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if(x=5)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if(x==5)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if(x==5)', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if(x===5)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if(x===5)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if(x->5)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if(x->5)', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop may never execute?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which loop may never execute?', 'easy', 'do-while always runs once.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop may never execute?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop may never execute?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop may never execute?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='do-while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'do-while', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop may never execute?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='All except do-while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'All except do-while', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Skips when i=');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 012')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 012', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 012');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='02')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '02', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 012');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='1')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '1', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 012');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0 1 2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0 1 2', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about switch?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is TRUE about switch?', 'easy', 'Strings supported since Java');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) Only works on int')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) Only works on int', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) Only works on int');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Works on int, char, String (Java 7+)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Works on int, char, String (Java 7+)', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) Only works on int');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Works on float')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Works on float', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) Only works on int');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Works on arrays')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Works on arrays', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does this output?', 'easy', 'Runs for i=0,');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='01')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '01', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='012')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '012', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Infinite')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Infinite', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can cause infinite loop?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these can cause infinite loop?', 'easy', 'All valid infinite loops.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can cause infinite loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for(;;)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for(;;)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can cause infinite loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while(true)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while(true)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can cause infinite loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='do{ }while(true);')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'do{ }while(true);', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can cause infinite loop?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='All of these')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'All of these', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which breaks out of switch after case match?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which breaks out of switch after case match?', 'easy', 'Prevents fall-through.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which breaks out of switch after case match?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='exit')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'exit', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which breaks out of switch after case match?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='stop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'stop', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which breaks out of switch after case match?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which breaks out of switch after case match?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='return only')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'return only', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will NOT compile?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which will NOT compile?', 'easy', 'While(false) is unreachable.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will NOT compile?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if(true){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if(true){}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will NOT compile?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while(false){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while(false){}', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will NOT compile?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for(;;){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for(;;){}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will NOT compile?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='switch(5){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'switch(5){}', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'Nested loops produce pairs.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='11 12 21 22 31 32')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '11 12 21 22 31 32', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='12 23 34')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '12 23 34', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='11 21 31 12 22 32')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '11 21 31 12 22 32', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword exits a method immediately?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword exits a method immediately?', 'easy', 'Ends the method.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword exits a method immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='stop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'stop', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword exits a method immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='exit')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'exit', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword exits a method immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='return')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'return', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword exits a method immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use else-if ladder instead of multiple if?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use else-if ladder instead of multiple if?', 'easy', 'Avoids unnecessary checks.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use else-if ladder instead of multiple if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Saves memory')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Saves memory', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use else-if ladder instead of multiple if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Improves readability & performance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Improves readability & performance', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use else-if ladder instead of multiple if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Java requirement')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Java requirement', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use else-if ladder instead of multiple if?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Avoids compilation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Avoids compilation', 0);


-- Chapter 3
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Java');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Methods & Classes' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 3, 'Methods & Classes', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Methods & Classes' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Methods & Classes\nFull Notes\nIn Java, code is organised into classes (blueprints) and methods (actions/behaviours).\nClasses\n• Define a class using the class keyword.\n*insert code example below*\npublic class Car {\nString brand;\nint speed;\n}\n• A class groups fields (variables) and methods (functions).\nMethods\n• Defined inside a class.\n• Syntax:\n*insert code example below*\nreturnType methodName(parameters) {\n// body\nreturn value;\n}\nExample:\n*insert code example below*\npublic int square(int x) {\nreturn x * x;\n}\nMain Method\n• Program entry point:\n*insert code example below*\npublic static void main(String[] args) { }\nStatic vs Instance Methods\n• Instance method → requires object.\n*insert code example below*\nCar c = new Car();\n• Static method → called on class directly.\n*insert code example below*\nMath.sqrt(16);\nConstructors\n• Special method with same name as class.\n• Initializes objects.\n*insert code example below*\npublic class Car {\nString brand;\nCar(String b) {\nbrand = b;\n}\n}\nMethod Overloading\n• Same method name, different parameter list.\n*insert code example below*\nint add(int a, int b) { return a+b; }\ndouble add(double a, double b) { return a+b; }\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Methods & Classes' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Methods & Classes');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What does OOP stand for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What does OOP stand for?', 'Object-Oriented Programming\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword is used to define a class in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword is used to define a class in Java?', 'class\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you create an object from a class?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you create an object from a class?', 'Using the new keyword\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is a constructor?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is a constructor?', 'A special method used to initialize objects\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword refers to the current object?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword refers to the current object?', 'this\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which access modifier makes members visible only inside the class?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which access modifier makes members visible only inside the class?', 'private\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used for inheritance in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used for inheritance in Java?', 'extends\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used to achieve polymorphism through interfaces?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used to achieve polymorphism through interfaces?', 'implements\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is method overloading?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is method overloading?', 'Defining multiple methods with the same name but different parameters\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is method overriding?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is method overriding?', 'Redefining a parent class method in a subclass\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Methods & Classes' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Methods & Classes');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword defines a class?', 'easy', 'Same as Python but uppercase reserved words.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='def')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'def', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'object', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is required name of entry method in Java?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is required name of entry method in Java?', 'easy', 'Always public static void main.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is required name of entry method in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='run()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'run()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is required name of entry method in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='init()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'init()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is required name of entry method in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='main()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'main()', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is required name of entry method in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='start()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'start()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'sqrt = square root.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='9')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '9', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='81')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '81', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method type is called without object?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method type is called without object?', 'easy', 'Belongs to class.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method type is called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Instance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Instance', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method type is called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Static')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Static', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method type is called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Constructor')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Constructor', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method type is called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstract')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstract', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which special method constructs objects?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which special method constructs objects?', 'easy', 'Same name as class.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which special method constructs objects?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='init')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'init', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which special method constructs objects?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='build()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'build()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which special method constructs objects?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='constructor')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'constructor', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which special method constructs objects?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ClassName()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ClassName()', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about constructors?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is TRUE about constructors?', 'easy', 'Identical to class name.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about constructors?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Return type must be void')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Return type must be void', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about constructors?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Must match class name')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Must match class name', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about constructors?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can be called without new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can be called without new', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about constructors?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can have multiple names')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can have multiple names', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword creates an object?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword creates an object?', 'easy', '');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword creates an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'object', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword creates an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword creates an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alloc')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alloc', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword creates an object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'Constructor prints.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Nothing')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Nothing', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hi')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hi', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method overloading?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is method overloading?', 'easy', 'Overloading changes parameter list.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Methods with same name, same params')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Methods with same name, same params', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Methods with same name, different params')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Methods with same name, different params', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Methods with different name, same params')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Methods with different name, same params', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct method definition?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct method definition?', 'easy', 'Must declare return type before name.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct method definition?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='method int add(a,b){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'method int add(a,b){}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct method definition?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int add(int a,int b){ return a+b; }')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int add(int a,int b){ return a+b; }', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct method definition?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='function add(int a,int b){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'function add(int a,int b){}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct method definition?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(int a,int b){}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(int a,int b){}', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier lets method be called without object?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which modifier lets method be called without object?', 'easy', 'Belongs to class.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier lets method be called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='public')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'public', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier lets method be called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='static')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'static', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier lets method be called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='private')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'private', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier lets method be called without object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='abstract')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'abstract', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output for the following block of codes?', 'easy', 'Constructor assigns value.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='null')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'null', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='BMW')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'BMW', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='brand')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'brand', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is invalid method overloading?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is invalid method overloading?', 'easy', 'Must differ in parameters.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is invalid method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(int a,int b)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(int a,int b)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is invalid method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(double a,double b)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(double a,double b)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is invalid method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(int a,int b,int c)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(int a,int b,int c)', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is invalid method overloading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(int x,int y) again')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(int x,int y) again', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if constructor is missing?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if constructor is missing?', 'easy', 'Java provides default.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if constructor is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if constructor is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Default constructor used')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Default constructor used', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if constructor is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No object can be made')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No object can be made', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if constructor is missing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='JVM stops')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'JVM stops', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to call parent class constructor?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used to call parent class constructor?', 'easy', '“super” goes up hierarchy.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to call parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='parent')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'parent', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to call parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='super')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'super', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to call parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='base')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'base', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to call parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='this')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'this', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output for the following block of codes?', 'easy', 'Double overload chosen.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='9')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '9', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='9.0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '9.0', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output for the following block of codes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which variable belongs to all objects of a class (shared)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which variable belongs to all objects of a class (shared)?', 'easy', 'static fields are shared.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which variable belongs to all objects of a class (shared)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='instance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'instance', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which variable belongs to all objects of a class (shared)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='local')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'local', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which variable belongs to all objects of a class (shared)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='static')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'static', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which variable belongs to all objects of a class (shared)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='final')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'final', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s TRUE about this keyword?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s TRUE about this keyword?', 'easy', 'Points to current object.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s TRUE about this keyword?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to class', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s TRUE about this keyword?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to current object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to current object', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s TRUE about this keyword?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to parent')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to parent', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s TRUE about this keyword?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to method')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to method', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method signature?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is method signature?', 'easy', 'Return type not included.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method signature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Method name only')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Method name only', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method signature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Method name + parameter list')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Method name + parameter list', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method signature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Return type only')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Return type only', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is method signature?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Class name + method')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Class name + method', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use method overloading?\')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use method overloading?\', 'easy', 'Improves readability.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use method overloading?\');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To confuse compiler')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To confuse compiler', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use method overloading?\');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To reuse method name for different params')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To reuse method name for different params', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use method overloading?\');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To slow execution')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To slow execution', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use method overloading?\');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To avoid using constructors')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To avoid using constructors', 0);


-- Chapter 4
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Java');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 4, 'Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)\nFull Notes\nJava is a pure OOP language (except primitives) that focuses on modelling real-world\nentities.\nEncapsulation\n• Binding data (fields) and methods (behaviour) inside a class.\n• Access controlled with access modifiers:\no public → accessible everywhere\no private → accessible only inside class\no protected → accessible in same package + subclasses\no default (no modifier) → package-private\n*insert code example below*\npublic class Student {\nprivate String name; // encapsulated field\npublic void setName(String n) { name = n; }\npublic String getName() { return name; }\n}\nInheritance\n• Mechanism of reusing code by creating a new class from an existing one.\n• Keyword: extends\n*insert code example below*\nclass Animal {\nvoid speak(){ System.out.println("Generic sound"); }\n}\nclass Dog extends Animal {\nvoid speak(){ System.out.println("Woof!"); }\n}\nPolymorphism\n• Ability of same method name to act differently.\n• Compile-time polymorphism → Method Overloading.\n• Runtime polymorphism → Method Overriding.\n*insert code example below*\nAnimal a = new Dog();\na.speak(); // Woof!\nAbstraction\n• Hiding implementation, showing only essentials.\n• Achieved using abstract classes and interfaces.\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword makes a class that cannot be instantiated?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword makes a class that cannot be instantiated?', 'abstract\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword makes a method that must be implemented by subclasses?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword makes a method that must be implemented by subclasses?', 'abstract\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Can abstract classes have constructors?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Can abstract classes have constructors?', 'Yes\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword makes a class that cannot be extended?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword makes a class that cannot be extended?', 'final\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword prevents a method from being overridden?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword prevents a method from being overridden?', 'final\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword is used to define an interface?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword is used to define an interface?', 'interface\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Can interfaces have method implementations (Java 8+)?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Can interfaces have method implementations (Java 8+)?', 'Yes, using default or static methods\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What access modifier do interface methods have by default?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What access modifier do interface methods have by default?', 'public abstract\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Can a class implement multiple interfaces?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Can a class implement multiple interfaces?', 'Yes\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is multiple inheritance in Java achieved through?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is multiple inheritance in Java achieved through?', 'Interfaces\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Object-Oriented Programming (Encapsulation, Inheritance, Polymorphism)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used for inheritance?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used for inheritance?', 'easy', 'Java inheritance keyword.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used for inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='implements')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'implements', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used for inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='extends')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'extends', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used for inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='inherits')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'inherits', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used for inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='super')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'super', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier hides data from outside?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which modifier hides data from outside?', 'easy', 'Encapsulation principle.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier hides data from outside?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='public')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'public', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier hides data from outside?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='private')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'private', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier hides data from outside?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='protected')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'protected', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which modifier hides data from outside?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='static')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'static', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is an example of runtime polymorphism?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is an example of runtime polymorphism?', 'easy', 'Happens when subclass overrides method.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is an example of runtime polymorphism?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Overloading')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Overloading', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is an example of runtime polymorphism?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Overriding')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Overriding', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is an example of runtime polymorphism?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Casting')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Casting', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is an example of runtime polymorphism?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='final methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'final methods', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword calls parent class constructor?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword calls parent class constructor?', 'easy', 'Always first statement in constructor.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword calls parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='super')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'super', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword calls parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='this')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'this', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword calls parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='parent')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'parent', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword calls parent class constructor?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='base')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'base', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about interfaces?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is TRUE about interfaces?', 'easy', 'Java allows multiple interface inheritance.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can’t contain methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can’t contain methods', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Support multiple inheritance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Support multiple inheritance', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Are instantiated directly')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Are instantiated directly', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Same as abstract class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Same as abstract class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output?', 'easy', 'Method overriding → runtime polymorphism.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'B', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='AB')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'AB', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access modifier gives package-private?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which access modifier gives package-private?', 'easy', 'Default in Java.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access modifier gives package-private?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='public')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'public', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access modifier gives package-private?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='private')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'private', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access modifier gives package-private?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='protected')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'protected', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access modifier gives package-private?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='no modifier')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'no modifier', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept ensures “data hiding”?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which concept ensures “data hiding”?', 'easy', 'Private fields with getters/setters.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept ensures “data hiding”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstraction')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstraction', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept ensures “data hiding”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Polymorphism')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Polymorphism', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept ensures “data hiding”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Encapsulation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Encapsulation', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept ensures “data hiding”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Inheritance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Inheritance', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword prevents overriding?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword prevents overriding?', 'easy', 'final = unchangeable.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword prevents overriding?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='final')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'final', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword prevents overriding?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='static')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'static', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword prevents overriding?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='super')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'super', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword prevents overriding?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='protected')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'protected', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which can Java NOT inherit?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which can Java NOT inherit?', 'easy', 'No multiple class inheritance.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which can Java NOT inherit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Interfaces')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Interfaces', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which can Java NOT inherit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstract classes')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstract classes', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which can Java NOT inherit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Multiple classes')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Multiple classes', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which can Java NOT inherit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Single class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Single class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid abstract class declaration?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is valid abstract class declaration?', 'easy', 'abstract before class keyword.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid abstract class declaration?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='abstract class A {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'abstract class A {}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid abstract class declaration?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='public abstract class A {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'public abstract class A {}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid abstract class declaration?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class abstract A {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class abstract A {}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid abstract class declaration?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Both A and B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Both A and B', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept is shown here?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which concept is shown here?', 'easy', 'Same method, different class.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept is shown here?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Overloading')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Overloading', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept is shown here?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Overriding')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Overriding', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept is shown here?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Encapsulation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Encapsulation', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which concept is shown here?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstraction')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstraction', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'Runtime polymorphism.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='P')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'P', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='C')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'C', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='PC')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'PC', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about abstract classes?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is true about abstract classes?', 'easy', 'You can’t directly create object.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about abstract classes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can’t have concrete methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can’t have concrete methods', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about abstract classes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can’t have constructors')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can’t have constructors', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about abstract classes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can’t be instantiated')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can’t be instantiated', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about abstract classes?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Must have only abstract methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Must have only abstract methods', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is multiple inheritance by interfaces?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is multiple inheritance by interfaces?', 'easy', 'Only interfaces support multiple.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is multiple inheritance by interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class A implements B, C {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class A implements B, C {}', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is multiple inheritance by interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class A extends B, C {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class A extends B, C {}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is multiple inheritance by interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class A implements B extends C {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class A implements B extends C {}', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is multiple inheritance by interfaces?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class A extends B implements C, D {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class A extends B implements C, D {}', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access level is widest?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which access level is widest?', 'easy', 'Public is open everywhere.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access level is widest?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='private')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'private', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access level is widest?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='default')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'default', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access level is widest?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='protected')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'protected', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which access level is widest?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='public')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'public', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures abstraction 100%?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which ensures abstraction 100%?', 'easy', 'Interface only has method signatures.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures abstraction 100%?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstract class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstract class', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures abstraction 100%?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Interface')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Interface', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures abstraction 100%?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Protected methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Protected methods', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures abstraction 100%?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Final class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Final class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if child doesn’t override abstract method?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if child doesn’t override abstract method?', 'easy', 'Must override or declare abstract.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if child doesn’t override abstract method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Compiles fine')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Compiles fine', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if child doesn’t override abstract method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if child doesn’t override abstract method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Becomes abstract itself')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Becomes abstract itself', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if child doesn’t override abstract method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Ignores method')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Ignores method', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which allows method in subclass to call overridden parent method?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which allows method in subclass to call overridden parent method?', 'easy', 'super calls parent.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which allows method in subclass to call overridden parent method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='this.method()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'this.method()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which allows method in subclass to call overridden parent method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='parent.method()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'parent.method()', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which allows method in subclass to call overridden parent method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='super.method()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'super.method()', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which allows method in subclass to call overridden parent method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='base.method()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'base.method()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why avoid multiple inheritance of classes in Java?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why avoid multiple inheritance of classes in Java?', 'easy', 'To avoid conflicting methods.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why avoid multiple inheritance of classes in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Slower performance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Slower performance', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why avoid multiple inheritance of classes in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Ambiguity (Diamond problem)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Ambiguity (Diamond problem)', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why avoid multiple inheritance of classes in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='JVM restriction only')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'JVM restriction only', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why avoid multiple inheritance of classes in Java?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Syntax limitation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Syntax limitation', 0);


-- Chapter 5
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Java');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Exceptions & File Handling' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 5, 'Exceptions & File Handling', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Exceptions & File Handling' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Exceptions & File Handling\nFull Notes\nExceptions in Java\n• Exception → abnormal condition disrupting program flow.\n• Types:\no Checked exceptions → must be handled (e.g., IOException).\no Unchecked exceptions → Runtime errors (e.g., NullPointerException).\nTry-Catch-Finally\n*insert code example below*\ntry {\nint x = 10/0;\n} catch (ArithmeticException e) {\nSystem.out.println("Cannot divide by zero!");\n} finally {\nSystem.out.println("Done.");\n}\n• try → risky code.\n• catch → handles error.\n• finally → always executes.\nThrowing Exceptions\n• throw → to raise an exception.\nthrow new IllegalArgumentException("Invalid input");\n• throws → declares method may throw exception.\npublic void readFile() throws IOException { }\nFile Handling\n• Import java.io.*.\n• Reading with FileReader + BufferedReader:\n*insert code example below*\nimport java.io.*;\nBufferedReader br = new BufferedReader(new\nFileReader("data.txt"));\nString line = br.readLine();\nbr.close();\n• Writing with FileWriter:\n*insert code example below*\nFileWriter fw = new FileWriter("out.txt");\nfw.write("Hello File");\nfw.close();\nTry-with-Resources (Java 7+)\n• Automatically closes resources.\n*insert code example below*\ntry (BufferedReader br = new BufferedReader(new\nFileReader("data.txt"))) {\nSystem.out.println(br.readLine());\n}\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Exceptions & File Handling' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Exceptions & File Handling');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used to handle exceptions?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used to handle exceptions?', 'try\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which block catches the exception?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which block catches the exception?', 'catch\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which block always executes, whether an exception occurs or not?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which block always executes, whether an exception occurs or not?', 'finally\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword is used to throw an exception?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword is used to throw an exception?', 'throw\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword declares that a method may throw exceptions?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword declares that a method may throw exceptions?', 'throws\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is the parent class of all exceptions in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is the parent class of all exceptions in Java?', 'Throwable\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which class is the parent of all checked exceptions?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which class is the parent of all checked exceptions?', 'Exception\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which class is the parent of unchecked exceptions?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which class is the parent of unchecked exceptions?', 'RuntimeException\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which package contains classes for file handling in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which package contains classes for file handling in Java?', 'java.io\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which classes are commonly used for reading files in Java?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which classes are commonly used for reading files in Java?', 'FileReader, BufferedReader\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Exceptions & File Handling' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Exceptions & File Handling');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to handle exceptions?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used to handle exceptions?', 'easy', 'It “catches” the error.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to handle exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='try')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'try', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to handle exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to handle exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='catch')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'catch', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used to handle exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is unchecked?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which exception is unchecked?', 'easy', 'Runtime exception.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is unchecked?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='IOException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'IOException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is unchecked?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='SQLException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'SQLException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is unchecked?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='NullPointerException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'NullPointerException', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is unchecked?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileNotFoundException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileNotFoundException', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does finally block do?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does finally block do?', 'easy', 'Always executes.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does finally block do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs only if exception occurs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs only if exception occurs', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does finally block do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs always')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs always', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does finally block do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs never')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs never', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does finally block do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs only at start')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs only at start', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword declares exceptions in a method?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword declares exceptions in a method?', 'easy', 'At method signature.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword declares exceptions in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword declares exceptions in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throws')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throws', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword declares exceptions in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword declares exceptions in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='catch')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'catch', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which class is used to read text files line by line?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which class is used to read text files line by line?', 'easy', 'Efficient reader wrapper.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which class is used to read text files line by line?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileInputStream')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileInputStream', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which class is used to read text files line by line?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='BufferedReader')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'BufferedReader', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which class is used to read text files line by line?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Scanner')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Scanner', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which class is used to read text files line by line?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='PrintWriter')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'PrintWriter', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'Catch handles division by zero.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='5/0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '5/0', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArithmeticException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArithmeticException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Err')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Err', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error at compile')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error at compile', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which statement is correct?', 'easy', 'throw = action, throws = declaration.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw and throws are same')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw and throws are same', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw raises exception, throws declares it')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw raises exception, throws declares it', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throws raises exception, throw declares it')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throws raises exception, throw declares it', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Neither is used in Java')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Neither is used in Java', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a checked exception?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is a checked exception?', 'easy', 'Must handle at compile time.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a checked exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='IOException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'IOException', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a checked exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='NullPointerException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'NullPointerException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a checked exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArithmeticException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArithmeticException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a checked exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArrayIndexOutOfBoundsException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArrayIndexOutOfBoundsException', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures resources close automatically?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which ensures resources close automatically?', 'easy', '');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures resources close automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='try-catch')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'try-catch', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures resources close automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='try-with-resources')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'try-with-resources', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures resources close automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='finally')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'finally', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures resources close automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='auto-close()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'auto-close()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which writes to a file?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which writes to a file?', 'easy', '“Writer” outputs.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which writes to a file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileWriter')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileWriter', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which writes to a file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileReader')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileReader', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which writes to a file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='BufferedReader')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'BufferedReader', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which writes to a file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Scanner')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Scanner', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which base class do all exceptions extend?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which base class do all exceptions extend?', 'easy', 'Root of error/exception hierarchy.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which base class do all exceptions extend?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which base class do all exceptions extend?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Throwable')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Throwable', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which base class do all exceptions extend?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Exception')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Exception', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which base class do all exceptions extend?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='RuntimeException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'RuntimeException', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which happens if exception not caught?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which happens if exception not caught?', 'easy', 'Unhandled → crash.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which happens if exception not caught?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='JVM terminates program')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'JVM terminates program', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which happens if exception not caught?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Program continues')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Program continues', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which happens if exception not caught?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Compiler fixes automatically')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Compiler fixes automatically', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which happens if exception not caught?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Ignores error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Ignores error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used inside catch block to rethrow exception?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is used inside catch block to rethrow exception?', 'easy', 'throw = action.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used inside catch block to rethrow exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='raise')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'raise', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used inside catch block to rethrow exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used inside catch block to rethrow exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throws')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throws', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is used inside catch block to rethrow exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT true about finally?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is NOT true about finally?', 'easy', 'Runs always unless forced exit.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT true about finally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs even after return')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs even after return', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT true about finally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs always')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs always', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT true about finally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='May not run if JVM exits')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'May not run if JVM exits', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT true about finally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs only when exception occurs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs only when exception occurs', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'finally executes even after return.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='AB')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'AB', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'B', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception occurs when accessing array index beyond limit?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which exception occurs when accessing array index beyond limit?', 'easy', 'Self-descriptive.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception occurs when accessing array index beyond limit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArrayIndexOutOfBoundsException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArrayIndexOutOfBoundsException', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception occurs when accessing array index beyond limit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='NullPointerException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'NullPointerException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception occurs when accessing array index beyond limit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='IOException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'IOException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception occurs when accessing array index beyond limit?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArithmeticException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArithmeticException', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is mandatory with switch-case in file handling exception?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword is mandatory with switch-case in file handling exception?', 'easy', 'Trick — switch doesn’t relate to exceptions.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is mandatory with switch-case in file handling exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is mandatory with switch-case in file handling exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='case')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'case', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is mandatory with switch-case in file handling exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='catch')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'catch', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword is mandatory with switch-case in file handling exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which file handling class is buffered (fast)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which file handling class is buffered (fast)?', 'easy', 'Buffer speeds up reading.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which file handling class is buffered (fast)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileReader')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileReader', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which file handling class is buffered (fast)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='BufferedReader')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'BufferedReader', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which file handling class is buffered (fast)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileWriter')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileWriter', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which file handling class is buffered (fast)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileInputStream')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileInputStream', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer try-with-resources?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why prefer try-with-resources?', 'easy', 'Auto-close feature.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer try-with-resources?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Saves memory')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Saves memory', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer try-with-resources?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Closes resources automatically')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Closes resources automatically', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer try-with-resources?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs faster')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs faster', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer try-with-resources?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Handles all exceptions')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Handles all exceptions', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is thrown if file not found?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which exception is thrown if file not found?', 'easy', 'Special case of IOException.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is thrown if file not found?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='IOException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'IOException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is thrown if file not found?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='NullPointerException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'NullPointerException', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is thrown if file not found?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FileNotFoundException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FileNotFoundException', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which exception is thrown if file not found?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ArithmeticException')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ArithmeticException', 0);
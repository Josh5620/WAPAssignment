IF NOT EXISTS (SELECT 1 FROM Courses WHERE Title = 'Python')
INSERT INTO Courses (Id, Title, Description, PreviewContent, Published)
VALUES (NEWID(), 'Python', 'Auto-generated description', 'Preview: Intro to Python', 1);


-- Chapter 1
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Python');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 1, 'Basics (Syntax, Variables, Data Types, I/O)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Basics (Syntax, Variables, Data Types, I/O)\nFull Notes\nPython is an interpreted, high-level programming language known for its readability and\nsimplicity. Unlike languages such as C or Java, Python relies on indentation (whitespace) to\ndefine blocks of code, rather than braces {}.\nVariables\n• Variables in Python are created when a value is assigned to a name.\n• Python is dynamically typed, meaning you don’t declare a variable type in advance.\n*insert code example below*\nx = 5 # int\ny = 3.14 # float\nname = "Ali" # string\nData Types\n• int → whole numbers (e.g., 10, -3)\n• float → decimal numbers (e.g., 3.14, -2.5)\n• str → text (e.g., "hello")\n• bool → logical values True / False\n• NoneType → absence of a value (None)\n*insert code example below*\na = True\nb = None\nprint(type(a), type(b)) # <class ''bool''> <class ''NoneType''>\nInput & Output\n• input() → reads input as a string.\n• print() → displays output; supports arguments like sep and end.\n*insert code example below*\nname = input("Enter your name: ")\nprint("Hello,", name)\nType Conversion\nConvert between types using constructors:\n*insert code example below*\nage = int("20") # string → int\npi = float("3.14") # string → float\ns = str(42) # int → string\nStrings & Slicing\n• Strings are sequences → can be indexed and sliced.\n• Negative indexing allows access from the end.\n*insert code example below*\ns = "Python"\nprint(s[0]) # P\nprint(s[-1]) # n\nprint(s[1:4]) # yth\nComments\n• Single-line: # comment\n• Multi-line: triple quotes """ comment """\n');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Basics (Syntax, Variables, Data Types, I/O)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What defines a block of code in Python?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What defines a block of code in Python?', 'Indentation\n', 1);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What type of typing does Python use?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What type of typing does Python use?', 'Dynamic typing\n', 2);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What type does input() return?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What type does input() return?', 'String (str)\n', 3);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which function displays output?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which function displays output?', 'print()\n', 4);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you convert a float to an integer?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you convert a float to an integer?', 'int(', 5);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which symbol starts a single-line comment?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which symbol starts a single-line comment?', '#\n', 6);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you access the last element of a string?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you access the last element of a string?', 'Negative indexing (s[-1])\n', 7);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is slicing syntax in Python?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is slicing syntax in Python?', 's[start:stop:step]\n', 8);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword represents “no value”?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword represents “no value”?', 'None\n', 9);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which string formatting method uses {} placeholders?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which string formatting method uses {} placeholders?', 'f-strings (f"Hello {name}")\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Syntax, Variables, Data Types, I/O)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Basics (Syntax, Variables, Data Types, I/O)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following defines a block of code in Python?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following defines a block of code in Python?', 'easy', 'Python avoids {} unlike Java/C.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following defines a block of code in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Braces {}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Braces {}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following defines a block of code in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Indentation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Indentation', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following defines a block of code in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Semicolons')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Semicolons', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following defines a block of code in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Parentheses')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Parentheses', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default type of value returned by input()?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the default type of value returned by input()?', 'easy', 'You must convert input into int/float if needed.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default type of value returned by input()?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default type of value returned by input()?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='float')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'float', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default type of value returned by input()?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default type of value returned by input()?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='bool')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'bool', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following represents a NoneType object?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following represents a NoneType object?', 'easy', 'It means “no value”.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following represents a NoneType object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following represents a NoneType object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='""')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '""', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following represents a NoneType object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following represents a NoneType object?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='False')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'False', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will print("Hi", "Ali", sep="-") output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will print("Hi", "Ali", sep="-") output?', 'easy', 'sep decides separator between arguments.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will print("Hi", "Ali", sep="-") output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hi Ali')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hi Ali', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will print("Hi", "Ali", sep="-") output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='HiAli')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'HiAli', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will print("Hi", "Ali", sep="-") output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hi-Ali')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hi-Ali', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will print("Hi", "Ali", sep="-") output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which symbol is used for a single-line comment in Python?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which symbol is used for a single-line comment in Python?', 'easy', 'Similar to shell scripts.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which symbol is used for a single-line comment in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='//')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '//', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which symbol is used for a single-line comment in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<!-- -->')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<!-- -->', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which symbol is used for a single-line comment in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='#')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '#', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which symbol is used for a single-line comment in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='--')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '--', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output of:')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output of:', 'easy', 'Start index is inclusive, end index is exclusive.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output of:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Pyt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Pyt', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output of:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='tho')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'tho', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output of:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='yth')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'yth', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output of:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='hon')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'hon', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function converts "3.14" to a float?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which function converts "3.14" to a float?', 'easy', 'Use correct constructor.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function converts "3.14" to a float?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function converts "3.14" to a float?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function converts "3.14" to a float?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='float()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'float()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function converts "3.14" to a float?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='eval()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'eval()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following is falsy in Python?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following is falsy in Python?', 'easy', 'Empty containers are falsy.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following is falsy in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,2,3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,2,3]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following is falsy in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='""')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '""', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following is falsy in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"False"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"False"', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following is falsy in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='10')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '10', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you run:')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if you run:', 'easy', 'int() can’t parse decimals with dots.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you run:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Returns 3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Returns 3', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you run:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Returns 3.0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Returns 3.0', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you run:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you run:');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a correct f-string usage?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is a correct f-string usage?', 'easy', 'Must start with f and curly braces.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a correct f-string usage?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print("Age is {age}")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print("Age is {age}")', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a correct f-string usage?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print(f"Age is {age}")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print(f"Age is {age}")', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a correct f-string usage?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print(f''Age is age'')')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print(f''Age is age'')', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a correct f-string usage?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print(f(Age is age))')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print(f(Age is age))', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following shows dynamic typing?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following shows dynamic typing?', 'easy', 'Must start with f and curly braces.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following shows dynamic typing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int x = 10')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int x = 10', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following shows dynamic typing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='x = 10; x = "hello"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'x = 10; x = "hello"', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following shows dynamic typing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='float y = 5.6')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'float y = 5.6', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following shows dynamic typing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='def func(): pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'def func(): pass', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output?', 'easy', 'end replaces newline.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A B C *')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A B C *', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A B C*')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A B C*', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='ABC*')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'ABC*', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A-B-C*')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A-B-C*', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following does NOT create a new string "abc"?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following does NOT create a new string "abc"?', 'easy', 'slicing entire string may reuse the object.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following does NOT create a new string "abc"?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"abc"[0:3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"abc"[0:3]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following does NOT create a new string "abc"?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"a" + "b" + "c"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"a" + "b" + "c"', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following does NOT create a new string "abc"?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"abc".strip()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"abc".strip()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following does NOT create a new string "abc"?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str("abc")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str("abc")', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function shows the exact representation of an object (useful for debugging)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which function shows the exact representation of an object (useful for debugging)?', 'easy', 'Think developer view, not user view.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function shows the exact representation of an object (useful for debugging)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function shows the exact representation of an object (useful for debugging)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='repr()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'repr()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function shows the exact representation of an object (useful for debugging)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which function shows the exact representation of an object (useful for debugging)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='debug()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'debug()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT immutable?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is NOT immutable?', 'easy', 'lists can be modified in place.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT immutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT immutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT immutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='float')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'float', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT immutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be the result?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will be the result?', 'easy', 'Negative index starts from the end.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be the result?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='py')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'py', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be the result?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='on')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'on', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be the result?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='th')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'th', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will be the result?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='no')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'no', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes whitespace from both ends of a string?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method removes whitespace from both ends of a string?', 'easy', 'Think of peeling outer layers.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes whitespace from both ends of a string?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='cut()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'cut()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes whitespace from both ends of a string?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='trim()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'trim()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes whitespace from both ends of a string?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='strip()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'strip()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes whitespace from both ends of a string?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='clean()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'clean()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you try to convert float("ten")?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if you try to convert float("ten")?', 'easy', 'Only numeric strings can be cast.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you try to convert float("ten")?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='10.0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '10.0', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you try to convert float("ten")?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you try to convert float("ten")?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you try to convert float("ten")?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='NaN')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'NaN', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following correctly swaps two variables a and b?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of the following correctly swaps two variables a and b?', 'easy', 'Python supports tuple unpacking.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following correctly swaps two variables a and b?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='a = b; b = a')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'a = b; b = a', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following correctly swaps two variables a and b?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='a, b = b, a')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'a, b = b, a', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following correctly swaps two variables a and b?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='swap(a,b)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'swap(a,b)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of the following correctly swaps two variables a and b?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='temp = a; b = a; a = b')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'temp = a; b = a; a = b', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is print("Hello", end="") useful?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why is print("Hello", end="") useful?', 'easy', 'end defines what happens after output.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is print("Hello", end="") useful?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It skips spaces')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It skips spaces', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is print("Hello", end="") useful?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It prevents newlines')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It prevents newlines', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is print("Hello", end="") useful?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It adds commas')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It adds commas', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is print("Hello", end="") useful?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It repeats output')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It repeats output', 0);


-- Chapter 2
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Python');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Control Flow (if/elif, loops, comprehensions)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 2, 'Control Flow (if/elif, loops, comprehensions)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/elif, loops, comprehensions)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Control Flow (if/elif, loops, comprehensions)\nFull Notes\nControl flow determines how Python executes code based on conditions or repetition.\nConditional Statements\n• if/elif/else → used for decision making.\n*insert code example below*\nage = 20\nif age >= 18:\nprint("Adult")\nelif age >= 13:\nprint("Teen")\nelse:\nprint("Child")\nLoops\n• for loop → iterates over iterables (lists, strings, dicts).\n*insert code example below*\nfor i in range(3):\nprint(i) # 0,1,2\n• while loop → continues until condition is False.\n*insert code example below*\nn = 3\nwhile n > 0:\nprint(n)\nn -= 1\nLoop Control Keywords\n• break → exit loop early.\n• continue → skip current iteration.\n• pass → placeholder, does nothing.\nTruthy and Falsy Values\n• Falsy: 0, "", None, [], {}, set().\n• Truthy: most non-empty values.\nComprehensions\n• Short syntax for building lists, sets, or dicts.\n*insert code example below*\nnums = [1,2,3,4,5]\nsquares = [n*n for n in nums if n % 2 == 0]\nprint(squares) # [4, 16]\n');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/elif, loops, comprehensions)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Control Flow (if/elif, loops, comprehensions)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword starts a conditional block?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword starts a conditional block?', 'if\n', 1);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword provides an alternative condition?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword provides an alternative condition?', 'elif\n', 2);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword is used when all other conditions fail?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword is used when all other conditions fail?', 'else\n', 3);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What operator checks equality?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What operator checks equality?', '==\n', 4);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword starts a while loop?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword starts a while loop?', 'while\n', 5);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword starts a for loop?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword starts a for loop?', 'for\n', 6);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What function generates a sequence of numbers for loops?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What function generates a sequence of numbers for loops?', 'range()\n', 7);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword stops a loop immediately?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword stops a loop immediately?', 'break\n', 8);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword skips to the next loop iteration?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword skips to the next loop iteration?', 'continue\n', 9);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword defines a placeholder loop with no action?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword defines a placeholder loop with no action?', 'pass\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Control Flow (if/elif, loops, comprehensions)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Control Flow (if/elif, loops, comprehensions)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword ends a loop immediately?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword ends a loop immediately?', 'easy', 'Think of “breaking out”.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword ends a loop immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='stop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'stop', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword ends a loop immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword ends a loop immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='exit')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'exit', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword ends a loop immediately?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='continue')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'continue', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is falsy?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is falsy?', 'easy', 'Empty containers are always False.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is falsy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='" "')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '" "', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is falsy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is falsy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[0]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[0]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is falsy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"False"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"False"', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does pass do?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does pass do?', 'easy', 'It’s like leaving a blank statement.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does pass do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Skips a loop iteration')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Skips a loop iteration', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does pass do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Placeholder (does nothing)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Placeholder (does nothing)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does pass do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Exits the program')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Exits the program', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does pass do?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Returns from a function')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Returns from a function', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for iterating through a list?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which loop is best for iterating through a list?', 'easy', 'Directly goes through elements.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for iterating through a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for iterating through a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='repeat')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'repeat', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for iterating through a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which loop is best for iterating through a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='goto')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'goto', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the output?', 'easy', 'Range(2) → 0 and 1 → 2 iterations.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hi')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hi', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='HiHi')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'HiHi', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hi (printed twice)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hi (printed twice)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will this code output?', 'easy', 'Loop stops when x=');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='4')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '4', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement skips the rest of a loop’s body but keeps looping?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which statement skips the rest of a loop’s body but keeps looping?', 'easy', 'It “continues” to the next round.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement skips the rest of a loop’s body but keeps looping?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='break')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'break', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement skips the rest of a loop’s body but keeps looping?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='continue')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'continue', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement skips the rest of a loop’s body but keeps looping?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pass', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement skips the rest of a loop’s body but keeps looping?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='skip')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'skip', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension creates a list of even numbers up to 10?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which comprehension creates a list of even numbers up to 10?', 'easy', 'Square brackets → list comprehension.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension creates a list of even numbers up to 10?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[n for n in range(11) if n % 2 == 0]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[n for n in range(11) if n % 2 == 0]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension creates a list of even numbers up to 10?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{n for n in range(11) if n % 2 == 0}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{n for n in range(11) if n % 2 == 0}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension creates a list of even numbers up to 10?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(n for n in range(11) if n % 2 == 0)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(n for n in range(11) if n % 2 == 0)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension creates a list of even numbers up to 10?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='n for n in range(11) if n % 2 == 0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'n for n in range(11) if n % 2 == 0', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT valid?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is NOT valid?', 'easy', 'Missing colon.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='if condition: print("Hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'if condition: print("Hi")', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for i in [1,2,3]: print(i)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for i in [1,2,3]: print(i)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while True print("Hi")')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while True print("Hi")', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is NOT valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pass', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output of:')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output of:', 'easy', 'continue skips printing when i=');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0 1 2', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0 2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0 2', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='1 2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '1 2', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code print?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will this code print?', 'easy', 'Outer 3 × Inner 2 = 6 pairs.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3 pairs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3 pairs', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='5 pairs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '5 pairs', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='6 pairs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '6 pairs', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='9 pairs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '9 pairs', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these correctly builds a dict mapping numbers to their squares (1–5)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these correctly builds a dict mapping numbers to their squares (1–5)?', 'easy', 'Dict → curly braces with key:value.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these correctly builds a dict mapping numbers to their squares (1–5)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{n:n**2 for n in range(1,6)}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{n:n**2 for n in range(1,6)}', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these correctly builds a dict mapping numbers to their squares (1–5)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[n:n**2 for n in range(1,6)]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[n:n**2 for n in range(1,6)]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these correctly builds a dict mapping numbers to their squares (1–5)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{n,n**2 for n in range(1,6)}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{n,n**2 for n in range(1,6)}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these correctly builds a dict mapping numbers to their squares (1–5)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(n:n**2 for n in range(1,6))')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(n:n**2 for n in range(1,6))', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Only values greater than');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) [1,2]')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) [1,2]', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) [1,2]');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[3,4]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[3,4]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) [1,2]');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[2,3,4]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[2,3,4]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) [1,2]');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which while loop will run forever?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which while loop will run forever?', 'easy', '1 is truthy forever.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which while loop will run forever?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while False:')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while False:', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which while loop will run forever?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while 0:')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while 0:', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which while loop will run forever?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while "":')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while "":', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which while loop will run forever?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='while 1:')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'while 1:', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these statements is TRUE about comprehensions?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these statements is TRUE about comprehensions?', 'easy', 'They’re concise but not universal.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these statements is TRUE about comprehensions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They are always faster.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They are always faster.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these statements is TRUE about comprehensions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They can replace any loop.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They can replace any loop.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these statements is TRUE about comprehensions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They create new collections concisely.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They create new collections concisely.', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these statements is TRUE about comprehensions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They cannot use conditions.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They cannot use conditions.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will this output?', 'easy', 'Last value of i =');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allows you to handle a “not found” case after loop completion?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword allows you to handle a “not found” case after loop completion?', 'easy', 'for/while can have an else clause.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allows you to handle a “not found” case after loop completion?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='except')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'except', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allows you to handle a “not found” case after loop completion?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='else (with loop)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'else (with loop)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allows you to handle a “not found” case after loop completion?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='finally')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'finally', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword allows you to handle a “not found” case after loop completion?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pass', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'i increases by 2 → 0 then');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) 0 1 2', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0 2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0 2', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0 2 4')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0 2 4', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) 0 1 2');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Infinite loop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Infinite loop', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension flattens a 2D list [[1,2],[3,4]]?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which comprehension flattens a 2D list [[1,2],[3,4]]?', 'easy', 'Double for → flatten.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension flattens a 2D list [[1,2],[3,4]]?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[x for row in lst for x in row]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[x for row in lst for x in row]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension flattens a 2D list [[1,2],[3,4]]?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[row for x in lst for row in x]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[row for x in lst for row in x]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension flattens a 2D list [[1,2],[3,4]]?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{x for row in lst for x in row}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{x for row in lst for x in row}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which comprehension flattens a 2D list [[1,2],[3,4]]?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='x for row in lst for x in row')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'x for row in lst for x in row', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why should complex comprehensions sometimes be avoided?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why should complex comprehensions sometimes be avoided?', 'easy', 'Too complex = hard to read.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why should complex comprehensions sometimes be avoided?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They are slow')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They are slow', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why should complex comprehensions sometimes be avoided?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They are unreadable')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They are unreadable', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why should complex comprehensions sometimes be avoided?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They don’t exist')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They don’t exist', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why should complex comprehensions sometimes be avoided?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They cause errors')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They cause errors', 0);


-- Chapter 3
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Python');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Functions & Modules' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 3, 'Functions & Modules', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Functions & Modules' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Functions & Modules\nFull Notes\nFunctions let you organise code into reusable blocks, while modules allow you to reuse\ncode across programs.\nDefining Functions\n• Use def keyword:\n*insert code example below*\ndef greet(name):\nreturn f"Hello, {name}!"\nParameters & Arguments\n• Positional arguments → passed in order.\n• Keyword arguments → passed by name.\n• Default values → used when not provided.\n*insert code example below*\ndef area_circle(r, pi=3.14):\nreturn pi * r * r\nprint(area_circle(2)) # 12.56\nprint(area_circle(2, 3.14159)) # 12.56636\n• *args → packs extra positional arguments as a tuple.\n• **kwargs → packs extra keyword arguments as a dict.\n*insert code example below*\ndef demo(*args, **kwargs):\nprint(args, kwargs)\ndemo(1,2,3, a=10, b=20)\nReturn Values\n• Functions may return single or multiple values.\n*insert code example below*\ndef swap(a, b):\nreturn b, a\nx, y = swap(1,2) # x=2, y=1\nScope\n• Local: inside function.\n• Global: outside any function.\n• Use global keyword to modify global variables (not recommended often).\nDocstrings\n• Triple quotes after def describe the function.\n• Accessible via help(function).\nModules\n• A Python file (.py) containing code.\n• Importing:\n*insert code example below*\nimport math\nprint(math.sqrt(16))\n• Aliases: import math as m.\n• Selective import: from math import sqrt.\nVirtual Environments & pip\n• Virtual environment → isolated Python environment for projects.\n• pip installs packages:\n*insert code example below*\npip install requests\n');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Functions & Modules' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Functions & Modules');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword defines a function?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword defines a function?', 'def\n', 1);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you call a function named greet?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you call a function named greet?', 'greet()\n', 2);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What keyword is used to return a value from a function?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What keyword is used to return a value from a function?', 'return\n', 3);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is a parameter?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is a parameter?', 'A variable defined inside the function header\n', 4);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What is an argument?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What is an argument?', 'The actual value passed to a function\n', 5);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What are default parameters?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What are default parameters?', 'Parameters with preset values (def func(x=10))\n', 6);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What type of scope do variables inside functions have?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What type of scope do variables inside functions have?', 'Local scope\n', 7);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you define an anonymous function?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you define an anonymous function?', 'Using lambda\n', 8);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What are docstrings used for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What are docstrings used for?', 'Documenting functions ("""description""")\n', 9);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Can a function return multiple values in Python?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Can a function return multiple values in Python?', 'Yes, as a tuple\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Functions & Modules' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Functions & Modules');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a function?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword defines a function?', 'easy', 'Short for define.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='func')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'func', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='def')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'def', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='function')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'function', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='define')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'define', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default return value of a function without return?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is the default return value of a function without return?', 'easy', 'No return → None.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default return value of a function without return?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default return value of a function without return?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default return value of a function without return?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='False')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'False', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is the default return value of a function without return?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='“”')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '“”', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will this output?', 'easy', 'Uses default argument.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='5')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '5', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='"5"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '"5"', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which collects extra positional arguments?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which collects extra positional arguments?', 'easy', 'Star collects extras.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which collects extra positional arguments?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='args')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'args', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which collects extra positional arguments?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='*args')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '*args', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which collects extra positional arguments?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='**kwargs')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '**kwargs', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which collects extra positional arguments?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which library is built-in?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which library is built-in?', 'easy', 'Comes with Python by default.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which library is built-in?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='numpy')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'numpy', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which library is built-in?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='requests')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'requests', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which library is built-in?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='math')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'math', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which library is built-in?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pandas')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pandas', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Values swapped.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='3 4')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '3 4', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='4 3')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '4 3', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(4,3)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(4,3)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement about global is TRUE?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which statement about global is TRUE?', 'easy', 'Accesses outer scope variable.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement about global is TRUE?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It creates a new variable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It creates a new variable.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement about global is TRUE?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It modifies a variable outside the function.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It modifies a variable outside the function.', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement about global is TRUE?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It deletes a variable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It deletes a variable.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement about global is TRUE?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It copies a variable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It copies a variable.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which docstring format is correct?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which docstring format is correct?', 'easy', 'Triple quotes.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which docstring format is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='“comment”')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '“comment”', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which docstring format is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='# docstring')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '# docstring', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which docstring format is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='“""This is a docstring."""')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '“""This is a docstring."""', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which docstring format is correct?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='/* docstring */')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '/* docstring */', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these imports sqrt only?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these imports sqrt only?', 'easy', 'from module import function.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these imports sqrt only?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='import math.sqrt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'import math.sqrt', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these imports sqrt only?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='from math import sqrt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'from math import sqrt', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these imports sqrt only?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='import sqrt from math')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'import sqrt from math', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these imports sqrt only?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='math sqrt()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'math sqrt()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command installs a package?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which command installs a package?', 'easy', 'pip is Python installer.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command installs a package?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='install pkg')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'install pkg', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command installs a package?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pip install pkg')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pip install pkg', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command installs a package?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='py install pkg')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'py install pkg', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command installs a package?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='python get pkg')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'python get pkg', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these returns multiple values?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these returns multiple values?', 'easy', 'Tuples, lists, or multiple items all work.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these returns multiple values?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='return 1,2')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'return 1,2', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these returns multiple values?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='return [1,2]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'return [1,2]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these returns multiple values?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='return (1,2)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'return (1,2)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these returns multiple values?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='All of the above')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'All of the above', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a higher-order function?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is a higher-order function?', 'easy', '“Higher” = takes/returns functions.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a higher-order function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Function returning another function.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Function returning another function.', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a higher-order function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Function without return.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Function without return.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a higher-order function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Function with default parameter.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Function with default parameter.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a higher-order function?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Function with print only.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Function with print only.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword argument call is valid?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword argument call is valid?', 'easy', 'Both positional and keyword allowed.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword argument call is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(3,2)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(3,2)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword argument call is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(y=2,x=3)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(y=2,x=3)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword argument call is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='add(3,y=2)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'add(3,y=2)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword argument call is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='All of these')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'All of these', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is dangerous as a default parameter?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is dangerous as a default parameter?', 'easy', 'Mutable defaults can change unexpectedly');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is dangerous as a default parameter?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is dangerous as a default parameter?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is dangerous as a default parameter?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is dangerous as a default parameter?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a module alias import?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is a module alias import?', 'easy', 'as creates alias.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a module alias import?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='import math as m')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'import math as m', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a module alias import?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='import m = math')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'import m = math', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a module alias import?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='math = import m')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'math = import m', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is a module alias import?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alias math as m')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alias math as m', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you call help(function_name)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if you call help(function_name)?', 'easy', 'Used for documentation.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you call help(function_name)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Runs the function.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Runs the function.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you call help(function_name)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Prints docstring.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Prints docstring.', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you call help(function_name)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Deletes function.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Deletes function.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if you call help(function_name)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Nothing.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Nothing.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command creates a virtual environment (modern)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which command creates a virtual environment (modern)?', 'easy', 'venv is built-in.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command creates a virtual environment (modern)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='python -m venv env')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'python -m venv env', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command creates a virtual environment (modern)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pip create env')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pip create env', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command creates a virtual environment (modern)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='venv install env')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'venv install env', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which command creates a virtual environment (modern)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='py env create')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'py env create', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which scope does Python check first?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which scope does Python check first?', 'easy', 'Follows LEGB rule.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which scope does Python check first?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Global')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Global', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which scope does Python check first?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Built-in')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Built-in', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which scope does Python check first?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Local')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Local', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which scope does Python check first?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Module')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Module', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which rule defines variable resolution order?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which rule defines variable resolution order?', 'easy', 'Classic rule in Python.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which rule defines variable resolution order?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FIFO')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FIFO', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which rule defines variable resolution order?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='LIFO')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'LIFO', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which rule defines variable resolution order?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='LEGB (Local, Enclosing, Global, Built-in)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'LEGB (Local, Enclosing, Global, Built-in)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which rule defines variable resolution order?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use modules?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use modules?', 'easy', 'Reuse & structure code.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use modules?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Avoids reusing code')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Avoids reusing code', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use modules?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Organises and reuses functions')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Organises and reuses functions', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use modules?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Slows execution')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Slows execution', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use modules?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Creates errors')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Creates errors', 0);


-- Chapter 4
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Python');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Data Structures (Lists, Tuples, Dicts, Sets)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 4, 'Data Structures (Lists, Tuples, Dicts, Sets)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Data Structures (Lists, Tuples, Dicts, Sets)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Data Structures (Lists, Tuples, Dicts, Sets)\nFull Notes\nData structures are containers that store and organise data. Python provides powerful built-\nins:\nLists\n• Ordered, mutable sequences.\n• Common operations:\n*insert code example below*\nnums = [1,2,3]\nnums.append(4) # [1,2,3,4]\nnums.pop() # [1,2,3]\nnums.sort() # in-place\nTuples\n• Ordered, immutable sequences.\n• Used for fixed data or as keys in dictionaries.\n*insert code example below*\npoint = (3,4)\nprint(point[0]) # 3\nDictionaries\n• Key-value mappings.\n• Fast lookups.\n*insert code example below*\nages = {"Ali":20, "Bala":22}\nprint(ages["Ali"]) # 20\nprint(ages.get("Chong",0)) # safe access\nSets\n• Unordered collection of unique elements.\n*insert code example below*\nletters = set("balloon")\nprint(letters) # {''b'',''a'',''l'',''o'',''n''}\n• Operations: union (|), intersection (&), difference (-).\nCopying\n• list(a) / a[:] → shallow copy.\n• copy.deepcopy() → deep copy (nested structures).\n');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Data Structures (Lists, Tuples, Dicts, Sets)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Data Structures (Lists, Tuples, Dicts, Sets)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you create a list in Python?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you create a list in Python?', 'With square brackets []\n', 1);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Are lists mutable or immutable?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Are lists mutable or immutable?', 'Mutable\n', 2);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you create a tuple?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you create a tuple?', 'With parentheses ()\n', 3);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Are tuples mutable or immutable?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Are tuples mutable or immutable?', 'Immutable\n', 4);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you create a set?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you create a set?', 'With curly braces {} or set()\n', 5);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Do sets allow duplicate values?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Do sets allow duplicate values?', 'No\n', 6);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you create a dictionary?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you create a dictionary?', 'With {key: value} pairs\n', 7);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which method gets all keys of a dictionary?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which method gets all keys of a dictionary?', '.keys()\n', 8);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which method removes and returns the last list item?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which method removes and returns the last list item?', '.pop()\n', 9);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which data structure is best for key-value storage?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which data structure is best for key-value storage?', 'Dictionary\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Data Structures (Lists, Tuples, Dicts, Sets)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Data Structures (Lists, Tuples, Dicts, Sets)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is mutable?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is mutable?', 'easy', 'You can append/remove.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is mutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='tuple')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'tuple', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is mutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is mutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is mutable?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='int')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'int', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='How do you access the 2nd element in nums=[10,20,30]?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'How do you access the 2nd element in nums=[10,20,30]?', 'easy', 'Indexing starts at');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) nums(2)')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) nums(2)', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) nums(2)');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums{1}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums{1}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) nums(2)');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[1]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[1]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) nums(2)');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[2]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[2]', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which removes duplicates from a list?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which removes duplicates from a list?', 'easy', 'Sets only keep unique.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which removes duplicates from a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='tuple(list)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'tuple(list)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which removes duplicates from a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='set(list)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'set(list)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which removes duplicates from a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='dict(list)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'dict(list)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which removes duplicates from a list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list.remove()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list.remove()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes and returns last element of list?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method removes and returns last element of list?', 'easy', 'Think “pop out”.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes and returns last element of list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='pop()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'pop()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes and returns last element of list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='remove()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'remove()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes and returns last element of list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='del()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'del()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method removes and returns last element of list?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='cut()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'cut()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s the output?', 'easy', 'Default value used if key not found.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='0')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '0', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='20')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '20', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is valid tuple?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these is valid tuple?', 'easy', 'Comma required for 1-item tuple.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is valid tuple?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(1)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(1)', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is valid tuple?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(1,)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(1,)', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is valid tuple?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these is valid tuple?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{1}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{1}', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method sorts list in-place?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method sorts list in-place?', 'easy', 'Only method of list object.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method sorts list in-place?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='sorted()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'sorted()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method sorts list in-place?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list.sort()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list.sort()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method sorts list in-place?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='arrange()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'arrange()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method sorts list in-place?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='order()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'order()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operation finds common elements of sets A and B?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which operation finds common elements of sets A and B?', 'easy', 'Intersection operator.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operation finds common elements of sets A and B?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A+B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A+B', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operation finds common elements of sets A and B?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A-B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A-B', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operation finds common elements of sets A and B?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A&B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A&B', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which operation finds common elements of sets A and B?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A|B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A|B', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a valid dict?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is a valid dict?', 'easy', 'Uses key:value pairs.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a valid dict?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{1,2,3}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{1,2,3}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a valid dict?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{"a":1, "b":2}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{"a":1, "b":2}', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a valid dict?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[("a",1)]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[("a",1)]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is a valid dict?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='("a":1)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '("a":1)', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Adding new key.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{"x":1}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{"x":1}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{"x":1,"y":2}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{"x":1,"y":2}', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,2]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,2]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can be dict keys?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these can be dict keys?', 'easy', 'Must be immutable/hashable.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can be dict keys?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='list')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'list', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can be dict keys?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='set')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'set', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can be dict keys?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='tuple')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'tuple', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these can be dict keys?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='dict')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'dict', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this print?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What will this print?', 'easy', 'b points to same list.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,2]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,2]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,2,3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,2,3]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What will this print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method returns list length?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method returns list length?', 'easy', 'Built-in function.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method returns list length?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='length()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'length()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method returns list length?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='len()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'len()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method returns list length?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='count()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'count()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method returns list length?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='size()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'size()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which dict comprehension inverts a dict {1:"a",2:"b"}?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which dict comprehension inverts a dict {1:"a",2:"b"}?', 'easy', 'Flip keys and values.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which dict comprehension inverts a dict {1:"a",2:"b"}?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{v:k for k,v in d.items()}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{v:k for k,v in d.items()}', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which dict comprehension inverts a dict {1:"a",2:"b"}?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{k:v for k,v in d.items()}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{k:v for k,v in d.items()}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which dict comprehension inverts a dict {1:"a",2:"b"}?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[v:k for k,v in d.items()]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[v:k for k,v in d.items()]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which dict comprehension inverts a dict {1:"a",2:"b"}?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='(v:k for k,v in d.items())')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '(v:k for k,v in d.items())', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which set operation removes elements in B from A?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which set operation removes elements in B from A?', 'easy', 'Difference.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which set operation removes elements in B from A?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A|B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A|B', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which set operation removes elements in B from A?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A-B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A-B', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which set operation removes elements in B from A?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A&B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A&B', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which set operation removes elements in B from A?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A^B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A^B', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Sets remove duplicates.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{1,2,2,3}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{1,2,2,3}', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='{1,2,3}')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '{1,2,3}', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='[1,2,3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '[1,2,3]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which slice gives last 3 elements of list nums?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which slice gives last 3 elements of list nums?', 'easy', 'Negative index from end.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which slice gives last 3 elements of list nums?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[3]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which slice gives last 3 elements of list nums?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[-3:]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[-3:]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which slice gives last 3 elements of list nums?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[:3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[:3]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which slice gives last 3 elements of list nums?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nums[:-3]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nums[:-3]', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about tuples?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is TRUE about tuples?', 'easy', 'Immutable = hashable.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about tuples?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They are mutable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They are mutable.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about tuples?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Can be used as dict keys.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Can be used as dict keys.', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about tuples?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Slower than lists.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Slower than lists.', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is TRUE about tuples?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Not indexable.')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Not indexable.', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s output?', 'easy', 'Taking first character.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='["hi","hello","hey"]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '["hi","hello","hey"]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='["h","h","h"]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '["h","h","h"]', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='["i","e","y"]')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '["i","e","y"]', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use deep copy over shallow copy?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use deep copy over shallow copy?', 'easy', 'Protects against shared references.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use deep copy over shallow copy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It’s faster')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It’s faster', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use deep copy over shallow copy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To copy nested structures safely')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To copy nested structures safely', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use deep copy over shallow copy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It uses less memory')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It uses less memory', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use deep copy over shallow copy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='It removes duplicates')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'It removes duplicates', 0);


-- Chapter 5
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='Python');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='OOP & Exceptions' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 5, 'OOP & Exceptions', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='OOP & Exceptions' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'OOP & Exceptions\nFull Notes\nObject-Oriented Programming (OOP) in Python helps you model real-world entities using\nclasses and objects. Exceptions let you handle errors gracefully.\nClasses & Objects\n• Class → blueprint for objects.\n• Object → instance of a class.\n*insert code example below*\nclass Dog:\ndef __init__(self, name):\nself.name = name\ndef bark(self):\nprint(f"{self.name} says woof!")\nd = Dog("Buddy")\nd.bark()\nMethods\n• Instance methods → take self.\n• Class methods → take cls, defined with @classmethod.\n• Static methods → no self or cls, defined with @staticmethod.\nEncapsulation\n• Hide details using naming conventions:\no _var → protected (convention).\no __var → name-mangled.\nInheritance & Polymorphism\n• Inheritance → create new classes from existing ones.\n• Polymorphism → same method name, different behaviours.\n*insert code example below*\nclass Animal:\ndef speak(self): print("Generic sound")\nclass Cat(Animal):\ndef speak(self): print("Meow")\nExceptions\n• try/except → catch errors.\n• else → runs if no error.\n• finally → always runs.\n*insert code example below*\ntry:\nx = 10/0\nexcept ZeroDivisionError:\nprint("You can’t divide by zero!")\nfinally:\nprint("Done")\n• Custom exceptions can be created by inheriting from Exception.\n');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='OOP & Exceptions' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for OOP & Exceptions');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which function is used to open a file in Python?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which function is used to open a file in Python?', 'open()\n', 1);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What are the two main arguments of open()?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What are the two main arguments of open()?', 'Filename and mode\n', 2);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which mode opens a file for reading?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which mode opens a file for reading?', '"r"\n', 3);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which mode opens a file for writing (overwrites)?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which mode opens a file for writing (overwrites)?', '"w"\n', 4);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which mode appends data to a file?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which mode appends data to a file?', '"a"\n', 5);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which mode reads and writes a file?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which mode reads and writes a file?', '"r+"\n', 6);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which statement ensures a file is closed automatically?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which statement ensures a file is closed automatically?', 'with open(...) as f:\n', 7);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword begins an exception handling block?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword begins an exception handling block?', 'try\n', 8);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword catches an exception?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword catches an exception?', 'except\n', 9);

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which keyword runs code no matter what (error or not)?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which keyword runs code no matter what (error or not)?', 'finally\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='OOP & Exceptions' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for OOP & Exceptions');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which keyword defines a class?', 'easy', 'Think blueprint keyword.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='def')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'def', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'object', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which keyword defines a class?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is self in a method?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is self in a method?', 'easy', 'Points to the current object.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is self in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to module')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to module', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is self in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to the object instance')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to the object instance', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is self in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to class', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is self in a method?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Refers to parent')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Refers to parent', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method runs when object is created?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method runs when object is created?', 'easy', 'Constructor.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method runs when object is created?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='start()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'start()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method runs when object is created?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new()', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method runs when object is created?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='init()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'init()', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method runs when object is created?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='begin()')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'begin()', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does @staticmethod mean?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does @staticmethod mean?', 'easy', 'Doesn’t take self or cls.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does @staticmethod mean?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Bound to object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Bound to object', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does @staticmethod mean?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Bound to class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Bound to class', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does @staticmethod mean?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No binding needed')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No binding needed', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does @staticmethod mean?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Creates static variable')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Creates static variable', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block handles exceptions?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which block handles exceptions?', 'easy', 'It “catches” errors.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block handles exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='try')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'try', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block handles exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='except')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'except', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block handles exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='finally')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'finally', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block handles exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='raise')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'raise', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about inheritance?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is true about inheritance?', 'easy', 'Parent → Child.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Child class can’t override parent method')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Child class can’t override parent method', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Parent inherits from child')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Parent inherits from child', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Child inherits methods/attributes from parent')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Child inherits methods/attributes from parent', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is true about inheritance?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Inheritance not supported in Python')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Inheritance not supported in Python', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code print?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does this code print?', 'easy', 'Object is instance of class.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='False')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'False', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='True')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'True', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does this code print?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the parent of all classes in Python?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is the parent of all classes in Python?', 'easy', 'Everything inherits from it.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the parent of all classes in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the parent of all classes in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='object')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'object', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the parent of all classes in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='base')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'base', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is the parent of all classes in Python?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block always runs, regardless of error?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which block always runs, regardless of error?', 'easy', 'Cleans up after try-except.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block always runs, regardless of error?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='try')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'try', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block always runs, regardless of error?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='except')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'except', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block always runs, regardless of error?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='else')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'else', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which block always runs, regardless of error?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='finally')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'finally', 1);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which raises an exception manually?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which raises an exception manually?', 'easy', 'Keyword in Python.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which raises an exception manually?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='throw')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'throw', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which raises an exception manually?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='raise')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'raise', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which raises an exception manually?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='except')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'except', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which raises an exception manually?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Child overrides parent.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='A')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'A', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='B')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'B', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these defines a custom exception?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which of these defines a custom exception?', 'easy', 'Must inherit Exception.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these defines a custom exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class MyError: pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class MyError: pass', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these defines a custom exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class MyError(Exception): pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class MyError(Exception): pass', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these defines a custom exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='def MyError(): pass')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'def MyError(): pass', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which of these defines a custom exception?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='raise MyError')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'raise MyError', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does polymorphism allow?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does polymorphism allow?', 'easy', 'Same method, different behaviour.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does polymorphism allow?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Using multiple classes with same method names')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Using multiple classes with same method names', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does polymorphism allow?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Using only one method per class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Using only one method per class', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does polymorphism allow?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Changing variable type')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Changing variable type', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does polymorphism allow?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Writing multiple init methods')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Writing multiple init methods', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method creates object without calling init?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method creates object without calling init?', 'easy', 'Lower-level constructor.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method creates object without calling init?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='new')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'new', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method creates object without calling init?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='create')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'create', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method creates object without calling init?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='obj')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'obj', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method creates object without calling init?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='class')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'class', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if error is not handled?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What happens if error is not handled?', 'easy', 'Exceptions stop program.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if error is not handled?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Program ignores it')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Program ignores it', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if error is not handled?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Program crashes')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Program crashes', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if error is not handled?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error gets logged silently')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error gets logged silently', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What happens if error is not handled?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Nothing')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Nothing', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which OOP concept allows replacing large if/elif with class hierarchy?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which OOP concept allows replacing large if/elif with class hierarchy?', 'easy', 'Override methods instead of ifs.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which OOP concept allows replacing large if/elif with class hierarchy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Inheritance + Polymorphism')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Inheritance + Polymorphism', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which OOP concept allows replacing large if/elif with class hierarchy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Encapsulation')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Encapsulation', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which OOP concept allows replacing large if/elif with class hierarchy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Abstraction')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Abstraction', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which OOP concept allows replacing large if/elif with class hierarchy?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Composition')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Composition', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which prints “Meow”?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which prints “Meow”?', 'easy', 'Child overrides.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which prints “Meow”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Generic')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Generic', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which prints “Meow”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Meow')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Meow', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which prints “Meow”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which prints “Meow”?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='None')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'None', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What’s the output?', 'easy', 'Exception goes to except.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error + No error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error + No error', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What’s the output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Crash')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Crash', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use custom exceptions?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use custom exceptions?', 'easy', 'Custom messages help clarity.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use custom exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To confuse users')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To confuse users', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use custom exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='For meaningful, specific error handling')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'For meaningful, specific error handling', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use custom exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To replace built-in errors')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To replace built-in errors', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use custom exceptions?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='To avoid debugging')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'To avoid debugging', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method defines behaviour for str(obj)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method defines behaviour for str(obj)?', 'easy', 'User-friendly string representation.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method defines behaviour for str(obj)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='repr')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'repr', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method defines behaviour for str(obj)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='str')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'str', 1);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method defines behaviour for str(obj)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='format')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'format', 0);

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method defines behaviour for str(obj)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='print')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'print', 0);

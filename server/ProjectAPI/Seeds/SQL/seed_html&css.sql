IF NOT EXISTS (SELECT 1 FROM Courses WHERE Title = 'HTML&CSS')
INSERT INTO Courses (Id, Title, Description, PreviewContent, Published)
VALUES (NEWID(), 'HTML&CSS', 'Auto-generated description', 'Preview: Intro to HTML&CSS', 1);


-- Chapter 1
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='HTML&CSS');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Basics (Structure, Tags, Elements, Attributes)' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 1, 'Basics (Structure, Tags, Elements, Attributes)', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Structure, Tags, Elements, Attributes)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Basics (Structure, Tags, Elements, Attributes)\nFull Notes\nHTML (HyperText Markup Language) is the standard language for creating web pages.\nIt uses tags to define the structure and content.\nHTML Document Structure\nEvery HTML file follows a standard skeleton:\n*insert code example below*\n<!DOCTYPE html>\n<html>\n<head>\n<title>My First Page</title>\n</head>\n<body>\n<h1>Hello, World!</h1>\n<p>This is a paragraph.</p>\n</body>\n</html>\n• <!DOCTYPE html> → declares HTML5.\n• <html> → root element.\n• <head> → metadata (title, styles, scripts).\n• <body> → visible page content.\nElements & Tags\n• Tag → instruction in angle brackets (<p>).\n• Element → complete structure with opening + closing tag + content.\n*insert code example below*\n<p>This is an element</p>\nAttributes\n• Provide extra information.\n*insert code example below*\n<img src="image.jpg" alt="My Image" width="200">\n• Example attributes: id, class, src, alt, href.\nCommon Tags\n• Headings: <h1> to <h6>\n• Paragraph: <p>\n• Link: <a href="url">\n• Image: <img>\n• Lists: <ul>, <ol>, <li>\nComments\n*insert code example below*\n<!-- This is a comment -->\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Structure, Tags, Elements, Attributes)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Basics (Structure, Tags, Elements, Attributes)');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What does HTML stand for?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What does HTML stand for?', 'HyperText Markup Language\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which declaration starts an HTML5 document?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which declaration starts an HTML5 document?', '<!DOCTYPE html>\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which element wraps the entire page?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which element wraps the entire page?', '<html>\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Where do metadata and the page title go?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Where do metadata and the page title go?', 'Inside <head>\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag sets the text shown on the browser tab?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag sets the text shown on the browser tab?', '<title>\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Where does visible page content go?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Where does visible page content go?', 'Inside <body>\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='What’s the difference between a tag and an element?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'What’s the difference between a tag and an element?', 'A tag is the markup (<p>), an element is tag + content (+ closing tag).\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you write a comment in HTML?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you write a comment in HTML?', '<!-- comment -->\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag creates a hyperlink?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag creates a hyperlink?', '<a> (use href for the URL)\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute specifies an image’s source?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute specifies an image’s source?', 'src on <img>\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Basics (Structure, Tags, Elements, Attributes)' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Basics (Structure, Tags, Elements, Attributes)');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What does HTML stand for?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What does HTML stand for?', 'easy', 'Standard for web pages.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does HTML stand for?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hyper Trainer Markup Language')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hyper Trainer Markup Language', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does HTML stand for?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='HyperText Markup Language')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'HyperText Markup Language', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does HTML stand for?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='HighText Machine Language')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'HighText Machine Language', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What does HTML stand for?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Hyper Tool Multi Language')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Hyper Tool Multi Language', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag displays the largest heading?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag displays the largest heading?', 'easy', 'Heading levels go from big (1) to small (6).');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag displays the largest heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<h6>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<h6>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag displays the largest heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<h1>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<h1>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag displays the largest heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag displays the largest heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<title>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<title>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is used for paragraphs?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is used for paragraphs?', 'easy', 'Short for paragraph.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is used for paragraphs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<para>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<para>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is used for paragraphs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<p>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<p>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is used for paragraphs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<pg>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<pg>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is used for paragraphs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<text>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<text>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies image source?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute specifies image source?', 'easy', 'Source = src.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies image source?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies image source?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies image source?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies image source?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='link')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'link', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag adds a hyperlink?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag adds a hyperlink?', 'easy', 'Anchor tag.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag adds a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<link>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<link>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag adds a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag adds a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<href>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<href>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag adds a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<url>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<url>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is correct HTML comment?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is correct HTML comment?', 'easy', 'Surrounded by <!-- -->.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is correct HTML comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='// comment')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '// comment', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is correct HTML comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<!-- comment -->')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<!-- comment -->', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is correct HTML comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='# comment')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '# comment', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is correct HTML comment?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='** comment **')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '** comment **', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines metadata like page title?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag defines metadata like page title?', 'easy', 'Metadata lives in head.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines metadata like page title?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<body>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<body>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines metadata like page title?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<meta>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<meta>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines metadata like page title?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines metadata like page title?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is self-closing?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element is self-closing?', 'easy', 'Doesn’t need closing tag.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is self-closing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<p>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<p>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is self-closing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is self-closing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<img>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<img>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is self-closing?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<h1>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<h1>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct link?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct link?', 'easy', 'Uses href.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a>www.google.com</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a>www.google.com</a>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a link="www.google.com">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a link="www.google.com">Google</a>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="https://www.google.com">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="https://www.google.com">Google</a>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a url="google.com">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a url="google.com">Google</a>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list shows numbers automatically?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which list shows numbers automatically?', 'easy', 'Ordered list.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list shows numbers automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ul>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ul>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list shows numbers automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ol>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ol>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list shows numbers automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<list>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<list>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list shows numbers automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<dl>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<dl>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default display of <div>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is default display of <div>?', 'easy', 'Divs stack vertically.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default display of <div>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='inline')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'inline', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default display of <div>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='block')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'block', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default display of <div>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='flex')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'flex', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default display of <div>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='inline-block')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'inline-block', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT a valid attribute of <img>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is NOT a valid attribute of <img>?', 'easy', 'href belongs to links.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT a valid attribute of <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT a valid attribute of <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT a valid attribute of <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT a valid attribute of <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='width')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'width', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Lower number = bigger heading.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='“Hello” bigger than “World”')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '“Hello” bigger than “World”', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Same size')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Same size', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Invisible')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Invisible', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is used for grouping inline elements?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element is used for grouping inline elements?', 'easy', 'Span is inline container.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is used for grouping inline elements?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<span>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<span>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is used for grouping inline elements?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is used for grouping inline elements?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<p>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<p>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is used for grouping inline elements?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute provides alternate text for images?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute provides alternate text for images?', 'easy', 'Important for accessibility.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute provides alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute provides alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute provides alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='title')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'title', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute provides alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines document title (seen in browser tab)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag defines document title (seen in browser tab)?', 'easy', 'Goes in head.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines document title (seen in browser tab)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<meta>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<meta>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines document title (seen in browser tab)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines document title (seen in browser tab)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<title>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<title>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines document title (seen in browser tab)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<h1>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<h1>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list has bullet points?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which list has bullet points?', 'easy', 'Unordered list.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list has bullet points?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ol>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ol>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list has bullet points?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ul>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ul>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list has bullet points?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<li>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<li>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which list has bullet points?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<dl>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<dl>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which HTML5 semantic tag represents navigation links?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which HTML5 semantic tag represents navigation links?', 'easy', 'nav = navigation.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which HTML5 semantic tag represents navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which HTML5 semantic tag represents navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<nav>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<nav>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which HTML5 semantic tag represents navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which HTML5 semantic tag represents navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which do all HTML documents start with?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which do all HTML documents start with?', 'easy', 'Declares HTML version.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which do all HTML documents start with?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which do all HTML documents start with?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<!DOCTYPE html>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<!DOCTYPE html>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which do all HTML documents start with?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<html>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<html>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which do all HTML documents start with?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<body>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<body>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why are attributes important?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why are attributes important?', 'easy', 'Add details like links, sources, IDs.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why are attributes important?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They create tags')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They create tags', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why are attributes important?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They provide extra info for elements')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They provide extra info for elements', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why are attributes important?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They replace elements')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They replace elements', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why are attributes important?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='They are not used in HTML')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'They are not used in HTML', 0);


-- Chapter 2
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='HTML&CSS');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Text Formatting & Links' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 2, 'Text Formatting & Links', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Text Formatting & Links' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Text Formatting & Links\nFull Notes\nHTML provides various tags to format text and create hyperlinks for navigation.\nText Formatting Tags\n• Bold → <b> (styling) or <strong> (semantic, important text).\n• Italic → <i> (styling) or <em> (semantic, emphasised text).\n• Underline → <u>\n• Superscript → <sup>\n• Subscript → <sub>\n• Monospace/code → <code>, <pre>\n*insert code example below*\n<p>This is <b>bold</b> and <i>italic</i>.</p>\n<p>Water formula: H<sub>2</sub>O</p>\n<p>2<sup>3</sup> = 8</p>\n<pre>\nline1\nline2 (keeps spacing)\n</pre>\nLinks\n• Anchor tag: <a href="url">Link Text</a>\n• Open in new tab: target="_blank"\n• Email link: <a href="mailto:someone@example.com">Email me</a>\n• Internal link (jump to section):\n*insert code example below*\n<a href="#section1">Go to Section 1</a>\n<h2 id="section1">Section 1</h2>\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Text Formatting & Links' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Text Formatting & Links');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines the largest heading?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines the largest heading?', '<h1>\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines the smallest heading?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines the smallest heading?', '<h6>\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag creates a paragraph?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag creates a paragraph?', '<p>\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you make text bold (semantic)?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you make text bold (semantic)?', '<strong>\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you make text italic (semantic)?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you make text italic (semantic)?', '<em>\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag inserts a line break?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag inserts a line break?', '<br>\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag draws a horizontal line?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag draws a horizontal line?', '<hr>\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you make text appear as superscript?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you make text appear as superscript?', '<sup>\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='How do you make text appear as subscript?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'How do you make text appear as subscript?', '<sub>\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag is used for inline styling of small text spans?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag is used for inline styling of small text spans?', '<span>\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Text Formatting & Links' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Text Formatting & Links');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text bold (semantic meaning)?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag makes text bold (semantic meaning)?', 'easy', 'Indicates importance, not just style.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text bold (semantic meaning)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<b>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<b>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text bold (semantic meaning)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<i>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<i>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text bold (semantic meaning)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<strong>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<strong>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text bold (semantic meaning)?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<em>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<em>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text italic for emphasis?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag makes text italic for emphasis?', 'easy', 'Semantic emphasised text.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text italic for emphasis?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<i>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<i>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text italic for emphasis?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<em>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<em>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text italic for emphasis?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<strong>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<strong>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes text italic for emphasis?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<mark>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<mark>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates a hyperlink?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which creates a hyperlink?', 'easy', 'Anchor tag.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<link>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<link>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<url>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<url>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates a hyperlink?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<href>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<href>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute opens link in a new tab?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute opens link in a new tab?', 'easy', 'Target attribute controls window.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute opens link in a new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='newtab')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'newtab', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute opens link in a new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='open')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'open', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute opens link in a new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='target="_blank"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'target="_blank"', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute opens link in a new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href="_new"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href="_new"', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag preserves spacing and line breaks?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag preserves spacing and line breaks?', 'easy', '“Preformatted”.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag preserves spacing and line breaks?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<code>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<code>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag preserves spacing and line breaks?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<pre>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<pre>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag preserves spacing and line breaks?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag preserves spacing and line breaks?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<span>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<span>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid email link?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is valid email link?', 'easy', 'Uses mailto protocol.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid email link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a email="me@test.com">Email</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a email="me@test.com">Email</a>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid email link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="mail:me@test.com">Email</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="mail:me@test.com">Email</a>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid email link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="mailto:me@test.com">Email</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="mailto:me@test.com">Email</a>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid email link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a url="email.com">Email</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a url="email.com">Email</a>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', 'Superscript raises text.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='24')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '24', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2⁴')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2⁴', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2_4')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2_4', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag underlines text?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag underlines text?', 'easy', '“u” for underline.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag underlines text?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<i>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<i>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag underlines text?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<u>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<u>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag underlines text?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<em>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<em>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag underlines text?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ul>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ul>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute is used in <a> for link destination?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute is used in <a> for link destination?', 'easy', 'href = Hypertext REFerence.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute is used in <a> for link destination?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='link')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'link', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute is used in <a> for link destination?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute is used in <a> for link destination?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute is used in <a> for link destination?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='url')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'url', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which shows inline code snippet?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which shows inline code snippet?', 'easy', 'Code = monospace inline.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which shows inline code snippet?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<pre>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<pre>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which shows inline code snippet?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<u>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<u>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which shows inline code snippet?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<code>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<code>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which shows inline code snippet?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<kbd>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<kbd>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is semantic: <b> or <strong>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is semantic: <b> or <strong>?', 'easy', 'Semantic = meaning, not just style.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is semantic: <b> or <strong>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<i>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<i>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is semantic: <b> or <strong>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<b>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<b>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is semantic: <b> or <strong>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<u>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<u>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is semantic: <b> or <strong>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<strong>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<strong>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct way to open Google in new tab?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct way to open Google in new tab?', 'easy', 'Always target="_blank".');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct way to open Google in new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="google.com" newtab>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="google.com" newtab>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct way to open Google in new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="google.com" target="_blank">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="google.com" target="_blank">Google</a>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct way to open Google in new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a link="google.com" target="new">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a link="google.com" target="new">Google</a>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct way to open Google in new tab?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="google.com" target="tab">Google</a>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="google.com" target="tab">Google</a>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates internal jump link?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which creates internal jump link?', 'easy', '# links to id.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates internal jump link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="section1">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="section1">', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates internal jump link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a id="section1">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a id="section1">', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates internal jump link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<a href="#section1">Go</a> + element with id="section1"')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<a href="#section1">Go</a> + element with id="section1"', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which creates internal jump link?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<link href="#section1">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<link href="#section1">', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which will be displayed?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which will be displayed?', 'easy', 'Subscript lowers');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) H2O')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) H2O', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) H2O');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='H₂O')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'H₂O', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) H2O');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='H^2O')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'H^2O', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) H2O');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies alternate text for images?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute specifies alternate text for images?', 'easy', 'Always include for accessibility.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='title')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'title', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute specifies alternate text for images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='desc')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'desc', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is difference between <i> and <em>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is difference between <i> and <em>?', 'easy', 'Emphasis = meaningful.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is difference between <i> and <em>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No difference')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No difference', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is difference between <i> and <em>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<em> is semantic, <i> is style')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<em> is semantic, <i> is style', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is difference between <i> and <em>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<i> is semantic, <em> is style')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<i> is semantic, <em> is style', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is difference between <i> and <em>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Both are deprecated')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Both are deprecated', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for multi-line code block?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is best for multi-line code block?', 'easy', 'Pre preserves whitespace, code for style.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for multi-line code block?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<pre><code> ... </code></pre>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<pre><code> ... </code></pre>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for multi-line code block?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<u>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<u>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for multi-line code block?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<kbd>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<kbd>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for multi-line code block?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<mark>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<mark>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which protocol is used for email links?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which protocol is used for email links?', 'easy', 'Always mailto.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which protocol is used for email links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='http://')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'http://', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which protocol is used for email links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='mail://')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'mail://', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which protocol is used for email links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='mailto:')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'mailto:', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which protocol is used for email links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='email://')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'email://', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag emphasises text visually but NOT semantically?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag emphasises text visually but NOT semantically?', 'easy', 'Just makes bold.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag emphasises text visually but NOT semantically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<em>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<em>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag emphasises text visually but NOT semantically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<strong>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<strong>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag emphasises text visually but NOT semantically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<b>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<b>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag emphasises text visually but NOT semantically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<abbr>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<abbr>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is semantic formatting preferred?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why is semantic formatting preferred?', 'easy', 'Screen readers detect meaning.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is semantic formatting preferred?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Shorter code')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Shorter code', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is semantic formatting preferred?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Adds visual style')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Adds visual style', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is semantic formatting preferred?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Improves accessibility & SEO')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Improves accessibility & SEO', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why is semantic formatting preferred?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No difference')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No difference', 0);


-- Chapter 3
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='HTML&CSS');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Images, Multimedia & Tables' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 3, 'Images, Multimedia & Tables', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Images, Multimedia & Tables' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Images, Multimedia & Tables\nFull Notes\nImages\n• Insert with <img> (self-closing).\n• Important attributes:\no src → file path/URL\no alt → alternate text for accessibility\no width, height → dimensions (px or %)\n*insert code example below*\n<img src="photo.jpg" alt="Profile picture" width="200">\nMultimedia (Audio & Video)\n• Audio:\n*insert code example below*\n<audio controls>\n<source src="song.mp3" type="audio/mpeg">\n</audio>\n• Video:\n*insert code example below*\n<video controls width="400">\n<source src="movie.mp4" type="video/mp4">\n</video>\n• Attributes: controls, autoplay, loop, muted.\nTables\n• Organise data into rows and columns.\n*insert code example below*\n<table border="1">\n<tr>\n<th>Name</th><th>Age</th>\n</tr>\n<tr>\n<td>Aisha</td><td>21</td>\n</tr>\n</table>\n• Tags:\no <table> → table container\no <tr> → table row\no <th> → header cell\no <td> → data cell\n• Attributes: colspan, rowspan.\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Images, Multimedia & Tables' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Images, Multimedia & Tables');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag creates a hyperlink?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag creates a hyperlink?', '<a>\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute in <a> defines the destination URL?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute in <a> defines the destination URL?', 'href\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute makes a link open in a new tab?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute makes a link open in a new tab?', 'target="_blank"\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag inserts an image?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag inserts an image?', '<img>\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute provides alternative text for an image?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute provides alternative text for an image?', 'alt\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag is used to embed audio?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag is used to embed audio?', '<audio>\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute makes audio play automatically?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute makes audio play automatically?', 'autoplay\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag is used to embed video?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag is used to embed video?', '<video>\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute adds playback controls to audio/video?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute adds playback controls to audio/video?', 'controls\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag is used to embed external media like YouTube?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag is used to embed external media like YouTube?', '<iframe>\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Images, Multimedia & Tables' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Images, Multimedia & Tables');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag inserts an image?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag inserts an image?', 'easy', 'Self-closing tag.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag inserts an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<image>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<image>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag inserts an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<img>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<img>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag inserts an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<pic>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<pic>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag inserts an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<src>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<src>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives text if image doesn’t load?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute gives text if image doesn’t load?', 'easy', 'Accessibility helper.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives text if image doesn’t load?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives text if image doesn’t load?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives text if image doesn’t load?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='title')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'title', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives text if image doesn’t load?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='desc')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'desc', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag plays a sound file?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag plays a sound file?', 'easy', 'Introduced in HTML');

GO
DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='A) <music>')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'A) <music>', 'easy', '');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) <music>');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<audio>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<audio>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) <music>');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<sound>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<sound>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='A) <music>');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<song>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<song>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines table row?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag defines table row?', 'easy', '“tr” = table row.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines table row?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<td>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<td>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines table row?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<th>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<th>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines table row?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<tr>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<tr>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag defines table row?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<row>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<row>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which cell is for table headers?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which cell is for table headers?', 'easy', 'Bold + centered by default.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which cell is for table headers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<td>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<td>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which cell is for table headers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<th>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<th>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which cell is for table headers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<tr>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<tr>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which cell is for table headers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes video start automatically?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute makes video start automatically?', 'easy', 'Auto-play attribute.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes video start automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='play')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'play', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes video start automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='autoplay')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'autoplay', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes video start automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='start')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'start', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes video start automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='auto')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'auto', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', '2 rows, 2 cells each.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Single row table')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Single row table', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='2×2 table')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '2×2 table', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='4×1 table')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '4×1 table', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag embeds a movie file?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag embeds a movie file?', 'easy', 'HTML5 tag.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag embeds a movie file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<vid>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<vid>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag embeds a movie file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<video>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<video>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag embeds a movie file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<movie>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<movie>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag embeds a movie file?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<media>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<media>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which merges cells horizontally?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which merges cells horizontally?', 'easy', 'Column span.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which merges cells horizontally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='rowspan')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'rowspan', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which merges cells horizontally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='colspan')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'colspan', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which merges cells horizontally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='merge')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'merge', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which merges cells horizontally?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='span')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'span', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute loops media?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute loops media?', 'easy', 'loop=repeat forever.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute loops media?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='loop')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'loop', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute loops media?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='repeat')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'repeat', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute loops media?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='cycle')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'cycle', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute loops media?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='autoplay')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'autoplay', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT valid for <img>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is NOT valid for <img>?', 'easy', 'href belongs to links.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT valid for <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='src')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'src', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT valid for <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT valid for <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT valid for <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='width')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'width', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures media works in all browsers?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which ensures media works in all browsers?', 'easy', 'Provide fallback formats.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures media works in all browsers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Multiple <source> elements')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Multiple <source> elements', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures media works in all browsers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='One mp4 only')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'One mp4 only', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures media works in all browsers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Convert to jpg')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Convert to jpg', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures media works in all browsers?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Always autoplay')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Always autoplay', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is output?', 'easy', '“col” = column.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Spans 2 rows')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Spans 2 rows', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Spans 2 columns')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Spans 2 columns', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Error')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Error', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is output?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Nothing')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Nothing', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups rows in table head?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag groups rows in table head?', 'easy', 'Used with <tbody> and <tfoot>.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups rows in table head?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<thead>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<thead>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups rows in table head?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<head>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<head>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups rows in table head?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<top>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<top>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups rows in table head?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<rowhead>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<rowhead>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups table body rows?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag groups table body rows?', 'easy', 'Standard sectioning.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups table body rows?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<tbody>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<tbody>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups table body rows?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<body>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<body>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups table body rows?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<tr>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<tr>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups table body rows?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<td>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<td>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute mutes video by default?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute mutes video by default?', 'easy', 'Boolean attribute.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute mutes video by default?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='silence')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'silence', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute mutes video by default?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='mute')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'mute', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute mutes video by default?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='muted')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'muted', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute mutes video by default?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='nosound')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'nosound', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is true about <pre>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which statement is true about <pre>?', 'easy', 'Keeps whitespace.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is true about <pre>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Used for tables')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Used for tables', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is true about <pre>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Preserves formatting')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Preserves formatting', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is true about <pre>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Only works with images')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Only works with images', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which statement is true about <pre>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Deprecated')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Deprecated', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which plays background audio automatically?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which plays background audio automatically?', 'easy', 'autoplay attribute.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which plays background audio automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<audio autoplay>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<audio autoplay>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which plays background audio automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<sound auto>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<sound auto>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which plays background audio automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<music play>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<music play>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which plays background audio automatically?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<audio start>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<audio start>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is NOT related to tables?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is NOT related to tables?', 'easy', 'ul = unordered list.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is NOT related to tables?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<tr>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<tr>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is NOT related to tables?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<td>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<td>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is NOT related to tables?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<ul>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<ul>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is NOT related to tables?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<th>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<th>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use alt attribute in <img>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why use alt attribute in <img>?', 'easy', 'Helps screen readers + search engines.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use alt attribute in <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Styling')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Styling', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use alt attribute in <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Accessibility + SEO')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Accessibility + SEO', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use alt attribute in <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='File path')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'File path', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why use alt attribute in <img>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Not necessary')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Not necessary', 0);


-- Chapter 4
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='HTML&CSS');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Forms & Inputs' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 4, 'Forms & Inputs', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Forms & Inputs' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Forms & Inputs\nFull Notes\nForms in HTML are used to collect user input such as text, passwords, selections, and files.\nThe <form> Tag\n*insert code example below*\n<form action="/submit" method="post">\n<!-- form elements here -->\n</form>\n• action → where data is sent (URL or script).\n• method → GET (append to URL) or POST (secure).\nCommon Input Types\n*insert code example below*\n<input type="text" name="username">\n<input type="password" name="pwd">\n<input type="email" name="email">\n<input type="number" name="age">\n<input type="date" name="dob">\n<input type="file" name="resume">\n<input type="checkbox" name="agree">\n<input type="radio" name="gender" value="male">\n<input type="submit" value="Submit">\nLabels & Placeholders\n• <label for="id"> → associates text with input.\n• placeholder → hint text inside input.\nSelect Menus & Textareas\n*insert code example below*\n<select name="country">\n<option>Malaysia</option>\n<option>Japan</option>\n</select>\n<textarea rows="4" cols="30">Enter text here...</textarea>\nButtons\n*insert code example below*\n• <button type="submit">Submit</button>\n• <button type="reset">Reset</button>\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Forms & Inputs' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Forms & Inputs');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines a form?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines a form?', '<form>\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute defines where form data is sent?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute defines where form data is sent?', 'action\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute sets the method of sending data?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute sets the method of sending data?', 'method\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which method appends data to the URL?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which method appends data to the URL?', 'GET\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which method sends data securely in the body?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which method sends data securely in the body?', 'POST\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which input type hides typed characters?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which input type hides typed characters?', 'password\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag creates a drop-down list?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag creates a drop-down list?', '<select>\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag creates multi-line text input?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag creates multi-line text input?', '<textarea>\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which attribute makes a form field mandatory?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which attribute makes a form field mandatory?', 'required\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which input type allows multiple choice selection?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which input type allows multiple choice selection?', 'checkbox\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Forms & Inputs' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Forms & Inputs');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag creates a form?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag creates a form?', 'easy', 'Container for inputs.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag creates a form?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<input>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<input>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag creates a form?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<form>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<form>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag creates a form?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<fieldset>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<fieldset>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag creates a form?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<table>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<table>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method appends data to URL?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which method appends data to URL?', 'easy', 'Exposes data in URL.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method appends data to URL?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='POST')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'POST', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method appends data to URL?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='SEND')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'SEND', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method appends data to URL?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='GET')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'GET', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which method appends data to URL?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FETCH')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FETCH', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type hides characters?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which input type hides characters?', 'easy', 'Used for login forms.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type hides characters?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='text')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'text', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type hides characters?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='password')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'password', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type hides characters?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='hidden')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'hidden', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type hides characters?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='secret')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'secret', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes drop-down menu?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag makes drop-down menu?', 'easy', 'Used with <option>.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes drop-down menu?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<select>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<select>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes drop-down menu?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<list>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<list>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes drop-down menu?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<menu>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<menu>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag makes drop-down menu?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<dropdown>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<dropdown>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag for multi-line input?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag for multi-line input?', 'easy', 'Rows & cols attributes.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag for multi-line input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<textbox>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<textbox>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag for multi-line input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<textarea>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<textarea>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag for multi-line input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<input type="longtext">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<input type="longtext">', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag for multi-line input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<lines>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<lines>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute links <label> to input?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute links <label> to input?', 'easy', 'Label uses for=id.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute links <label> to input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute links <label> to input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='id')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'id', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute links <label> to input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='name')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'name', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute links <label> to input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='href')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'href', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input allows multiple choices?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which input allows multiple choices?', 'easy', 'Tick boxes allow multiple.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input allows multiple choices?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='radio')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'radio', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input allows multiple choices?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='checkbox')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'checkbox', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input allows multiple choices?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='text')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'text', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input allows multiple choices?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='file')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'file', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives hint text inside input?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute gives hint text inside input?', 'easy', 'Greyed-out text inside box.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives hint text inside input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='label')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'label', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives hint text inside input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='placeholder')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'placeholder', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives hint text inside input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='hint')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'hint', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute gives hint text inside input?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='alt')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'alt', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type allows uploading a document?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which input type allows uploading a document?', 'easy', 'Browses files.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type allows uploading a document?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='text')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'text', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type allows uploading a document?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='file')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'file', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type allows uploading a document?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='upload')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'upload', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input type allows uploading a document?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='submit')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'submit', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input restricts to one option in group?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which input restricts to one option in group?', 'easy', 'Only one radio per group.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input restricts to one option in group?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='checkbox')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'checkbox', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input restricts to one option in group?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='select')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'select', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input restricts to one option in group?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='radio')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'radio', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input restricts to one option in group?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='multiple')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'multiple', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT an input type?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is NOT an input type?', 'easy', 'No “picture” type.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT an input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='color')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'color', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT an input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='range')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'range', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT an input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='picture')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'picture', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is NOT an input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='email')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'email', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default method if not specified?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'What is default method if not specified?', 'easy', 'Default is GET.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default method if not specified?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='GET')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'GET', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default method if not specified?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='POST')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'POST', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default method if not specified?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='SEND')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'SEND', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='What is default method if not specified?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='FETCH')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'FETCH', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element groups related inputs?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element groups related inputs?', 'easy', 'Often used with <legend>.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element groups related inputs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<fieldset>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<fieldset>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element groups related inputs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<group>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<group>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element groups related inputs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<bundle>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<bundle>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element groups related inputs?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes input mandatory?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute makes input mandatory?', 'easy', 'HTML5 attribute.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes input mandatory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='required')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'required', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes input mandatory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='validate')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'validate', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes input mandatory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='must')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'must', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute makes input mandatory?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='needed')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'needed', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input is best for selecting a date?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which input is best for selecting a date?', 'easy', 'Calendar picker.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input is best for selecting a date?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='text')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'text', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input is best for selecting a date?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='date')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'date', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input is best for selecting a date?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='datetime')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'datetime', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which input is best for selecting a date?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='calendar')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'calendar', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct reset button?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct reset button?', 'easy', 'Resets fields to default.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct reset button?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<button type="clear">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<button type="clear">', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct reset button?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<input type="reset">')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<input type="reset">', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct reset button?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<resetbutton>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<resetbutton>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct reset button?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<button reset>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<button reset>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid HTML5 input type?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is valid HTML5 input type?', 'easy', 'Accepts numeric values.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid HTML5 input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='money')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'money', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid HTML5 input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='number')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'number', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid HTML5 input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='decimal')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'decimal', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is valid HTML5 input type?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='currency')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'currency', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute defines unique name for server?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which attribute defines unique name for server?', 'easy', 'Name attribute sends key=value.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute defines unique name for server?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='id')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'id', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute defines unique name for server?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='name')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'name', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute defines unique name for server?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='for')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'for', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which attribute defines unique name for server?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='label')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'label', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures multiple file uploads?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which ensures multiple file uploads?', 'easy', '');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures multiple file uploads?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='multiple')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'multiple', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures multiple file uploads?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='many')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'many', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures multiple file uploads?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='files')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'files', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which ensures multiple file uploads?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='all')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'all', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer POST over GET for passwords?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why prefer POST over GET for passwords?', 'easy', 'Data not visible in URL.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer POST over GET for passwords?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Faster')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Faster', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer POST over GET for passwords?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Secure (not in URL)')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Secure (not in URL)', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer POST over GET for passwords?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Requires less code')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Requires less code', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer POST over GET for passwords?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='More compatible')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'More compatible', 0);


-- Chapter 5
DECLARE @CourseId uniqueidentifier = (SELECT Id FROM Courses WHERE Title='HTML&CSS');
IF NOT EXISTS (SELECT 1 FROM Chapters WHERE Title='Semantic Elements & Layout' AND CourseId=@CourseId)
INSERT INTO Chapters (Id, CourseId, Number, Title, Summary)
VALUES (NEWID(), @CourseId, 5, 'Semantic Elements & Layout', 'Auto summary');

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Semantic Elements & Layout' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='note')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'note', 'Semantic Elements & Layout\nFull Notes\nWhat are Semantic Elements?\nSemantic elements clearly describe their meaning to both browser and developer. Improves\naccessibility and SEO.\nExamples:\n• <header> → Introductory section or navigation.\n• <nav> → Contains navigation links.\n• <main> → Main content of page.\n• <section> → Thematic grouping of content.\n• <article> → Independent content (blog post, news).\n• <aside> → Side content (ads, related info).\n• <footer> → Footer section of page.\n• <figure> + <figcaption> → Image + caption.\nNon-Semantic vs Semantic\n• Non-semantic: <div>, <span> (no meaning, just containers).\n• Semantic: <header>, <article> (carry meaning).\nLayout with Semantic Tags\n*insert code example below*\n<header>\n<h1>My Website</h1>\n</header>\n<nav>\n<a href="#home">Home</a>\n<a href="#about">About</a>\n</nav>\n<main>\n<article>\n<h2>Blog Post</h2>\n<p>Content goes here...</p>\n</article>\n<aside>Related links</aside>\n</main>\n<footer>\n<p>© 2025 My Website</p>\n</footer>\n');

GO
DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Semantic Elements & Layout' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'flashcard', 'Flashcards for Semantic Elements & Layout');

DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines the header of a page or section?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines the header of a page or section?', '<header>\n', 1);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag contains navigation links?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag contains navigation links?', '<nav>\n', 2);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag holds the main content of a page?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag holds the main content of a page?', '<main>\n', 3);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines a standalone piece of content, like a blog post?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines a standalone piece of content, like a blog post?', '<article>\n', 4);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag groups related content under a thematic heading?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag groups related content under a thematic heading?', '<section>\n', 5);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag contains secondary content, like a sidebar?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag contains secondary content, like a sidebar?', '<aside>\n', 6);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag defines the footer of a page or section?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag defines the footer of a page or section?', '<footer>\n', 7);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag is used for an image with a caption?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag is used for an image with a caption?', '<figure>\n', 8);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tag adds a caption to a <figure>?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tag adds a caption to a <figure>?', '<figcaption>\n', 9);

GO
DECLARE @FlashResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='flashcard');
IF NOT EXISTS (SELECT 1 FROM Flashcards WHERE ResourceId=@FlashResId AND FrontText='Which tags are non-semantic containers?')
INSERT INTO Flashcards (Id, ResourceId, FrontText, BackText, OrderIndex)
VALUES (NEWID(), @FlashResId, 'Which tags are non-semantic containers?', '<div> and <span>\nMCQs (20) with Answers & Hints\nEasy (5)\n', 10);

DECLARE @ChapterId uniqueidentifier = (SELECT Id FROM Chapters WHERE Title='Semantic Elements & Layout' AND CourseId=@CourseId);
IF NOT EXISTS (SELECT 1 FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq')
INSERT INTO Resources (Id, ChapterId, Type, Content)
VALUES (NEWID(), @ChapterId, 'mcq', 'MCQs for Semantic Elements & Layout');

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag contains navigation links?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag contains navigation links?', 'easy', 'Short for navigation.');

DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag contains navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<nav>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<nav>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag contains navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<menu>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<menu>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag contains navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag contains navigation links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is for page footer?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is for page footer?', 'easy', 'Footer = bottom of page.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is for page footer?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<bottom>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<bottom>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is for page footer?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<footer>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<footer>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is for page footer?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<end>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<end>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is for page footer?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<base>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<base>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is non-semantic?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element is non-semantic?', 'easy', 'Has no meaning by itself.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is non-semantic?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is non-semantic?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is non-semantic?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is non-semantic?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag holds main content?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which semantic tag holds main content?', 'easy', 'One per page.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag holds main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag holds main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag holds main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<body>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<body>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag holds main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for blog post?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is best for blog post?', 'easy', 'Independent, reusable content.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for blog post?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for blog post?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<span>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<span>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for blog post?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is best for blog post?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups related content with heading?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag groups related content with heading?', 'easy', 'Each section has heading.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups related content with heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups related content with heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups related content with heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag groups related content with heading?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<footer>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<footer>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is ideal for ads or sidebar links?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag is ideal for ads or sidebar links?', 'easy', 'Not central content.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is ideal for ads or sidebar links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is ideal for ads or sidebar links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is ideal for ads or sidebar links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag is ideal for ads or sidebar links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag provides caption for an image?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag provides caption for an image?', 'easy', 'Paired with <figure>.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag provides caption for an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<caption>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<caption>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag provides caption for an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<figcaption>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<figcaption>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag provides caption for an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<label>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<label>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag provides caption for an image?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element improves SEO & accessibility?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element improves SEO & accessibility?', 'easy', 'Search engines “understand”.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element improves SEO & accessibility?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Non-semantic')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Non-semantic', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element improves SEO & accessibility?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Semantic')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Semantic', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element improves SEO & accessibility?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Inline')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Inline', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element improves SEO & accessibility?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Deprecated')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Deprecated', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct semantic layout?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which is correct semantic layout?', 'easy', 'Standard structure.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct semantic layout?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header><main><footer>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header><main><footer>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct semantic layout?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<top><center><bottom>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<top><center><bottom>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct semantic layout?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div><span><end>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div><span><end>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which is correct semantic layout?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<page><section><end>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<page><section><end>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain <h1> logo?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which semantic tag should contain <h1> logo?', 'easy', 'Header = intro section.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain <h1> logo?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain <h1> logo?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain <h1> logo?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<nav>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<nav>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain <h1> logo?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<footer>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<footer>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain site map links?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which semantic tag should contain site map links?', 'easy', 'Footer often has links.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain site map links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain site map links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<footer>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<footer>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain site map links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<nav>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<nav>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag should contain site map links?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is best for self-contained news article?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element is best for self-contained news article?', 'easy', 'Independent content.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is best for self-contained news article?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is best for self-contained news article?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is best for self-contained news article?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element is best for self-contained news article?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element should appear only once per page?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which element should appear only once per page?', 'easy', 'One main per page.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element should appear only once per page?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element should appear only once per page?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element should appear only once per page?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which element should appear only once per page?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag semantically describes related group of images?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag semantically describes related group of images?', 'easy', 'Use figcaption for caption.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag semantically describes related group of images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<figure>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<figure>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag semantically describes related group of images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<gallery>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<gallery>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag semantically describes related group of images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<div>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<div>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag semantically describes related group of images?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<span>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<span>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer semantic over <div>/<span>?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Why prefer semantic over <div>/<span>?', 'easy', 'Search engines rank better.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer semantic over <div>/<span>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Shorter code')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Shorter code', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer semantic over <div>/<span>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Better SEO + readability')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Better SEO + readability', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer semantic over <div>/<span>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='More stylish')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'More stylish', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Why prefer semantic over <div>/<span>?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='No difference')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'No difference', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag is for navigation bar?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which semantic tag is for navigation bar?', 'easy', 'nav = navigation.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag is for navigation bar?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag is for navigation bar?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<nav>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<nav>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag is for navigation bar?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<header>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<header>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag is for navigation bar?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<menu>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<menu>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which structure is valid?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which structure is valid?', 'easy', 'Articles can have header/footer.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which structure is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Valid')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Valid', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which structure is valid?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='Invalid')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, 'Invalid', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag contains content indirectly related?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which semantic tag contains content indirectly related?', 'easy', 'Sidebars, ads, extra info.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag contains content indirectly related?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<aside>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<aside>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag contains content indirectly related?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<article>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<article>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag contains content indirectly related?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<section>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<section>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which semantic tag contains content indirectly related?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 0);

DECLARE @McqResId uniqueidentifier = (SELECT Id FROM Resources WHERE ChapterId=@ChapterId AND Type='mcq');
IF NOT EXISTS (SELECT 1 FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag was introduced in HTML5 for main content?')
INSERT INTO Questions (Id, ResourceId, Stem, Difficulty, Explanation)
VALUES (NEWID(), @McqResId, 'Which tag was introduced in HTML5 for main content?', 'easy', 'New semantic tag.');

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag was introduced in HTML5 for main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<main>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<main>', 1);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag was introduced in HTML5 for main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<body>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<body>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag was introduced in HTML5 for main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<frame>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<frame>', 0);

GO
DECLARE @QId uniqueidentifier = (SELECT Id FROM Questions WHERE ResourceId=@McqResId AND Stem='Which tag was introduced in HTML5 for main content?');
IF NOT EXISTS (SELECT 1 FROM QuestionOptions WHERE QuestionId=@QId AND OptionText='<center>')
INSERT INTO QuestionOptions (Id, QuestionId, OptionText, IsCorrect)
VALUES (NEWID(), @QId, '<center>', 0);
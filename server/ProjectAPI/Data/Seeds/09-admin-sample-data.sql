-- ========================================
-- ADMIN DASHBOARD SAMPLE DATA
-- Sample data for Pending Approvals, Announcements, and Help Requests
-- ========================================

-- Declare all variables at the top
DECLARE @AdminId UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'admin' ORDER BY CreatedAt);
DECLARE @TeacherId UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'teacher' ORDER BY CreatedAt);
DECLARE @Student1 UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'student' AND Email = 'student@codesage.com');
DECLARE @Student2 UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'student' AND Email = 'alice.student@codesage.com');
DECLARE @Student3 UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'student' AND Email = 'bob.smith@codesage.com');
DECLARE @Student4 UNIQUEIDENTIFIER = (SELECT TOP 1 UserId FROM Profiles WHERE Role = 'student' AND Email = 'emma.t@codesage.com');
DECLARE @Chapter2 UNIQUEIDENTIFIER = (SELECT TOP 1 ChapterId FROM Chapters WHERE Number = 2);
DECLARE @Chapter4 UNIQUEIDENTIFIER = (SELECT TOP 1 ChapterId FROM Chapters WHERE Number = 4);
DECLARE @Chapter5 UNIQUEIDENTIFIER = (SELECT TOP 1 ChapterId FROM Chapters WHERE Number = 5);

-- ========================================
-- 1. PENDING COURSE APPROVALS (3 courses)
-- ========================================

INSERT INTO Courses (CourseId, TeacherId, Title, Description, PreviewContent, Published, ApprovalStatus, RejectionReason)
VALUES 
(NEWID(), @TeacherId, 'Advanced JavaScript Patterns', 
'Master design patterns, closures, and advanced JavaScript concepts for building scalable applications.',
'Learn about the module pattern, revealing module pattern, singleton, factory, and more advanced JavaScript techniques.',
0, 'Pending', NULL),

(NEWID(), @TeacherId, 'React & Redux Fundamentals', 
'Build modern web applications with React and manage state effectively using Redux.',
'Introduction to React components, hooks, Redux store, actions, and reducers for building interactive UIs.',
0, 'Pending', NULL),

(NEWID(), @TeacherId, 'Database Design & SQL Mastery', 
'Learn database normalization, SQL queries, indexing, and optimization techniques.',
'Comprehensive guide to relational database design, SQL syntax, joins, subqueries, and performance tuning.',
0, 'Pending', NULL);

-- ========================================
-- 2. ANNOUNCEMENTS (5 announcements)
-- ========================================

INSERT INTO Announcements (AnnouncementId, AdminId, Title, Message, CreatedAt)
VALUES 
(NEWID(), @AdminId, 'Platform Maintenance Scheduled', 
'Our learning platform will undergo scheduled maintenance on Sunday, November 17th from 2:00 AM to 6:00 AM UTC. During this time, the platform may be temporarily unavailable. We apologize for any inconvenience.',
DATEADD(HOUR, -2, GETUTCDATE())),

(NEWID(), @AdminId, 'New Course Library Update', 
'We are excited to announce that 5 new courses have been added to our catalog this week! Check out Advanced Web Development, Cloud Computing Essentials, and more in the Courses section.',
DATEADD(DAY, -1, GETUTCDATE())),

(NEWID(), @AdminId, 'Student Achievement Recognition', 
'Congratulations to our top performers this month! Over 150 students have completed their Python certification. Keep up the excellent work and continue learning!',
DATEADD(DAY, -3, GETUTCDATE())),

(NEWID(), @AdminId, 'Holiday Learning Promotion', 
'Special offer for the holiday season! All premium courses are now available at a 30% discount. Enroll now and advance your skills. Offer valid until December 31st.',
DATEADD(DAY, -5, GETUTCDATE())),

(NEWID(), @AdminId, 'Forum Guidelines Update', 
'We have updated our community forum guidelines to ensure a positive learning environment for everyone. Please review the new guidelines in the Help section before posting.',
DATEADD(DAY, -7, GETUTCDATE()));

-- ========================================
-- 3. ANONYMOUS FEEDBACK / SUGGESTIONS (5 items)
-- ========================================
-- These are general platform feedback (using Chapter 1 as placeholder)
-- They appear in the "Review Feedback" tab as anonymous suggestions

DECLARE @GeneralChapter UNIQUEIDENTIFIER = (SELECT TOP 1 ChapterId FROM Chapters ORDER BY Number);

INSERT INTO HelpRequests (HelpRequestId, StudentId, ChapterId, Question, Status, ResolvedByTeacherId, Response, CreatedAt, ResolvedAt)
VALUES 
(NEWID(), @Student1, @GeneralChapter, 
'Would love to see more video tutorials explaining the coding concepts. Sometimes reading isn''t enough - visual learners need that extra support!',
'Pending', NULL, NULL, DATEADD(HOUR, -2, GETUTCDATE()), NULL),

(NEWID(), @Student2, @GeneralChapter, 
'The dark mode theme is excellent, but could we get more color options? A blue or green theme would be amazing for late-night study sessions.',
'Pending', NULL, NULL, DATEADD(HOUR, -5, GETUTCDATE()), NULL),

(NEWID(), @Student3, @GeneralChapter, 
'Some of the practice challenges jump in difficulty too quickly. It would help to have progressive hints available or easier starter problems.',
'Pending', NULL, NULL, DATEADD(HOUR, -8, GETUTCDATE()), NULL),

(NEWID(), @Student4, @GeneralChapter, 
'Love the leaderboard feature! It makes learning more competitive and motivating. Suggestion: add weekly/monthly categories so newcomers have a chance too.',
'Pending', NULL, NULL, DATEADD(DAY, -1, GETUTCDATE()), NULL),

(NEWID(), @Student1, @GeneralChapter, 
'The chatbot is helpful but sometimes gives outdated information for Python syntax. Please update its knowledge base for Python 3.11+ features.',
'Pending', NULL, NULL, DATEADD(DAY, -2, GETUTCDATE()), NULL);

-- ========================================
-- VERIFICATION QUERIES
-- ========================================

-- You can run these to verify the data was inserted:
-- SELECT COUNT(*) as PendingCourses FROM Courses WHERE ApprovalStatus = 'Pending';
-- SELECT COUNT(*) as TotalAnnouncements FROM Announcements;
-- SELECT COUNT(*) as PendingHelpRequests FROM HelpRequests WHERE Status = 'Pending';

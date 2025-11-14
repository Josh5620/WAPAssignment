
-- ==============================
-- TESTIMONIALS SEED DATA
-- ==============================
-- This seed file creates sample testimonials for testing and demo purposes
-- Testimonials can be course-specific or general platform reviews (CourseId = NULL)

-- Get Python Course ID
DECLARE @PythonCourseId uniqueidentifier = (SELECT CourseId FROM Courses WHERE Title='The Garden of Python');

-- Get User IDs from Profiles (these must exist from previous test data seeding)
DECLARE @AliceId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='alice.student@codesage.com');
DECLARE @BobId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='bob.smith@codesage.com');
DECLARE @EmmaId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='emma.t@codesage.com');
DECLARE @CarlosId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='carlos.m@codesage.com');
DECLARE @SophiaId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='sophia.lee@codesage.com');
DECLARE @JamesId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='james.w@codesage.com');

-- Testimonial 1: Alice - Python Course (5 stars)
IF @AliceId IS NOT NULL AND @PythonCourseId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@AliceId AND CourseId=@PythonCourseId)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @AliceId, 
        @PythonCourseId, 
        5, 
        'This Python course completely transformed my coding journey! The interactive exercises and clear explanations made learning so enjoyable. Highly recommend to anyone starting with programming!', 
        DATEADD(day, -15, GETUTCDATE())
    );
END
GO

-- Testimonial 2: Bob - Python Course (4 stars)
DECLARE @BobId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='bob.smith@codesage.com');
DECLARE @PythonCourseId uniqueidentifier = (SELECT CourseId FROM Courses WHERE Title='The Garden of Python');

IF @BobId IS NOT NULL AND @PythonCourseId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@BobId AND CourseId=@PythonCourseId)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @BobId, 
        @PythonCourseId, 
        4, 
        'Great course structure and well-paced lessons. The flashcards really helped me memorize key concepts. Lost one star only because I wish there were more advanced topics covered.', 
        DATEADD(day, -10, GETUTCDATE())
    );
END
GO

-- Testimonial 3: Emma - Python Course (5 stars)
DECLARE @EmmaId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='emma.t@codesage.com');
DECLARE @PythonCourseId uniqueidentifier = (SELECT CourseId FROM Courses WHERE Title='The Garden of Python');

IF @EmmaId IS NOT NULL AND @PythonCourseId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@EmmaId AND CourseId=@PythonCourseId)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @EmmaId, 
        @PythonCourseId, 
        5, 
        'As someone who struggled with programming before, this course was a game-changer. The Garden of Python theme is adorable and the gamification kept me motivated throughout!', 
        DATEADD(day, -7, GETUTCDATE())
    );
END
GO

-- Testimonial 4: Carlos - General Platform Review (5 stars, no course)
DECLARE @CarlosId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='carlos.m@codesage.com');

IF @CarlosId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@CarlosId AND CourseId IS NULL)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @CarlosId, 
        NULL, 
        5, 
        'CodeSage is hands down the best learning platform I''ve used! The interface is beautiful, the community is supportive, and the learning path is well-designed. Can''t wait for more courses!', 
        DATEADD(day, -5, GETUTCDATE())
    );
END
GO

-- Testimonial 5: Sophia - Python Course (4 stars)
DECLARE @SophiaId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='sophia.lee@codesage.com');
DECLARE @PythonCourseId uniqueidentifier = (SELECT CourseId FROM Courses WHERE Title='The Garden of Python');

IF @SophiaId IS NOT NULL AND @PythonCourseId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@SophiaId AND CourseId=@PythonCourseId)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @SophiaId, 
        @PythonCourseId, 
        4, 
        'Excellent teaching materials and the quiz system really tests your understanding. The teacher forum is very responsive too. Would love to see more real-world project examples!', 
        DATEADD(day, -3, GETUTCDATE())
    );
END
GO

-- Testimonial 6: James - General Platform Review (5 stars, no course)
DECLARE @JamesId uniqueidentifier = (SELECT UserId FROM Profiles WHERE Email='james.w@codesage.com');

IF @JamesId IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Testimonials WHERE UserId=@JamesId AND CourseId IS NULL)
    INSERT INTO Testimonials (TestimonialId, UserId, CourseId, Rating, Comment, CreatedAt)
    VALUES (
        NEWID(), 
        @JamesId, 
        NULL, 
        5, 
        'The XP and leaderboard system makes learning addictive in the best way possible! I love competing with my classmates while actually learning valuable skills. Amazing platform!', 
        DATEADD(day, -1, GETUTCDATE())
    );
END
GO


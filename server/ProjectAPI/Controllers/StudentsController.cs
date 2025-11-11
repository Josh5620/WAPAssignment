using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;

namespace ProjectAPI.Controllers;

/// <summary>
/// Controller for student-specific operations including learning activities,
/// progress tracking, quizzes, flashcards, and forum participation.
/// </summary>
[ApiController]
[Route("api/students")]
[Authorize]
public class StudentsController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<StudentsController> _logger;

    public StudentsController(ApplicationDbContext context, ILogger<StudentsController> logger)
    {
        _context = context;
        _logger = logger;
    }

    #region Announcements & Notifications

    /// <summary>
    /// Get platform announcements with read status for the current student.
    /// </summary>
    [HttpGet("announcements")]
    public async Task<IActionResult> GetAnnouncements(
        [FromQuery] bool unreadOnly = false,
        CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user identification" });
        }

        try
        {
            var announcementQuery = _context.Announcements
                .Select(a => new
                {
                    announcementId = a.AnnouncementId,
                    title = a.Title,
                    message = a.Message,
                    createdAt = a.CreatedAt,
                    admin = new
                    {
                        userId = a.AdminId,
                        name = a.Admin.FullName
                    },
                    isRead = a.Reads.Any(r => r.UserId == userId)
                });

            if (unreadOnly)
            {
                announcementQuery = announcementQuery.Where(a => !a.isRead);
            }

            var announcements = await announcementQuery
                .OrderByDescending(a => a.createdAt)
                .ToListAsync(ct);

            return Ok(new
            {
                total = announcements.Count,
                unread = announcements.Count(a => !a.isRead),
                announcements
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving announcements for user {UserId}", userId);
            return StatusCode(500, new { error = "An error occurred while retrieving announcements." });
        }
    }

    /// <summary>
    /// Mark an announcement as read for the current student.
    /// </summary>
    [HttpPost("announcements/{announcementId:guid}/mark-read")]
    public async Task<IActionResult> MarkAnnouncementRead(Guid announcementId, CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user identification" });
        }

        try
        {
            var announcementExists = await _context.Announcements
                .AnyAsync(a => a.AnnouncementId == announcementId, ct);

            if (!announcementExists)
            {
                return NotFound(new { error = "Announcement not found." });
            }

            var existingRead = await _context.AnnouncementReads
                .FindAsync(new object[] { announcementId, userId }, ct);

            if (existingRead == null)
            {
                _context.AnnouncementReads.Add(new AnnouncementRead
                {
                    AnnouncementId = announcementId,
                    UserId = userId,
                    ReadAt = DateTime.UtcNow
                });
                await _context.SaveChangesAsync(ct);
            }

            return Ok(new
            {
                announcementId,
                readAt = DateTime.UtcNow
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error marking announcement {AnnouncementId} as read for user {UserId}", announcementId, userId);
            return StatusCode(500, new { error = "An error occurred while updating announcement status." });
        }
    }

    #endregion

    #region Learning Content

    /// <summary>
    /// Master Key Endpoint: Get complete chapter content with all related resources, questions, and flashcards
    /// </summary>
    [HttpGet("chapters/{chapterId}/content")]
    public async Task<IActionResult> GetChapterContent(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var chapter = await _context.Chapters
                .Include(ch => ch.Course)
                .Include(ch => ch.Resources)
                    .ThenInclude(r => r.Questions)
                        .ThenInclude(q => q.QuestionOptions)
                .Include(ch => ch.Resources)
                    .ThenInclude(r => r.Flashcards)
                .FirstOrDefaultAsync(ch => ch.ChapterId == chapterId, ct);

            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Build the complete response with all nested content
            var content = new
            {
                chapterId = chapter.ChapterId,
                chapterTitle = chapter.Title,
                chapterSummary = chapter.Summary,
                number = chapter.Number,
                courseId = chapter.CourseId,
                course = new
                {
                    courseId = chapter.Course.CourseId,
                    title = chapter.Course.Title,
                    description = chapter.Course.Description
                },
                content = chapter.Resources
                    .OrderBy(r => r.ResourceId)
                    .Select(r => new
                    {
                        resourceId = r.ResourceId,
                        type = r.Type,
                        content = r.Content,
                        // Include flashcards for this resource
                        flashcards = r.Flashcards
                            .OrderBy(f => f.OrderIndex)
                            .Select(f => new
                            {
                                fcId = f.FcId,
                                frontText = f.FrontText,
                                backText = f.BackText,
                                orderIndex = f.OrderIndex
                            })
                            .ToList(),
                        // Include questions with their options for this resource
                        questions = r.Questions
                            .OrderBy(q => q.QuestionId)
                            .Select(q => new
                            {
                                questionId = q.QuestionId,
                                stem = q.Stem,
                                difficulty = q.Difficulty,
                                explanation = q.Explanation,
                                options = q.QuestionOptions
                                    .OrderBy(qo => qo.OptionId)
                                    .Select(qo => new
                                    {
                                        optionId = qo.OptionId,
                                        optionText = qo.OptionText,
                                        isCorrect = qo.IsCorrect
                                    })
                                    .ToList()
                            })
                            .ToList()
                    })
                    .ToList()
            };

            return Ok(content);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving chapter content for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving chapter content" });
        }
    }

    /// <summary>
    /// Get flashcards for a specific chapter
    /// </summary>
    [HttpGet("chapters/{chapterId}/flashcards")]
    public async Task<IActionResult> GetFlashcards(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var flashcards = await _context.Flashcards
                .Include(f => f.Resource)
                    .ThenInclude(r => r.Chapter)
                .Where(f => f.Resource.ChapterId == chapterId)
                .OrderBy(f => f.OrderIndex)
                .Select(f => new
                {
                    id = f.FcId,
                    frontText = f.FrontText,
                    backText = f.BackText,
                    orderIndex = f.OrderIndex
                })
                .ToListAsync(ct);

            return Ok(flashcards);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving flashcards for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving flashcards" });
        }
    }

    /// <summary>
    /// Get quiz questions for a specific chapter (without correct answers)
    /// </summary>
    [HttpGet("chapters/{chapterId}/quizzes")]
    public async Task<IActionResult> GetQuizQuestions(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var questions = await _context.Questions
                .Include(q => q.Resource)
                    .ThenInclude(r => r.Chapter)
                .Include(q => q.QuestionOptions)
                .Where(q => q.Resource.ChapterId == chapterId)
                .Select(q => new
                {
                    questionId = q.QuestionId,
                    stem = q.Stem,
                    difficulty = q.Difficulty,
                    options = q.QuestionOptions.Select(o => new
                    {
                        optionId = o.OptionId,
                        optionText = o.OptionText
                    }).ToList()
                })
                .ToListAsync(ct);

            return Ok(questions);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving quiz questions for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving quiz questions" });
        }
    }

    #endregion

    #region Quiz Submission and Feedback

    /// <summary>
    /// Submit quiz answers, calculate score, and update chapter progress
    /// </summary>
    [HttpPost("quizzes/submit")]
    public async Task<IActionResult> SubmitQuiz([FromBody] QuizSubmissionRequest request, CancellationToken ct = default)
    {
        try
        {
            // Validate request
            if (request == null || request.ChapterId == Guid.Empty || request.Answers == null || !request.Answers.Any())
            {
                return BadRequest(new { error = "Invalid quiz submission data. ChapterId and Answers are required." });
            }

            // Get user ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            // Verify chapter exists
            var chapterExists = await _context.Chapters.AnyAsync(ch => ch.ChapterId == request.ChapterId, ct);
            if (!chapterExists)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Get all questions for this chapter with their correct answers
            var questions = await _context.Questions
                .Include(q => q.QuestionOptions)
                .Include(q => q.Resource)
                .Where(q => q.Resource.ChapterId == request.ChapterId)
                .ToListAsync(ct);

            if (!questions.Any())
            {
                return BadRequest(new { error = "No questions found for this chapter" });
            }

            // Calculate score by checking answers against QuestionOptions table
            int totalQuestions = request.Answers.Count;
            int correctAnswers = 0;
            var results = new List<object>();

            foreach (var answer in request.Answers)
            {
                var question = questions.FirstOrDefault(q => q.QuestionId == answer.QuestionId);
                
                if (question == null)
                {
                    continue; // Skip invalid question IDs
                }

                // Check if the selected option is correct
                var selectedOption = question.QuestionOptions
                    .FirstOrDefault(qo => qo.OptionId == answer.SelectedOptionId);

                bool isCorrect = selectedOption != null && selectedOption.IsCorrect;
                
                if (isCorrect)
                {
                    correctAnswers++;
                }

                // Get the correct answer for feedback
                var correctOption = question.QuestionOptions.FirstOrDefault(qo => qo.IsCorrect);

                results.Add(new
                {
                    questionId = question.QuestionId,
                    stem = question.Stem,
                    selectedOptionId = answer.SelectedOptionId,
                    selectedOptionText = selectedOption?.OptionText,
                    isCorrect,
                    correctOptionId = correctOption?.OptionId,
                    correctOptionText = correctOption?.OptionText,
                    explanation = question.Explanation
                });
            }

            // Calculate percentage score
            var scorePercentage = totalQuestions > 0 ? (int)Math.Round((double)correctAnswers / totalQuestions * 100) : 0;

            // Update ChapterProgress table for this user and chapter
            var existingProgress = await _context.ChapterProgress
                .FirstOrDefaultAsync(cp => cp.UserId == userId && cp.ChapterId == request.ChapterId, ct);

            if (existingProgress != null)
            {
                // Update existing progress
                existingProgress.Completed = true;
                existingProgress.McqsAttempted = totalQuestions;
                existingProgress.McqsCorrect = correctAnswers;
                existingProgress.CompletedAt = DateTime.UtcNow;
                _context.ChapterProgress.Update(existingProgress);
            }
            else
            {
                // Create new progress record
                var newProgress = new ChapterProgress
                {
                    UserId = userId,
                    ChapterId = request.ChapterId,
                    Completed = true,
                    McqsAttempted = totalQuestions,
                    McqsCorrect = correctAnswers,
                    CompletedAt = DateTime.UtcNow
                };
                await _context.ChapterProgress.AddAsync(newProgress, ct);
            }

            await _context.SaveChangesAsync(ct);

            // Return results
            return Ok(new
            {
                chapterId = request.ChapterId,
                userId,
                score = scorePercentage,
                correctAnswers,
                totalQuestions,
                passed = scorePercentage >= 70, // 70% passing threshold
                completedAt = DateTime.UtcNow,
                results,
                message = scorePercentage >= 70 
                    ? "Congratulations! You passed this chapter!" 
                    : "Keep practicing! You can retake the quiz to improve your score."
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error submitting quiz for chapter {ChapterId}", request?.ChapterId);
            return StatusCode(500, new { error = "An error occurred while submitting your quiz" });
        }
    }

    /// <summary>
    /// Get hints for a specific question
    /// </summary>
    [HttpGet("questions/{questionId}/hint")]
    public async Task<IActionResult> GetQuestionHint(Guid questionId, CancellationToken ct = default)
    {
        try
        {
            var question = await _context.Questions
                .FirstOrDefaultAsync(q => q.QuestionId == questionId, ct);

            if (question == null)
            {
                return NotFound(new { error = "Question not found" });
            }

            // Generate hint based on difficulty and explanation
            var hint = GenerateHint(question.Difficulty, question.Explanation, question.Stem);

            return Ok(new
            {
                questionId = question.QuestionId,
                hint = hint,
                difficulty = question.Difficulty
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving hint for question {QuestionId}", questionId);
            return StatusCode(500, new { error = "An error occurred while retrieving the hint" });
        }
    }

    #endregion

    #region Progress Tracking

    /// <summary>
    /// Get the logged-in student's progress across all chapters
    /// </summary>
    [HttpGet("progress")]
    public async Task<IActionResult> GetProgress(CancellationToken ct = default)
    {
        try
        {
            // Get user ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            // Get all chapter progress for this user
            var progress = await _context.ChapterProgress
                .Include(cp => cp.Chapter)
                    .ThenInclude(ch => ch.Course)
                .Where(cp => cp.UserId == userId)
                .Select(cp => new
                {
                    userId = cp.UserId,
                    chapterId = cp.ChapterId,
                    completed = cp.Completed,
                    mcqsAttempted = cp.McqsAttempted,
                    mcqsCorrect = cp.McqsCorrect,
                    score = cp.McqsAttempted > 0 ? (int)Math.Round((double)cp.McqsCorrect / cp.McqsAttempted * 100) : 0,
                    completedAt = cp.CompletedAt,
                    chapter = new
                    {
                        chapterId = cp.Chapter.ChapterId,
                        number = cp.Chapter.Number,
                        title = cp.Chapter.Title,
                        summary = cp.Chapter.Summary,
                        courseId = cp.Chapter.CourseId
                    },
                    course = new
                    {
                        courseId = cp.Chapter.Course.CourseId,
                        title = cp.Chapter.Course.Title
                    }
                })
                .OrderBy(cp => cp.course.title)
                    .ThenBy(cp => cp.chapter.number)
                .ToListAsync(ct);

            return Ok(new
            {
                userId,
                totalChapters = progress.Count,
                completedChapters = progress.Count(p => p.completed),
                averageScore = progress.Any() 
                    ? progress.Average(p => p.score) 
                    : 0,
                progress
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving student progress");
            return StatusCode(500, new { error = "An error occurred while retrieving your progress" });
        }
    }

    /// <summary>
    /// Get student's progress for all enrolled courses
    /// </summary>
    [HttpGet("{userId}/progress")]
    public async Task<IActionResult> GetStudentProgress(Guid userId, CancellationToken ct = default)
    {
        try
        {
            var userExists = await _context.Profiles.AnyAsync(p => p.UserId == userId, ct);
            if (!userExists)
            {
                return NotFound(new { error = "User not found" });
            }

            var enrolments = await _context.Enrolments
                .Include(e => e.Course)
                    .ThenInclude(c => c.Chapters)
                .Where(e => e.UserId == userId)
                .ToListAsync(ct);

            var progressData = new List<CourseProgressDto>();

            foreach (var enrolment in enrolments)
            {
                var chapterProgress = await _context.ChapterProgress
                    .Where(cp => cp.UserId == userId && cp.Chapter.CourseId == enrolment.CourseId)
                    .ToListAsync(ct);

                var completedChapters = chapterProgress.Count(cp => cp.Completed);
                var totalChapters = enrolment.Course.Chapters.Count;
                var totalMcqsAttempted = chapterProgress.Sum(cp => cp.McqsAttempted);
                var totalMcqsCorrect = chapterProgress.Sum(cp => cp.McqsCorrect);

                progressData.Add(new CourseProgressDto
                {
                    CourseId = enrolment.CourseId,
                    CourseTitle = enrolment.Course.Title,
                    CompletedChapters = completedChapters,
                    TotalChapters = totalChapters,
                    ProgressPercentage = totalChapters > 0 ? (double)completedChapters / totalChapters * 100 : 0,
                    TotalMcqsAttempted = totalMcqsAttempted,
                    TotalMcqsCorrect = totalMcqsCorrect,
                    McqAccuracy = totalMcqsAttempted > 0 ? (double)totalMcqsCorrect / totalMcqsAttempted * 100 : 0
                });
            }

            return Ok(progressData);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving progress for user {UserId}", userId);
            return StatusCode(500, new { error = "An error occurred while retrieving progress" });
        }
    }

    /// <summary>
    /// Get detailed progress for a specific chapter
    /// </summary>
    [HttpGet("{userId}/chapters/{chapterId}/progress")]
    public async Task<IActionResult> GetChapterProgress(Guid userId, Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var progress = await _context.ChapterProgress
                .Include(cp => cp.Chapter)
                .FirstOrDefaultAsync(cp => cp.UserId == userId && cp.ChapterId == chapterId, ct);

            if (progress == null)
            {
                // Return default progress if not found
                return Ok(new
                {
                    userId = userId,
                    chapterId = chapterId,
                    completed = false,
                    mcqsAttempted = 0,
                    mcqsCorrect = 0
                });
            }

            return Ok(new
            {
                userId = progress.UserId,
                chapterId = progress.ChapterId,
                completed = progress.Completed,
                mcqsAttempted = progress.McqsAttempted,
                mcqsCorrect = progress.McqsCorrect,
                accuracy = progress.McqsAttempted > 0 
                    ? (double)progress.McqsCorrect / progress.McqsAttempted * 100 
                    : 0
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving chapter progress for user {UserId}, chapter {ChapterId}", userId, chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving chapter progress" });
        }
    }

    /// <summary>
    /// Mark a chapter as completed
    /// </summary>
    [HttpPost("{userId}/chapters/{chapterId}/complete")]
    public async Task<IActionResult> MarkChapterComplete(Guid userId, Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var progress = await _context.ChapterProgress
                .FirstOrDefaultAsync(cp => cp.UserId == userId && cp.ChapterId == chapterId, ct);

            if (progress == null)
            {
                progress = new ChapterProgress
                {
                    UserId = userId,
                    ChapterId = chapterId,
                    Completed = true,
                    McqsAttempted = 0,
                    McqsCorrect = 0
                };
                _context.ChapterProgress.Add(progress);
            }
            else
            {
                progress.Completed = true;
            }

            await _context.SaveChangesAsync(ct);

            // Award XP for completing a chapter
            await AwardXPAsync(userId, 50, ct); // Base XP for chapter completion

            return Ok(new
            {
                message = "Chapter marked as completed",
                xpAwarded = 50
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error marking chapter complete for user {UserId}, chapter {ChapterId}", userId, chapterId);
            return StatusCode(500, new { error = "An error occurred while marking chapter as complete" });
        }
    }

    #endregion

    #region Profile Management

    /// <summary>
    /// Update student profile information
    /// </summary>
    [HttpPatch("{userId}/profile")]
    public async Task<IActionResult> UpdateStudentProfile(Guid userId, [FromBody] UpdateStudentProfileRequest request, CancellationToken ct = default)
    {
        try
        {
            var profile = await _context.Profiles.FindAsync(new object[] { userId }, ct);
            if (profile == null)
            {
                return NotFound(new { error = "Profile not found" });
            }

            if (profile.Role != "student")
            {
                return Forbid("This endpoint is only for students");
            }

            if (!string.IsNullOrWhiteSpace(request.FullName))
            {
                profile.FullName = request.FullName;
            }

            if (!string.IsNullOrWhiteSpace(request.Email))
            {
                // Check if email is already taken by another user
                var emailExists = await _context.Profiles
                    .AnyAsync(p => p.Email == request.Email && p.UserId != userId, ct);
                
                if (emailExists)
                {
                    return Conflict(new { error = "Email is already in use" });
                }

                profile.Email = request.Email;
            }

            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                userId = profile.UserId,
                fullName = profile.FullName,
                email = profile.Email,
                role = profile.Role
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating profile for user {UserId}", userId);
            return StatusCode(500, new { error = "An error occurred while updating profile" });
        }
    }

    /// <summary>
    /// Get student profile information
    /// </summary>
    [HttpGet("{userId}/profile")]
    public async Task<IActionResult> GetStudentProfile(Guid userId, CancellationToken ct = default)
    {
        try
        {
            var profile = await _context.Profiles
                .Include(p => p.Leaderboard)
                .FirstOrDefaultAsync(p => p.UserId == userId, ct);

            if (profile == null)
            {
                return NotFound(new { error = "Profile not found" });
            }

            return Ok(new
            {
                userId = profile.UserId,
                fullName = profile.FullName,
                email = profile.Email,
                role = profile.Role,
                createdAt = profile.CreatedAt,
                leaderboard = profile.Leaderboard != null ? new
                {
                    xp = profile.Leaderboard.XP,
                    streaks = profile.Leaderboard.Streaks,
                    badges = profile.Leaderboard.Badges
                } : null
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving profile for user {UserId}", userId);
            return StatusCode(500, new { error = "An error occurred while retrieving profile" });
        }
    }

    #endregion

    #region Forum Participation

    /// <summary>
    /// Get forum posts for a course (students can view all posts)
    /// </summary>
    [HttpGet("forums/courses/{courseId}/posts")]
    public async Task<IActionResult> GetForumPosts(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            var posts = await _context.ForumPosts
                .Include(fp => fp.Profile)
                .Include(fp => fp.Course)
                .Where(fp => fp.CourseId == courseId)
                .OrderByDescending(fp => fp.CreatedAt)
                .Select(fp => new
                {
                    forumId = fp.ForumId,
                    userId = fp.UserId,
                    userName = fp.Profile.FullName,
                    userEmail = fp.Profile.Email,
                    content = fp.Content,
                    createdAt = fp.CreatedAt,
                    courseId = fp.CourseId,
                    courseTitle = fp.Course.Title,
                    commentCount = fp.Comments.Count
                })
                .ToListAsync(ct);

            return Ok(posts);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving forum posts for course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while retrieving forum posts" });
        }
    }

    /// <summary>
    /// Create a new forum post (students can post)
    /// </summary>
    [HttpPost("forums/posts")]
    public async Task<IActionResult> CreateForumPost([FromBody] CreateForumPostRequest request, CancellationToken ct = default)
    {
        try
        {
            if (request == null || string.IsNullOrWhiteSpace(request.Content))
            {
                return BadRequest(new { error = "Post content is required" });
            }

            // Verify user exists and is a student
            var profile = await _context.Profiles.FindAsync(new object[] { request.UserId }, ct);
            if (profile == null)
            {
                return NotFound(new { error = "User not found" });
            }

            // Verify course exists
            var courseExists = await _context.Courses.AnyAsync(c => c.CourseId == request.CourseId, ct);
            if (!courseExists)
            {
                return NotFound(new { error = "Course not found" });
            }

            // Verify user is enrolled in the course
            var isEnrolled = await _context.Enrolments
                .AnyAsync(e => e.UserId == request.UserId && e.CourseId == request.CourseId, ct);

            if (!isEnrolled && profile.Role != "admin" && profile.Role != "teacher")
            {
                return Forbid("You must be enrolled in the course to post in its forum");
            }

            var forumPost = new ForumPost
            {
                ForumId = Guid.NewGuid(),
                UserId = request.UserId,
                CourseId = request.CourseId,
                Content = request.Content,
                CreatedAt = DateTime.UtcNow
            };

            _context.ForumPosts.Add(forumPost);
            await _context.SaveChangesAsync(ct);

            // Award XP for forum participation
            await AwardXPAsync(request.UserId, 10, ct);

            return CreatedAtAction(
                nameof(GetForumPosts),
                new { courseId = request.CourseId },
                new
                {
                    forumId = forumPost.ForumId,
                    userId = forumPost.UserId,
                    courseId = forumPost.CourseId,
                    content = forumPost.Content,
                    createdAt = forumPost.CreatedAt,
                    xpAwarded = 10
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating forum post for user {UserId}", request?.UserId);
            return StatusCode(500, new { error = "An error occurred while creating the forum post" });
        }
    }

    /// <summary>
    /// Get comments for a forum post (nested thread).
    /// </summary>
    [HttpGet("forums/posts/{forumId}/comments")]
    public async Task<IActionResult> GetForumComments(Guid forumId, CancellationToken ct = default)
    {
        try
        {
            var forumExists = await _context.ForumPosts
                .AnyAsync(fp => fp.ForumId == forumId, ct);

            if (!forumExists)
            {
                return NotFound(new { error = "Forum post not found" });
            }

            var comments = await _context.ForumComments
                .Include(fc => fc.Profile)
                .Where(fc => fc.ForumId == forumId)
                .OrderBy(fc => fc.CreatedAt)
                .ToListAsync(ct);

            var commentTree = BuildCommentTree(comments);

            return Ok(new
            {
                forumId,
                total = comments.Count,
                comments = commentTree
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving comments for forum {ForumId}", forumId);
            return StatusCode(500, new { error = "An error occurred while retrieving comments" });
        }
    }

    /// <summary>
    /// Add a comment or reply to a forum post.
    /// </summary>
    [HttpPost("forums/posts/{forumId}/comments")]
    public async Task<IActionResult> CreateForumComment(
        Guid forumId,
        [FromBody] CreateForumCommentRequest request,
        CancellationToken ct = default)
    {
        if (request == null || string.IsNullOrWhiteSpace(request.Content))
        {
            return BadRequest(new { error = "Comment content is required" });
        }

        try
        {
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);

            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            var profile = await _context.Profiles.FindAsync(new object[] { userId }, ct);
            if (profile == null)
            {
                return NotFound(new { error = "Profile not found" });
            }

            var forumPost = await _context.ForumPosts
                .Include(fp => fp.Course)
                .FirstOrDefaultAsync(fp => fp.ForumId == forumId, ct);

            if (forumPost == null)
            {
                return NotFound(new { error = "Forum post not found" });
            }

            var isEnrolled = await _context.Enrolments
                .AnyAsync(e => e.UserId == userId && e.CourseId == forumPost.CourseId, ct);

            if (!isEnrolled && profile.Role == "student")
            {
                return Forbid("You must be enrolled in the course to comment on this forum.");
            }

            if (request.ParentCommentId.HasValue)
            {
                var parentComment = await _context.ForumComments
                    .AnyAsync(fc => fc.CommentId == request.ParentCommentId.Value && fc.ForumId == forumId, ct);

                if (!parentComment)
                {
                    return BadRequest(new { error = "Parent comment not found in this thread." });
                }
            }

            var comment = new ForumComment
            {
                CommentId = Guid.NewGuid(),
                ForumId = forumId,
                UserId = userId,
                ParentCommentId = request.ParentCommentId,
                Content = request.Content.Trim(),
                CreatedAt = DateTime.UtcNow
            };

            _context.ForumComments.Add(comment);
            await _context.SaveChangesAsync(ct);

            await AwardXPAsync(userId, 5, ct);

            return CreatedAtAction(
                nameof(GetForumComments),
                new { forumId },
                new
                {
                    commentId = comment.CommentId,
                    forumId = comment.ForumId,
                    parentCommentId = comment.ParentCommentId,
                    content = comment.Content,
                    createdAt = comment.CreatedAt,
                    user = new
                    {
                        userId = profile.UserId,
                        name = profile.FullName,
                        email = profile.Email
                    },
                    xpAwarded = 5
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating comment for forum {ForumId}", forumId);
            return StatusCode(500, new { error = "An error occurred while creating the comment" });
        }
    }

    #endregion

    #region Leaderboard

    /// <summary>
    /// Get leaderboard with student's position
    /// </summary>
    [HttpGet("leaderboard")]
    public async Task<IActionResult> GetLeaderboard([FromQuery] Guid? userId = null, CancellationToken ct = default)
    {
        try
        {
            var leaderboard = await _context.Leaderboards
                .Include(l => l.Profile)
                .OrderByDescending(l => l.XP)
                .ThenByDescending(l => l.Streaks)
                .Select(l => new
                {
                    userId = l.UserId,
                    userName = l.Profile.FullName,
                    xp = l.XP,
                    streaks = l.Streaks,
                    badges = l.Badges
                })
                .ToListAsync(ct);

            // Calculate rank
            var leaderboardWithRank = leaderboard.Select((entry, index) => new
            {
                rank = index + 1,
                userId = entry.userId,
                userName = entry.userName,
                xp = entry.xp,
                streaks = entry.streaks,
                badges = entry.badges,
                isCurrentUser = userId.HasValue && entry.userId == userId.Value
            }).ToList();

            return Ok(leaderboardWithRank);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving leaderboard");
            return StatusCode(500, new { error = "An error occurred while retrieving the leaderboard" });
        }
    }

    #endregion

    #region Helper Methods

    private async Task UpdateChapterProgressAsync(Guid userId, Guid chapterId, int mcqsAttempted, int mcqsCorrect, CancellationToken ct)
    {
        var progress = await _context.ChapterProgress
            .FirstOrDefaultAsync(cp => cp.UserId == userId && cp.ChapterId == chapterId, ct);

        if (progress == null)
        {
            progress = new ChapterProgress
            {
                UserId = userId,
                ChapterId = chapterId,
                Completed = false,
                McqsAttempted = mcqsAttempted,
                McqsCorrect = mcqsCorrect
            };
            _context.ChapterProgress.Add(progress);
        }
        else
        {
            progress.McqsAttempted += mcqsAttempted;
            progress.McqsCorrect += mcqsCorrect;
        }

        await _context.SaveChangesAsync(ct);
    }

    private async Task AwardXPAsync(Guid userId, int xpAmount, CancellationToken ct)
    {
        var leaderboard = await _context.Leaderboards
            .FirstOrDefaultAsync(l => l.UserId == userId, ct);

        if (leaderboard == null)
        {
            leaderboard = new Leaderboard
            {
                UserId = userId,
                XP = xpAmount,
                Streaks = 0,
                Badges = null
            };
            _context.Leaderboards.Add(leaderboard);
        }
        else
        {
            leaderboard.XP += xpAmount;
        }

        await _context.SaveChangesAsync(ct);
    }

    private static List<ForumCommentResponse> BuildCommentTree(List<ForumComment> comments)
    {
        var lookup = comments.ToDictionary(
            c => c.CommentId,
            c => new ForumCommentResponse
            {
                CommentId = c.CommentId,
                ForumId = c.ForumId,
                ParentCommentId = c.ParentCommentId,
                Content = c.Content,
                CreatedAt = c.CreatedAt,
                User = new SimpleUserDto
                {
                    UserId = c.UserId,
                    FullName = c.Profile.FullName,
                    Email = c.Profile.Email
                }
            });

        var roots = new List<ForumCommentResponse>();

        foreach (var comment in lookup.Values)
        {
            if (comment.ParentCommentId.HasValue &&
                lookup.TryGetValue(comment.ParentCommentId.Value, out var parent))
            {
                parent.Replies.Add(comment);
            }
            else
            {
                roots.Add(comment);
            }
        }

        return roots
            .OrderBy(c => c.CreatedAt)
            .ToList();
    }

    private int CalculateXPAwarded(int correct, int total)
    {
        if (total == 0) return 0;

        var accuracy = (double)correct / total;
        
        // Base XP: 10 points per correct answer
        var baseXP = correct * 10;
        
        // Bonus for perfect score
        if (accuracy == 1.0)
        {
            baseXP += 50;
        }
        // Bonus for high accuracy (80%+)
        else if (accuracy >= 0.8)
        {
            baseXP += 20;
        }

        return baseXP;
    }

    private string GenerateHint(string difficulty, string? explanation, string stem)
    {
        if (!string.IsNullOrWhiteSpace(explanation))
        {
            // Return a simplified version of the explanation as a hint
            return difficulty.ToLower() switch
            {
                "easy" => explanation.Length > 100 ? explanation.Substring(0, 100) + "..." : explanation,
                "medium" => explanation.Length > 50 ? explanation.Substring(0, 50) + "..." : explanation,
                "hard" => "Think carefully about the key concepts in this question.",
                _ => explanation
            };
        }

        // Generate generic hints based on difficulty
        return difficulty.ToLower() switch
        {
            "easy" => "This is a straightforward question. Review the basic concepts.",
            "medium" => "Think about the relationships between the concepts mentioned.",
            "hard" => "This requires deeper understanding. Consider all aspects of the topic.",
            _ => "Review the lesson material for this chapter."
        };
    }

    #endregion
}

#region DTOs

public record QuizSubmissionRequest
{
    [Required]
    public Guid ChapterId { get; init; }

    [Required]
    public List<AnswerSubmission> Answers { get; init; } = new();
}

public record AnswerSubmission
{
    [Required]
    public Guid QuestionId { get; init; }

    [Required]
    public Guid SelectedOptionId { get; init; }
}

public record QuizSubmissionResponse
{
    public int TotalQuestions { get; init; }
    public int TotalCorrect { get; init; }
    public double Score { get; init; }
    public int XPAwarded { get; init; }
    public List<QuestionResultDto> Results { get; init; } = new();
}

public record QuestionResultDto
{
    public Guid QuestionId { get; init; }
    public bool IsCorrect { get; init; }
    public string Feedback { get; init; } = string.Empty;
    public string? Explanation { get; init; }
    public Guid? CorrectOptionId { get; init; }
}

public record CourseProgressDto
{
    public Guid CourseId { get; init; }
    public string CourseTitle { get; init; } = string.Empty;
    public int CompletedChapters { get; init; }
    public int TotalChapters { get; init; }
    public double ProgressPercentage { get; init; }
    public int TotalMcqsAttempted { get; init; }
    public int TotalMcqsCorrect { get; init; }
    public double McqAccuracy { get; init; }
}

public record UpdateStudentProfileRequest
{
    public string? FullName { get; init; }
    [EmailAddress]
    public string? Email { get; init; }
}

public record CreateForumPostRequest
{
    [Required]
    public Guid UserId { get; init; }

    [Required]
    public Guid CourseId { get; init; }

    [Required]
    [MinLength(1)]
    public string Content { get; init; } = string.Empty;
}

public record CreateForumCommentRequest
{
    [Required]
    [MinLength(1)]
    public string Content { get; init; } = string.Empty;

    public Guid? ParentCommentId { get; init; }
}

public class ForumCommentResponse
{
    public Guid CommentId { get; init; }
    public Guid ForumId { get; init; }
    public Guid? ParentCommentId { get; init; }
    public string Content { get; init; } = string.Empty;
    public DateTime CreatedAt { get; init; }
    public SimpleUserDto User { get; init; } = null!;
    public List<ForumCommentResponse> Replies { get; } = new();
}

public class SimpleUserDto
{
    public Guid UserId { get; init; }
    public string FullName { get; init; } = string.Empty;
    public string Email { get; init; } = string.Empty;
}

#endregion


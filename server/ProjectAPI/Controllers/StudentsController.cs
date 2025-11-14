using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;
using System.Linq;
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

    #region Enrollments

    [HttpGet("my-courses")]
    public async Task<IActionResult> GetMyCourses(CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user context." });
        }

        var enrolments = await _context.Enrolments
            .Where(e => e.UserId == userId)
            .Include(e => e.Course)
            .OrderBy(e => e.EnrolledAt)
            .Select(e => new
            {
                enrollmentId = e.EnrolmentId,
                e.CourseId,
                courseTitle = e.Course.Title,
                courseDescription = e.Course.Description,
                e.Status,
                e.EnrolledAt
            })
            .ToListAsync(ct);

        return Ok(new
        {
            total = enrolments.Count,
            courses = enrolments
        });
    }

    [HttpPost("enrollments")]
    public async Task<IActionResult> EnrollInCourse([FromBody] EnrollInCourseRequest request, CancellationToken ct = default)
    {
        if (request == null || request.CourseId == Guid.Empty)
        {
            return BadRequest(new { error = "CourseId is required." });
        }

        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user context." });
        }

        var course = await _context.Courses.FirstOrDefaultAsync(c => c.CourseId == request.CourseId, ct);
        if (course == null)
        {
            return NotFound(new { error = "Course not found." });
        }

        var existing = await _context.Enrolments
            .AnyAsync(e => e.CourseId == request.CourseId && e.UserId == userId, ct);

        if (existing)
        {
            return Conflict(new { error = "You are already enrolled in this course." });
        }

        var enrolment = new Enrolment
        {
            CourseId = request.CourseId,
            UserId = userId,
            Status = "active",
            EnrolledAt = DateTime.UtcNow
        };

        _context.Enrolments.Add(enrolment);
        await _context.SaveChangesAsync(ct);

        return Ok(new
        {
            enrollmentId = enrolment.EnrolmentId,
            enrolment.CourseId,
            enrolment.Status,
            enrolment.EnrolledAt
        });
    }

    [HttpDelete("enrollments/{enrollmentId:guid}")]
    public async Task<IActionResult> Unenroll(Guid enrollmentId, CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user context." });
        }

        var enrolment = await _context.Enrolments
            .FirstOrDefaultAsync(e => e.EnrolmentId == enrollmentId && e.UserId == userId, ct);

        if (enrolment == null)
        {
            return NotFound(new { error = "Enrollment not found." });
        }

        _context.Enrolments.Remove(enrolment);
        await _context.SaveChangesAsync(ct);

        return NoContent();
    }

    #endregion

    #region Certificates

    [HttpGet("certificates")]
    public async Task<IActionResult> GetMyCertificates(CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { error = "Invalid or missing user context." });
        }

        var certificates = await _context.Certificates
            .Where(c => c.StudentId == userId)
            .Include(c => c.Course)
            .OrderByDescending(c => c.IssueDate)
            .Select(c => new
            {
                certificateId = c.CertificateId,
                c.CourseId,
                courseTitle = c.Course.Title,
                c.IssueDate,
                c.CertificateUrl
            })
            .ToListAsync(ct);

        return Ok(certificates);
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
                    questionType = q.QuestionType ?? "multiple_choice",
                    options = q.QuestionOptions.Select(o => new
                    {
                        optionId = o.OptionId,
                        optionText = o.OptionText
                    }).ToList()
                })
                .ToListAsync(ct);

            if (questions.Count == 0)
            {
                return Ok(new List<object>());
            }

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
    /// Get quiz information including time limit and attempt limits
    /// </summary>
    [HttpGet("quizzes/chapters/{chapterId}/info")]
    public async Task<IActionResult> GetQuizInfo(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            var chapter = await _context.Chapters
                .FirstOrDefaultAsync(ch => ch.ChapterId == chapterId, ct);

            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Get attempt count for this user and chapter
            var attemptCount = await _context.QuizAttempts
                .CountAsync(qa => qa.UserId == userId && qa.ChapterId == chapterId, ct);

            // Get questions count
            var questionCount = await _context.Questions
                .Include(q => q.Resource)
                .CountAsync(q => q.Resource.ChapterId == chapterId, ct);

            return Ok(new
            {
                chapterId,
                timeLimitSeconds = chapter.QuizTimeLimitSeconds,
                maxAttempts = chapter.MaxQuizAttempts,
                currentAttemptCount = attemptCount,
                remainingAttempts = chapter.MaxQuizAttempts.HasValue 
                    ? Math.Max(0, chapter.MaxQuizAttempts.Value - attemptCount)
                    : (int?)null,
                totalQuestions = questionCount,
                canAttempt = !chapter.MaxQuizAttempts.HasValue || attemptCount < chapter.MaxQuizAttempts.Value
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting quiz info for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while getting quiz information" });
        }
    }

    /// <summary>
    /// Start a new quiz attempt (tracks timer start)
    /// </summary>
    [HttpPost("quizzes/start")]
    public async Task<IActionResult> StartQuiz([FromBody] StartQuizRequest request, CancellationToken ct = default)
    {
        try
        {
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            var chapter = await _context.Chapters
                .FirstOrDefaultAsync(ch => ch.ChapterId == request.ChapterId, ct);

            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Check attempt limit
            if (chapter.MaxQuizAttempts.HasValue)
            {
                var attemptCount = await _context.QuizAttempts
                    .CountAsync(qa => qa.UserId == userId && qa.ChapterId == request.ChapterId, ct);

                if (attemptCount >= chapter.MaxQuizAttempts.Value)
                {
                    return BadRequest(new { error = $"Maximum attempts ({chapter.MaxQuizAttempts.Value}) reached for this quiz." });
                }
            }

            var attempt = new QuizAttempt
            {
                AttemptId = Guid.NewGuid(),
                UserId = userId,
                ChapterId = request.ChapterId,
                TimeLimitSeconds = chapter.QuizTimeLimitSeconds,
                StartedAt = DateTime.UtcNow,
                CompletedInTime = true
            };

            _context.QuizAttempts.Add(attempt);
            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                attemptId = attempt.AttemptId,
                chapterId = request.ChapterId,
                timeLimitSeconds = attempt.TimeLimitSeconds,
                startedAt = attempt.StartedAt
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error starting quiz for chapter {ChapterId}", request?.ChapterId);
            return StatusCode(500, new { error = "An error occurred while starting the quiz" });
        }
    }

    /// <summary>
    /// Get quiz attempt history for a chapter
    /// </summary>
    [HttpGet("quizzes/chapters/{chapterId}/history")]
    public async Task<IActionResult> GetQuizHistory(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            var attempts = await _context.QuizAttempts
                .Where(qa => qa.UserId == userId && qa.ChapterId == chapterId)
                .OrderByDescending(qa => qa.StartedAt)
                .Select(qa => new
                {
                    attemptId = qa.AttemptId,
                    scorePercentage = qa.ScorePercentage,
                    correctAnswers = qa.CorrectAnswers,
                    totalQuestions = qa.TotalQuestions,
                    passed = qa.Passed,
                    timeSpentSeconds = qa.TimeSpentSeconds,
                    timeLimitSeconds = qa.TimeLimitSeconds,
                    completedInTime = qa.CompletedInTime,
                    startedAt = qa.StartedAt,
                    submittedAt = qa.SubmittedAt
                })
                .ToListAsync(ct);

            return Ok(new
            {
                chapterId,
                totalAttempts = attempts.Count,
                attempts
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting quiz history for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving quiz history" });
        }
    }

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

            // Verify chapter exists and get it
            var chapter = await _context.Chapters
                .FirstOrDefaultAsync(ch => ch.ChapterId == request.ChapterId, ct);
            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Check attempt limit if this is a new attempt
            QuizAttempt? attempt = null;
            if (request.AttemptId.HasValue)
            {
                attempt = await _context.QuizAttempts
                    .FirstOrDefaultAsync(qa => qa.AttemptId == request.AttemptId.Value && qa.UserId == userId, ct);
                if (attempt == null)
                {
                    return NotFound(new { error = "Quiz attempt not found" });
                }
            }
            else
            {
                // Check attempt limit for new attempts
                if (chapter.MaxQuizAttempts.HasValue)
                {
                    var attemptCount = await _context.QuizAttempts
                        .CountAsync(qa => qa.UserId == userId && qa.ChapterId == request.ChapterId, ct);

                    if (attemptCount >= chapter.MaxQuizAttempts.Value)
                    {
                        return BadRequest(new { error = $"Maximum attempts ({chapter.MaxQuizAttempts.Value}) reached for this quiz." });
                    }
                }
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

            // Calculate score by checking answers - supports different question types
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

                bool isCorrect = false;
                string? selectedAnswerText = null;
                string? correctAnswerText = null;

                // Handle different question types
                switch (question.QuestionType.ToLower())
                {
                    case "multiple_choice":
                        // Multiple choice: check SelectedOptionId
                        if (Guid.TryParse(answer.SelectedOptionId, out var optionId))
                        {
                            var selectedOption = question.QuestionOptions
                                .FirstOrDefault(qo => qo.OptionId == optionId);
                            isCorrect = selectedOption != null && selectedOption.IsCorrect;
                            selectedAnswerText = selectedOption?.OptionText;
                            var correctOption = question.QuestionOptions.FirstOrDefault(qo => qo.IsCorrect);
                            correctAnswerText = correctOption?.OptionText;
                        }
                        break;

                    case "true_false":
                        // True/False: check if SelectedOptionId matches "true" or "false"
                        var correctTFOption = question.QuestionOptions.FirstOrDefault(qo => qo.IsCorrect);
                        if (correctTFOption != null && answer.SelectedOptionId != null)
                        {
                            // Compare the option text or check if it's the correct option
                            var selectedTFOption = question.QuestionOptions
                                .FirstOrDefault(qo => qo.OptionText.ToLower() == answer.SelectedOptionId.ToLower());
                            isCorrect = selectedTFOption != null && selectedTFOption.IsCorrect;
                            selectedAnswerText = answer.SelectedOptionId;
                            correctAnswerText = correctTFOption.OptionText;
                        }
                        break;

                    case "short_answer":
                    case "essay":
                        // Text-based questions: compare with ExpectedAnswer (case-insensitive for short_answer)
                        if (!string.IsNullOrWhiteSpace(answer.TextAnswer) && !string.IsNullOrWhiteSpace(question.ExpectedAnswer))
                        {
                            if (question.QuestionType.ToLower() == "short_answer")
                            {
                                // Case-insensitive comparison for short answer
                                isCorrect = answer.TextAnswer.Trim().Equals(question.ExpectedAnswer.Trim(), StringComparison.OrdinalIgnoreCase);
                            }
                            else
                            {
                                // Essay questions might need manual grading, but for now we'll do exact match
                                isCorrect = answer.TextAnswer.Trim().Equals(question.ExpectedAnswer.Trim(), StringComparison.OrdinalIgnoreCase);
                            }
                            selectedAnswerText = answer.TextAnswer;
                            correctAnswerText = question.ExpectedAnswer;
                        }
                        break;

                    default:
                        // Default to multiple choice behavior
                        if (Guid.TryParse(answer.SelectedOptionId, out var defaultOptionId))
                        {
                            var defaultOption = question.QuestionOptions
                                .FirstOrDefault(qo => qo.OptionId == defaultOptionId);
                            isCorrect = defaultOption != null && defaultOption.IsCorrect;
                            selectedAnswerText = defaultOption?.OptionText;
                            var defaultCorrectOption = question.QuestionOptions.FirstOrDefault(qo => qo.IsCorrect);
                            correctAnswerText = defaultCorrectOption?.OptionText;
                        }
                        break;
                }
                
                if (isCorrect)
                {
                    correctAnswers++;
                }

                results.Add(new
                {
                    questionId = question.QuestionId,
                    questionType = question.QuestionType,
                    stem = question.Stem,
                    selectedAnswer = selectedAnswerText,
                    isCorrect,
                    correctAnswer = correctAnswerText,
                    explanation = question.Explanation
                });
            }

            // Calculate percentage score
            var scorePercentage = totalQuestions > 0 ? (int)Math.Round((double)correctAnswers / totalQuestions * 100) : 0;
            var passed = scorePercentage >= 70; // 70% passing threshold

            // Check if completed within time limit
            bool completedInTime = true;
            if (attempt != null && attempt.TimeLimitSeconds.HasValue && request.TimeSpentSeconds.HasValue)
            {
                completedInTime = request.TimeSpentSeconds.Value <= attempt.TimeLimitSeconds.Value;
            }

            // Save or update quiz attempt
            if (attempt == null)
            {
                attempt = new QuizAttempt
                {
                    AttemptId = Guid.NewGuid(),
                    UserId = userId,
                    ChapterId = request.ChapterId,
                    TimeLimitSeconds = chapter.QuizTimeLimitSeconds,
                    TimeSpentSeconds = request.TimeSpentSeconds,
                    ScorePercentage = scorePercentage,
                    CorrectAnswers = correctAnswers,
                    TotalQuestions = totalQuestions,
                    Passed = passed,
                    CompletedInTime = completedInTime,
                    StartedAt = DateTime.UtcNow,
                    SubmittedAt = DateTime.UtcNow,
                    ResultsJson = System.Text.Json.JsonSerializer.Serialize(results)
                };
                _context.QuizAttempts.Add(attempt);
            }
            else
            {
                attempt.TimeSpentSeconds = request.TimeSpentSeconds;
                attempt.ScorePercentage = scorePercentage;
                attempt.CorrectAnswers = correctAnswers;
                attempt.TotalQuestions = totalQuestions;
                attempt.Passed = passed;
                attempt.CompletedInTime = completedInTime;
                attempt.SubmittedAt = DateTime.UtcNow;
                attempt.ResultsJson = System.Text.Json.JsonSerializer.Serialize(results);
                _context.QuizAttempts.Update(attempt);
            }

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
                attemptId = attempt.AttemptId,
                chapterId = request.ChapterId,
                userId,
                score = scorePercentage,
                correctAnswers,
                totalQuestions,
                passed,
                timeSpentSeconds = request.TimeSpentSeconds,
                completedInTime,
                completedAt = DateTime.UtcNow,
                results,
                message = passed 
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
                    badges = profile.UserBadges.Select(ub => new
                    {
                        badgeId = ub.Badge.BadgeId,
                        name = ub.Badge.Name,
                        description = ub.Badge.Description,
                        iconUrl = ub.Badge.IconUrl,
                        category = ub.Badge.Category
                    }).ToList()
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
    /// Get all forum posts (including general discussions)
    /// </summary>
    [HttpGet("forums/posts")]
    public async Task<IActionResult> GetAllForumPosts(CancellationToken ct = default)
    {
        try
        {
            var posts = await _context.ForumPosts
                .Include(fp => fp.Profile)
                .Include(fp => fp.Course)
                .Include(fp => fp.Comments)
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
                    courseTitle = fp.Course != null ? fp.Course.Title : "General Discussion",
                    commentCount = fp.Comments.Count
                })
                .ToListAsync(ct);

            return Ok(posts);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving all forum posts");
            return StatusCode(500, new { error = "An error occurred while retrieving forum posts" });
        }
    }

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
                .Include(fp => fp.Comments) // Include Comments to get accurate count
                .Where(fp => fp.CourseId == courseId || (courseId == Guid.Empty && fp.CourseId == null))
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
                    courseTitle = fp.Course != null ? fp.Course.Title : "General Discussion",
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

            // Verify user exists
            var profile = await _context.Profiles.FindAsync(new object[] { request.UserId }, ct);
            if (profile == null)
            {
                return NotFound(new { error = "User not found" });
            }

            // Allow posting without course validation - users can ask general questions
            // CourseId is optional - can be null for general forum discussions
            Guid? courseIdToUse = null;
            
            // If a courseId is provided, verify it exists (optional check)
            if (request.CourseId != Guid.Empty)
            {
                var courseExists = await _context.Courses.AnyAsync(c => c.CourseId == request.CourseId, ct);
                if (courseExists)
                {
                    courseIdToUse = request.CourseId;
                }
                else
                {
                    // Course doesn't exist, but allow posting anyway as general forum post
                    _logger.LogWarning("Post created with non-existent courseId {CourseId}, posting as general forum discussion", request.CourseId);
                    courseIdToUse = null; // Set to null for general forum post
                }
            }

            var forumPost = new ForumPost
            {
                ForumId = Guid.NewGuid(),
                UserId = request.UserId,
                CourseId = courseIdToUse, // Can be null for general forum posts
                Content = request.Content,
                CreatedAt = DateTime.UtcNow
            };

            _context.ForumPosts.Add(forumPost);
            await _context.SaveChangesAsync(ct);

            // Award XP for forum participation (don't fail if this errors)
            try
            {
                await AwardXPAsync(request.UserId, 10, ct);
            }
            catch (Exception xpEx)
            {
                _logger.LogWarning(xpEx, "Failed to award XP for forum post, but post was created successfully");
            }

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
        catch (DbUpdateException dbEx)
        {
            _logger.LogError(dbEx, "Database error creating forum post for user {UserId}", request?.UserId);
            return StatusCode(500, new { error = "Database error occurred while creating the forum post. Please try again." });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating forum post for user {UserId}. Error: {ErrorMessage}", request?.UserId, ex.Message);
            return StatusCode(500, new { error = $"An error occurred while creating the forum post: {ex.Message}" });
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

            // Load all comments with their profile information
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
                .Include(fp => fp.Profile)
                .FirstOrDefaultAsync(fp => fp.ForumId == forumId, ct);

            if (forumPost == null)
            {
                return NotFound(new { error = "Forum post not found" });
            }

            // Allow all authenticated users to comment (students, teachers, admins)
            // Enrollment check is optional - we'll allow commenting for better engagement
            // If you want to enforce enrollment, uncomment the check below
            /*
            var isEnrolled = await _context.Enrolments
                .AnyAsync(e => e.UserId == userId && e.CourseId == forumPost.CourseId, ct);

            if (!isEnrolled && profile.Role == "student")
            {
                return Forbid("You must be enrolled in the course to comment on this forum.");
            }
            */

            Guid? notificationRecipientId = null;
            string notificationMessage = string.Empty;

            if (request.ParentCommentId.HasValue)
            {
                // This is a reply to a comment - notify the comment author
                var parentComment = await _context.ForumComments
                    .Include(fc => fc.Profile)
                    .FirstOrDefaultAsync(fc => fc.CommentId == request.ParentCommentId.Value && fc.ForumId == forumId, ct);

                if (parentComment == null)
                {
                    return BadRequest(new { error = "Parent comment not found in this thread." });
                }

                // Only notify if the comment author is different from the person replying
                if (parentComment.UserId != userId)
                {
                    notificationRecipientId = parentComment.UserId;
                    var commentPreview = parentComment.Content.Length > 50 
                        ? parentComment.Content.Substring(0, 47) + "..." 
                        : parentComment.Content;
                    notificationMessage = $"💬 {profile.FullName} replied to your comment: \"{commentPreview}\"";
                }
            }
            else
            {
                // This is a direct reply to the post - notify the post author
                // Only notify if the post author is different from the person commenting
                if (forumPost.UserId != userId)
                {
                    notificationRecipientId = forumPost.UserId;
                    var postPreview = forumPost.Content.Length > 50 
                        ? forumPost.Content.Substring(0, 47) + "..." 
                        : forumPost.Content;
                    notificationMessage = $"💬 {profile.FullName} replied to your post: \"{postPreview}\"";
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

            // Create notification if there's a recipient
            if (notificationRecipientId.HasValue && !string.IsNullOrEmpty(notificationMessage))
            {
                _context.Notifications.Add(new Notification
                {
                    NotificationId = Guid.NewGuid(),
                    UserId = notificationRecipientId.Value,
                    Message = notificationMessage,
                    CreatedAt = DateTime.UtcNow
                });
            }

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
            // Get all students (users with role 'student')
            var allStudents = await _context.Profiles
                .Where(p => p.Role == "student")
                .Include(p => p.UserBadges)
                    .ThenInclude(ub => ub.Badge)
                .ToListAsync(ct);

            // Get all leaderboard entries
            var leaderboardEntries = await _context.Leaderboards
                .Include(l => l.Profile)
                    .ThenInclude(p => p.UserBadges)
                        .ThenInclude(ub => ub.Badge)
                .ToListAsync(ct);

            // Create a dictionary for quick lookup
            var leaderboardDict = leaderboardEntries.ToDictionary(l => l.UserId);

            // Build leaderboard - only show students who have actually earned XP (XP > 0)
            var leaderboardData = allStudents
                .Select(student => 
                {
                    var entry = leaderboardDict.GetValueOrDefault(student.UserId);
                    return new
                    {
                        userId = student.UserId,
                        userName = student.FullName,
                        xp = entry?.XP ?? 0,
                        streaks = entry?.Streaks ?? 0,
                        badges = student.UserBadges
                            .Select(ub => new
                            {
                                badgeId = ub.Badge.BadgeId,
                                name = ub.Badge.Name,
                                description = ub.Badge.Description,
                                iconUrl = ub.Badge.IconUrl,
                                category = ub.Badge.Category,
                                earnedAt = ub.EarnedAt
                            })
                            .ToList(),
                        isCurrentUser = userId.HasValue && student.UserId == userId.Value
                    };
                })
                .Where(l => l.xp > 0) // Only show students who have earned XP
                .OrderByDescending(l => l.xp)
                .ThenByDescending(l => l.streaks)
                .ThenBy(l => l.userName) // Tie-breaker: alphabetical by name
                .Select((entry, index) => new
                {
                    rank = index + 1,
                    userId = entry.userId,
                    userName = entry.userName,
                    xp = entry.xp,
                    streaks = entry.streaks,
                    badges = entry.badges,
                    isCurrentUser = entry.isCurrentUser
                })
                .ToList();

            _logger.LogInformation("📊 Leaderboard retrieved: {Count} students, CurrentUserId={UserId}", 
                leaderboardData.Count, userId);

            return Ok(leaderboardData);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving leaderboard");
            return StatusCode(500, new { error = "An error occurred while retrieving the leaderboard" });
        }
    }

    /// <summary>
    /// Award XP to a student
    /// </summary>
    [HttpPost("award-xp")]
    public async Task<IActionResult> AwardXP([FromBody] AwardXPRequest request, CancellationToken ct = default)
    {
        try
        {
            _logger.LogInformation("🎯 Awarding XP: UserId={UserId}, XPAmount={XPAmount}", request.UserId, request.XPAmount);
            
            if (request.UserId == Guid.Empty)
            {
                _logger.LogWarning("⚠️ Invalid UserId provided: {UserId}", request.UserId);
                return BadRequest(new { error = "Invalid user ID" });
            }

            if (request.XPAmount <= 0)
            {
                _logger.LogWarning("⚠️ Invalid XP amount: {XPAmount}", request.XPAmount);
                return BadRequest(new { error = "XP amount must be greater than 0" });
            }

            await AwardXPAsync(request.UserId, request.XPAmount, ct);
            
            // Verify XP was saved
            var updatedLeaderboard = await _context.Leaderboards
                .FirstOrDefaultAsync(l => l.UserId == request.UserId, ct);
            
            _logger.LogInformation("✅ XP awarded successfully. UserId={UserId}, New Total XP={XP}", 
                request.UserId, updatedLeaderboard?.XP ?? 0);
            
            // Check for badges after awarding XP
            var badgeService = new Services.BadgeService(_context);
            var newBadges = await badgeService.CheckAndAwardBadges(request.UserId);
            
            return Ok(new
            {
                message = "XP awarded successfully",
                xpAwarded = request.XPAmount,
                totalXP = updatedLeaderboard?.XP ?? 0,
                newBadges = newBadges.Select(b => new
                {
                    badgeId = b.BadgeId,
                    name = b.Name,
                    description = b.Description,
                    iconUrl = b.IconUrl,
                    category = b.Category
                }).ToList()
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "❌ Error awarding XP for UserId={UserId}", request.UserId);
            return StatusCode(500, new { error = "An error occurred while awarding XP", details = ex.Message });
        }
    }

    #endregion

    #region Request Models

    /// <summary>
    /// Clear all leaderboard data (reset all XP and streaks to 0)
    /// </summary>
    [HttpDelete("leaderboard/clear")]
    public async Task<IActionResult> ClearLeaderboard(CancellationToken ct = default)
    {
        try
        {
            _logger.LogInformation("🗑️ Clearing all leaderboard data");
            
            // Remove all leaderboard entries
            var allEntries = await _context.Leaderboards.ToListAsync(ct);
            _context.Leaderboards.RemoveRange(allEntries);
            await _context.SaveChangesAsync(ct);
            
            _logger.LogInformation("✅ Cleared {Count} leaderboard entries", allEntries.Count);
            
            return Ok(new
            {
                message = "Leaderboard cleared successfully",
                entriesCleared = allEntries.Count
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "❌ Error clearing leaderboard");
            return StatusCode(500, new { error = "An error occurred while clearing the leaderboard", details = ex.Message });
        }
    }

    public class AwardXPRequest
    {
        public Guid UserId { get; set; }
        public int XPAmount { get; set; }
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

    /// <summary>
    /// Awards XP to a user's leaderboard entry.
    /// Creates a new entry if one doesn't exist, or adds to existing XP.
    /// XP is cumulative - it accumulates over time and persists in the database.
    /// </summary>
    private async Task AwardXPAsync(Guid userId, int xpAmount, CancellationToken ct)
    {
        var leaderboard = await _context.Leaderboards
            .FirstOrDefaultAsync(l => l.UserId == userId, ct);

        if (leaderboard == null)
        {
            // First time earning XP - create new leaderboard entry
            leaderboard = new Leaderboard
            {
                UserId = userId,
                XP = xpAmount,
                Streaks = 0
            };
            _context.Leaderboards.Add(leaderboard);
            _logger.LogInformation("📝 Created new leaderboard entry for UserId={UserId} with {XP} XP", userId, xpAmount);
        }
        else
        {
            // Add to existing XP (accumulative)
            var oldXP = leaderboard.XP;
            leaderboard.XP += xpAmount;
            _logger.LogInformation("📈 Updated XP for UserId={UserId}: {OldXP} + {Awarded} = {NewXP}", 
                userId, oldXP, xpAmount, leaderboard.XP);
        }

        await _context.SaveChangesAsync(ct);
        _logger.LogInformation("✅ Leaderboard saved to database for UserId={UserId}", userId);
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

    #region Help Requests

    /// <summary>
    /// Create a new help request for a chapter
    /// </summary>
    [HttpPost("help-request")]
    public async Task<IActionResult> CreateHelpRequest([FromBody] CreateHelpRequestDto request, CancellationToken ct = default)
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var studentId))
        {
            return Unauthorized(new { error = "Invalid or missing student identification" });
        }

        if (request == null || !ModelState.IsValid)
        {
            return BadRequest(new { error = "Invalid request data" });
        }

        try
        {
            // Verify chapter exists
            var chapter = await _context.Chapters.FindAsync(new object?[] { request.ChapterId }, ct);
            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            // Create help request
            var helpRequest = new HelpRequest
            {
                HelpRequestId = Guid.NewGuid(),
                StudentId = studentId,
                ChapterId = request.ChapterId,
                Question = request.Question,
                Status = "Pending",
                CreatedAt = DateTime.UtcNow
            };

            _context.HelpRequests.Add(helpRequest);
            await _context.SaveChangesAsync(ct);

            _logger.LogInformation("Help request created: {HelpRequestId} by student {StudentId}", 
                helpRequest.HelpRequestId, studentId);

            return Ok(new
            {
                success = true,
                helpRequestId = helpRequest.HelpRequestId,
                message = "Help request submitted successfully"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating help request for student {StudentId}", studentId);
            return StatusCode(500, new { error = "An error occurred while submitting your help request" });
        }
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
    
    /// <summary>
    /// Time spent on quiz in seconds
    /// </summary>
    public int? TimeSpentSeconds { get; init; }
    
    /// <summary>
    /// Attempt ID if this is continuing a previous attempt
    /// </summary>
    public Guid? AttemptId { get; init; }
}

public record AnswerSubmission
{
    [Required]
    public Guid QuestionId { get; init; }

    /// <summary>
    /// For multiple choice: SelectedOptionId
    /// For true/false: "true" or "false"
    /// For short answer: the text answer
    /// For essay: the essay text
    /// </summary>
    public string? SelectedOptionId { get; init; }
    
    /// <summary>
    /// For text-based questions (short_answer, essay)
    /// </summary>
    public string? TextAnswer { get; init; }
}

public record StartQuizRequest
{
    [Required]
    public Guid ChapterId { get; init; }
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

public record EnrollInCourseRequest
{
    [Required]
    public Guid CourseId { get; init; }
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

public record CreateHelpRequestDto
{
    [Required]
    public Guid ChapterId { get; init; }

    [Required]
    [MinLength(1)]
    public string Question { get; init; } = string.Empty;
}

#endregion


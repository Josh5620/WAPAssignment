using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;

namespace ProjectAPI.Controllers;

/// <summary>
/// Controller for student-specific operations including learning activities,
/// progress tracking, quizzes, flashcards, and forum participation.
/// </summary>
[ApiController]
[Route("api/students")]
public class StudentsController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<StudentsController> _logger;

    public StudentsController(ApplicationDbContext context, ILogger<StudentsController> logger)
    {
        _context = context;
        _logger = logger;
    }

    #region Learning Content

    /// <summary>
    /// Get all learning content (lessons, quizzes, flashcards) for a specific chapter
    /// </summary>
    [HttpGet("chapters/{chapterId}/content")]
    public async Task<IActionResult> GetChapterContent(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var chapter = await _context.Chapters
                .Include(c => c.Resources)
                    .ThenInclude(r => r.Questions)
                        .ThenInclude(q => q.QuestionOptions)
                .Include(c => c.Resources)
                    .ThenInclude(r => r.Flashcards)
                .FirstOrDefaultAsync(c => c.ChapterId == chapterId, ct);

            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            var content = chapter.Resources.Select(r => new
            {
                resourceId = r.ResourceId,
                type = r.Type,
                content = r.Content,
                flashcards = r.Type == "flashcard" ? r.Flashcards.OrderBy(f => f.OrderIndex).Select(f => new
                {
                    id = f.FcId,
                    frontText = f.FrontText,
                    backText = f.BackText,
                    orderIndex = f.OrderIndex
                }) : null,
                questions = r.Type == "mcq" ? r.Questions.Select(q => new
                {
                    questionId = q.QuestionId,
                    stem = q.Stem,
                    difficulty = q.Difficulty,
                    options = q.QuestionOptions.Select(o => new
                    {
                        optionId = o.OptionId,
                        optionText = o.OptionText
                        // Note: IsCorrect is excluded for security - students shouldn't see correct answers
                    }).ToList()
                }) : null
            }).ToList();

            return Ok(new
            {
                chapterId = chapter.ChapterId,
                chapterTitle = chapter.Title,
                chapterSummary = chapter.Summary,
                content
            });
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
    /// Submit quiz answers and receive feedback
    /// </summary>
    [HttpPost("quizzes/submit")]
    public async Task<IActionResult> SubmitQuiz([FromBody] QuizSubmissionRequest request, CancellationToken ct = default)
    {
        try
        {
            if (request == null || request.Answers == null || !request.Answers.Any())
            {
                return BadRequest(new { error = "Quiz submission is required" });
            }

            // Verify user exists
            var userExists = await _context.Profiles.AnyAsync(p => p.UserId == request.UserId, ct);
            if (!userExists)
            {
                return NotFound(new { error = "User not found" });
            }

            var results = new List<QuestionResultDto>();
            int totalCorrect = 0;
            int totalAttempted = request.Answers.Count;

            foreach (var answer in request.Answers)
            {
                var question = await _context.Questions
                    .Include(q => q.QuestionOptions)
                    .FirstOrDefaultAsync(q => q.QuestionId == answer.QuestionId, ct);

                if (question == null)
                {
                    results.Add(new QuestionResultDto
                    {
                        QuestionId = answer.QuestionId,
                        IsCorrect = false,
                        Feedback = "Question not found"
                    });
                    continue;
                }

                var correctOption = question.QuestionOptions.FirstOrDefault(o => o.IsCorrect);
                var isCorrect = correctOption != null && correctOption.OptionId == answer.SelectedOptionId;

                if (isCorrect)
                    totalCorrect++;

                results.Add(new QuestionResultDto
                {
                    QuestionId = question.QuestionId,
                    IsCorrect = isCorrect,
                    Feedback = isCorrect 
                        ? "Correct! Well done!" 
                        : $"Incorrect. The correct answer is: {correctOption?.OptionText ?? "N/A"}",
                    Explanation = question.Explanation,
                    CorrectOptionId = correctOption?.OptionId
                });
            }

            // Update chapter progress if chapterId is provided
            if (request.ChapterId.HasValue)
            {
                await UpdateChapterProgressAsync(request.UserId, request.ChapterId.Value, totalAttempted, totalCorrect, ct);
            }

            // Award XP and update leaderboard
            var xpAwarded = CalculateXPAwarded(totalCorrect, totalAttempted);
            await AwardXPAsync(request.UserId, xpAwarded, ct);

            return Ok(new QuizSubmissionResponse
            {
                TotalQuestions = totalAttempted,
                TotalCorrect = totalCorrect,
                Score = totalAttempted > 0 ? (double)totalCorrect / totalAttempted * 100 : 0,
                XPAwarded = xpAwarded,
                Results = results
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error submitting quiz for user {UserId}", request?.UserId);
            return StatusCode(500, new { error = "An error occurred while submitting the quiz" });
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
                    courseTitle = fp.Course.Title
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
    public Guid UserId { get; init; }

    public Guid? ChapterId { get; init; }

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

#endregion


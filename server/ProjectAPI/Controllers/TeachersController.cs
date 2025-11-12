using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;

namespace ProjectAPI.Controllers;

/// <summary>
/// Controller for teacher-specific operations including course creation and management
/// </summary>
[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "teacher")]
public class TeachersController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<TeachersController> _logger;

    public TeachersController(ApplicationDbContext context, ILogger<TeachersController> logger)
    {
        _context = context;
        _logger = logger;
    }

    #region Course Management

    /// <summary>
    /// Get all courses created by the logged-in teacher
    /// </summary>
    /// <param name="ct">Cancellation token</param>
    /// <returns>List of courses where TeacherId matches the authenticated teacher</returns>
    [HttpGet("my-courses")]
    public async Task<IActionResult> GetMyCourses(CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Get all courses created by this teacher
            var courses = await _context.Courses
                .Include(c => c.Chapters)
                .Where(c => c.TeacherId == teacherId)
                .Select(c => new
                {
                    courseId = c.CourseId,
                    title = c.Title,
                    description = c.Description,
                    previewContent = c.PreviewContent,
                    published = c.Published,
                    approvalStatus = c.ApprovalStatus,
                    rejectionReason = c.RejectionReason,
                    teacherId = c.TeacherId,
                    totalChapters = c.Chapters.Count
                })
                .OrderByDescending(c => c.approvalStatus == "Pending")
                    .ThenBy(c => c.title)
                .ToListAsync(ct);

            return Ok(new
            {
                teacherId,
                totalCourses = courses.Count,
                pendingApproval = courses.Count(c => c.approvalStatus == "Pending"),
                approved = courses.Count(c => c.approvalStatus == "Approved"),
                rejected = courses.Count(c => c.approvalStatus == "Rejected"),
                courses
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving teacher's courses");
            return StatusCode(500, new { error = "An error occurred while retrieving your courses" });
        }
    }

    /// <summary>
    /// Create a new course (pending admin approval)
    /// </summary>
    /// <param name="request">Course creation request</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Created course details</returns>
    [HttpPost("courses")]
    public async Task<IActionResult> CreateCourse([FromBody] CreateCourseRequest request, CancellationToken ct = default)
    {
        try
        {
            // Validate request
            if (request == null || string.IsNullOrWhiteSpace(request.Title))
            {
                return BadRequest(new { error = "Course title is required" });
            }

            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Verify teacher exists
            var teacher = await _context.Profiles.FindAsync(new object[] { teacherId }, ct);
            if (teacher == null || teacher.Role != "teacher")
            {
                return Forbid("Only teachers can create courses");
            }

            // Create new course with Pending status
            var course = new Course
            {
                CourseId = Guid.NewGuid(),
                Title = request.Title.Trim(),
                Description = request.Description?.Trim() ?? string.Empty,
                PreviewContent = request.PreviewContent?.Trim(),
                Published = false,
                TeacherId = teacherId,
                ApprovalStatus = "Pending" // Always set to Pending for new courses
            };

            await _context.Courses.AddAsync(course, ct);
            await _context.SaveChangesAsync(ct);

            return CreatedAtAction(
                nameof(GetMyCourses),
                new
                {
                    courseId = course.CourseId,
                    title = course.Title,
                    description = course.Description,
                    previewContent = course.PreviewContent,
                    published = course.Published,
                    approvalStatus = course.ApprovalStatus,
                    teacherId = course.TeacherId,
                    message = "Course created successfully! Waiting for admin approval."
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating course");
            return StatusCode(500, new { error = "An error occurred while creating the course" });
        }
    }

    /// <summary>
    /// Update an existing course (only if it's pending or rejected)
    /// </summary>
    /// <param name="courseId">Course ID</param>
    /// <param name="request">Update course request</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Updated course details</returns>
    [HttpPut("courses/{courseId}")]
    public async Task<IActionResult> UpdateCourse(Guid courseId, [FromBody] UpdateCourseRequest request, CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Get the course
            var course = await _context.Courses.FindAsync(new object[] { courseId }, ct);
            
            if (course == null)
            {
                return NotFound(new { error = "Course not found" });
            }

            // Verify the teacher owns this course
            if (course.TeacherId != teacherId)
            {
                return Forbid("You can only update your own courses");
            }

            // Update course details
            if (!string.IsNullOrWhiteSpace(request.Title))
            {
                course.Title = request.Title.Trim();
            }

            if (request.Description != null)
            {
                course.Description = request.Description.Trim();
            }

            if (request.PreviewContent != null)
            {
                course.PreviewContent = request.PreviewContent.Trim();
            }

            // If course was rejected, reset to Pending when updated
            if (course.ApprovalStatus == "Rejected")
            {
                course.ApprovalStatus = "Pending";
                course.RejectionReason = null;
            }

            _context.Courses.Update(course);
            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                courseId = course.CourseId,
                title = course.Title,
                description = course.Description,
                previewContent = course.PreviewContent,
                published = course.Published,
                approvalStatus = course.ApprovalStatus,
                message = "Course updated successfully!"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while updating the course" });
        }
    }

    /// <summary>
    /// Delete a course (only if it's pending or rejected)
    /// </summary>
    /// <param name="courseId">Course ID</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Confirmation message</returns>
    [HttpDelete("courses/{courseId}")]
    public async Task<IActionResult> DeleteCourse(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Get the course
            var course = await _context.Courses
                .Include(c => c.Chapters)
                .FirstOrDefaultAsync(c => c.CourseId == courseId, ct);
            
            if (course == null)
            {
                return NotFound(new { error = "Course not found" });
            }

            // Verify the teacher owns this course
            if (course.TeacherId != teacherId)
            {
                return Forbid("You can only delete your own courses");
            }

            // Don't allow deletion of approved courses with students enrolled
            if (course.ApprovalStatus == "Approved")
            {
                var hasEnrollments = await _context.Enrolments.AnyAsync(e => e.CourseId == courseId, ct);
                if (hasEnrollments)
                {
                    return BadRequest(new { error = "Cannot delete approved courses with enrolled students" });
                }
            }

            _context.Courses.Remove(course);
            await _context.SaveChangesAsync(ct);

            return Ok(new { message = "Course deleted successfully" });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while deleting the course" });
        }
    }

    /// <summary>
    /// Get detailed information about a specific course (teacher's own)
    /// </summary>
    /// <param name="courseId">Course ID</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Detailed course information</returns>
    [HttpGet("courses/{courseId}")]
    public async Task<IActionResult> GetCourse(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            var course = await _context.Courses
                .Include(c => c.Chapters)
                    .ThenInclude(ch => ch.Resources)
                .Include(c => c.Enrolments)
                .FirstOrDefaultAsync(c => c.CourseId == courseId && c.TeacherId == teacherId, ct);

            if (course == null)
            {
                return NotFound(new { error = "Course not found or you don't have access" });
            }

            return Ok(new
            {
                courseId = course.CourseId,
                title = course.Title,
                description = course.Description,
                previewContent = course.PreviewContent,
                published = course.Published,
                approvalStatus = course.ApprovalStatus,
                rejectionReason = course.RejectionReason,
                teacherId = course.TeacherId,
                totalChapters = course.Chapters.Count,
                totalEnrollments = course.Enrolments.Count,
                chapters = course.Chapters
                    .OrderBy(ch => ch.Number)
                    .Select(ch => new
                    {
                        chapterId = ch.ChapterId,
                        number = ch.Number,
                        title = ch.Title,
                        summary = ch.Summary,
                        resourceCount = ch.Resources.Count
                    })
                    .ToList()
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while retrieving the course" });
        }
    }

    #endregion

    #region Teacher Statistics

    /// <summary>
    /// Get statistics for the logged-in teacher
    /// </summary>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Teacher statistics</returns>
    [HttpGet("statistics")]
    public async Task<IActionResult> GetStatistics(CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            var courses = await _context.Courses
                .Include(c => c.Chapters)
                .Include(c => c.Enrolments)
                .Where(c => c.TeacherId == teacherId)
                .ToListAsync(ct);

            var totalEnrollments = courses.Sum(c => c.Enrolments.Count);
            var totalChapters = courses.Sum(c => c.Chapters.Count);

            return Ok(new
            {
                teacherId,
                totalCourses = courses.Count,
                approvedCourses = courses.Count(c => c.ApprovalStatus == "Approved"),
                pendingCourses = courses.Count(c => c.ApprovalStatus == "Pending"),
                rejectedCourses = courses.Count(c => c.ApprovalStatus == "Rejected"),
                totalChapters,
                totalEnrollments
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving teacher statistics");
            return StatusCode(500, new { error = "An error occurred while retrieving statistics" });
        }
    }

    #endregion

    #region Question Management

    /// <summary>
    /// Create a question for a chapter's quiz resource
    /// </summary>
    [HttpPost("chapters/{chapterId}/questions")]
    public async Task<IActionResult> CreateQuestion(
        Guid chapterId,
        [FromBody] CreateQuestionRequest request,
        CancellationToken ct = default)
    {
        try
        {
            if (request == null || string.IsNullOrWhiteSpace(request.Stem))
            {
                return BadRequest(new { error = "Question stem is required" });
            }

            // Verify chapter exists and belongs to teacher's course
            var chapter = await _context.Chapters
                .Include(ch => ch.Course)
                .FirstOrDefaultAsync(ch => ch.ChapterId == chapterId, ct);

            if (chapter == null)
            {
                return NotFound(new { error = "Chapter not found" });
            }

            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid teacher identification" });
            }

            if (chapter.Course.TeacherId != teacherId)
            {
                return Forbid("You can only add questions to chapters in your own courses");
            }

            // Find or create MCQ resource for this chapter
            var resource = await _context.Resources
                .FirstOrDefaultAsync(r => r.ChapterId == chapterId && r.Type == "mcq", ct);

            if (resource == null)
            {
                resource = new Resource
                {
                    ResourceId = Guid.NewGuid(),
                    ChapterId = chapterId,
                    Type = "mcq",
                    Content = "Quiz Questions"
                };
                _context.Resources.Add(resource);
                await _context.SaveChangesAsync(ct);
            }

            // Create the question
            var question = new Question
            {
                QuestionId = Guid.NewGuid(),
                ResourceId = resource.ResourceId,
                Stem = request.Stem.Trim(),
                Difficulty = request.Difficulty ?? "medium",
                QuestionType = request.QuestionType ?? "multiple_choice",
                ExpectedAnswer = request.ExpectedAnswer,
                Explanation = request.Explanation
            };

            _context.Questions.Add(question);

            // Add options for multiple choice and true/false questions
            if (question.QuestionType == "multiple_choice" || question.QuestionType == "true_false")
            {
                if (request.Options == null || !request.Options.Any())
                {
                    return BadRequest(new { error = "Options are required for multiple choice and true/false questions" });
                }

                var options = request.Options.Select((opt, index) => new QuestionOption
                {
                    OptionId = Guid.NewGuid(),
                    QuestionId = question.QuestionId,
                    OptionText = opt.Text.Trim(),
                    IsCorrect = opt.IsCorrect
                }).ToList();

                // Validate that at least one option is correct
                if (!options.Any(o => o.IsCorrect))
                {
                    return BadRequest(new { error = "At least one option must be marked as correct" });
                }

                _context.QuestionOptions.AddRange(options);
            }
            else if (question.QuestionType == "short_answer" || question.QuestionType == "essay")
            {
                if (string.IsNullOrWhiteSpace(request.ExpectedAnswer))
                {
                    return BadRequest(new { error = "Expected answer is required for short answer and essay questions" });
                }
            }

            await _context.SaveChangesAsync(ct);

            return CreatedAtAction(
                nameof(GetQuestion),
                new { questionId = question.QuestionId },
                new
                {
                    questionId = question.QuestionId,
                    stem = question.Stem,
                    difficulty = question.Difficulty,
                    questionType = question.QuestionType,
                    explanation = question.Explanation,
                    options = question.QuestionType == "multiple_choice" || question.QuestionType == "true_false"
                        ? await _context.QuestionOptions
                            .Where(o => o.QuestionId == question.QuestionId)
                            .Select(o => new
                            {
                                optionId = o.OptionId,
                                text = o.OptionText,
                                isCorrect = o.IsCorrect
                            })
                            .ToListAsync(ct)
                        : null
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating question for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while creating the question" });
        }
    }

    /// <summary>
    /// Get a question by ID
    /// </summary>
    [HttpGet("questions/{questionId}")]
    public async Task<IActionResult> GetQuestion(Guid questionId, CancellationToken ct = default)
    {
        try
        {
            var question = await _context.Questions
                .Include(q => q.QuestionOptions)
                .Include(q => q.Resource)
                    .ThenInclude(r => r.Chapter)
                        .ThenInclude(ch => ch.Course)
                .FirstOrDefaultAsync(q => q.QuestionId == questionId, ct);

            if (question == null)
            {
                return NotFound(new { error = "Question not found" });
            }

            return Ok(new
            {
                questionId = question.QuestionId,
                chapterId = question.Resource.ChapterId,
                stem = question.Stem,
                difficulty = question.Difficulty,
                questionType = question.QuestionType,
                expectedAnswer = question.ExpectedAnswer,
                explanation = question.Explanation,
                options = question.QuestionOptions.Select(o => new
                {
                    optionId = o.OptionId,
                    text = o.OptionText,
                    isCorrect = o.IsCorrect
                }).ToList()
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving question {QuestionId}", questionId);
            return StatusCode(500, new { error = "An error occurred while retrieving the question" });
        }
    }

    /// <summary>
    /// Get all questions for a chapter
    /// </summary>
    [HttpGet("chapters/{chapterId}/questions")]
    public async Task<IActionResult> GetChapterQuestions(Guid chapterId, CancellationToken ct = default)
    {
        try
        {
            var questions = await _context.Questions
                .Include(q => q.QuestionOptions)
                .Include(q => q.Resource)
                .Where(q => q.Resource.ChapterId == chapterId)
                .Select(q => new
                {
                    questionId = q.QuestionId,
                    stem = q.Stem,
                    difficulty = q.Difficulty,
                    questionType = q.QuestionType,
                    expectedAnswer = q.ExpectedAnswer,
                    explanation = q.Explanation,
                    options = q.QuestionOptions.Select(o => new
                    {
                        optionId = o.OptionId,
                        text = o.OptionText,
                        isCorrect = o.IsCorrect
                    }).ToList()
                })
                .ToListAsync(ct);

            return Ok(new
            {
                chapterId,
                totalQuestions = questions.Count,
                questions
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving questions for chapter {ChapterId}", chapterId);
            return StatusCode(500, new { error = "An error occurred while retrieving questions" });
        }
    }

    /// <summary>
    /// Update a question
    /// </summary>
    [HttpPut("questions/{questionId}")]
    public async Task<IActionResult> UpdateQuestion(
        Guid questionId,
        [FromBody] UpdateQuestionRequest request,
        CancellationToken ct = default)
    {
        try
        {
            var question = await _context.Questions
                .Include(q => q.QuestionOptions)
                .Include(q => q.Resource)
                    .ThenInclude(r => r.Chapter)
                        .ThenInclude(ch => ch.Course)
                .FirstOrDefaultAsync(q => q.QuestionId == questionId, ct);

            if (question == null)
            {
                return NotFound(new { error = "Question not found" });
            }

            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid teacher identification" });
            }

            if (question.Resource.Chapter.Course.TeacherId != teacherId)
            {
                return Forbid("You can only update questions in your own courses");
            }

            // Update question fields
            if (!string.IsNullOrWhiteSpace(request.Stem))
                question.Stem = request.Stem.Trim();

            if (!string.IsNullOrWhiteSpace(request.Difficulty))
                question.Difficulty = request.Difficulty;

            if (!string.IsNullOrWhiteSpace(request.QuestionType))
                question.QuestionType = request.QuestionType;

            if (request.ExpectedAnswer != null)
                question.ExpectedAnswer = request.ExpectedAnswer;

            if (request.Explanation != null)
                question.Explanation = request.Explanation;

            // Update options if provided
            if (request.Options != null && request.Options.Any())
            {
                // Remove existing options
                _context.QuestionOptions.RemoveRange(question.QuestionOptions);

                // Add new options
                var newOptions = request.Options.Select(opt => new QuestionOption
                {
                    OptionId = Guid.NewGuid(),
                    QuestionId = question.QuestionId,
                    OptionText = opt.Text.Trim(),
                    IsCorrect = opt.IsCorrect
                }).ToList();

                _context.QuestionOptions.AddRange(newOptions);
            }

            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                questionId = question.QuestionId,
                stem = question.Stem,
                difficulty = question.Difficulty,
                questionType = question.QuestionType,
                message = "Question updated successfully"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating question {QuestionId}", questionId);
            return StatusCode(500, new { error = "An error occurred while updating the question" });
        }
    }

    /// <summary>
    /// Delete a question
    /// </summary>
    [HttpDelete("questions/{questionId}")]
    public async Task<IActionResult> DeleteQuestion(Guid questionId, CancellationToken ct = default)
    {
        try
        {
            var question = await _context.Questions
                .Include(q => q.Resource)
                    .ThenInclude(r => r.Chapter)
                        .ThenInclude(ch => ch.Course)
                .FirstOrDefaultAsync(q => q.QuestionId == questionId, ct);

            if (question == null)
            {
                return NotFound(new { error = "Question not found" });
            }

            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid teacher identification" });
            }

            if (question.Resource.Chapter.Course.TeacherId != teacherId)
            {
                return Forbid("You can only delete questions in your own courses");
            }

            _context.Questions.Remove(question);
            await _context.SaveChangesAsync(ct);

            return Ok(new { message = "Question deleted successfully" });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting question {QuestionId}", questionId);
            return StatusCode(500, new { error = "An error occurred while deleting the question" });
        }
    }

    #endregion

    #region Help Requests Management

    /// <summary>
    /// Get all pending help requests for teachers to answer
    /// </summary>
    /// <param name="ct">Cancellation token</param>
    /// <returns>List of pending help requests from students</returns>
    [HttpGet("help-requests")]
    public async Task<IActionResult> GetHelpRequests(CancellationToken ct = default)
    {
        try
        {
            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Get all pending help requests
            var helpRequests = await _context.HelpRequests
                .Include(hr => hr.Student)
                .Include(hr => hr.Chapter)
                    .ThenInclude(ch => ch.Course)
                .Where(hr => hr.Status == "Pending")
                .OrderByDescending(hr => hr.CreatedAt)
                .Select(hr => new
                {
                    helpRequestId = hr.HelpRequestId,
                    studentId = hr.StudentId,
                    studentName = hr.Student.FullName,
                    studentEmail = hr.Student.Email,
                    chapterId = hr.ChapterId,
                    chapterTitle = hr.Chapter.Title,
                    chapterNumber = hr.Chapter.Number,
                    courseId = hr.Chapter.CourseId,
                    courseTitle = hr.Chapter.Course.Title,
                    question = hr.Question,
                    status = hr.Status,
                    createdAt = hr.CreatedAt
                })
                .ToListAsync(ct);

            return Ok(new
            {
                teacherId,
                totalPending = helpRequests.Count,
                helpRequests
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving help requests");
            return StatusCode(500, new { error = "An error occurred while retrieving help requests" });
        }
    }

    /// <summary>
    /// Respond to a help request and mark it as resolved
    /// </summary>
    /// <param name="helpRequestId">Help request ID</param>
    /// <param name="request">Response request</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Updated help request</returns>
    [HttpPost("help-requests/{helpRequestId}/respond")]
    public async Task<IActionResult> RespondToHelpRequest(
        Guid helpRequestId, 
        [FromBody] HelpRequestResponseRequest request, 
        CancellationToken ct = default)
    {
        try
        {
            // Validate request
            if (request == null || string.IsNullOrWhiteSpace(request.Response))
            {
                return BadRequest(new { error = "Response text is required" });
            }

            // Get teacher ID from JWT token
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var teacherId))
            {
                return Unauthorized(new { error = "Invalid or missing teacher identification" });
            }

            // Get the help request
            var helpRequest = await _context.HelpRequests
                .Include(hr => hr.Student)
                .FirstOrDefaultAsync(hr => hr.HelpRequestId == helpRequestId, ct);

            if (helpRequest == null)
            {
                return NotFound(new { error = "Help request not found" });
            }

            if (helpRequest.Status != "Pending")
            {
                return BadRequest(new { error = "This help request has already been resolved" });
            }

            // Update the help request
            helpRequest.Response = request.Response.Trim();
            helpRequest.Status = "Resolved";
            helpRequest.ResolvedByTeacherId = teacherId;
            helpRequest.ResolvedAt = DateTime.UtcNow;

            var questionPreview = string.IsNullOrWhiteSpace(helpRequest.Question)
                ? "Your help request"
                : helpRequest.Question[..Math.Min(helpRequest.Question.Length, 60)] +
                (helpRequest.Question.Length > 60 ? "..." : string.Empty);

            var notificationMessage = $"✅ {questionPreview} has a new reply from your teacher.";

            _context.Notifications.Add(new Notification
            {
                NotificationId = Guid.NewGuid(),
                UserId = helpRequest.StudentId,
                Message = notificationMessage,
                CreatedAt = DateTime.UtcNow
            });

            _context.HelpRequests.Update(helpRequest);
            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                helpRequestId = helpRequest.HelpRequestId,
                studentName = helpRequest.Student.FullName,
                question = helpRequest.Question,
                response = helpRequest.Response,
                status = helpRequest.Status,
                resolvedByTeacherId = helpRequest.ResolvedByTeacherId,
                resolvedAt = helpRequest.ResolvedAt,
                message = "Help request resolved successfully!"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error responding to help request {HelpRequestId}", helpRequestId);
            return StatusCode(500, new { error = "An error occurred while responding to the help request" });
        }
    }

    #endregion
}

#region DTOs

/// <summary>
/// Request model for creating a new course
/// </summary>
public record CreateCourseRequest
{
    [Required]
    [MinLength(3)]
    public string Title { get; init; } = string.Empty;

    public string? Description { get; init; }

    public string? PreviewContent { get; init; }
}

/// <summary>
/// Request model for updating a course
/// </summary>
public record UpdateCourseRequest
{
    [MinLength(3)]
    public string? Title { get; init; }

    public string? Description { get; init; }

    public string? PreviewContent { get; init; }
}

/// <summary>
/// Request model for responding to a help request
/// </summary>
public record HelpRequestResponseRequest
{
    [Required]
    [MinLength(10)]
    public string Response { get; init; } = string.Empty;
}

/// <summary>
/// Request model for creating a question
/// </summary>
public record CreateQuestionRequest
{
    [Required]
    public string Stem { get; init; } = string.Empty;
    
    public string? Difficulty { get; init; } // "easy", "medium", "hard"
    
    public string? QuestionType { get; init; } // "multiple_choice", "true_false", "short_answer", "essay"
    
    public string? ExpectedAnswer { get; init; } // For short_answer and essay
    
    public string? Explanation { get; init; }
    
    public List<QuestionOptionDto>? Options { get; init; } // For multiple_choice and true_false
}

/// <summary>
/// Request model for updating a question
/// </summary>
public record UpdateQuestionRequest
{
    public string? Stem { get; init; }
    
    public string? Difficulty { get; init; }
    
    public string? QuestionType { get; init; }
    
    public string? ExpectedAnswer { get; init; }
    
    public string? Explanation { get; init; }
    
    public List<QuestionOptionDto>? Options { get; init; }
}

/// <summary>
/// DTO for question options
/// </summary>
public record QuestionOptionDto
{
    [Required]
    public string Text { get; init; } = string.Empty;
    
    public bool IsCorrect { get; init; }
}

#endregion

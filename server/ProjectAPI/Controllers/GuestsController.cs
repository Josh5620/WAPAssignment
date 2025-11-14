using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;

namespace ProjectAPI.Controllers;

/// <summary>
/// Controller for guest (unregistered user) operations including browsing public content,
/// course previews, searching, and account registration.
/// </summary>
[ApiController]
[Route("api/guests")]
[AllowAnonymous]
public class GuestsController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<GuestsController> _logger;

    public GuestsController(ApplicationDbContext context, ILogger<GuestsController> logger)
    {
        _context = context;
        _logger = logger;
    }

    #region Course Catalog & Previews

    /// <summary>
    /// Get all approved and published courses for guest browsing
    /// </summary>
    [HttpGet("courses")]
    public async Task<IActionResult> GetCourseCatalog(CancellationToken ct = default)
    {
        try
        {
            var courses = await _context.Courses
                .Where(c => c.ApprovalStatus == "Approved" && c.Published == true)
                .Select(c => new
                {
                    courseId = c.CourseId,
                    title = c.Title,
                    description = c.Description,
                    previewContent = c.PreviewContent,
                    published = c.Published,
                    approvalStatus = c.ApprovalStatus,
                    chapterCount = c.Chapters.Count
                })
                .OrderBy(c => c.title)
                .ToListAsync(ct);

            return Ok(new
            {
                courses,
                total = courses.Count,
                message = "Preview mode - Sign up for full access"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving course catalog for guests");
            return StatusCode(500, new { error = "An error occurred while retrieving the course catalog" });
        }
    }

    /// <summary>
    /// Get a single approved course with its chapters for preview
    /// </summary>
    [HttpGet("courses/{courseId}/preview")]
    public async Task<IActionResult> GetCoursePreview(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            var course = await _context.Courses
                .Include(c => c.Chapters)
                    .ThenInclude(ch => ch.Resources)
                .FirstOrDefaultAsync(c => c.CourseId == courseId && c.ApprovalStatus == "Approved", ct);

            if (course == null)
            {
                return NotFound(new { error = "Course not found or not approved for preview" });
            }

            // Return course with first 3 chapters for preview (guest can only see 3 chapters)
            // For preview chapters, only show notes and flashcards (no challenges or help requests)
            var allChapters = course.Chapters.OrderBy(ch => ch.Number).ToList();
            var previewChapters = allChapters.Take(3).ToList();
            
            var preview = new
            {
                courseId = course.CourseId,
                title = course.Title,
                description = course.Description,
                previewContent = course.PreviewContent,
                published = course.Published,
                approvalStatus = course.ApprovalStatus,
                chapterCount = course.Chapters.Count,
                totalChapters = course.Chapters.Count,
                chapters = previewChapters
                    .Select(ch => new
                    {
                        chapterId = ch.ChapterId,
                        number = ch.Number,
                        title = ch.Title,
                        summary = ch.Summary,
                        // Preview mode: only notes and flashcards available
                        availableFeatures = new
                        {
                            notes = ch.Resources.Any(r => r.Type == "note"),
                            flashcards = ch.Resources.Any(r => r.Type == "flashcard"),
                            challenges = false, // Locked for guests
                            helpRequests = false // Locked for guests
                        },
                        previewResources = ch.Resources
                            .Where(r => r.Type == "note" || r.Type == "flashcard")
                            .Select(r => new
                            {
                                resourceId = r.ResourceId,
                                type = r.Type,
                                content = r.Content
                            })
                            .ToList()
                    })
                    .ToList(),
                message = "Preview mode: Access notes and flashcards. Sign up to unlock challenges, quizzes, and help requests."
            };

            return Ok(preview);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving course preview for course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while retrieving the course preview" });
        }
    }

    /// <summary>
    /// Get sample chapter preview (first chapter only, limited content)
    /// </summary>
    [HttpGet("courses/{courseId}/sample-chapter")]
    public async Task<IActionResult> GetSampleChapterPreview(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            var course = await _context.Courses
                .Include(c => c.Chapters.OrderBy(ch => ch.Number).Take(1))
                    .ThenInclude(ch => ch.Resources)
                .FirstOrDefaultAsync(c => c.CourseId == courseId && c.Published, ct);

            if (course == null || !course.Chapters.Any())
            {
                return NotFound(new { error = "Course or sample chapter not found" });
            }

            var firstChapter = course.Chapters.First();
            var sampleContent = new
            {
                courseId = course.CourseId,
                courseTitle = course.Title,
                chapter = new
                {
                    chapterId = firstChapter.ChapterId,
                    number = firstChapter.Number,
                    title = firstChapter.Title,
                    summary = firstChapter.Summary,
                    // Limited resource preview (only notes, no quizzes/flashcards)
                    sampleResources = firstChapter.Resources
                        .Where(r => r.Type == "note")
                        .Take(2) // Limit to 2 sample resources
                        .Select(r => new
                        {
                            resourceId = r.ResourceId,
                            type = r.Type,
                            content = r.Content != null && r.Content.Length > 500 
                                ? r.Content.Substring(0, 500) + "..." 
                                : r.Content
                        })
                        .ToList()
                },
                message = "This is a sample preview. Register to access all chapters and learning materials."
            };

            return Ok(sampleContent);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving sample chapter preview for course {CourseId}", courseId);
            return StatusCode(500, new { error = "An error occurred while retrieving the sample chapter" });
        }
    }

    #endregion

    #region Search

    /// <summary>
    /// Search public course content (restricted to published courses only)
    /// </summary>
    [HttpGet("search")]
    public async Task<IActionResult> SearchContent([FromQuery] string query, CancellationToken ct = default)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                return BadRequest(new { error = "Search query is required" });
            }

            var searchTerm = query.Trim().ToLower();

            // Search in published courses only
            var courses = await _context.Courses
                .Where(c => c.Published && (
                    c.Title.ToLower().Contains(searchTerm) ||
                    (c.Description != null && c.Description.ToLower().Contains(searchTerm)) ||
                    (c.PreviewContent != null && c.PreviewContent.ToLower().Contains(searchTerm))
                ))
                .Select(c => new
                {
                    courseId = c.CourseId,
                    title = c.Title,
                    description = c.Description,
                    previewContent = c.PreviewContent,
                    matchType = "course"
                })
                .ToListAsync(ct);

            // Search in chapter titles and summaries (from published courses only)
            var chapters = await _context.Chapters
                .Include(ch => ch.Course)
                .Where(ch => ch.Course.Published && (
                    ch.Title.ToLower().Contains(searchTerm) ||
                    (ch.Summary != null && ch.Summary.ToLower().Contains(searchTerm))
                ))
                .Select(ch => new
                {
                    courseId = ch.CourseId,
                    courseTitle = ch.Course.Title,
                    chapterId = ch.ChapterId,
                    chapterNumber = ch.Number,
                    chapterTitle = ch.Title,
                    chapterSummary = ch.Summary,
                    matchType = "chapter"
                })
                .ToListAsync(ct);

            return Ok(new
            {
                query = query,
                results = new
                {
                    courses,
                    chapters,
                    totalResults = courses.Count + chapters.Count
                },
                message = "Search results are limited to public content. Register for full access."
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching content with query: {Query}", query);
            return StatusCode(500, new { error = "An error occurred while searching content" });
        }
    }

    #endregion

    #region Registration

    /// <summary>
    /// Register a new user account
    /// </summary>
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request, CancellationToken ct = default)
    {
        try
        {
            if (request == null)
            {
                return BadRequest(new { error = "Registration data is required" });
            }

            // Validate input
            if (string.IsNullOrWhiteSpace(request.FullName))
            {
                return BadRequest(new { error = "Full name is required" });
            }

            if (string.IsNullOrWhiteSpace(request.Email) || !IsValidEmail(request.Email))
            {
                return BadRequest(new { error = "Valid email address is required" });
            }

            if (string.IsNullOrWhiteSpace(request.Password) || request.Password.Length < 6)
            {
                return BadRequest(new { error = "Password must be at least 6 characters long" });
            }

            // Check if email already exists
            var existingUser = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email.ToLower() == request.Email.ToLower(), ct);

            if (existingUser != null)
            {
                return Conflict(new { error = "An account with this email already exists" });
            }

            // Hash password (using BCrypt like in ProfilesController)
            var passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);

            // Create new profile
            var newProfile = new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = request.FullName.Trim(),
                Email = request.Email.Trim().ToLower(),
                PasswordHash = passwordHash,
                Role = request.Role?.ToLower() ?? "student",
                CreatedAt = DateTime.UtcNow
            };

            _context.Profiles.Add(newProfile);
            await _context.SaveChangesAsync(ct);

            // Return success response (without password hash)
            return CreatedAtAction(
                nameof(Register),
                new { id = newProfile.UserId },
                new
                {
                    userId = newProfile.UserId,
                    fullName = newProfile.FullName,
                    email = newProfile.Email,
                    role = newProfile.Role,
                    createdAt = newProfile.CreatedAt,
                    message = "Account created successfully. You can now log in."
                });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error registering new user");
            return StatusCode(500, new { error = "An error occurred while creating your account. Please try again." });
        }
    }

    /// <summary>
    /// Check if email is available for registration
    /// </summary>
    [HttpGet("check-email")]
    public async Task<IActionResult> CheckEmailAvailability([FromQuery] string email, CancellationToken ct = default)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(email) || !IsValidEmail(email))
            {
                return BadRequest(new { error = "Valid email address is required" });
            }

            var exists = await _context.Profiles
                .AnyAsync(p => p.Email.ToLower() == email.Trim().ToLower(), ct);

            return Ok(new
            {
                email = email,
                available = !exists,
                message = exists ? "This email is already registered" : "Email is available"
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking email availability for: {Email}", email);
            return StatusCode(500, new { error = "An error occurred while checking email availability" });
        }
    }

    #endregion

    #region Public Content (About, FAQ, Testimonials)

    /// <summary>
    /// Get About page content
    /// </summary>
    [HttpGet("about")]
    public IActionResult GetAboutContent()
    {
        try
        {
            // Static content - can be moved to database later if needed
            var aboutContent = new
            {
                title = "About CodeSage",
                content = new
                {
                    mission = "CodeSage is a learning platform designed to help you grow your programming skills through interactive courses, hands-on practice, and a supportive community.",
                    vision = "To make programming education accessible, engaging, and effective for learners of all levels.",
                    features = new[]
                    {
                        "Interactive coding lessons with real-time feedback",
                        "Comprehensive quizzes and flashcards for practice",
                        "Progress tracking and personalized learning paths",
                        "Community forums for collaboration and support",
                        "Gamified learning with XP points and leaderboards"
                    }
                }
            };

            return Ok(aboutContent);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving about content");
            return StatusCode(500, new { error = "An error occurred while retrieving about content" });
        }
    }

    /// <summary>
    /// Get Frequently Asked Questions
    /// </summary>
    [HttpGet("faq")]
    public IActionResult GetFAQs()
    {
        try
        {
            // Static FAQ content - can be moved to database later if needed
            var faqs = new[]
            {
                new
                {
                    id = 1,
                    question = "What is CodeSage?",
                    answer = "CodeSage is an online learning platform that offers interactive programming courses, quizzes, flashcards, and community features to help you learn coding effectively."
                },
                new
                {
                    id = 2,
                    question = "Do I need to pay to use CodeSage?",
                    answer = "CodeSage offers free access to course previews and public content. Full access to all courses and features requires registration, which is free."
                },
                new
                {
                    id = 3,
                    question = "What programming languages are available?",
                    answer = "Currently, we offer courses in Python, with plans to expand to other languages. You can browse our course catalog to see available courses."
                },
                new
                {
                    id = 4,
                    question = "How do I track my progress?",
                    answer = "Once you register and enroll in a course, you can track your progress through completed chapters, quiz scores, and XP points earned."
                },
                new
                {
                    id = 5,
                    question = "Can I access courses without registering?",
                    answer = "Yes! You can browse course previews, view sample content, and explore the platform without registering. However, full access to courses, quizzes, and progress tracking requires a free account."
                },
                new
                {
                    id = 6,
                    question = "How do I register?",
                    answer = "Click on the 'Register' button, fill in your details (name, email, password), and you'll be able to access all features immediately after registration."
                }
            };

            return Ok(new
            {
                faqs,
                total = faqs.Length
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving FAQs");
            return StatusCode(500, new { error = "An error occurred while retrieving FAQs" });
        }
    }

    /// <summary>
    /// Get all testimonials from the database
    /// </summary>
    [HttpGet("testimonials")]
    public async Task<IActionResult> GetTestimonials([FromQuery] Guid? courseId = null, [FromQuery] int? limit = null, CancellationToken ct = default)
    {
        try
        {
            var query = _context.Testimonials
                .Include(t => t.Profile)
                .Include(t => t.Course)
                .AsQueryable();

            // Filter by courseId if provided
            if (courseId.HasValue)
            {
                query = query.Where(t => t.CourseId == courseId.Value);
            }

            var testimonials = await query
                .Select(t => new
                {
                    testimonialId = t.TestimonialId,
                    rating = t.Rating,
                    comment = t.Comment,
                    createdAt = t.CreatedAt,
                    user = new
                    {
                        userId = t.Profile.UserId,
                        fullName = t.Profile.FullName,
                        role = t.Profile.Role
                    },
                    course = t.Course != null ? new
                    {
                        courseId = t.Course.CourseId,
                        title = t.Course.Title
                    } : null
                })
                .OrderByDescending(t => t.createdAt)
                .ToListAsync(ct);

            // Apply limit if provided
            if (limit.HasValue && limit.Value > 0)
            {
                testimonials = testimonials.Take(limit.Value).ToList();
            }

            return Ok(new
            {
                testimonials,
                total = testimonials.Count
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving testimonials");
            return StatusCode(500, new { error = "An error occurred while retrieving testimonials" });
        }
    }

    #endregion

    #region Helper Methods

    private static bool IsValidEmail(string email)
    {
        try
        {
            var addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }

    #endregion
}

#region DTOs

public record RegisterRequest
{
    [Required]
    public string FullName { get; init; } = string.Empty;

    [Required]
    [EmailAddress]
    public string Email { get; init; } = string.Empty;

    [Required]
    [MinLength(6)]
    public string Password { get; init; } = string.Empty;

    public string? Role { get; init; }
}

#endregion


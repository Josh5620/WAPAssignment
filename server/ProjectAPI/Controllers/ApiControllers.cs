using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers;

// ProfilesController - EF Core implementation maintaining Supabase API compatibility
[ApiController]
[Route("api/[controller]")]
public class ProfilesController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ProfilesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetProfiles(CancellationToken ct = default)
    {
        try
        {
            var profiles = await _context.Profiles
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync(ct);
            return Ok(profiles);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetProfileById(Guid id, CancellationToken ct = default)
    {
        try
        {
            var profile = await _context.Profiles.FirstOrDefaultAsync(p => p.UserId == id);
            if (profile == null)
                return NotFound(new { error = "Profile not found" });

            return Ok(profile);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("role/{role}")]
    public async Task<IActionResult> GetProfilesByRole(string role, CancellationToken ct = default)
    {
        try
        {
            var profiles = await _context.Profiles
                .Where(p => p.Role == role)
                .OrderByDescending(p => p.CreatedAt)
                .ToListAsync(ct);
            return Ok(profiles);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost]
    public async Task<IActionResult> CreateProfile([FromBody] CreateProfileRequest request, CancellationToken ct = default)
    {
        try
        {
            var profile = new Profile
            {
                UserId = request.Id,
                FullName = request.FullName,
                Email = request.Email,
                Role = request.Role ?? "student",
                PasswordHash = "1", // Default password as per schema
                CreatedAt = DateTime.UtcNow
            };

            _context.Profiles.Add(profile);
            await _context.SaveChangesAsync(ct);

            return CreatedAtAction(nameof(GetProfileById), new { id = profile.UserId }, profile);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPatch("{id}")]
    public async Task<IActionResult> UpdateProfile(Guid id, [FromBody] UpdateProfileRequest request, CancellationToken ct = default)
    {
        try
        {
            var profile = await _context.Profiles.FindAsync(id);
            if (profile == null)
                return NotFound(new { error = "Profile not found" });

            if (!string.IsNullOrEmpty(request.FullName))
                profile.FullName = request.FullName;
            
            if (!string.IsNullOrEmpty(request.Role))
                profile.Role = request.Role;

            await _context.SaveChangesAsync(ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteProfile(Guid id, CancellationToken ct = default)
    {
        try
        {
            var profile = await _context.Profiles.FindAsync(id);
            if (profile == null)
                return NotFound(new { error = "Profile not found" });

            _context.Profiles.Remove(profile);
            await _context.SaveChangesAsync(ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        try
        {
            if (request == null || string.IsNullOrEmpty(request.Identifier) || string.IsNullOrEmpty(request.Password))
            {
                return BadRequest(new { error = "Identifier and password are required" });
            }

            Profile? profile = null;

            // Check if identifier is an email (contains '@')
            if (request.Identifier.Contains('@'))
            {
                profile = await _context.Profiles
                    .FirstOrDefaultAsync(p => p.Email == request.Identifier);
            }
            else
            {
                // Treat as username (full_name)
                profile = await _context.Profiles
                    .FirstOrDefaultAsync(p => p.FullName == request.Identifier);
            }

            if (profile == null)
            {
                return Unauthorized(new { error = "User not found", identifier = request.Identifier });
            }

            // Add debugging for password verification
            bool isValidPassword = BCrypt.Net.BCrypt.Verify(request.Password, profile.PasswordHash);
            
            if (!isValidPassword)
            {
                return Unauthorized(new { 
                    error = "Invalid password", 
                    debug = new {
                        email = profile.Email,
                        inputPassword = request.Password,
                        passwordHashLength = profile.PasswordHash.Length,
                        passwordHashStart = profile.PasswordHash.Substring(0, Math.Min(10, profile.PasswordHash.Length))
                    }
                });
            }

            // Return profile with mock token structure (similar to Supabase response)
            var loginResponse = new
            {
                id = profile.UserId,
                full_name = profile.FullName,
                email = profile.Email,
                role = profile.Role,
                created_at = profile.CreatedAt,
                access_token = "mock_access_token", // In real implementation, generate JWT
                refresh_token = "mock_refresh_token",
                auth_user = new { id = profile.UserId, email = profile.Email }
            };

            return Ok(loginResponse);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost("simple-login")]
    public async Task<IActionResult> SimpleLogin([FromBody] LoginRequest request)
    {
        try
        {
            if (request == null || string.IsNullOrEmpty(request.Identifier) || string.IsNullOrEmpty(request.Password))
            {
                return BadRequest(new { error = "Identifier and password are required" });
            }

            var profile = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email == request.Identifier);

            if (profile == null)
            {
                return Unauthorized(new { error = "User not found", identifier = request.Identifier });
            }

            // Simple string comparison (ONLY FOR TESTING!)
            if (profile.PasswordHash != request.Password)
            {
                return Unauthorized(new { 
                    error = "Invalid password", 
                    debug = new {
                        expected = profile.PasswordHash,
                        received = request.Password
                    }
                });
            }

            // Return success response
            var loginResponse = new
            {
                id = profile.UserId,
                full_name = profile.FullName,
                email = profile.Email,
                role = profile.Role,
                created_at = profile.CreatedAt,
                access_token = "simple_access_token",
                refresh_token = "simple_refresh_token",
                auth_user = new { id = profile.UserId, email = profile.Email }
            };

            return Ok(loginResponse);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }
}

public record CreateProfileRequest(Guid Id, string FullName, string Email, string? Role = null);
public record UpdateProfileRequest(string? FullName = null, string? Role = null);
public record LoginRequest(string Identifier, string Password);

// CoursesController - EF Core implementation maintaining Supabase API compatibility
[ApiController]
[Route("api/[controller]")]
public sealed class CoursesController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public CoursesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> List(CancellationToken ct) =>
        Ok(await _context.Courses.ToListAsync(ct));

    public sealed record CreateDto(string Title, string? Description);
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateDto dto, CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(dto.Title)) return BadRequest(new { message = "Title required" });
        
        var course = new Course
        {
            CourseId = Guid.NewGuid(),
            Title = dto.Title,
            Description = dto.Description ?? string.Empty,
            PreviewContent = string.Empty,
            Published = false
        };

        _context.Courses.Add(course);
        await _context.SaveChangesAsync(ct);
        
        return Created(string.Empty, course);
    }

    public sealed record UpdateDto(string? Title, string? Description);
    [HttpPut("{id:guid}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateDto dto, CancellationToken ct)
    {
        var course = await _context.Courses.FirstOrDefaultAsync(c => c.CourseId == id);
        if (course == null)
            return NotFound();

        if (!string.IsNullOrEmpty(dto.Title))
            course.Title = dto.Title;
        
        if (dto.Description != null)
            course.Description = dto.Description;

        await _context.SaveChangesAsync(ct);
        return NoContent();
    }

    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> Delete(Guid id, CancellationToken ct)
    {
        var course = await _context.Courses.FindAsync(id);
        if (course == null)
            return NotFound();

        _context.Courses.Remove(course);
        await _context.SaveChangesAsync(ct);
        return NoContent();
    }
}

// ChaptersController - EF Core implementation maintaining Supabase API compatibility
[ApiController]
[Route("api/[controller]")]
public sealed class ChaptersController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ChaptersController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("course/{courseId}")]
    public async Task<IActionResult> GetChaptersByCourse(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            var chapters = await _context.Chapters
                .Where(c => c.CourseId == courseId)
                .OrderBy(c => c.Number)
                .ToListAsync(ct);
            return Ok(chapters);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetChapterById(Guid id, CancellationToken ct = default)
    {
        try
        {
            var chapter = await _context.Chapters.FirstOrDefaultAsync(c => c.ChapterId == id);
            if (chapter == null)
                return NotFound(new { error = "Chapter not found" });

            return Ok(chapter);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost]
    public async Task<IActionResult> CreateChapter([FromBody] CreateChapterRequest request, CancellationToken ct = default)
    {
        try
        {
            var chapter = new Chapter
            {
                ChapterId = Guid.NewGuid(),
                CourseId = request.CourseId,
                Number = request.Number,
                Title = request.Title,
                Summary = request.Summary ?? string.Empty
            };

            _context.Chapters.Add(chapter);
            await _context.SaveChangesAsync(ct);

            return CreatedAtAction(nameof(GetChapterById), new { id = chapter.ChapterId }, chapter);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPatch("{id}")]
    public async Task<IActionResult> UpdateChapter(Guid id, [FromBody] UpdateChapterRequest request, CancellationToken ct = default)
    {
        try
        {
            var chapter = await _context.Chapters.FindAsync(id);
            if (chapter == null)
                return NotFound(new { error = "Chapter not found" });

            if (!string.IsNullOrEmpty(request.Title))
                chapter.Title = request.Title;
            
            if (request.Summary != null)
                chapter.Summary = request.Summary;

            await _context.SaveChangesAsync(ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteChapter(Guid id, CancellationToken ct = default)
    {
        try
        {
            var chapter = await _context.Chapters.FindAsync(id);
            if (chapter == null)
                return NotFound(new { error = "Chapter not found" });

            _context.Chapters.Remove(chapter);
            await _context.SaveChangesAsync(ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }
}

public record CreateChapterRequest(Guid CourseId, int Number, string Title, string? Summary = null);
public record UpdateChapterRequest(string? Title = null, string? Summary = null);

// ResourcesController
[ApiController]
[Route("api/[controller]")]
public class ResourcesController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ResourcesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetResources([FromQuery] Guid chapterId)
    {
        var resources = await _context.Resources
            .Where(r => r.ChapterId == chapterId)
            .Include(r => r.Flashcards)
            .Include(r => r.Questions)
                .ThenInclude(q => q.QuestionOptions)
            .ToListAsync();

        return Ok(resources);
    }

    [HttpPost]
    public async Task<IActionResult> CreateResource(Resource resource)
    {
        _context.Resources.Add(resource);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetResources), new { chapterId = resource.ChapterId }, resource);
    }
}

// EnrolmentsController
[ApiController]
[Route("api/[controller]")]
public class EnrolmentsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public EnrolmentsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetEnrolments([FromQuery] Guid userId)
    {
        var enrolments = await _context.Enrolments
            .Where(e => e.UserId == userId)
            .Include(e => e.Course)
            .ToListAsync();

        return Ok(enrolments);
    }

    [HttpPost]
    public async Task<IActionResult> CreateEnrolment(Enrolment enrolment)
    {
        // Check if enrolment already exists
        var existingEnrolment = await _context.Enrolments
            .FirstOrDefaultAsync(e => e.UserId == enrolment.UserId && e.CourseId == enrolment.CourseId);

        if (existingEnrolment != null)
            return Conflict("User is already enrolled in this course");

        _context.Enrolments.Add(enrolment);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetEnrolments), new { userId = enrolment.UserId }, enrolment);
    }

    [HttpPut]
    public async Task<IActionResult> UpdateEnrolment(Enrolment enrolment)
    {
        var existingEnrolment = await _context.Enrolments
            .FirstOrDefaultAsync(e => e.UserId == enrolment.UserId && e.CourseId == enrolment.CourseId);

        if (existingEnrolment == null)
            return NotFound();

        existingEnrolment.Status = enrolment.Status;
        await _context.SaveChangesAsync();

        return NoContent();
    }
}

// ChapterProgressController
[ApiController]
[Route("api/[controller]")]
public class ChapterProgressController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ChapterProgressController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetProgress([FromQuery] Guid userId, [FromQuery] Guid chapterId)
    {
        var progress = await _context.ChapterProgress
            .FirstOrDefaultAsync(cp => cp.UserId == userId && cp.ChapterId == chapterId);

        if (progress == null)
            return NotFound();

        return Ok(progress);
    }

    [HttpPost]
    public async Task<IActionResult> UpdateProgress(ChapterProgress progress)
    {
        var existingProgress = await _context.ChapterProgress
            .FirstOrDefaultAsync(cp => cp.UserId == progress.UserId && cp.ChapterId == progress.ChapterId);

        if (existingProgress == null)
        {
            _context.ChapterProgress.Add(progress);
        }
        else
        {
            existingProgress.Completed = progress.Completed;
            existingProgress.McqsAttempted = progress.McqsAttempted;
            existingProgress.McqsCorrect = progress.McqsCorrect;
        }

        await _context.SaveChangesAsync();

        return Ok(progress);
    }
}

// ForumPostsController
[ApiController]
[Route("api/[controller]")]
public class ForumPostsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public ForumPostsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetForumPosts([FromQuery] Guid courseId)
    {
        var posts = await _context.ForumPosts
            .Where(fp => fp.CourseId == courseId)
            .Include(fp => fp.Profile)
            .OrderByDescending(fp => fp.CreatedAt)
            .ToListAsync();

        return Ok(posts);
    }

    [HttpPost]
    public async Task<IActionResult> CreateForumPost(ForumPost forumPost)
    {
        forumPost.CreatedAt = DateTime.UtcNow;
        _context.ForumPosts.Add(forumPost);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetForumPosts), new { courseId = forumPost.CourseId }, forumPost);
    }
}

// LeaderboardController
[ApiController]
[Route("api/[controller]")]
public class LeaderboardController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public LeaderboardController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetLeaderboard()
    {
        var leaderboard = await _context.Leaderboards
            .Include(l => l.Profile)
            .OrderByDescending(l => l.XP)
            .ThenByDescending(l => l.Streaks)
            .ToListAsync();

        return Ok(leaderboard);
    }

    [HttpGet("{userId}")]
    public async Task<IActionResult> GetUserLeaderboard(Guid userId)
    {
        var userLeaderboard = await _context.Leaderboards
            .Include(l => l.Profile)
            .FirstOrDefaultAsync(l => l.UserId == userId);

        if (userLeaderboard == null)
            return NotFound();

        return Ok(userLeaderboard);
    }

    [HttpPost]
    public async Task<IActionResult> UpdateLeaderboard(Leaderboard leaderboard)
    {
        var existing = await _context.Leaderboards.FirstOrDefaultAsync(l => l.UserId == leaderboard.UserId);

        if (existing == null)
        {
            _context.Leaderboards.Add(leaderboard);
        }
        else
        {
            existing.XP = leaderboard.XP;
            existing.Streaks = leaderboard.Streaks;
            existing.Badges = leaderboard.Badges;
        }

        await _context.SaveChangesAsync();

        return Ok(leaderboard);
    }
}

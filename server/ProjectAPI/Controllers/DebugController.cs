using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DebugController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public DebugController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("profiles")]
    public async Task<IActionResult> GetAllProfiles()
    {
        try
        {
            var profiles = await _context.Profiles
                .Select(p => new {
                    p.UserId,
                    p.Email,
                    p.FullName,
                    p.Role,
                    PasswordHashLength = p.PasswordHash.Length,
                    PasswordHashStartsWith = p.PasswordHash.Substring(0, Math.Min(10, p.PasswordHash.Length))
                })
                .ToListAsync();
            
            return Ok(profiles);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost("test-login")]
    public async Task<IActionResult> TestLogin([FromBody] TestLoginRequest request)
    {
        try
        {
            var profile = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email == request.Email);

            if (profile == null)
            {
                return NotFound(new { error = "Profile not found", email = request.Email });
            }

            var isValidPassword = BCrypt.Net.BCrypt.Verify(request.Password, profile.PasswordHash);
            
            return Ok(new {
                email = profile.Email,
                fullName = profile.FullName,
                role = profile.Role,
                passwordHashLength = profile.PasswordHash.Length,
                passwordHashStartsWith = profile.PasswordHash.Substring(0, Math.Min(10, profile.PasswordHash.Length)),
                inputPassword = request.Password,
                isValidPassword = isValidPassword,
                message = isValidPassword ? "Password is correct!" : "Password verification failed"
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message });
        }
    }

    [HttpGet("testimonials")]
    public async Task<IActionResult> CheckTestimonials()
    {
        try
        {
            var count = await _context.Testimonials.CountAsync();
            var testimonials = await _context.Testimonials
                .Include(t => t.Profile)
                .Include(t => t.Course)
                .Select(t => new
                {
                    t.TestimonialId,
                    t.Rating,
                    t.Comment,
                    UserEmail = t.Profile.Email,
                    UserName = t.Profile.FullName,
                    CourseTitle = t.Course != null ? t.Course.Title : "General"
                })
                .Take(10)
                .ToListAsync();

            var pythonCourse = await _context.Courses
                .FirstOrDefaultAsync(c => c.Title == "The Garden of Python");
            
            var requiredProfiles = new[]
            {
                "alice.student@codesage.com",
                "bob.smith@codesage.com",
                "emma.t@codesage.com",
                "carlos.m@codesage.com",
                "sophia.lee@codesage.com",
                "james.w@codesage.com"
            };

            var existingProfiles = await _context.Profiles
                .Where(p => requiredProfiles.Contains(p.Email))
                .Select(p => p.Email)
                .ToListAsync();

            return Ok(new
            {
                testimonialCount = count,
                testimonials,
                pythonCourseExists = pythonCourse != null,
                pythonCourseId = pythonCourse?.CourseId,
                requiredProfiles = requiredProfiles,
                existingProfiles = existingProfiles,
                missingProfiles = requiredProfiles.Except(existingProfiles).ToList()
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message });
        }
    }
}

public class TestLoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
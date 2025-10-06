using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TestDataController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public TestDataController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpPost("seed")]
    public async Task<IActionResult> SeedTestData()
    {
        try
        {
            // Clear existing profiles first to avoid duplicates
            var existingProfiles = await _context.Profiles.ToListAsync();
            _context.Profiles.RemoveRange(existingProfiles);
            await _context.SaveChangesAsync();

            // Check if courses already exist (but not profiles)
            var coursesExist = await _context.Courses.AnyAsync();

            // Create test profiles with variety of users - using List for better control
            var testProfiles = new List<Profile>();

            // Admin users
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Admin User",
                Email = "admin@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("admin123"),
                Role = "admin",
                CreatedAt = DateTime.UtcNow.AddDays(-30)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Sarah Administrator",
                Email = "sarah.admin@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "admin",
                CreatedAt = DateTime.UtcNow.AddDays(-25)
            });

            // Teacher users
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Dr. Michael Johnson",
                Email = "teacher@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher123"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-20)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Prof. Emily Chen",
                Email = "emily.chen@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-18)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "David Rodriguez",
                Email = "david.teacher@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher456"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-15)
            });

            // Student users
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "John Student",
                Email = "student@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-10)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Alice Williams",
                Email = "alice.student@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-8)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Bob Smith",
                Email = "bob.smith@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student456"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-7)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Emma Thompson",
                Email = "emma.t@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("emma123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-5)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Carlos Martinez",
                Email = "carlos.m@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("carlos789"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-3)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "Sophia Lee",
                Email = "sophia.lee@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("sophia321"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-2)
            });
            testProfiles.Add(new Profile
            {
                Id = Guid.NewGuid(),
                FullName = "James Wilson",
                Email = "james.w@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("james654"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-1)
            });

            Console.WriteLine($"About to add {testProfiles.Count} profiles to database");
            await _context.Profiles.AddRangeAsync(testProfiles);
            await _context.SaveChangesAsync();
            Console.WriteLine($"Successfully added {testProfiles.Count} profiles to database");

            // Get the first student and admin for enrollment
            var adminProfile = testProfiles.First(p => p.Role == "admin");
            var studentProfile = testProfiles.First(p => p.Role == "student");

            Course jsCourse, pythonCourse;
            
            if (!coursesExist)
            {
                // Create test courses
                jsCourse = new Course
                {
                    Id = Guid.NewGuid(),
                    Title = "JavaScript Fundamentals",
                    Description = "Learn the basics of JavaScript programming",
                    PreviewContent = "Introduction to variables, functions, and control structures",
                    Published = true
                };

                pythonCourse = new Course
                {
                    Id = Guid.NewGuid(),
                    Title = "Python for Beginners",
                    Description = "Start your Python journey with this comprehensive course",
                    PreviewContent = "Learn Python syntax, data types, and basic programming concepts",
                    Published = true
                };

                await _context.Courses.AddRangeAsync(jsCourse, pythonCourse);
                await _context.SaveChangesAsync();
            }
            else
            {
                // Get existing courses
                jsCourse = await _context.Courses.FirstAsync();
                pythonCourse = await _context.Courses.Skip(1).FirstAsync();
            }

            // Create test chapters
            var jsChapter1 = new Chapter
            {
                Id = Guid.NewGuid(),
                CourseId = jsCourse.Id,
                Number = 1,
                Title = "Variables and Data Types",
                Summary = "Learn about JavaScript variables and different data types"
            };

            var pythonChapter1 = new Chapter
            {
                Id = Guid.NewGuid(),
                CourseId = pythonCourse.Id,
                Number = 1,
                Title = "Python Basics",
                Summary = "Introduction to Python programming fundamentals"
            };

            await _context.Chapters.AddRangeAsync(jsChapter1, pythonChapter1);
            await _context.SaveChangesAsync();

            // Create test enrollment
            var enrollment = new Enrolment
            {
                UserId = studentProfile.Id,
                CourseId = jsCourse.Id,
                Status = "active"
            };

            await _context.Enrolments.AddAsync(enrollment);
            await _context.SaveChangesAsync();

            return Ok(new { 
                message = "Test data created successfully!",
                data = new {
                    profiles = 12,
                    courses = 2,
                    chapters = 2,
                    enrollments = 1
                },
                accounts = new {
                    admins = testProfiles.Where(p => p.Role == "admin").Select(p => new { p.Email, p.FullName, Password = "Check documentation for passwords" }),
                    teachers = testProfiles.Where(p => p.Role == "teacher").Select(p => new { p.Email, p.FullName, Password = "Check documentation for passwords" }),
                    students = testProfiles.Where(p => p.Role == "student").Select(p => new { p.Email, p.FullName, Password = "Check documentation for passwords" })
                }
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message });
        }
    }

    [HttpPost("create-test-users")]
    public async Task<IActionResult> CreateTestUsers()
    {
        try
        {
            // Clear existing profiles
            var existingProfiles = await _context.Profiles.ToListAsync();
            _context.Profiles.RemoveRange(existingProfiles);
            await _context.SaveChangesAsync();

            // Create fresh test users with simple passwords
            var testUsers = new[]
            {
                new Profile
                {
                    Id = Guid.NewGuid(),
                    FullName = "Test Student",
                    Email = "student@test.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("password"),
                    Role = "student",
                    CreatedAt = DateTime.UtcNow
                },
                new Profile
                {
                    Id = Guid.NewGuid(),
                    FullName = "Test Admin",
                    Email = "admin@test.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("password"),
                    Role = "admin",
                    CreatedAt = DateTime.UtcNow
                }
            };

            await _context.Profiles.AddRangeAsync(testUsers);
            await _context.SaveChangesAsync();

            return Ok(new { 
                message = "Test users created successfully!",
                users = testUsers.Select(u => new { u.Email, Password = "password", u.Role }).ToArray()
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message });
        }
    }

    [HttpPost("create-simple-users")]
    public async Task<IActionResult> CreateSimpleUsers()
    {
        try
        {
            // Clear existing profiles
            var existingProfiles = await _context.Profiles.ToListAsync();
            _context.Profiles.RemoveRange(existingProfiles);
            await _context.SaveChangesAsync();

            // Create test users with plain text passwords (ONLY FOR TESTING!)
            var testUsers = new[]
            {
                new Profile
                {
                    Id = Guid.NewGuid(),
                    FullName = "Simple Student",
                    Email = "simple@test.com",
                    PasswordHash = "test123", // Plain text for debugging
                    Role = "student",
                    CreatedAt = DateTime.UtcNow
                }
            };

            await _context.Profiles.AddRangeAsync(testUsers);
            await _context.SaveChangesAsync();

            return Ok(new { 
                message = "Simple test user created (plain password)!",
                users = testUsers.Select(u => new { u.Email, Password = "test123", u.Role }).ToArray()
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message });
        }
    }

    [HttpGet("status")]
    public async Task<IActionResult> GetDataStatus()
    {
        try
        {
            var status = new
            {
                profiles = await _context.Profiles.CountAsync(),
                courses = await _context.Courses.CountAsync(),
                chapters = await _context.Chapters.CountAsync(),
                resources = await _context.Resources.CountAsync(),
                questions = await _context.Questions.CountAsync(),
                flashcards = await _context.Flashcards.CountAsync(),
                enrollments = await _context.Enrolments.CountAsync()
            };

            return Ok(status);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpDelete("clear")]
    public async Task<IActionResult> ClearTestData()
    {
        try
        {
            // Clear all data in proper order
            _context.QuestionOptions.RemoveRange(_context.QuestionOptions);
            _context.Questions.RemoveRange(_context.Questions);
            _context.Flashcards.RemoveRange(_context.Flashcards);
            _context.Resources.RemoveRange(_context.Resources);
            _context.ChapterProgress.RemoveRange(_context.ChapterProgress);
            _context.Enrolments.RemoveRange(_context.Enrolments);
            _context.Chapters.RemoveRange(_context.Chapters);
            _context.Courses.RemoveRange(_context.Courses);
            _context.ForumPosts.RemoveRange(_context.ForumPosts);
            _context.Leaderboards.RemoveRange(_context.Leaderboards);
            _context.Profiles.RemoveRange(_context.Profiles);

            await _context.SaveChangesAsync();
            return Ok(new { message = "All test data cleared successfully!" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }
}
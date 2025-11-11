using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api/[controller]")]

// Used to add or clear test data in the database for development and testing purposes.
// Adds Data to the DBContext directly - bypassing services and business logic.
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
            // Clear existing data in proper order to avoid FK constraints
            _context.ChapterProgress.RemoveRange(_context.ChapterProgress);
            _context.Enrolments.RemoveRange(_context.Enrolments);
            _context.Chapters.RemoveRange(_context.Chapters);
            _context.Courses.RemoveRange(_context.Courses);
            _context.Profiles.RemoveRange(_context.Profiles);
            await _context.SaveChangesAsync();

            // ===================================
            // STEP 1: Create and save all Profiles first
            // ===================================
            var testProfiles = new List<Profile>();

            // Admin users
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Admin User",
                Email = "admin@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("admin123"),
                Role = "admin",
                CreatedAt = DateTime.UtcNow.AddDays(-30)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Sarah Administrator",
                Email = "sarah.admin@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "admin",
                CreatedAt = DateTime.UtcNow.AddDays(-25)
            });

            // Teacher users
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Dr. Michael Johnson",
                Email = "teacher@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher123"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-20)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Prof. Emily Chen",
                Email = "emily.chen@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-18)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "David Rodriguez",
                Email = "david.teacher@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher456"),
                Role = "teacher",
                CreatedAt = DateTime.UtcNow.AddDays(-15)
            });

            // Student users
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "John Student",
                Email = "student@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-10)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Alice Williams",
                Email = "alice.student@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-8)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Bob Smith",
                Email = "bob.smith@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student456"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-7)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Emma Thompson",
                Email = "emma.t@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("emma123"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-5)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Carlos Martinez",
                Email = "carlos.m@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("carlos789"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-3)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
                FullName = "Sophia Lee",
                Email = "sophia.lee@codesage.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("sophia321"),
                Role = "student",
                CreatedAt = DateTime.UtcNow.AddDays(-2)
            });
            testProfiles.Add(new Profile
            {
                UserId = Guid.NewGuid(),
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

            // ===================================
            // STEP 2: Query the database to get a valid TeacherId
            // ===================================
            var teacherProfile = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email == "teacher@codesage.com");

            if (teacherProfile == null)
            {
                return StatusCode(500, new { error = "Failed to create teacher profile" });
            }

            Console.WriteLine($"Found teacher with UserId: {teacherProfile.UserId}");

            // ===================================
            // STEP 3: Create Courses with valid TeacherId
            // ===================================
            var jsCourse = new Course
            {
                CourseId = Guid.NewGuid(),
                Title = "JavaScript Fundamentals",
                Description = "Learn the basics of JavaScript programming",
                PreviewContent = "Introduction to variables, functions, and control structures",
                Published = true,
                TeacherId = teacherProfile.UserId, // Set valid TeacherId
                ApprovalStatus = "Approved" // Set to approved for testing
            };

            var pythonCourse = new Course
            {
                CourseId = Guid.NewGuid(),
                Title = "Python for Beginners",
                Description = "Start your Python journey with this comprehensive course",
                PreviewContent = "Learn Python syntax, data types, and basic programming concepts",
                Published = true,
                TeacherId = teacherProfile.UserId, // Set valid TeacherId
                ApprovalStatus = "Approved" // Set to approved for testing
            };

            Console.WriteLine("About to add courses to database");
            await _context.Courses.AddRangeAsync(jsCourse, pythonCourse);
            await _context.SaveChangesAsync();
            Console.WriteLine("Successfully added courses to database");

            // ===================================
            // STEP 4: Create Chapters
            // ===================================
            var jsChapter1 = new Chapter
            {
                ChapterId = Guid.NewGuid(),
                CourseId = jsCourse.CourseId,
                Number = 1,
                Title = "Variables and Data Types",
                Summary = "Learn about JavaScript variables and different data types"
            };

            var pythonChapter1 = new Chapter
            {
                ChapterId = Guid.NewGuid(),
                CourseId = pythonCourse.CourseId,
                Number = 1,
                Title = "Python Basics",
                Summary = "Introduction to Python programming fundamentals"
            };

            await _context.Chapters.AddRangeAsync(jsChapter1, pythonChapter1);
            await _context.SaveChangesAsync();
            Console.WriteLine("Successfully added chapters to database");

            // ===================================
            // STEP 5: Create test enrollment
            // ===================================
            var studentProfile = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email == "student@codesage.com");

            if (studentProfile != null)
            {
                var enrollment = new Enrolment
                {
                    UserId = studentProfile.UserId,
                    CourseId = jsCourse.CourseId,
                    Status = "active",
                    EnrolledAt = DateTime.UtcNow
                };

                await _context.Enrolments.AddAsync(enrollment);
                await _context.SaveChangesAsync();
                Console.WriteLine("Successfully added enrollment to database");
            }

            return Ok(new
            {
                message = "Test data created successfully!",
                data = new
                {
                    profiles = testProfiles.Count,
                    courses = 2,
                    chapters = 2,
                    enrollments = 1
                },
                accounts = new
                {
                    admins = testProfiles.Where(p => p.Role == "admin").Select(p => new { p.Email, p.FullName, Password = "admin123 or password123" }),
                    teachers = testProfiles.Where(p => p.Role == "teacher").Select(p => new { p.Email, p.FullName, Password = "teacher123 or password123 or teacher456" }),
                    students = testProfiles.Where(p => p.Role == "student").Select(p => new { p.Email, p.FullName, Password = "student123 or password123 or student456 or emma123 or carlos789 or sophia321 or james654" })
                }
            });
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in SeedTestData: {ex.Message}");
            Console.WriteLine($"Inner Exception: {ex.InnerException?.Message}");
            return StatusCode(500, new { error = ex.Message, details = ex.InnerException?.Message, stackTrace = ex.StackTrace });
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
                    UserId = Guid.NewGuid(),
                    FullName = "Test Student",
                    Email = "student@test.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("password"),
                    Role = "student",
                    CreatedAt = DateTime.UtcNow
                },
                new Profile
                {
                    UserId = Guid.NewGuid(),
                    FullName = "Test Admin",
                    Email = "admin@test.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("password"),
                    Role = "admin",
                    CreatedAt = DateTime.UtcNow
                }
            };

            await _context.Profiles.AddRangeAsync(testUsers);
            await _context.SaveChangesAsync();

            return Ok(new
            {
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
                    UserId = Guid.NewGuid(),
                    FullName = "Simple Student",
                    Email = "simple@test.com",
                    PasswordHash = "test123", // Plain text for debugging
                    Role = "student",
                    CreatedAt = DateTime.UtcNow
                }
            };

            await _context.Profiles.AddRangeAsync(testUsers);
            await _context.SaveChangesAsync();

            return Ok(new
            {
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



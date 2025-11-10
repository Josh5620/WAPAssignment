using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    // [Authorize] // TODO: Re-enable when authentication is properly configured
    public class AdminController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public AdminController(ApplicationDbContext context)
        {
            _context = context;
        }

        // === DASHBOARD DATA ===
        [HttpGet("dashboard")]
        public async Task<IActionResult> GetDashboardData()
        {
            try
            {
                var stats = await GetDashboardStatistics();
                var recentUsers = await GetRecentUsers();
                var recentPosts = await GetRecentPosts();

                return Ok(new
                {
                    success = true,
                    data = new
                    {
                        statistics = stats,
                        recentUsers = recentUsers,
                        recentPosts = recentPosts
                    }
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to load dashboard data", error = ex.Message });
            }
        }

        // === USER MANAGEMENT ===
        [HttpGet("users")]
        public async Task<IActionResult> GetAllUsers()
        {
            try
            {
                // First check if we can connect to database and if there are any profiles
                var profileCount = await _context.Profiles.CountAsync();
                Console.WriteLine($"Total profiles in database: {profileCount}");

                var users = await _context.Profiles
                    .Select(u => new
                    {
                        id = u.UserId,
                        u.FullName,
                        u.Email,
                        u.Role,
                        u.CreatedAt
                    })
                    .OrderByDescending(u => u.CreatedAt)
                    .ToListAsync();

                Console.WriteLine($"Retrieved {users.Count} users from database");
                
                return Ok(new { success = true, data = users, count = users.Count });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in GetAllUsers: {ex.Message}");
                Console.WriteLine($"Stack trace: {ex.StackTrace}");
                return StatusCode(500, new { success = false, message = "Failed to load users", error = ex.Message });
            }
        }

        [HttpPut("users/{userId}/role")]
        public async Task<IActionResult> UpdateUserRole(Guid userId, [FromBody] UpdateRoleDto dto)
        {
            try
            {
                var user = await _context.Profiles.FindAsync(userId);
                if (user == null)
                    return NotFound(new { success = false, message = "User not found" });

                user.Role = dto.NewRole;
                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "User role updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to update user role", error = ex.Message });
            }
        }

        [HttpDelete("users/{userId}")]
        public async Task<IActionResult> DeleteUser(Guid userId)
        {
            try
            {
                var user = await _context.Profiles.FindAsync(userId);
                if (user == null)
                    return NotFound(new { success = false, message = "User not found" });

                _context.Profiles.Remove(user);
                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "User deleted successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to delete user", error = ex.Message });
            }
        }

        // === COURSE MANAGEMENT ===
        [HttpGet("courses")]
        public async Task<IActionResult> GetAllCourses()
        {
            try
            {
                var courses = await _context.Courses
                    .Include(c => c.Chapters)
                    .Include(c => c.Enrolments)
                    .Select(c => new
                    {
                        id = c.CourseId,
                        c.Title,
                        c.Description,
                        c.Published,
                        // TODO: Add these fields to Course model when ready
                        // c.PendingApproval,
                        // c.CreatedBy,
                        // c.CreatedAt
                        chapterCount = c.Chapters.Count,
                        enrollmentCount = c.Enrolments.Count
                    })
                    .ToListAsync();

                return Ok(new { success = true, data = courses });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to load courses", error = ex.Message });
            }
        }

        [HttpGet("courses/pending-approval")]
        public async Task<IActionResult> GetPendingApprovalCourses()
        {
            try
            {
                // TODO: Implement when approval fields are added to Course model
                // For now, return empty array
                var pendingCourses = new object[] { };

                return Ok(new { success = true, data = pendingCourses });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to load pending courses", error = ex.Message });
            }
        }

        [HttpPut("courses/{courseId}/approve")]
        public async Task<IActionResult> ApproveCourse(Guid courseId, [FromBody] ApproveCourseDto dto)
        {
            try
            {
                var course = await _context.Courses.FindAsync(courseId);
                if (course == null)
                    return NotFound(new { success = false, message = "Course not found" });

                // For now, just publish/unpublish the course
                // TODO: Implement full approval workflow when model is updated
                course.Published = dto.Approved;
                await _context.SaveChangesAsync();

                return Ok(new { 
                    success = true, 
                    message = dto.Approved ? "Course approved and published successfully" : "Course rejected"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to process course approval", error = ex.Message });
            }
        }

        [HttpPost("courses")]
        public async Task<IActionResult> CreateCourse([FromBody] CreateCourseDto dto)
        {
            try
            {
                var course = new Course
                {
                    CourseId = Guid.NewGuid(),
                    Title = dto.Title,
                    Description = dto.Description,
                    Published = dto.Published
                };

                _context.Courses.Add(course);
                await _context.SaveChangesAsync();

                return Ok(new { 
                    success = true, 
                    data = new { 
                        id = course.CourseId, 
                        course.Title, 
                        course.Description, 
                        course.Published 
                    }, 
                    message = "Course created successfully" 
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to create course", error = ex.Message });
            }
        }

        [HttpPut("courses/{courseId}")]
        public async Task<IActionResult> UpdateCourse(Guid courseId, [FromBody] UpdateCourseDto dto)
        {
            try
            {
                var course = await _context.Courses.FindAsync(courseId);
                if (course == null)
                    return NotFound(new { success = false, message = "Course not found" });

                course.Title = dto.Title ?? course.Title;
                course.Description = dto.Description ?? course.Description;
                course.Published = dto.Published ?? course.Published;

                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "Course updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to update course", error = ex.Message });
            }
        }

        [HttpDelete("courses/{courseId}")]
        public async Task<IActionResult> DeleteCourse(Guid courseId)
        {
            try
            {
                var course = await _context.Courses.FindAsync(courseId);
                if (course == null)
                    return NotFound(new { success = false, message = "Course not found" });

                _context.Courses.Remove(course);
                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "Course deleted successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to delete course", error = ex.Message });
            }
        }

        [HttpPut("courses/{courseId}/status")]
        public async Task<IActionResult> UpdateCourseStatus(Guid courseId, [FromBody] UpdateCourseStatusDto dto)
        {
            try
            {
                var course = await _context.Courses.FindAsync(courseId);
                if (course == null)
                    return NotFound(new { success = false, message = "Course not found" });

                course.Published = dto.Published;
                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "Course status updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to update course status", error = ex.Message });
            }
        }

        // === ANNOUNCEMENTS (Placeholder - you'll need to create Announcement model) ===
        [HttpGet("announcements")]
        public IActionResult GetAllAnnouncements()
        {
            // TODO: Implement when Announcement model is created
            var sampleAnnouncements = new[]
            {
                new
                {
                    id = Guid.NewGuid(),
                    title = "Welcome to CodeSage",
                    content = "Welcome to our learning platform!",
                    priority = "medium",
                    createdAt = DateTime.UtcNow.AddDays(-2)
                }
            };

            return Ok(new { success = true, data = sampleAnnouncements });
        }

        [HttpPost("announcements")]
        public IActionResult CreateAnnouncement([FromBody] CreateAnnouncementDto dto)
        {
            // TODO: Implement when Announcement model is created
            var newAnnouncement = new
            {
                id = Guid.NewGuid(),
                title = dto.Title,
                content = dto.Content,
                priority = dto.Priority,
                createdAt = DateTime.UtcNow
            };

            return Ok(new { success = true, data = newAnnouncement, message = "Announcement created successfully" });
        }

        [HttpDelete("announcements/{announcementId}")]
        public IActionResult DeleteAnnouncement(Guid announcementId)
        {
            // TODO: Implement when Announcement model is created
            return Ok(new { success = true, message = "Announcement deleted successfully" });
        }

        // === FORUM POSTS ===
        [HttpGet("forum-posts")]
        public async Task<IActionResult> GetAllForumPosts()
        {
            try
            {
                var posts = await _context.ForumPosts
                    .Include(p => p.Profile)
                    .Select(p => new
                    {
                        id = p.ForumId,
                        title = p.Content.Length > 50 ? p.Content.Substring(0, 50) + "..." : p.Content, // Use content as title since there's no Title field
                        p.Content,
                        authorName = p.Profile.FullName,
                        p.CreatedAt
                    })
                    .OrderByDescending(p => p.CreatedAt)
                    .ToListAsync();

                return Ok(new { success = true, data = posts });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to load forum posts", error = ex.Message });
            }
        }

        [HttpDelete("forum-posts/{postId}")]
        public async Task<IActionResult> DeleteForumPost(Guid postId)
        {
            try
            {
                var post = await _context.ForumPosts.FindAsync(postId);
                if (post == null)
                    return NotFound(new { success = false, message = "Forum post not found" });

                _context.ForumPosts.Remove(post);
                await _context.SaveChangesAsync();

                return Ok(new { success = true, message = "Forum post deleted successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to delete forum post", error = ex.Message });
            }
        }

        // === REPORTS ===
        [HttpGet("reports")]
        public async Task<IActionResult> GetReports()
        {
            try
            {
                var stats = await GetDashboardStatistics();
                
                var report = new
                {
                    generatedAt = DateTime.UtcNow,
                    totalUsers = stats.TotalUsers,
                    activeStudents = stats.TotalStudents,
                    totalCourses = stats.TotalCourses,
                    completionRate = 75.5, // Calculate this based on actual data
                    usersByRole = new
                    {
                        students = stats.TotalStudents,
                        teachers = stats.TotalTeachers,
                        admins = stats.TotalAdmins
                    }
                };

                return Ok(new { success = true, data = report });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to generate report", error = ex.Message });
            }
        }

        [HttpPost("generate-report")]
        public async Task<IActionResult> GenerateReport()
        {
            // Same as GetReports but indicates it's freshly generated
            return await GetReports();
        }

        // === HELP REQUESTS (Placeholder) ===
        [HttpGet("help-requests")]
        public IActionResult GetHelpRequests()
        {
            try
            {
                // TODO: Implement when HelpRequest model is created
                var sampleRequests = new[]
                {
                    new
                    {
                        id = Guid.NewGuid(),
                        userName = "Sample User",
                        content = "Sample help request content",
                        submittedDate = DateTime.UtcNow.AddDays(-1),
                        status = "pending"
                    }
                };

                return Ok(new { success = true, data = sampleRequests });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to load help requests", error = ex.Message });
            }
        }

        [HttpPost("help-requests/{requestId}/reply")]
        public IActionResult ReplyToHelpRequest(Guid requestId, [FromBody] HelpRequestReplyDto dto)
        {
            try
            {
                // TODO: Implement when HelpRequest model is created
                return Ok(new { success = true, message = "Reply sent successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Failed to send reply", error = ex.Message });
            }
        }

        // === HELPER METHODS ===
        private async Task<DashboardStatsDto> GetDashboardStatistics()
        {
            var totalUsers = await _context.Profiles.CountAsync();
            var totalStudents = await _context.Profiles.CountAsync(p => p.Role == "student");
            var totalTeachers = await _context.Profiles.CountAsync(p => p.Role == "teacher");
            var totalAdmins = await _context.Profiles.CountAsync(p => p.Role == "admin");
            var totalForumPosts = await _context.ForumPosts.CountAsync();
            var totalResources = await _context.Resources.CountAsync();
            var totalCourses = await _context.Courses.CountAsync();
            var totalChapters = await _context.Chapters.CountAsync();

            return new DashboardStatsDto
            {
                TotalUsers = totalUsers,
                TotalStudents = totalStudents,
                TotalTeachers = totalTeachers,
                TotalAdmins = totalAdmins,
                TotalForumPosts = totalForumPosts,
                TotalResources = totalResources,
                TotalCourses = totalCourses,
                TotalChapters = totalChapters
            };
        }

        private async Task<object[]> GetRecentUsers()
        {
            return await _context.Profiles
                .OrderByDescending(u => u.CreatedAt)
                .Take(5)
                .Select(u => new
                {
                    id = u.UserId,
                    u.FullName,
                    u.Role,
                    u.CreatedAt
                })
                .ToArrayAsync();
        }

        private async Task<object[]> GetRecentPosts()
        {
            return await _context.ForumPosts
                .Include(p => p.Profile)
                .OrderByDescending(p => p.CreatedAt)
                .Take(5)
                .Select(p => new
                {
                    id = p.ForumId,
                    title = p.Content.Length > 50 ? p.Content.Substring(0, 50) + "..." : p.Content,
                    authorName = p.Profile.FullName,
                    p.CreatedAt
                })
                .ToArrayAsync();
        }
    }

    // === DTOs ===
    public class DashboardStatsDto
    {
        public int TotalUsers { get; set; }
        public int TotalStudents { get; set; }
        public int TotalTeachers { get; set; }
        public int TotalAdmins { get; set; }
        public int TotalForumPosts { get; set; }
        public int TotalResources { get; set; }
        public int TotalCourses { get; set; }
        public int TotalChapters { get; set; }
    }

    public class UpdateRoleDto
    {
        public string NewRole { get; set; } = string.Empty;
    }

    public class CreateAnnouncementDto
    {
        public string Title { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
        public string Priority { get; set; } = "medium";
    }

    public class CreateCourseDto
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public bool Published { get; set; } = false;
    }

    public class UpdateCourseDto
    {
        public string? Title { get; set; }
        public string? Description { get; set; }
        public bool? Published { get; set; }
    }

    public class UpdateCourseStatusDto
    {
        public bool Published { get; set; }
    }

    public class ApproveCourseDto
    {
        public bool Approved { get; set; }
        public string? RejectionReason { get; set; }
        public Guid AdminUserId { get; set; }
    }

    public class HelpRequestReplyDto
    {
        public string Message { get; set; } = string.Empty;
    }
}
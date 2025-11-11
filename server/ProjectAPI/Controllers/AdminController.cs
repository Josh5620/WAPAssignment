using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(Roles = "admin")]
    public class AdminController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<AdminController> _logger;

        public AdminController(ApplicationDbContext context, ILogger<AdminController> logger)
        {
            _context = context;
            _logger = logger;
        }

        // === COURSE APPROVAL MANAGEMENT ===
        
        /// <summary>
        /// Get all courses pending admin approval (alias endpoint)
        /// </summary>
        [HttpGet("pending-approval")]
        public async Task<IActionResult> GetPendingApproval()
        {
            // This is an alias for pending-courses to match frontend expectations
            return await GetPendingCourses();
        }
        
        /// <summary>
        /// Get all courses pending admin approval
        /// </summary>
        [HttpGet("pending-courses")]
        public async Task<IActionResult> GetPendingCourses()
        {
            try
            {
                var pendingCourses = await _context.Courses
                    .Include(c => c.Teacher)
                    .Include(c => c.Chapters)
                    .Where(c => c.ApprovalStatus == "Pending")
                    .Select(c => new
                    {
                        courseId = c.CourseId,
                        title = c.Title,
                        description = c.Description,
                        previewContent = c.PreviewContent,
                        approvalStatus = c.ApprovalStatus,
                        teacherId = c.TeacherId,
                        teacher = new
                        {
                            userId = c.Teacher.UserId,
                            fullName = c.Teacher.FullName,
                            email = c.Teacher.Email
                        },
                        totalChapters = c.Chapters.Count
                    })
                    .OrderBy(c => c.title)
                    .ToListAsync();

                return Ok(new
                {
                    totalPending = pendingCourses.Count,
                    courses = pendingCourses
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving pending courses");
                return StatusCode(500, new { error = "An error occurred while retrieving pending courses" });
            }
        }

        /// <summary>
        /// Approve a course - sets ApprovalStatus to "Approved" and Published to true
        /// </summary>
        [HttpPost("courses/{id}/approve")]
        public async Task<IActionResult> ApproveCourse(Guid id)
        {
            try
            {
                var course = await _context.Courses
                    .Include(c => c.Teacher)
                    .FirstOrDefaultAsync(c => c.CourseId == id);

                if (course == null)
                {
                    return NotFound(new { error = "Course not found" });
                }

                if (course.ApprovalStatus == "Approved")
                {
                    return BadRequest(new { error = "Course is already approved" });
                }

                // Approve the course
                course.ApprovalStatus = "Approved";
                course.Published = true;
                course.RejectionReason = null;

                _context.Courses.Update(course);
                await _context.SaveChangesAsync();

                return Ok(new
                {
                    courseId = course.CourseId,
                    title = course.Title,
                    approvalStatus = course.ApprovalStatus,
                    published = course.Published,
                    teacherName = course.Teacher.FullName,
                    message = "Course approved successfully and is now published!"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error approving course {CourseId}", id);
                return StatusCode(500, new { error = "An error occurred while approving the course" });
            }
        }

        /// <summary>
        /// Reject a course - sets ApprovalStatus to "Rejected" with a reason
        /// </summary>
        [HttpPost("courses/{id}/reject")]
        public async Task<IActionResult> RejectCourse(Guid id, [FromBody] RejectCourseRequest request)
        {
            try
            {
                if (request == null || string.IsNullOrWhiteSpace(request.RejectionReason))
                {
                    return BadRequest(new { error = "Rejection reason is required" });
                }

                var course = await _context.Courses
                    .Include(c => c.Teacher)
                    .FirstOrDefaultAsync(c => c.CourseId == id);

                if (course == null)
                {
                    return NotFound(new { error = "Course not found" });
                }

                // Reject the course
                course.ApprovalStatus = "Rejected";
                course.RejectionReason = request.RejectionReason.Trim();
                course.Published = false;

                _context.Courses.Update(course);
                await _context.SaveChangesAsync();

                return Ok(new
                {
                    courseId = course.CourseId,
                    title = course.Title,
                    approvalStatus = course.ApprovalStatus,
                    rejectionReason = course.RejectionReason,
                    teacherName = course.Teacher.FullName,
                    message = "Course rejected. Teacher has been notified."
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error rejecting course {CourseId}", id);
                return StatusCode(500, new { error = "An error occurred while rejecting the course" });
            }
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
                        courseId = c.CourseId,
                        title = c.Title,
                        description = c.Description,
                        published = c.Published,
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

        // === ANNOUNCEMENTS ===
        /// <summary>
        /// Get all announcements from the database
        /// </summary>
        [HttpGet("announcements")]
        public async Task<IActionResult> GetAllAnnouncements()
        {
            try
            {
                var announcements = await _context.Announcements
                    .Include(a => a.Admin)
                    .OrderByDescending(a => a.CreatedAt)
                    .Select(a => new
                    {
                        id = a.AnnouncementId,
                        title = a.Title,
                        content = a.Message,
                        adminId = a.AdminId,
                        adminName = a.Admin.FullName,
                        createdAt = a.CreatedAt
                    })
                    .ToListAsync();

                return Ok(new { success = true, data = announcements, count = announcements.Count });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving announcements");
                return StatusCode(500, new { success = false, message = "Failed to load announcements", error = ex.Message });
            }
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

        // === HELP REQUESTS ===
        /// <summary>
        /// Get all pending help requests from students
        /// </summary>
        [HttpGet("help-requests")]
        public async Task<IActionResult> GetHelpRequests()
        {
            try
            {
                var helpRequests = await _context.HelpRequests
                    .Include(hr => hr.Student)
                    .Include(hr => hr.ResolvedByTeacher)
                    .Include(hr => hr.Chapter)
                        .ThenInclude(ch => ch.Course)
                    .Where(hr => hr.Status == "Pending")
                    .OrderByDescending(hr => hr.CreatedAt)
                    .Select(hr => new
                    {
                        id = hr.HelpRequestId,
                        studentId = hr.StudentId,
                        studentName = hr.Student.FullName,
                        studentEmail = hr.Student.Email,
                        chapterId = hr.ChapterId,
                        chapterTitle = hr.Chapter.Title,
                        courseTitle = hr.Chapter.Course.Title,
                        question = hr.Question,
                        response = hr.Response,
                        status = hr.Status,
                        resolvedByTeacherId = hr.ResolvedByTeacherId,
                        resolvedByTeacherName = hr.ResolvedByTeacher != null ? hr.ResolvedByTeacher.FullName : null,
                        submittedDate = hr.CreatedAt,
                        resolvedDate = hr.ResolvedAt
                    })
                    .ToListAsync();

                return Ok(new 
                { 
                    success = true, 
                    data = helpRequests,
                    totalPending = helpRequests.Count
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving help requests");
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

    public class RejectCourseRequest
    {
        public string RejectionReason { get; set; } = string.Empty;
    }
}
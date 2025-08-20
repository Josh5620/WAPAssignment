using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.DTOs;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize] // Require authentication for all admin endpoints
    public class AdminController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AdminController(AppDbContext context)
        {
            _context = context;
        }

        // [HttpGet("dashboard")]
        // public async Task<ActionResult<ApiResponse<AdminDashboardDto>>> GetDashboardData()
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         // Get dashboard statistics
        //         var totalUsers = await _context.Users.CountAsync();
        //         var totalStudents = await _context.Users.CountAsync(u => u.Role == "student");
        //         var totalTeachers = await _context.Users.CountAsync(u => u.Role == "teacher");
        //         var totalAdmins = await _context.Users.CountAsync(u => u.Role == "admin");
        //         var totalForumPosts = await _context.ForumPosts.CountAsync();
        //         var totalResources = await _context.Resources.CountAsync();

        //         // Get recent users (last 10)
        //         var recentUsers = await _context.Users
        //             .OrderByDescending(u => u.CreatedAt)
        //             .Take(10)
        //             .Select(u => new UserDto
        //             {
        //                 Id = u.Id,
        //                 Email = u.Email,
        //                 FullName = u.FullName,
        //                 Role = u.Role,
        //                 CreatedAt = u.CreatedAt,
        //                 IsAdmin = u.IsAdmin,
        //                 IsTeacher = u.IsTeacher,
        //                 IsStudent = u.IsStudent
        //             })
        //             .ToListAsync();

        //         // Get recent forum posts (last 10)
        //         var recentPosts = await _context.ForumPosts
        //             .Include(p => p.Author)
        //             .OrderByDescending(p => p.CreatedAt)
        //             .Take(10)
        //             .Select(p => new ForumPostDto
        //             {
        //                 Id = p.Id,
        //                 Title = p.Title,
        //                 Content = p.Content.Length > 100 ? p.Content.Substring(0, 100) + "..." : p.Content,
        //                 AuthorId = p.AuthorId,
        //                 AuthorName = p.Author.FullName,
        //                 CreatedAt = p.CreatedAt
        //             })
        //             .ToListAsync();

        //         var dashboardData = new AdminDashboardDto
        //         {
        //             Statistics = new DashboardStatisticsDto
        //             {
        //                 TotalUsers = totalUsers,
        //                 TotalStudents = totalStudents,
        //                 TotalTeachers = totalTeachers,
        //                 TotalAdmins = totalAdmins,
        //                 TotalForumPosts = totalForumPosts,
        //                 TotalResources = totalResources
        //             },
        //             RecentUsers = recentUsers,
        //             RecentPosts = recentPosts
        //         };

        //         return Ok(new ApiResponse<AdminDashboardDto>
        //         {
        //             Success = true,
        //             Message = "Dashboard data retrieved successfully",
        //             Data = dashboardData
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<AdminDashboardDto>
        //         {
        //             Success = false,
        //             Message = "An error occurred while retrieving dashboard data",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }

        // [HttpGet("users")]
        // public async Task<ActionResult<ApiResponse<List<UserDto>>>> GetAllUsers()
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         var users = await _context.Users
        //             .OrderByDescending(u => u.CreatedAt)
        //             .Select(u => new UserDto
        //             {
        //                 Id = u.Id,
        //                 Email = u.Email,
        //                 FullName = u.FullName,
        //                 Role = u.Role,
        //                 CreatedAt = u.CreatedAt,
        //                 IsAdmin = u.IsAdmin,
        //                 IsTeacher = u.IsTeacher,
        //                 IsStudent = u.IsStudent
        //             })
        //             .ToListAsync();

        //         return Ok(new ApiResponse<List<UserDto>>
        //         {
        //             Success = true,
        //             Message = "Users retrieved successfully",
        //             Data = users
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<List<UserDto>>
        //         {
        //             Success = false,
        //             Message = "An error occurred while retrieving users",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }

        // [HttpPut("users/{id}/role")]
        // public async Task<ActionResult<ApiResponse<UserDto>>> UpdateUserRole(Guid id, [FromBody] UpdateUserRoleRequest request)
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         var user = await _context.Users.FindAsync(id);
        //         if (user == null)
        //         {
        //             return NotFound(new ApiResponse<UserDto>
        //             {
        //                 Success = false,
        //                 Message = "User not found"
        //             });
        //         }

        //         // Validate role
        //         var validRoles = new[] { "student", "teacher", "admin" };
        //         if (!validRoles.Contains(request.Role.ToLower()))
        //         {
        //             return BadRequest(new ApiResponse<UserDto>
        //             {
        //                 Success = false,
        //                 Message = "Invalid role. Must be student, teacher, or admin"
        //             });
        //         }

        //         user.Role = request.Role.ToLower();
        //         await _context.SaveChangesAsync();

        //         var updatedUser = new UserDto
        //         {
        //             Id = user.Id,
        //             Email = user.Email,
        //             FullName = user.FullName,
        //             Role = user.Role,
        //             CreatedAt = user.CreatedAt,
        //             IsAdmin = user.IsAdmin,
        //             IsTeacher = user.IsTeacher,
        //             IsStudent = user.IsStudent
        //         };

        //         return Ok(new ApiResponse<UserDto>
        //         {
        //             Success = true,
        //             Message = "User role updated successfully",
        //             Data = updatedUser
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<UserDto>
        //         {
        //             Success = false,
        //             Message = "An error occurred while updating user role",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }

        // [HttpDelete("users/{id}")]
        // public async Task<ActionResult<ApiResponse<object>>> DeleteUser(Guid id)
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         var user = await _context.Users.FindAsync(id);
        //         if (user == null)
        //         {
        //             return NotFound(new ApiResponse<object>
        //             {
        //                 Success = false,
        //                 Message = "User not found"
        //             });
        //         }

        //         // Prevent admin from deleting themselves
        //         var currentUserId = User.FindFirst("sub")?.Value;
        //         if (currentUserId == id.ToString())
        //         {
        //             return BadRequest(new ApiResponse<object>
        //             {
        //                 Success = false,
        //                 Message = "You cannot delete your own account"
        //             });
        //         }

        //         _context.Users.Remove(user);
        //         await _context.SaveChangesAsync();

        //         return Ok(new ApiResponse<object>
        //         {
        //             Success = true,
        //             Message = "User deleted successfully"
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<object>
        //         {
        //             Success = false,
        //             Message = "An error occurred while deleting user",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }

        // [HttpGet("forum-posts")]
        // public async Task<ActionResult<ApiResponse<List<ForumPostDto>>>> GetAllForumPosts()
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         var posts = await _context.ForumPosts
        //             .Include(p => p.Author)
        //             .OrderByDescending(p => p.CreatedAt)
        //             .Select(p => new ForumPostDto
        //             {
        //                 Id = p.Id,
        //                 Title = p.Title,
        //                 Content = p.Content,
        //                 AuthorId = p.AuthorId,
        //                 AuthorName = p.Author.FullName,
        //                 CreatedAt = p.CreatedAt
        //             })
        //             .ToListAsync();

        //         return Ok(new ApiResponse<List<ForumPostDto>>
        //         {
        //             Success = true,
        //             Message = "Forum posts retrieved successfully",
        //             Data = posts
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<List<ForumPostDto>>
        //         {
        //             Success = false,
        //             Message = "An error occurred while retrieving forum posts",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }

        // [HttpDelete("forum-posts/{id}")]
        // public async Task<ActionResult<ApiResponse<object>>> DeleteForumPost(int id)
        // {
        //     try
        //     {
        //         // Check if user is admin
        //         var userRole = User.FindFirst("role")?.Value;
        //         if (userRole != "admin")
        //         {
        //             return Forbid();
        //         }

        //         var post = await _context.ForumPosts.FindAsync(id);
        //         if (post == null)
        //         {
        //             return NotFound(new ApiResponse<object>
        //             {
        //                 Success = false,
        //                 Message = "Forum post not found"
        //             });
        //         }

        //         _context.ForumPosts.Remove(post);
        //         await _context.SaveChangesAsync();

        //         return Ok(new ApiResponse<object>
        //         {
        //             Success = true,
        //             Message = "Forum post deleted successfully"
        //         });
        //     }
        //     catch (Exception ex)
        //     {
        //         return StatusCode(500, new ApiResponse<object>
        //         {
        //             Success = false,
        //             Message = "An error occurred while deleting forum post",
        //             Errors = new[] { ex.Message }
        //         });
        //     }
        // }
    }
}

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.DTOs;
using ProjectAPI.Models;
using System.Security.Claims;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ForumController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ForumController(AppDbContext context)
        {
            _context = context;
        }

        private Guid GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst("user_id")?.Value;
            if (Guid.TryParse(userIdClaim, out var userId))
                return userId;
            throw new UnauthorizedAccessException("Invalid user token");
        }

        [HttpGet]
        public async Task<ActionResult<ApiResponse<List<ForumPostDto>>>> GetAllPosts()
        {
            try
            {
                var posts = await _context.ForumPosts
                    .Include(fp => fp.Author)
                    .OrderByDescending(fp => fp.CreatedAt)
                    .Select(fp => new ForumPostDto
                    {
                        Id = fp.Id,
                        Title = fp.Title,
                        Content = fp.Content,
                        CreatedAt = fp.CreatedAt,
                        Author = new UserDto
                        {
                            Id = fp.Author.Id,
                            Email = fp.Author.Email,
                            FullName = fp.Author.FullName,
                            Role = fp.Author.Role,
                            CreatedAt = fp.Author.CreatedAt,
                            IsAdmin = fp.Author.Role.ToLower() == "admin",
                            IsTeacher = fp.Author.Role.ToLower() == "teacher",
                            IsStudent = fp.Author.Role.ToLower() == "student"
                        }
                    })
                    .ToListAsync();

                return Ok(new ApiResponse<List<ForumPostDto>>
                {
                    Success = true,
                    Message = "Posts retrieved successfully",
                    Data = posts
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<List<ForumPostDto>>
                {
                    Success = false,
                    Message = "An error occurred while retrieving posts",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ApiResponse<ForumPostDto>>> GetPost(long id)
        {
            try
            {
                var post = await _context.ForumPosts
                    .Include(fp => fp.Author)
                    .Where(fp => fp.Id == id)
                    .Select(fp => new ForumPostDto
                    {
                        Id = fp.Id,
                        Title = fp.Title,
                        Content = fp.Content,
                        CreatedAt = fp.CreatedAt,
                        Author = new UserDto
                        {
                            Id = fp.Author.Id,
                            Email = fp.Author.Email,
                            FullName = fp.Author.FullName,
                            Role = fp.Author.Role,
                            CreatedAt = fp.Author.CreatedAt,
                            IsAdmin = fp.Author.Role.ToLower() == "admin",
                            IsTeacher = fp.Author.Role.ToLower() == "teacher",
                            IsStudent = fp.Author.Role.ToLower() == "student"
                        }
                    })
                    .FirstOrDefaultAsync();

                if (post == null)
                {
                    return NotFound(new ApiResponse<ForumPostDto>
                    {
                        Success = false,
                        Message = "Post not found"
                    });
                }

                return Ok(new ApiResponse<ForumPostDto>
                {
                    Success = true,
                    Message = "Post retrieved successfully",
                    Data = post
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<ForumPostDto>
                {
                    Success = false,
                    Message = "An error occurred while retrieving the post",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpPost]
        [Authorize]
        public async Task<ActionResult<ApiResponse<ForumPostDto>>> CreatePost(CreateForumPostRequest request)
        {
            try
            {
                var userId = GetCurrentUserId();

                var post = new ForumPost
                {
                    Title = request.Title,
                    Content = request.Content,
                    AuthorId = userId,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ForumPosts.Add(post);
                await _context.SaveChangesAsync();

                // Reload with author information
                var createdPost = await _context.ForumPosts
                    .Include(fp => fp.Author)
                    .Where(fp => fp.Id == post.Id)
                    .Select(fp => new ForumPostDto
                    {
                        Id = fp.Id,
                        Title = fp.Title,
                        Content = fp.Content,
                        CreatedAt = fp.CreatedAt,
                        Author = new UserDto
                        {
                            Id = fp.Author.Id,
                            Email = fp.Author.Email,
                            FullName = fp.Author.FullName,
                            Role = fp.Author.Role,
                            CreatedAt = fp.Author.CreatedAt,
                            IsAdmin = fp.Author.Role.ToLower() == "admin",
                            IsTeacher = fp.Author.Role.ToLower() == "teacher",
                            IsStudent = fp.Author.Role.ToLower() == "student"
                        }
                    })
                    .FirstOrDefaultAsync();

                return CreatedAtAction(nameof(GetPost), new { id = post.Id }, new ApiResponse<ForumPostDto>
                {
                    Success = true,
                    Message = "Post created successfully",
                    Data = createdPost
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<ForumPostDto>
                {
                    Success = false,
                    Message = "An error occurred while creating the post",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpPut("{id}")]
        [Authorize]
        public async Task<ActionResult<ApiResponse<ForumPostDto>>> UpdatePost(long id, UpdateForumPostRequest request)
        {
            try
            {
                var userId = GetCurrentUserId();
                var userRole = User.FindFirst("role")?.Value;

                var post = await _context.ForumPosts
                    .Include(fp => fp.Author)
                    .FirstOrDefaultAsync(fp => fp.Id == id);

                if (post == null)
                {
                    return NotFound(new ApiResponse<ForumPostDto>
                    {
                        Success = false,
                        Message = "Post not found"
                    });
                }

                // Check authorization - only author or admin can update
                if (post.AuthorId != userId && userRole?.ToLower() != "admin")
                {
                    return Forbid();
                }

                post.Title = request.Title;
                post.Content = request.Content;

                await _context.SaveChangesAsync();

                var updatedPost = new ForumPostDto
                {
                    Id = post.Id,
                    Title = post.Title,
                    Content = post.Content,
                    CreatedAt = post.CreatedAt,
                    Author = new UserDto
                    {
                        Id = post.Author.Id,
                        Email = post.Author.Email,
                        FullName = post.Author.FullName,
                        Role = post.Author.Role,
                        CreatedAt = post.Author.CreatedAt,
                        IsAdmin = post.Author.Role.ToLower() == "admin",
                        IsTeacher = post.Author.Role.ToLower() == "teacher",
                        IsStudent = post.Author.Role.ToLower() == "student"
                    }
                };

                return Ok(new ApiResponse<ForumPostDto>
                {
                    Success = true,
                    Message = "Post updated successfully",
                    Data = updatedPost
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<ForumPostDto>
                {
                    Success = false,
                    Message = "An error occurred while updating the post",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpDelete("{id}")]
        [Authorize]
        public async Task<ActionResult<ApiResponse<object>>> DeletePost(long id)
        {
            try
            {
                var userId = GetCurrentUserId();
                var userRole = User.FindFirst("role")?.Value;

                var post = await _context.ForumPosts.FirstOrDefaultAsync(fp => fp.Id == id);

                if (post == null)
                {
                    return NotFound(new ApiResponse<object>
                    {
                        Success = false,
                        Message = "Post not found"
                    });
                }

                // Check authorization - only author or admin can delete
                if (post.AuthorId != userId && userRole?.ToLower() != "admin")
                {
                    return Forbid();
                }

                _context.ForumPosts.Remove(post);
                await _context.SaveChangesAsync();

                return Ok(new ApiResponse<object>
                {
                    Success = true,
                    Message = "Post deleted successfully"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<object>
                {
                    Success = false,
                    Message = "An error occurred while deleting the post",
                    Errors = new[] { ex.Message }
                });
            }
        }
    }
}

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BCrypt.Net;
using ProjectAPI.Data;
using ProjectAPI.DTOs;
using ProjectAPI.Models;
using ProjectAPI.Services;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IJwtService _jwtService;

        public AuthController(AppDbContext context, IJwtService jwtService)
        {
            _context = context;
            _jwtService = jwtService;
        }

        [HttpPost("register")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> Register(RegisterRequest request)
        {
            try
            {
                // Check if user already exists
                var existingUser = await _context.Users
                    .FirstOrDefaultAsync(u => u.Email == request.Email);

                if (existingUser != null)
                {
                    return BadRequest(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "User with this email already exists"
                    });
                }

                // Validate role
                var validRoles = new[] { "student", "teacher", "admin" };
                if (!validRoles.Contains(request.Role.ToLower()))
                {
                    return BadRequest(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Invalid role. Must be student, teacher, or admin"
                    });
                }

                // Hash password
                var hashedPassword = BCrypt.Net.BCrypt.HashPassword(request.Password);

                // Create new user
                var user = new User
                {
                    Id = Guid.NewGuid(),
                    Email = request.Email,
                    PasswordHash = hashedPassword,
                    FullName = request.FullName,
                    Role = request.Role.ToLower(),
                    CreatedAt = DateTime.UtcNow
                };

                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                // Generate JWT token
                var token = _jwtService.GenerateToken(user);

                var response = new AuthResponse
                {
                    Token = token,
                    User = new UserDto
                    {
                        Id = user.Id,
                        Email = user.Email,
                        FullName = user.FullName,
                        Role = user.Role,
                        CreatedAt = user.CreatedAt,
                        IsAdmin = user.IsAdmin,
                        IsTeacher = user.IsTeacher,
                        IsStudent = user.IsStudent
                    }
                };

                return Ok(new ApiResponse<AuthResponse>
                {
                    Success = true,
                    Message = "Registration successful",
                    Data = response
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<AuthResponse>
                {
                    Success = false,
                    Message = "An error occurred during registration",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpPost("login")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> Login(LoginRequest request)
        {
            try
            {
                // Find user by email (login_id in database)
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => u.Email == request.Email);

                if (user == null)
                {
                    return Unauthorized(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Invalid email or password"
                    });
                }

                // Check password - handle both plain text (legacy) and hashed passwords
                bool isPasswordValid = false;
                if (user.PasswordHash.StartsWith("$2"))
                {
                    // Password is already hashed with BCrypt
                    isPasswordValid = BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash);
                }
                else
                {
                    // Password is stored as plain text (legacy data)
                    isPasswordValid = user.PasswordHash == request.Password;
                }

                if (!isPasswordValid)
                {
                    return Unauthorized(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Invalid email or password"
                    });
                }

                // Generate JWT token
                var token = _jwtService.GenerateToken(user);

                var response = new AuthResponse
                {
                    Token = token,
                    User = new UserDto
                    {
                        Id = user.Id,
                        Email = user.Email,
                        FullName = user.FullName,
                        Role = user.Role,
                        CreatedAt = user.CreatedAt,
                        IsAdmin = user.IsAdmin,
                        IsTeacher = user.IsTeacher,
                        IsStudent = user.IsStudent
                    }
                };

                return Ok(new ApiResponse<AuthResponse>
                {
                    Success = true,
                    Message = "Login successful",
                    Data = response
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<AuthResponse>
                {
                    Success = false,
                    Message = "An error occurred during login",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpPost("admin-login")]
        public async Task<ActionResult<ApiResponse<AuthResponse>>> AdminLogin(AdminLoginRequest request)
        {
            try
            {
                // Find admin user by email (login_id in database)
                // The Username in AdminLoginRequest maps to the email field in the database
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => u.Email == request.Username);

                if (user == null)
                {
                    return Unauthorized(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Invalid username or password"
                    });
                }

                // Check password - handle both plain text (legacy) and hashed passwords
                bool isPasswordValid = false;
                if (user.PasswordHash.StartsWith("$2"))
                {
                    // Password is already hashed with BCrypt
                    isPasswordValid = BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash);
                }
                else
                {
                    // Password is stored as plain text (legacy data)
                    isPasswordValid = user.PasswordHash == request.Password;
                }

                if (!isPasswordValid)
                {
                    return Unauthorized(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Invalid username or password"
                    });
                }

                // Check if user is admin
                if (user.Role != "admin")
                {
                    return Unauthorized(new ApiResponse<AuthResponse>
                    {
                        Success = false,
                        Message = "Access denied. Admin privileges required."
                    });
                }

                // Generate JWT token
                var token = _jwtService.GenerateToken(user);

                var response = new AuthResponse
                {
                    Token = token,
                    User = new UserDto
                    {
                        Id = user.Id,
                        Email = user.Email,
                        FullName = user.FullName,
                        Role = user.Role,
                        CreatedAt = user.CreatedAt,
                        IsAdmin = user.IsAdmin,
                        IsTeacher = user.IsTeacher,
                        IsStudent = user.IsStudent
                    }
                };

                return Ok(new ApiResponse<AuthResponse>
                {
                    Success = true,
                    Message = "Admin login successful",
                    Data = response
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ApiResponse<AuthResponse>
                {
                    Success = false,
                    Message = "An error occurred during admin login",
                    Errors = new[] { ex.Message }
                });
            }
        }

        [HttpGet("test-db")]
        public async Task<IActionResult> TestDatabase()
        {
            try
            {
                await _context.Database.CanConnectAsync();
                var userCount = await _context.Users.CountAsync();
                return Ok(new { message = "Database connection successful", userCount });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Database connection failed", error = ex.Message });
            }
        }
    }
}

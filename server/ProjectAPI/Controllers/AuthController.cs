using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace ProjectAPI.Controllers;

/// <summary>
/// Controller for authentication operations including user registration and login
/// </summary>
[ApiController]
[Route("api/[controller]")]
[AllowAnonymous]
public class AuthController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<AuthController> _logger;
    private readonly IConfiguration _configuration;

    public AuthController(
        ApplicationDbContext context, 
        ILogger<AuthController> logger,
        IConfiguration configuration)
    {
        _context = context;
        _logger = logger;
        _configuration = configuration;
    }

    /// <summary>
    /// Register a new user account
    /// </summary>
    /// <param name="request">Registration details</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>Success message with user details</returns>
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request, CancellationToken ct = default)
    {
        try
        {
            // Validate request
            if (request == null || string.IsNullOrWhiteSpace(request.Email) || 
                string.IsNullOrWhiteSpace(request.Password) || string.IsNullOrWhiteSpace(request.FullName))
            {
                return BadRequest(new { error = "Email, Password, and FullName are required" });
            }

            // Normalize email
            var email = request.Email.Trim().ToLower();

            // Check if user with this email already exists
            var existingUser = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email.ToLower() == email, ct);

            if (existingUser != null)
            {
                return BadRequest(new { error = "A user with this email already exists" });
            }

            // Validate email format
            if (!IsValidEmail(email))
            {
                return BadRequest(new { error = "Invalid email format" });
            }

            // Validate password strength
            if (request.Password.Length < 6)
            {
                return BadRequest(new { error = "Password must be at least 6 characters long" });
            }

            // Hash the password using BCrypt
            var passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);

            // Create new Profile
            var newProfile = new Profile
            {
                UserId = Guid.NewGuid(),
                Email = email,
                FullName = request.FullName.Trim(),
                PasswordHash = passwordHash,
                Role = "student", // Default role
                CreatedAt = DateTime.UtcNow
            };

            // Save to database
            await _context.Profiles.AddAsync(newProfile, ct);
            await _context.SaveChangesAsync(ct);

            _logger.LogInformation("New user registered: {Email}", email);

            return Ok(new
            {
                message = "Registration successful!",
                userId = newProfile.UserId,
                email = newProfile.Email,
                fullName = newProfile.FullName,
                role = newProfile.Role
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during user registration for email: {Email}", request?.Email);
            return StatusCode(500, new { error = "An error occurred during registration" });
        }
    }

    /// <summary>
    /// Login with email and password
    /// </summary>
    /// <param name="request">Login credentials</param>
    /// <param name="ct">Cancellation token</param>
    /// <returns>JWT token and user details</returns>
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] AuthLoginRequest request, CancellationToken ct = default)
    {
        try
        {
            // Validate request
            if (request == null || string.IsNullOrWhiteSpace(request.Email) || 
                string.IsNullOrWhiteSpace(request.Password))
            {
                return BadRequest(new { error = "Email and Password are required" });
            }

            // Normalize email
            var email = request.Email.Trim().ToLower();

            // Find user by email
            var user = await _context.Profiles
                .FirstOrDefaultAsync(p => p.Email.ToLower() == email, ct);

            if (user == null)
            {
                _logger.LogWarning("Login attempt failed: User not found for email {Email}", email);
                return Unauthorized(new { error = "Invalid email or password" });
            }

            // Verify password using BCrypt
            bool isPasswordValid = BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash);

            if (!isPasswordValid)
            {
                _logger.LogWarning("Login attempt failed: Invalid password for email {Email}", email);
                return Unauthorized(new { error = "Invalid email or password" });
            }

            // Generate JWT token
            var token = GenerateJwtToken(user);

            _logger.LogInformation("User logged in successfully: {Email}", email);

            return Ok(new
            {
                message = "Login successful",
                access_token = token,
                token_type = "Bearer",
                user = new
                {
                    userId = user.UserId,
                    email = user.Email,
                    fullName = user.FullName,
                    role = user.Role
                }
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during login for email: {Email}", request?.Email);
            return StatusCode(500, new { error = "An error occurred during login" });
        }
    }

    /// <summary>
    /// Get current user profile from JWT token
    /// </summary>
    /// <returns>User profile details</returns>
    [HttpGet("profile")]
    public async Task<IActionResult> GetProfile(CancellationToken ct = default)
    {
        try
        {
            // Get user ID from JWT token (requires authorization header)
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            
            if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
            {
                return Unauthorized(new { error = "Invalid or missing user identification" });
            }

            // Get user from database
            var user = await _context.Profiles.FindAsync(new object[] { userId }, ct);

            if (user == null)
            {
                return NotFound(new { error = "User not found" });
            }

            return Ok(new
            {
                userId = user.UserId,
                email = user.Email,
                fullName = user.FullName,
                role = user.Role,
                createdAt = user.CreatedAt
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving user profile");
            return StatusCode(500, new { error = "An error occurred while retrieving profile" });
        }
    }

    #region Helper Methods

    /// <summary>
    /// Generate a JWT token for the authenticated user
    /// </summary>
    /// <param name="user">User profile</param>
    /// <returns>JWT token string</returns>
    private string GenerateJwtToken(Profile user)
    {
        // Get JWT settings from configuration (with defaults)
        var jwtKey = _configuration["Jwt:Key"] ?? "YourSuperSecretKeyThatIsAtLeast32CharactersLongForHS256Algorithm";
        var jwtIssuer = _configuration["Jwt:Issuer"] ?? "ProjectAPI";
        var jwtAudience = _configuration["Jwt:Audience"] ?? "ProjectAPIClients";
        var jwtExpiryMinutes = int.TryParse(_configuration["Jwt:ExpiryMinutes"], out var expiry) ? expiry : 1440; // Default 24 hours

        // Create claims
        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),
            new Claim(ClaimTypes.Email, user.Email),
            new Claim(ClaimTypes.Name, user.FullName),
            new Claim(ClaimTypes.Role, user.Role),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(JwtRegisteredClaimNames.Iat, DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString())
        };

        // Create signing key
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        // Create token
        var token = new JwtSecurityToken(
            issuer: jwtIssuer,
            audience: jwtAudience,
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(jwtExpiryMinutes),
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    /// <summary>
    /// Validate email format
    /// </summary>
    /// <param name="email">Email address</param>
    /// <returns>True if valid</returns>
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

/// <summary>
/// Request model for user login via AuthController
/// </summary>
public record AuthLoginRequest
{
    [Required]
    [EmailAddress]
    public string Email { get; init; } = string.Empty;

    [Required]
    public string Password { get; init; } = string.Empty;
}

#endregion

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
                    p.Id,
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
}

public class TestLoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
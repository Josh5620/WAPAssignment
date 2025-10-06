// Legacy Supabase implementation - kept for reference.
using Microsoft.AspNetCore.Mvc;
using ProjectAPI.Services;

namespace ProjectAPI.Legacy.Supabase.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class ProfilesController(IProfilesService profilesService) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetProfiles(CancellationToken ct = default)
    {
        try
        {
            var profiles = await profilesService.GetProfilesAsync(ct);
            return Ok(profiles);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetProfileById(Guid id, CancellationToken ct = default)
    {
        try
        {
            var profile = await profilesService.GetProfileByIdAsync(id, ct);
            return Ok(profile);
        }
        catch (KeyNotFoundException)
        {
            return NotFound(new { error = "Profile not found" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("role/{role}")]
    public async Task<IActionResult> GetProfilesByRole(string role, CancellationToken ct = default)
    {
        try
        {
            var profiles = await profilesService.GetProfilesByRoleAsync(role, ct);
            return Ok(profiles);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost]
    public async Task<IActionResult> CreateProfile([FromBody] CreateProfileRequest request, CancellationToken ct = default)
    {
        try
        {
            var profile = await profilesService.CreateProfileAsync(
                request.Id, 
                request.FullName, 
                request.Email,
                request.Role ?? "student", 
                ct);
            return CreatedAtAction(nameof(GetProfileById), new { id = profile["id"] }, profile);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPatch("{id}")]
    public async Task<IActionResult> UpdateProfile(Guid id, [FromBody] UpdateProfileRequest request, CancellationToken ct = default)
    {
        try
        {
            await profilesService.UpdateProfileAsync(id, request.FullName, request.Role, ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteProfile(Guid id, CancellationToken ct = default)
    {
        try
        {
            await profilesService.DeleteProfileAsync(id, ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        try
        {
            if (request == null || string.IsNullOrEmpty(request.Identifier) || string.IsNullOrEmpty(request.Password))
            {
                return BadRequest(new { error = "Identifier and password are required" });
            }

            var result = await profilesService.LoginAsync(request.Identifier, request.Password);
            
            if (result == null)
            {
                return Unauthorized(new { error = "Invalid credentials" });
            }
            
            return Ok(result);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }
}

public record CreateProfileRequest(Guid Id, string FullName, string Email, string? Role = null);
public record UpdateProfileRequest(string? FullName = null, string? Role = null);
public record LoginRequest(string Identifier, string Password);
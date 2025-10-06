// Legacy Supabase implementation - kept for reference.
using Microsoft.AspNetCore.Mvc;
using ProjectAPI.Services;

namespace ProjectAPI.Legacy.Supabase.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class ChaptersController(IChaptersService chaptersService) : ControllerBase
{
    [HttpGet("course/{courseId}")]
    public async Task<IActionResult> GetChaptersByCourse(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            var chapters = await chaptersService.GetChaptersByCourseAsync(courseId, ct);
            return Ok(chapters);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetChapterById(Guid id, CancellationToken ct = default)
    {
        try
        {
            var chapter = await chaptersService.GetChapterByIdAsync(id, ct);
            return Ok(chapter);
        }
        catch (KeyNotFoundException)
        {
            return NotFound(new { error = "Chapter not found" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPost]
    public async Task<IActionResult> CreateChapter([FromBody] CreateChapterRequest request, CancellationToken ct = default)
    {
        try
        {
            var chapter = await chaptersService.CreateChapterAsync(
                request.CourseId, 
                request.Number, 
                request.Title, 
                request.Summary, 
                ct);
            return CreatedAtAction(nameof(GetChapterById), new { id = chapter["id"] }, chapter);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpPatch("{id}")]
    public async Task<IActionResult> UpdateChapter(Guid id, [FromBody] UpdateChapterRequest request, CancellationToken ct = default)
    {
        try
        {
            await chaptersService.UpdateChapterAsync(id, request.Title, request.Summary, ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteChapter(Guid id, CancellationToken ct = default)
    {
        try
        {
            await chaptersService.DeleteChapterAsync(id, ct);
            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { error = ex.Message });
        }
    }
}

public record CreateChapterRequest(Guid CourseId, int Number, string Title, string? Summary = null);
public record UpdateChapterRequest(string? Title = null, string? Summary = null);
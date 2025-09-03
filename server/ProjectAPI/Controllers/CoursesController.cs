using Microsoft.AspNetCore.Mvc;
using ProjectAPI.Services;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public sealed class CoursesController(ISupabaseService supa) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> List(CancellationToken ct) =>
        Ok(await supa.GetCoursesAsync(ct));

    public sealed record CreateDto(string Title, string? Description);
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateDto dto, CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(dto.Title)) return BadRequest(new { message = "Title required" });
        var created = await supa.CreateCourseAsync(dto.Title, dto.Description, ct);
        return Created(string.Empty, created);
    }

    public sealed record UpdateDto(string? Title, string? Description);
    [HttpPut("{id:guid}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateDto dto, CancellationToken ct)
    {
        await supa.UpdateCourseAsync(id, dto.Title, dto.Description, ct);
        return NoContent();
    }

    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> Delete(Guid id, CancellationToken ct)
    {
        await supa.DeleteCourseAsync(id, ct);
        return NoContent();
    }
}
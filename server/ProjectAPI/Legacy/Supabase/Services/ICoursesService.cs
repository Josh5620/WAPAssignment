// Legacy Supabase implementation - kept for reference.
using System.Text.Json.Nodes;

namespace ProjectAPI.Legacy.Supabase.Services;

public interface ICoursesService
{
    Task<JsonArray> GetCoursesAsync(CancellationToken ct = default);
    Task<JsonObject> CreateCourseAsync(string title, string? description, CancellationToken ct = default);
    Task UpdateCourseAsync(Guid id, string? title, string? description, CancellationToken ct = default);
    Task DeleteCourseAsync(Guid id, CancellationToken ct = default);
}

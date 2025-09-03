using System.Text.Json.Nodes;

namespace ProjectAPI.Services;

public interface ISupabaseService
{
    Task<JsonArray> GetCoursesAsync(CancellationToken ct = default);
    Task<JsonObject> CreateCourseAsync(string title, string? description, CancellationToken ct = default);
    Task UpdateCourseAsync(Guid id, string? title, string? description, CancellationToken ct = default);
    Task DeleteCourseAsync(Guid id, CancellationToken ct = default);
}
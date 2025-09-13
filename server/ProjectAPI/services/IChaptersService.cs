using System.Text.Json.Nodes;

namespace ProjectAPI.Services;

public interface IChaptersService
{
    Task<JsonArray> GetChaptersByCourseAsync(Guid courseId, CancellationToken ct = default);
    Task<JsonObject> GetChapterByIdAsync(Guid id, CancellationToken ct = default);
    Task<JsonObject> CreateChapterAsync(Guid courseId, int number, string title, string? summary = null, CancellationToken ct = default);
    Task UpdateChapterAsync(Guid id, string? title = null, string? summary = null, CancellationToken ct = default);
    Task DeleteChapterAsync(Guid id, CancellationToken ct = default);
}
using System.Text.Json.Nodes;

// Legacy Supabase implementation - kept for reference.
namespace ProjectAPI.Legacy.Supabase.Services;

public interface IProfilesService
{
    Task<JsonArray> GetProfilesAsync(CancellationToken ct = default);
    Task<JsonObject> GetProfileByIdAsync(Guid id, CancellationToken ct = default);
    Task<JsonObject> CreateProfileAsync(Guid id, string fullName, string email, string role = "student", CancellationToken ct = default);
    Task UpdateProfileAsync(Guid id, string? fullName = null, string? role = null, CancellationToken ct = default);
    Task DeleteProfileAsync(Guid id, CancellationToken ct = default);
    Task<JsonArray> GetProfilesByRoleAsync(string role, CancellationToken ct = default);
    Task<JsonObject?> LoginAsync(string identifier, string password);
}

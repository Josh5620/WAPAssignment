using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using Microsoft.Extensions.Options;
using ProjectAPI.Options;

namespace ProjectAPI.Services;

public sealed class SupabaseService : ISupabaseService
{
    private readonly HttpClient _http;
    private static readonly JsonSerializerOptions JsonOpts = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,
        DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull
    };

    public SupabaseService(HttpClient http, IOptions<SupabaseOptions> opt)
    {
        _http = http;
        var cfg = opt.Value;
        var key = string.IsNullOrWhiteSpace(cfg.ServiceRoleKey) ? cfg.AnonKey : cfg.ServiceRoleKey!;
        _http.BaseAddress = new Uri($"{cfg.Url}/rest/v1/");
        _http.DefaultRequestHeaders.Add("apikey", key);
        _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", key);
        _http.DefaultRequestHeaders.Add("Prefer", "return=representation");
    }

    public async Task<JsonArray> GetCoursesAsync(CancellationToken ct = default)
    {
        var res = await _http.GetAsync("courses?select=*&order=created_at.desc", ct);
        res.EnsureSuccessStatusCode();
        return JsonNode.Parse(await res.Content.ReadAsStringAsync(ct))!.AsArray();
    }

    public async Task<JsonObject> CreateCourseAsync(string title, string? description, CancellationToken ct = default)
    {
        var payload = JsonSerializer.Serialize(new[] { new { title, description } }, JsonOpts);
        var res = await _http.PostAsync("courses", new StringContent(payload, Encoding.UTF8, "application/json"), ct);
        res.EnsureSuccessStatusCode();
        return JsonNode.Parse(await res.Content.ReadAsStringAsync(ct))![0]!.AsObject();
    }

    public async Task UpdateCourseAsync(Guid id, string? title, string? description, CancellationToken ct = default)
    {
        var payload = JsonSerializer.Serialize(new { title, description }, JsonOpts);
        var res = await _http.PatchAsync($"courses?id=eq.{id}", new StringContent(payload, Encoding.UTF8, "application/json"), ct);
        res.EnsureSuccessStatusCode();
    }

    public async Task DeleteCourseAsync(Guid id, CancellationToken ct = default)
    {
        var res = await _http.DeleteAsync($"courses?id=eq.{id}", ct);
        res.EnsureSuccessStatusCode();
    }
}

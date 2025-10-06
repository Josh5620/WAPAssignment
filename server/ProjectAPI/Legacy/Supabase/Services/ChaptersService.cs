// Legacy Supabase implementation - kept for reference.
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using Microsoft.Extensions.Options;
using ProjectAPI.Options;

namespace ProjectAPI.Legacy.Supabase.Services;

public sealed class ChaptersService : IChaptersService
{
    private readonly HttpClient _http;
    private static readonly JsonSerializerOptions JsonOpts = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,
        DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull
    };

    public ChaptersService(HttpClient http, IOptions<SupabaseOptions> opt)
    {
        _http = http;
        var cfg = opt.Value;
        var key = string.IsNullOrWhiteSpace(cfg.ServiceRoleKey) ? cfg.AnonKey : cfg.ServiceRoleKey!;
        _http.BaseAddress = new Uri($"{cfg.Url}/rest/v1/");
        _http.DefaultRequestHeaders.Add("apikey", key);
        _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", key);
        _http.DefaultRequestHeaders.Add("Prefer", "return=representation");
        
        Console.WriteLine($"[CHAPTERS] Service initialized with base URL: {_http.BaseAddress}");
    }

    public async Task<JsonArray> GetChaptersByCourseAsync(Guid courseId, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[CHAPTERS] Fetching chapters for course: {courseId}");
            
            var requestUrl = $"chapters?course_id=eq.{courseId}&order=number";
            Console.WriteLine($"[CHAPTERS] Making GET request to: {requestUrl}");
            
            var res = await _http.GetAsync(requestUrl, ct);
            Console.WriteLine($"[CHAPTERS] Response status: {res.StatusCode}");
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                Console.WriteLine($"[CHAPTERS ERROR] API error: {res.StatusCode} - {errorContent}");
                throw new HttpRequestException($"Chapters API error: {res.StatusCode} - {errorContent}");
            }
            
            var content = await res.Content.ReadAsStringAsync(ct);
            Console.WriteLine($"[CHAPTERS] Successfully received {content.Length} characters");
            
            var result = JsonNode.Parse(content)!.AsArray();
            Console.WriteLine($"[CHAPTERS] Successfully parsed {result.Count} chapters");
            
            return result;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[CHAPTERS ERROR] Error fetching chapters: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonObject> GetChapterByIdAsync(Guid id, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[CHAPTERS] Fetching chapter by ID: {id}");
            
            var requestUrl = $"chapters?id=eq.{id}&select=*";
            var res = await _http.GetAsync(requestUrl, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Chapters API error: {res.StatusCode} - {errorContent}");
            }
            
            var content = await res.Content.ReadAsStringAsync(ct);
            var array = JsonNode.Parse(content)!.AsArray();
            
            if (array.Count == 0)
                throw new KeyNotFoundException($"Chapter with ID {id} not found");
            
            return array[0]!.AsObject();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[CHAPTERS ERROR] Error fetching chapter by ID: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonObject> CreateChapterAsync(Guid courseId, int number, string title, string? summary = null, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[CHAPTERS] Creating chapter: {title} (number: {number}) for course: {courseId}");
            
            var payload = new
            {
                course_id = courseId,
                number,
                title,
                summary
            };
            
            var json = JsonSerializer.Serialize(payload, JsonOpts);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            
            var res = await _http.PostAsync("chapters", content, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Chapters API error: {res.StatusCode} - {errorContent}");
            }
            
            var responseContent = await res.Content.ReadAsStringAsync(ct);
            var result = JsonNode.Parse(responseContent)!.AsArray()[0]!.AsObject();
            
            Console.WriteLine($"[CHAPTERS] Successfully created chapter with ID: {result["id"]}");
            return result;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[CHAPTERS ERROR] Error creating chapter: {ex.Message}");
            throw;
        }
    }

    public async Task UpdateChapterAsync(Guid id, string? title = null, string? summary = null, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[CHAPTERS] Updating chapter: {id}");
            
            var payload = new Dictionary<string, object?>();
            if (title != null) payload["title"] = title;
            if (summary != null) payload["summary"] = summary;
            
            if (payload.Count == 0) return; // Nothing to update
            
            var json = JsonSerializer.Serialize(payload, JsonOpts);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            
            var res = await _http.PatchAsync($"chapters?id=eq.{id}", content, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Chapters API error: {res.StatusCode} - {errorContent}");
            }
            
            Console.WriteLine($"[CHAPTERS] Successfully updated chapter: {id}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[CHAPTERS ERROR] Error updating chapter: {ex.Message}");
            throw;
        }
    }

    public async Task DeleteChapterAsync(Guid id, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[CHAPTERS] Deleting chapter: {id}");
            
            var res = await _http.DeleteAsync($"chapters?id=eq.{id}", ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Chapters API error: {res.StatusCode} - {errorContent}");
            }
            
            Console.WriteLine($"[CHAPTERS] Successfully deleted chapter: {id}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[CHAPTERS ERROR] Error deleting chapter: {ex.Message}");
            throw;
        }
    }
}

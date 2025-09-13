using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using Microsoft.Extensions.Options;
using ProjectAPI.Options;

namespace ProjectAPI.Services;

public sealed class ProfilesService : IProfilesService
{
    private readonly HttpClient _http;
    private readonly HttpClient _authHttp;
    private readonly SupabaseOptions _config;
    private static readonly JsonSerializerOptions JsonOpts = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower,
        DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull
    };

    public ProfilesService(HttpClient http, IOptions<SupabaseOptions> opt, IHttpClientFactory httpClientFactory)
    {
        _http = http;
        _config = opt.Value;
        
        // For REST API operations, use service role key if available (for admin operations)
        var serviceKey = string.IsNullOrWhiteSpace(_config.ServiceRoleKey) ? _config.AnonKey : _config.ServiceRoleKey!;
        
        // Setup REST API client
        _http.BaseAddress = new Uri($"{_config.Url}/rest/v1/");
        _http.DefaultRequestHeaders.Add("apikey", serviceKey);
        _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", serviceKey);
        _http.DefaultRequestHeaders.Add("Prefer", "return=representation");
        
        // Setup Auth API client - MUST use anon key for login operations
        var anonKey = _config.AnonKey;
        _authHttp = httpClientFactory.CreateClient();
        _authHttp.BaseAddress = new Uri($"{_config.Url}/auth/v1/");
        _authHttp.DefaultRequestHeaders.Add("apikey", anonKey);
        _authHttp.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", anonKey);
        
        Console.WriteLine($"[PROFILES] Service initialized with REST URL: {_http.BaseAddress}");
        Console.WriteLine($"[PROFILES] Service initialized with AUTH URL: {_authHttp.BaseAddress}");
        Console.WriteLine($"[PROFILES] Using SERVICE KEY for REST API: {serviceKey[..Math.Min(20, serviceKey.Length)]}...");
        Console.WriteLine($"[PROFILES] Using ANON KEY for AUTH API: {anonKey[..Math.Min(20, anonKey.Length)]}...");
    }

    public async Task<JsonArray> GetProfilesAsync(CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine("[PROFILES] Fetching all profiles");
            
            var requestUrl = "profiles?select=*&order=created_at.desc";
            var res = await _http.GetAsync(requestUrl, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                Console.WriteLine($"[PROFILES ERROR] API error: {res.StatusCode} - {errorContent}");
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            var content = await res.Content.ReadAsStringAsync(ct);
            var result = JsonNode.Parse(content)!.AsArray();
            Console.WriteLine($"[PROFILES] Successfully fetched {result.Count} profiles");
            
            return result;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error fetching profiles: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonObject> GetProfileByIdAsync(Guid id, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Fetching profile by ID: {id}");
            
            var requestUrl = $"profiles?id=eq.{id}&select=*";
            var res = await _http.GetAsync(requestUrl, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            var content = await res.Content.ReadAsStringAsync(ct);
            var array = JsonNode.Parse(content)!.AsArray();
            
            if (array.Count == 0)
                throw new KeyNotFoundException($"Profile with ID {id} not found");
            
            return array[0]!.AsObject();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error fetching profile by ID: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonObject> CreateProfileAsync(Guid id, string fullName, string email, string role = "student", CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Creating profile: {fullName} (role: {role})");
            
            var payload = new
            {
                id,
                full_name = fullName,
                email,
                role,
                password = "1" // Default password as per schema
            };
            
            var json = JsonSerializer.Serialize(payload, JsonOpts);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            
            var res = await _http.PostAsync("profiles", content, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            var responseContent = await res.Content.ReadAsStringAsync(ct);
            var result = JsonNode.Parse(responseContent)!.AsArray()[0]!.AsObject();
            
            Console.WriteLine($"[PROFILES] Successfully created profile with ID: {result["id"]}");
            return result;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error creating profile: {ex.Message}");
            throw;
        }
    }

    public async Task UpdateProfileAsync(Guid id, string? fullName = null, string? role = null, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Updating profile: {id}");
            
            var payload = new Dictionary<string, object?>();
            if (fullName != null) payload["full_name"] = fullName;
            if (role != null) payload["role"] = role;
            
            if (payload.Count == 0) return; // Nothing to update
            
            var json = JsonSerializer.Serialize(payload, JsonOpts);
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            
            var res = await _http.PatchAsync($"profiles?id=eq.{id}", content, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            Console.WriteLine($"[PROFILES] Successfully updated profile: {id}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error updating profile: {ex.Message}");
            throw;
        }
    }

    public async Task DeleteProfileAsync(Guid id, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Deleting profile: {id}");
            
            var res = await _http.DeleteAsync($"profiles?id=eq.{id}", ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            Console.WriteLine($"[PROFILES] Successfully deleted profile: {id}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error deleting profile: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonArray> GetProfilesByRoleAsync(string role, CancellationToken ct = default)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Fetching profiles by role: {role}");
            
            var requestUrl = $"profiles?role=eq.{role}&select=*&order=created_at.desc";
            var res = await _http.GetAsync(requestUrl, ct);
            
            if (!res.IsSuccessStatusCode)
            {
                var errorContent = await res.Content.ReadAsStringAsync(ct);
                throw new HttpRequestException($"Profiles API error: {res.StatusCode} - {errorContent}");
            }
            
            var content = await res.Content.ReadAsStringAsync(ct);
            var result = JsonNode.Parse(content)!.AsArray();
            Console.WriteLine($"[PROFILES] Successfully fetched {result.Count} profiles with role {role}");
            
            return result;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error fetching profiles by role: {ex.Message}");
            throw;
        }
    }

    public async Task<JsonObject?> LoginAsync(string identifier, string password)
    {
        try
        {
            Console.WriteLine($"[PROFILES] Attempting login for identifier: {identifier}");
            
            string email;
            
            // Check if identifier is an email (contains '@')
            if (identifier.Contains('@'))
            {
                email = identifier;
                Console.WriteLine($"[PROFILES] Treating identifier as email: {email}");
            }
            else
            {
                // Treat as username - query profiles table
                Console.WriteLine($"[PROFILES] Treating identifier as username, looking up email...");
                
                // Query profiles for username - look for full_name OR email field
                // First try to find by full_name (treating it as username)
                var usernameRequestUrl = $"profiles?full_name=eq.{identifier}&select=id,full_name,email";
                Console.WriteLine($"[PROFILES] Querying profiles with URL: {usernameRequestUrl}");
                
                var usernameRes = await _http.GetAsync(usernameRequestUrl);
                
                if (!usernameRes.IsSuccessStatusCode)
                {
                    var errorContent = await usernameRes.Content.ReadAsStringAsync();
                    Console.WriteLine($"[PROFILES ERROR] Failed to lookup user profile: {usernameRes.StatusCode} - {errorContent}");
                    return null;
                }
                
                var usernameContent = await usernameRes.Content.ReadAsStringAsync();
                Console.WriteLine($"[PROFILES] Profile lookup response: {usernameContent}");
                
                var userProfiles = JsonNode.Parse(usernameContent)!.AsArray();
                
                if (userProfiles.Count == 0)
                {
                    Console.WriteLine($"[PROFILES] No profile found for username: {identifier}");
                    Console.WriteLine($"[PROFILES] This could mean:");
                    Console.WriteLine($"[PROFILES] 1. No user exists with full_name = '{identifier}'");
                    Console.WriteLine($"[PROFILES] 2. You need to add an 'email' field to profiles table");
                    Console.WriteLine($"[PROFILES] 3. The identifier should be an email instead");
                    return null;
                }
                
                var foundProfile = userProfiles[0]!.AsObject();
                var lookupUserId = foundProfile["id"]!.GetValue<Guid>();
                Console.WriteLine($"[PROFILES] Found user profile: ID = {lookupUserId}, full_name = {foundProfile["full_name"]}");
                
                // Try to get email from the profile
                if (foundProfile["email"] != null)
                {
                    email = foundProfile["email"]!.GetValue<string>();
                    Console.WriteLine($"[PROFILES] Found email in profile: {email}");
                }
                else
                {
                    Console.WriteLine($"[PROFILES ERROR] No email field found in profiles table!");
                    Console.WriteLine($"[PROFILES ERROR] You need to add an 'email' column to your profiles table");
                    Console.WriteLine($"[PROFILES ERROR] ALTER TABLE profiles ADD COLUMN email TEXT;");
                    return null;
                }
            }
            
            // Now authenticate with Supabase Auth
            Console.WriteLine($"[PROFILES] ========== SUPABASE AUTH REQUEST ==========");
            Console.WriteLine($"[PROFILES] Attempting authentication with email: {email}");
            
            // Prepare the request
            var authEndpoint = "token?grant_type=password";
            var fullAuthUrl = $"{_authHttp.BaseAddress}{authEndpoint}";
            Console.WriteLine($"[PROFILES] Full Auth URL: {fullAuthUrl}");
            
            // Log all headers that will be sent
            Console.WriteLine($"[PROFILES] Request Headers:");
            foreach (var header in _authHttp.DefaultRequestHeaders)
            {
                var values = string.Join(", ", header.Value);
                if (header.Key.ToLower() == "apikey" || header.Key.ToLower() == "authorization")
                {
                    // Show first 20 chars of sensitive headers
                    values = values.Length > 20 ? $"{values[..20]}..." : values;
                }
                Console.WriteLine($"[PROFILES]   {header.Key}: {values}");
            }
            
            // Prepare JSON payload
            var authPayload = new
            {
                email,
                password = password // Don't log the actual password
            };
            
            var authJson = JsonSerializer.Serialize(authPayload, JsonOpts);
            Console.WriteLine($"[PROFILES] Request Body: {{\"email\":\"{email}\",\"password\":\"[REDACTED]\"}}");
            Console.WriteLine($"[PROFILES] JSON Serialization Options: snake_case={JsonOpts.PropertyNamingPolicy != null}");
            
            // Create content with proper headers
            var authContent = new StringContent(authJson, Encoding.UTF8, "application/json");
            Console.WriteLine($"[PROFILES] Content-Type header set to: application/json");
            Console.WriteLine($"[PROFILES] Content encoding: UTF-8");
            
            Console.WriteLine($"[PROFILES] ========== SENDING REQUEST ==========");
            
            HttpResponseMessage authRes;
            try
            {
                authRes = await _authHttp.PostAsync(authEndpoint, authContent);
                Console.WriteLine($"[PROFILES] Request completed successfully");
            }
            catch (HttpRequestException httpEx)
            {
                Console.WriteLine($"[PROFILES ERROR] HttpRequestException during auth request:");
                Console.WriteLine($"[PROFILES ERROR] Message: {httpEx.Message}");
                Console.WriteLine($"[PROFILES ERROR] Inner Exception: {httpEx.InnerException?.Message}");
                Console.WriteLine($"[PROFILES ERROR] This usually indicates network/connectivity issues");
                return null;
            }
            catch (TaskCanceledException tcEx)
            {
                Console.WriteLine($"[PROFILES ERROR] Request timeout during auth request:");
                Console.WriteLine($"[PROFILES ERROR] Message: {tcEx.Message}");
                Console.WriteLine($"[PROFILES ERROR] This indicates the request took too long");
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[PROFILES ERROR] Unexpected exception during auth request:");
                Console.WriteLine($"[PROFILES ERROR] Type: {ex.GetType().Name}");
                Console.WriteLine($"[PROFILES ERROR] Message: {ex.Message}");
                Console.WriteLine($"[PROFILES ERROR] Stack Trace: {ex.StackTrace}");
                return null;
            }
            
            Console.WriteLine($"[PROFILES] ========== RESPONSE RECEIVED ==========");
            Console.WriteLine($"[PROFILES] Status Code: {(int)authRes.StatusCode} {authRes.StatusCode}");
            Console.WriteLine($"[PROFILES] Response Headers:");
            foreach (var header in authRes.Headers)
            {
                Console.WriteLine($"[PROFILES]   {header.Key}: {string.Join(", ", header.Value)}");
            }
            
            if (!authRes.IsSuccessStatusCode)
            {
                string errorContent;
                try
                {
                    errorContent = await authRes.Content.ReadAsStringAsync();
                }
                catch (Exception ex)
                {
                    errorContent = $"[Failed to read error content: {ex.Message}]";
                }
                
                Console.WriteLine($"[PROFILES ERROR] Authentication failed!");
                Console.WriteLine($"[PROFILES ERROR] Status: {(int)authRes.StatusCode} {authRes.StatusCode}");
                Console.WriteLine($"[PROFILES ERROR] Response Body: {errorContent}");
                
                // Provide specific guidance based on status code
                switch (authRes.StatusCode)
                {
                    case System.Net.HttpStatusCode.ServiceUnavailable:
                        Console.WriteLine($"[PROFILES] 503 Service Unavailable - Possible causes:");
                        Console.WriteLine($"[PROFILES] 1. Email auth not enabled in Supabase Dashboard");
                        Console.WriteLine($"[PROFILES] 2. Supabase service temporarily down");
                        Console.WriteLine($"[PROFILES] 3. Wrong project URL: {_config.Url}");
                        Console.WriteLine($"[PROFILES] 4. Network/proxy issues");
                        break;
                    case System.Net.HttpStatusCode.BadRequest:
                        Console.WriteLine($"[PROFILES] 400 Bad Request - Check email/password format");
                        break;
                    case System.Net.HttpStatusCode.Unauthorized:
                        Console.WriteLine($"[PROFILES] 401 Unauthorized - Wrong API key or user doesn't exist");
                        break;
                    case System.Net.HttpStatusCode.UnprocessableEntity:
                        Console.WriteLine($"[PROFILES] 422 Unprocessable Entity - Invalid email/password");
                        break;
                    default:
                        Console.WriteLine($"[PROFILES] Unexpected status code");
                        break;
                }
                
                return null;
            }
            
            Console.WriteLine($"[PROFILES] ========== SUCCESS! AUTH RESPONSE ==========");
            var authResponseContent = await authRes.Content.ReadAsStringAsync();
            Console.WriteLine($"[PROFILES] Authentication successful!");
            Console.WriteLine($"[PROFILES] Response length: {authResponseContent.Length} characters");
            
            var authResult = JsonNode.Parse(authResponseContent)!.AsObject();
            var authenticatedUserId = authResult["user"]!["id"]!.GetValue<Guid>();
            
            Console.WriteLine($"[PROFILES] Authenticated user ID: {authenticatedUserId}");
            Console.WriteLine($"[PROFILES] Access token received: {(authResult["access_token"] != null ? "Yes" : "No")}");
            Console.WriteLine($"[PROFILES] Refresh token received: {(authResult["refresh_token"] != null ? "Yes" : "No")}");
            
            // Fetch user profile from profiles table
            var finalProfileRequestUrl = $"profiles?id=eq.{authenticatedUserId}&select=*";
            var finalProfileRes = await _http.GetAsync(finalProfileRequestUrl);
            
            if (!finalProfileRes.IsSuccessStatusCode)
            {
                var errorContent = await finalProfileRes.Content.ReadAsStringAsync();
                Console.WriteLine($"[PROFILES ERROR] Failed to fetch user profile: {finalProfileRes.StatusCode} - {errorContent}");
                return null;
            }
            
            var finalProfileContent = await finalProfileRes.Content.ReadAsStringAsync();
            var finalProfiles = JsonNode.Parse(finalProfileContent)!.AsArray();
            
            if (finalProfiles.Count == 0)
            {
                Console.WriteLine($"[PROFILES ERROR] No profile found for authenticated user: {authenticatedUserId}");
                return null;
            }
            
            var userProfile = finalProfiles[0]!.AsObject();
            
            // Add auth token to the response
            userProfile["access_token"] = authResult["access_token"];
            userProfile["refresh_token"] = authResult["refresh_token"];
            
            Console.WriteLine($"[PROFILES] Login successful for user: {userProfile["full_name"]} (role: {userProfile["role"]})");
            
            return userProfile;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[PROFILES ERROR] Error during login: {ex.Message}");
            Console.WriteLine($"[PROFILES ERROR] Stack trace: {ex.StackTrace}");
            return null;
        }
    }
}
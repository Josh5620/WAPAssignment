using System.Net.Http;
using System.Net.Http.Json;

public class GeminiService(HttpClient httpClient, string apiKey)
{
    private readonly HttpClient _httpClient = httpClient; // Add this field
    private readonly string _apiKey = apiKey; // Store API key as field

    private static readonly Dictionary<string, List<(string Role, string Text)>> _conversations = new();

    public async Task<string> SendMessageAsync(string sessionId, string userMessage)
    {
        if (!_conversations.ContainsKey(sessionId))
            _conversations[sessionId] = new List<(string, string)>();

        _conversations[sessionId].Add(("user", userMessage));

        var payload = new
        {
            contents = _conversations[sessionId].Select(m => new
            {
                role = m.Role,
                parts = new[] { new { text = m.Text } }
            })
        };

        var response = await _httpClient.PostAsJsonAsync(
            $"models/gemini-1.5-flash:generateContent?key={_apiKey}", payload);

        if (!response.IsSuccessStatusCode)
        {
            var error = await response.Content.ReadAsStringAsync();
            throw new Exception($"Gemini API error: {response.StatusCode} - {error}");
        }

        var result = await response.Content.ReadFromJsonAsync<GeminiResponse>();

        var botReply = result?.Candidates?.FirstOrDefault()?.Content?.Parts?.FirstOrDefault()?.Text ?? "";
        _conversations[sessionId].Add(("model", botReply));

        return botReply;
    }
}

public class GeminiResponse
{
    public List<Candidate>? Candidates { get; set; }
}

public class Candidate
{
    public Content? Content { get; set; }
}

public class Content
{
    public List<Part>? Parts { get; set; }
}

public class Part
{
    public string? Text { get; set; }
}

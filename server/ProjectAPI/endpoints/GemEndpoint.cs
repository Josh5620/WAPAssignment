using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/chat")]
public class GemEndpoint : ControllerBase
{
    private readonly GeminiService _geminiService;

    public GemEndpoint(GeminiService geminiService)
    {
        _geminiService = geminiService;
    }

    [HttpPost("send")]
    public async Task<IActionResult> SendMessage([FromBody] ChatRequest request)
    {
        var reply = await _geminiService.SendMessageAsync(request.SessionId, request.Message);
        return Ok(new { reply });
    }
}

public record ChatRequest(string SessionId, string Message);

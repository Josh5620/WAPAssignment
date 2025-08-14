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

    [HttpPost("explain")]
    public async Task<IActionResult> ExplainCode([FromBody] CheckAnswer request)
    {
        var reply = await _geminiService.ExplainCodeAsync(request.user, request.question);
        return Ok(new { reply });
    }

}

public record ChatRequest(string user, string Message);
public record CheckAnswer(User user, string question);
public record User(string userName);

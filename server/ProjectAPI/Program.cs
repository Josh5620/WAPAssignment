var builder = WebApplication.CreateBuilder(args);

// Read API keys from configuration
var geminiKey = builder.Configuration["GeminiApiKey"];
var supabaseKey = builder.Configuration["SupabaseApiKey"];

// Register HttpClients
builder.Services.AddHttpClient("Gemini", client =>
{
    client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/");
});

builder.Services.AddHttpClient("Supabase", client =>
{
    client.BaseAddress = new Uri("https://YOUR_PROJECT_REF.supabase.co/rest/v1/");
    client.DefaultRequestHeaders.Add("apikey", supabaseKey);
});

// Register services

builder.Services.AddScoped<GeminiService>(sp =>
    new GeminiService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Gemini"), geminiKey));
builder.Services.AddScoped<SupabaseService>(sp =>
    new SupabaseService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Supabase")));

// Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Group 1: Gemini routes
var gemGroup = app.MapGroup("/api/v1/gem");
gemGroup.MapPost("/chat", async (GeminiService gemini, string prompt) =>
{
    var reply = await gemini.AskGeminiAsync(prompt);
    return Results.Ok(new { response = reply });
});

// Group 2: Supabase routes
var dbGroup = app.MapGroup("/api/v1/db");
dbGroup.MapGet("/test", (SupabaseService supabase) =>
{
    return Results.Ok(new { message = "DB route works!" });
});

app.Run();

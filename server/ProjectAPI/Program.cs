var builder = WebApplication.CreateBuilder(args);

// Read API keys from configuration
var geminiKey = builder.Configuration["Gemini:ApiKey"];

// HttpClient for Gemini
builder.Services.AddHttpClient("Gemini", client =>
{
    client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/");
});

// Register GeminiService
builder.Services.AddScoped<GeminiService>(sp =>
    new GeminiService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Gemini"), geminiKey));

// Enable CORS for React
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp",
        policy => policy
            .WithOrigins("http://localhost:5173") // remove if want host and change to react hosted url 
            .AllowAnyHeader()
            .AllowAnyMethod());
});

// Controllers
builder.Services.AddControllers();

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
app.UseCors("AllowReactApp");

app.MapControllers();

app.Run();

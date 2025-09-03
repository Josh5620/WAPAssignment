using System.Net.Http.Headers;
using ProjectAPI.Services;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using ProjectAPI.Options;

var builder = WebApplication.CreateBuilder(args);

// Read config
var geminiKey = builder.Configuration["Gemini:ApiKey"];

//  HttpClient: Gemini
builder.Services.AddHttpClient("Gemini", client =>
{
    client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/");
});

// Bind Supabase Options from user-secrets
builder.Services.Configure<SupabaseOptions>(builder.Configuration.GetSection("Supabase"));

// Supabase HttpClient + service
builder.Services.AddHttpClient<ISupabaseService, SupabaseService>();

//  Register Services
builder.Services.AddScoped<GeminiService>(sp =>
    new GeminiService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Gemini"), geminiKey));



//  CORS for React
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp", policy => policy
        .WithOrigins("http://localhost:5173", "http://localhost:5174")
        .AllowAnyHeader()
        .AllowAnyMethod()
        .AllowCredentials());
});

//  MVC + Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "ProjectAPI", Version = "v1" });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowReactApp");

// NOTE: no UseAuthentication(); no custom JWTs
app.UseAuthorization();

app.MapControllers();

app.Run();

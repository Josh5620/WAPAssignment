using System.Data;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;

var builder = WebApplication.CreateBuilder(args);

// Read config
var geminiKey = builder.Configuration["Gemini:ApiKey"];

// Database
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

//  HttpClient: Gemini
builder.Services.AddHttpClient("Gemini", client =>
{
    client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/");
});

//  Register Services
builder.Services.AddScoped<GeminiService>(sp =>
    new GeminiService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Gemini"), geminiKey ?? string.Empty));

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

// Ensure database is created and seeded
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
    
    try
    {
        // Ensure database is created
        context.Database.EnsureCreated();
        
        // Run seed data if database is empty
        // await SeedDatabase(context, logger); // Temporarily disabled due to SQL variable conflicts
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "An error occurred while seeding the database.");
    }
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseStaticFiles(); // Add static file support
app.UseHttpsRedirection();
app.UseCors("AllowReactApp");

// NOTE: no UseAuthentication(); no custom JWTs
app.UseAuthorization();

app.MapControllers();

app.Run();

// Database seeding method
static async Task SeedDatabase(ApplicationDbContext context, ILogger logger)
{
    // Check if database already has data
    if (context.Courses.Any())
    {
        logger.LogInformation("Database already contains data. Skipping seeding.");
        return;
    }

    logger.LogInformation("Seeding database with initial data...");

    try
    {
        // Execute SQL seed files
        var seedFiles = new[]
        {
            "Seeds/SQL/seed_python.sql",
            "Seeds/SQL/seed_java.sql", 
            "Seeds/SQL/seed_html&css.sql"
        };

        foreach (var seedFile in seedFiles)
        {
            var filePath = Path.Combine(Directory.GetCurrentDirectory(), seedFile);
            if (File.Exists(filePath))
            {
                logger.LogInformation($"Executing seed file: {seedFile}");
                var sql = await File.ReadAllTextAsync(filePath);
                
                // Split by GO statements and execute each batch
                var batches = sql.Split(new[] { "\nGO\n", "\ngo\n", "\nGo\n", "\ngO\n" }, 
                    StringSplitOptions.RemoveEmptyEntries);
                
                foreach (var batch in batches)
                {
                    if (!string.IsNullOrWhiteSpace(batch))
                    {
                        // Create a SqlCommand to execute raw SQL without format string interpretation
                        using var command = context.Database.GetDbConnection().CreateCommand();
                        command.CommandText = batch;
                        
                        if (context.Database.GetDbConnection().State != System.Data.ConnectionState.Open)
                        {
                            await context.Database.GetDbConnection().OpenAsync();
                        }
                        
                        await command.ExecuteNonQueryAsync();
                    }
                }
            }
            else
            {
                logger.LogWarning($"Seed file not found: {seedFile}");
            }
        }

        logger.LogInformation("Database seeding completed successfully!");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error occurred during database seeding.");
        throw;
    }
}

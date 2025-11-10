using System.Data;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

var builder = WebApplication.CreateBuilder(args);

// Read config
var geminiKey = builder.Configuration["Gemini:ApiKey"];

// Database
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrEmpty(connectionString))
{
    throw new InvalidOperationException("DefaultConnection string is not configured.");
}

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString)
        .EnableSensitiveDataLogging(builder.Environment.IsDevelopment())
        .EnableDetailedErrors(builder.Environment.IsDevelopment()));

//  HttpClient: Gemini
builder.Services.AddHttpClient("Gemini", client =>
{
    client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/");
});

//  Register Services
builder.Services.AddScoped<GeminiService>(sp =>
    new GeminiService(sp.GetRequiredService<IHttpClientFactory>().CreateClient("Gemini"), geminiKey));

//  CORS for React - Enhanced for API compatibility
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp", policy => policy
        .WithOrigins("http://localhost:5173", "http://localhost:5174", "http://127.0.0.1:5173")
        .AllowAnyHeader()
        .AllowAnyMethod()
        .AllowCredentials()
        .SetPreflightMaxAge(TimeSpan.FromMinutes(10)));
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
        logger.LogInformation("Database ensured created.");
        
        // Run seed data if database is empty
        await SeedDatabaseIfEmpty(context, logger);
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

// Database seeding method that checks if database is empty first
static async Task SeedDatabaseIfEmpty(ApplicationDbContext context, ILogger logger)
{
    try
    {
        // Check if database already has profiles
        var profileCount = await context.Profiles.CountAsync();
        logger.LogInformation($"Current profile count: {profileCount}");
        
        if (profileCount > 0)
        {
            logger.LogInformation("Database already contains profiles. Skipping seeding.");
            return;
        }

        logger.LogInformation("Database is empty. Starting automatic seeding...");
        
        // Use the same logic as TestDataController
        await SeedTestProfiles(context, logger);
        await SeedTestCourses(context, logger);
        
        logger.LogInformation("Automatic database seeding completed successfully!");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error occurred during automatic database seeding.");
        throw;
    }
}

static async Task SeedTestProfiles(ApplicationDbContext context, ILogger logger)
{
    var profiles = new List<Profile>
    {
        // Admins
        new() { UserId = Guid.NewGuid(), FullName = "Admin User", Email = "admin@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("admin123"), Role = "admin", CreatedAt = DateTime.UtcNow.AddDays(-30) },
        new() { UserId = Guid.NewGuid(), FullName = "Sarah Administrator", Email = "sarah.admin@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"), Role = "admin", CreatedAt = DateTime.UtcNow.AddDays(-28) },
        
        // Teachers  
        new() { UserId = Guid.NewGuid(), FullName = "Dr. Michael Johnson", Email = "teacher@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher123"), Role = "teacher", CreatedAt = DateTime.UtcNow.AddDays(-25) },
        new() { UserId = Guid.NewGuid(), FullName = "Prof. Emily Chen", Email = "emily.chen@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"), Role = "teacher", CreatedAt = DateTime.UtcNow.AddDays(-22) },
        new() { UserId = Guid.NewGuid(), FullName = "David Rodriguez", Email = "david.teacher@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("teacher456"), Role = "teacher", CreatedAt = DateTime.UtcNow.AddDays(-20) },
        
        // Students
        new() { UserId = Guid.NewGuid(), FullName = "John Student", Email = "student@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student123"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-18) },
        new() { UserId = Guid.NewGuid(), FullName = "Alice Williams", Email = "alice.student@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("password123"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-15) },
        new() { UserId = Guid.NewGuid(), FullName = "Bob Smith", Email = "bob.smith@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("student456"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-12) },
        new() { UserId = Guid.NewGuid(), FullName = "Emma Thompson", Email = "emma.t@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("emma123"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-10) },
        new() { UserId = Guid.NewGuid(), FullName = "Carlos Martinez", Email = "carlos.m@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("carlos789"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-8) },
        new() { UserId = Guid.NewGuid(), FullName = "Sophia Lee", Email = "sophia.lee@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("sophia321"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-5) },
        new() { UserId = Guid.NewGuid(), FullName = "James Wilson", Email = "james.w@codesage.com", 
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("james654"), Role = "student", CreatedAt = DateTime.UtcNow.AddDays(-2) }
    };

    context.Profiles.AddRange(profiles);
    await context.SaveChangesAsync();
    logger.LogInformation($"Added {profiles.Count} profiles to database");
}

static async Task SeedTestCourses(ApplicationDbContext context, ILogger logger)
{
    // Only add basic courses to prevent complexity
    if (!await context.Courses.AnyAsync())
    {
        var courses = new List<Course>
        {
            new() { CourseId = Guid.NewGuid(), Title = "Introduction to Python", Description = "Learn Python basics", Published = true }
        };
        
        context.Courses.AddRange(courses);
        await context.SaveChangesAsync();
        logger.LogInformation($"Added {courses.Count} courses to database");
    }
}

// Original database seeding method (kept for reference)
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

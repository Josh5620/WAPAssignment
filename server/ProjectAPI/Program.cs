using System.Data;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using ProjectAPI.Data;
using ProjectAPI.Models;

var builder = WebApplication.CreateBuilder(args);

// Read config
var geminiKey = builder.Configuration["Gemini:ApiKey"];
var jwtKey = builder.Configuration["Jwt:Key"] ?? "YourSuperSecretKeyThatIsAtLeast32CharactersLongForHS256Algorithm";
var jwtIssuer = builder.Configuration["Jwt:Issuer"] ?? "ProjectAPI";
var jwtAudience = builder.Configuration["Jwt:Audience"] ?? "ProjectAPIClients";

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

// JWT Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtIssuer,
        ValidAudience = jwtAudience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
        ClockSkew = TimeSpan.Zero // Remove default 5 minute clock skew
    };
});

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
builder.Services
    .AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.DictionaryKeyPolicy = JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
    });
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
        // Apply all pending migrations (this creates tables properly)
        logger.LogInformation("🔧 Checking for pending migrations...");
        await context.Database.MigrateAsync();
        logger.LogInformation("✅ Database migrations applied successfully.");
        
        // Run seed data if database is empty
        await SeedDatabaseIfEmpty(context, logger);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "❌ An error occurred while setting up the database.");
        throw; // Re-throw to prevent app from starting with broken database
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

// Enable authentication and authorization
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

// Database seeding method that checks if database is empty first
static async Task SeedDatabaseIfEmpty(ApplicationDbContext context, ILogger logger)
{
    try
    {
        logger.LogInformation("🔍 Checking database state...");

        // Check profiles
        var profileCount = await context.Profiles.CountAsync();
        logger.LogInformation($"   Profiles: {profileCount}");

        // Check courses
        var courseCount = await context.Courses.CountAsync();
        logger.LogInformation($"   Courses: {courseCount}");

        // Check chapters
        var chapterCount = await context.Chapters.CountAsync();
        logger.LogInformation($"   Chapters: {chapterCount}");

        // Seed profiles if needed
        if (profileCount == 0)
        {
            logger.LogInformation("🌱 Seeding user profiles...");
            await SeedTestProfiles(context, logger);
        }
        else
        {
            logger.LogInformation($"✓ Profiles already exist ({profileCount} found)");
        }

        // Seed course content if needed
        if (courseCount == 0 || chapterCount == 0)
        {
            logger.LogInformation("🌱 Seeding course content from SQL files...");
            await ExecuteSqlSeedFiles(context, logger);
        }
        else
        {
            logger.LogInformation($"✓ Course content already exists ({courseCount} courses, {chapterCount} chapters)");
        }

        logger.LogInformation("✅ Database seeding check completed!");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "❌ Error occurred during database seeding.");
        throw;
    }
}

static async Task ExecuteSqlSeedFiles(ApplicationDbContext context, ILogger logger)
{
    logger.LogInformation("🌱 Starting SQL seed file execution...");
    
    var seedFiles = new[]
    {
        "Data/Seeds/02-python-course.sql",
        "Data/Seeds/03-python-chapters.sql",
        "Data/Seeds/04-python-resources.sql",
        "Data/Seeds/05-python-flashcards.sql",
        "Data/Seeds/06-python-questions.sql",
        "Data/Seeds/07-python-question-options.sql"
    };

    foreach (var seedFile in seedFiles)
    {
        try
        {
            var filePath = Path.Combine(Directory.GetCurrentDirectory(), seedFile);
            
            if (!File.Exists(filePath))
            {
                logger.LogWarning($"⚠️ Seed file not found: {filePath}");
                continue;
            }

            logger.LogInformation($"📄 Reading seed file: {seedFile}");
            var sql = await File.ReadAllTextAsync(filePath);
            
            if (string.IsNullOrWhiteSpace(sql))
            {
                logger.LogWarning($"⚠️ Seed file is empty: {seedFile}");
                continue;
            }
            
            // Split by GO statements (case-insensitive, handling different newline styles) and execute each batch
            var batches = Regex.Split(sql, @"^\s*GO\s*$", RegexOptions.Multiline | RegexOptions.IgnoreCase)
                .Where(batch => !string.IsNullOrWhiteSpace(batch))
                .ToList();

            logger.LogInformation($"📦 Found {batches.Count} SQL batches in {seedFile}");

            int batchNumber = 0;
            foreach (var batch in batches)
            {
                batchNumber++;
                var trimmedBatch = batch.Trim();
                
                if (string.IsNullOrWhiteSpace(trimmedBatch))
                {
                    continue;
                }

                try
                {
                    logger.LogInformation($"   ⚡ Executing batch {batchNumber}/{batches.Count} ({trimmedBatch.Length} chars)");
                    await context.Database.ExecuteSqlRawAsync(trimmedBatch);
                    logger.LogInformation($"   ✅ Batch {batchNumber} completed");
                }
                catch (Exception batchEx)
                {
                    logger.LogError(batchEx, $"   ❌ Error in batch {batchNumber} of {seedFile}");
                    logger.LogError($"   📝 Failed SQL (first 200 chars): {trimmedBatch.Substring(0, Math.Min(200, trimmedBatch.Length))}...");
                    // Continue with next batch instead of failing completely
                }
            }
            
            logger.LogInformation($"✅ Completed seed file: {seedFile}");
        }
        catch (Exception ex)
        {
            logger.LogError(ex, $"❌ Failed to process seed file: {seedFile}");
        }
    }
    
    logger.LogInformation("🎉 SQL seed file execution completed!");
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
        
        // Teachers - MUST use specific GUID that matches SQL seed files
        new() { UserId = Guid.Parse("213ac00b-c3df-4d60-a264-f5e8e5d3cb93"), FullName = "Dr. Michael Johnson", Email = "teacher@codesage.com", 
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

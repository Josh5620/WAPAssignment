namespace ProjectAPI.DTOs
{
    // API Response wrapper
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public T? Data { get; set; }
        public string[]? Errors { get; set; }
    }

    // Authentication DTOs
    public class LoginRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class AdminLoginRequest
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class RegisterRequest
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Role { get; set; } = "student";
    }

    public class AuthResponse
    {
        public string Token { get; set; } = string.Empty;
        public UserDto User { get; set; } = null!;
    }

    // User DTOs
    public class UserDto
    {
        public Guid Id { get; set; }
        public string Email { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
        public bool IsAdmin { get; set; }
        public bool IsTeacher { get; set; }
        public bool IsStudent { get; set; }
    }

    // Forum Post DTOs
    public class ForumPostDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
        public UserDto Author { get; set; } = null!;
        
        // Additional properties for admin dashboard
        public Guid AuthorId { get; set; }
        public string AuthorName { get; set; } = string.Empty;
    }

    public class CreateForumPostRequest
    {
        public string Title { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
    }

    public class UpdateForumPostRequest
    {
        public string Title { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
    }

    // Resource DTOs
    public class ResourceDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Type { get; set; } = string.Empty;
        public string? Url { get; set; }
        public string? FilePath { get; set; }
        public bool IsApproved { get; set; }
        public DateTime CreatedAt { get; set; }
        public UserDto Creator { get; set; } = null!;
    }

    public class CreateResourceRequest
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Type { get; set; } = string.Empty;
        public string? Url { get; set; }
        public string? FilePath { get; set; }
    }

    public class UpdateResourceRequest
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Type { get; set; } = string.Empty;
        public string? Url { get; set; }
        public string? FilePath { get; set; }
    }

    // Admin Dashboard DTOs
    public class AdminDashboardDto
    {
        public DashboardStatisticsDto Statistics { get; set; } = null!;
        public List<UserDto> RecentUsers { get; set; } = new();
        public List<ForumPostDto> RecentPosts { get; set; } = new();
    }

    public class DashboardStatisticsDto
    {
        public int TotalUsers { get; set; }
        public int TotalStudents { get; set; }
        public int TotalTeachers { get; set; }
        public int TotalAdmins { get; set; }
        public int TotalForumPosts { get; set; }
        public int TotalResources { get; set; }
    }

    public class UpdateUserRoleRequest
    {
        public string Role { get; set; } = string.Empty;
    }
}

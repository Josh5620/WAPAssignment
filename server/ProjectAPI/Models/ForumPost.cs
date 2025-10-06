namespace ProjectAPI.Models
{
    public class ForumPost
    {
        public Guid Id { get; set; }
        public Guid UserId { get; set; }
        public Guid CourseId { get; set; }
        public string Content { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation
        public Profile Profile { get; set; } = null!;
        public Course Course { get; set; } = null!;
    }
}

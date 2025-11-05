using System.ComponentModel.DataAnnotations;

namespace ProjectAPI.Models
{
    public class Profile
    {
        public Guid UserId { get; set; }

        [Required]
        public string FullName { get; set; } = string.Empty;

        [Required, EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Required]
        public string PasswordHash { get; set; } = string.Empty;

        public string Role { get; set; } = "student";
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation
        public ICollection<Enrolment> Enrolments { get; set; } = new List<Enrolment>();
        public ICollection<ChapterProgress> ChapterProgress { get; set; } = new List<ChapterProgress>();
        public ICollection<ForumPost> ForumPosts { get; set; } = new List<ForumPost>();
        public Leaderboard? Leaderboard { get; set; }
    }
}

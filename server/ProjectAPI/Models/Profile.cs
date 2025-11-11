using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Profile
    {
        [Key]
        public Guid UserId { get; set; }

        [Required]
        public string FullName { get; set; } = string.Empty;

        [Required, EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Required]
        public string PasswordHash { get; set; } = string.Empty;

        public string Role { get; set; } = "student"; // student, teacher, admin
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        // Token fields for authentication
        public string? AccessToken { get; set; }
        public string? RefreshToken { get; set; }

        // Navigation properties
        public ICollection<Enrolment> Enrolments { get; set; } = new List<Enrolment>();
        public ICollection<ChapterProgress> ChapterProgress { get; set; } = new List<ChapterProgress>();
        public ICollection<ForumPost> ForumPosts { get; set; } = new List<ForumPost>();
        public ICollection<ForumComment> ForumComments { get; set; } = new List<ForumComment>();
        public ICollection<Course> CoursesCreated { get; set; } = new List<Course>();
        
        // Navigation properties for HelpRequests
        [InverseProperty("Student")]
        public ICollection<HelpRequest> HelpRequestsAsStudent { get; set; } = new List<HelpRequest>();
        [InverseProperty("ResolvedByTeacher")]
        public ICollection<HelpRequest> HelpRequestsAsTeacher { get; set; } = new List<HelpRequest>();
        
        public ICollection<Announcement> Announcements { get; set; } = new List<Announcement>();
        public ICollection<AnnouncementRead> AnnouncementReads { get; set; } = new List<AnnouncementRead>();
        public ICollection<Testimonial> Testimonials { get; set; } = new List<Testimonial>();
        public ICollection<Notification> Notifications { get; set; } = new List<Notification>();
        public Leaderboard? Leaderboard { get; set; }
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class ForumPost
    {
        [Key]
        public Guid ForumId { get; set; }
        
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Course")]
        public Guid? CourseId { get; set; } // Nullable to allow general forum posts
        
        [Required]
        public string Content { get; set; } = string.Empty;
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Course? Course { get; set; } // Nullable to allow general forum posts
        public ICollection<ForumComment> Comments { get; set; } = new List<ForumComment>();
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Badge
    {
        [Key]
        public Guid BadgeId { get; set; }
        
        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;
        
        [MaxLength(500)]
        public string? Description { get; set; }
        
        [MaxLength(200)]
        public string? IconUrl { get; set; }
        
        [MaxLength(50)]
        public string? Category { get; set; } // e.g., "Course", "Quiz", "Streak", "Forum"
        
        public int RequiredValue { get; set; } = 0; // e.g., 10 for "10 courses completed"
        
        // Navigation properties
        public ICollection<UserBadge> UserBadges { get; set; } = new List<UserBadge>();
    }
}


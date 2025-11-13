using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    [Table("UserBadges")]
    public class UserBadge
    {
        [Key]
        public Guid UserBadgeId { get; set; }
        
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Badge")]
        public Guid BadgeId { get; set; }
        
        public DateTime EarnedAt { get; set; } = DateTime.UtcNow;
        
        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Badge Badge { get; set; } = null!;
    }
}


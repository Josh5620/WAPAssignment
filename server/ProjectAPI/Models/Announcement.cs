using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Announcement
    {
        [Key]
        public Guid AnnouncementId { get; set; }
        
        [ForeignKey("Admin")]
        public Guid AdminId { get; set; }
        
        [Required]
        public string Title { get; set; } = string.Empty;
        
        [Required]
        public string Message { get; set; } = string.Empty;
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Admin { get; set; } = null!;
    }
}

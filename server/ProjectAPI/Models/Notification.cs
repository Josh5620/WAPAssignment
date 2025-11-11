using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Notification
    {
        [Key]
        public Guid NotificationId { get; set; }
        
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [Required]
        public string Message { get; set; } = string.Empty;
        
        public bool IsRead { get; set; } = false;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Profile { get; set; } = null!;
    }
}

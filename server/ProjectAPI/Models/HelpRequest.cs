using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class HelpRequest
    {
        [Key]
        public Guid HelpRequestId { get; set; }
        
        [ForeignKey("Student")]
        public Guid StudentId { get; set; }
        
        [ForeignKey("Chapter")]
        public Guid ChapterId { get; set; }
        
        [Required]
        public string Question { get; set; } = string.Empty;
        
        public string Status { get; set; } = "Pending"; // "Pending", "Resolved"
        
        [ForeignKey("ResolvedByTeacher")]
        public Guid? ResolvedByTeacherId { get; set; }
        
        public string? Response { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? ResolvedAt { get; set; }

        // Navigation properties
        public Profile Student { get; set; } = null!;
        public Chapter Chapter { get; set; } = null!;
        public Profile? ResolvedByTeacher { get; set; }
    }
}

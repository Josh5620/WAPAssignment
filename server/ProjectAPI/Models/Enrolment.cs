using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Enrolment
    {
        [Key]
        public Guid EnrolmentId { get; set; } = Guid.NewGuid();

        [ForeignKey("Profile")]
        public Guid UserId { get; set; }

        [ForeignKey("Course")]
        public Guid CourseId { get; set; }

        [Required]
        public string Status { get; set; } = "active"; // "active", "completed", "withdrawn"
        public DateTime EnrolledAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Course Course { get; set; } = null!;
    }
}

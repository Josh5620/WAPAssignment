using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjectAPI.Models
{
    [PrimaryKey(nameof(UserId), nameof(CourseId))]
    public class Enrolment
    {
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Course")]
        public Guid CourseId { get; set; }
        
        public string Status { get; set; } = "active"; // "active", "completed", "withdrawn"
        public DateTime EnrolledAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Course Course { get; set; } = null!;
    }
}

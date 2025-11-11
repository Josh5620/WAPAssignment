using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Testimonial
    {
        [Key]
        public Guid TestimonialId { get; set; }
        
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Course")]
        public Guid? CourseId { get; set; } // Nullable - can be general testimonial
        
        [Range(1, 5)]
        public int Rating { get; set; }
        
        [Required]
        public string Comment { get; set; } = string.Empty;
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Course? Course { get; set; }
    }
}

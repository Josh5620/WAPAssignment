using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Course
    {
        [Key]
        public Guid CourseId { get; set; }
        
        [ForeignKey("Teacher")]
        public Guid TeacherId { get; set; }
        
        [Required]
        public string Title { get; set; } = string.Empty;
        
        public string? Description { get; set; }
        public string? PreviewContent { get; set; }
        public bool Published { get; set; } = true;
        
        // Admin approval workflow fields
        public string ApprovalStatus { get; set; } = "Pending"; // "Pending", "Approved", "Rejected"
        public string? RejectionReason { get; set; }

        // Navigation properties
        public Profile Teacher { get; set; } = null!;
        public ICollection<Chapter> Chapters { get; set; } = new List<Chapter>();
        public ICollection<Enrolment> Enrolments { get; set; } = new List<Enrolment>();
        public ICollection<ForumPost> ForumPosts { get; set; } = new List<ForumPost>();
        public ICollection<Testimonial> Testimonials { get; set; } = new List<Testimonial>();
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Certificate
    {
        [Key]
        public Guid CertificateId { get; set; } = Guid.NewGuid();

        [ForeignKey("Profile")]
        public Guid StudentId { get; set; }

        [ForeignKey("Course")]
        public Guid CourseId { get; set; }

        public DateTime IssueDate { get; set; } = DateTime.UtcNow;

        [Required]
        public string CertificateUrl { get; set; } = string.Empty;

        public Profile Student { get; set; } = null!;
        public Course Course { get; set; } = null!;
    }
}

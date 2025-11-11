using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Chapter
    {
        [Key]
        public Guid ChapterId { get; set; }
        
        [ForeignKey("Course")]
        public Guid CourseId { get; set; }
        
        public int Number { get; set; }
        
        [Required]
        public string Title { get; set; } = string.Empty;
        
        public string? Summary { get; set; }

        // Navigation properties
        public Course Course { get; set; } = null!;
        public ICollection<Resource> Resources { get; set; } = new List<Resource>();
        public ICollection<ChapterProgress> ChapterProgress { get; set; } = new List<ChapterProgress>();
        public ICollection<HelpRequest> HelpRequests { get; set; } = new List<HelpRequest>();
    }
}

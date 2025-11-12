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
        
        /// <summary>
        /// Time limit for quiz in seconds (null = no limit)
        /// </summary>
        public int? QuizTimeLimitSeconds { get; set; }
        
        /// <summary>
        /// Maximum number of quiz attempts allowed (null = unlimited)
        /// </summary>
        public int? MaxQuizAttempts { get; set; }

        // Navigation properties
        public Course Course { get; set; } = null!;
        public ICollection<Resource> Resources { get; set; } = new List<Resource>();
        public ICollection<ChapterProgress> ChapterProgress { get; set; } = new List<ChapterProgress>();
        public ICollection<HelpRequest> HelpRequests { get; set; } = new List<HelpRequest>();
        public ICollection<QuizAttempt> QuizAttempts { get; set; } = new List<QuizAttempt>();
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Question
    {
        [Key]
        public Guid QuestionId { get; set; }
        
        [ForeignKey("Resource")]
        public Guid ResourceId { get; set; }
        
        [Required]
        public string Stem { get; set; } = string.Empty;
        
        [Required]
        public string Difficulty { get; set; } = string.Empty; // "easy", "medium", "hard"
        
        public string? Explanation { get; set; }

        // Navigation properties
        public Resource Resource { get; set; } = null!;
        public ICollection<QuestionOption> QuestionOptions { get; set; } = new List<QuestionOption>();
    }
}

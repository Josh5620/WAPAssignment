using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Resource
    {
        [Key]
        public Guid ResourceId { get; set; }
        
        [ForeignKey("Chapter")]
        public Guid ChapterId { get; set; }
        
        [Required]
        public string Type { get; set; } = string.Empty; // "text", "flashcard", "mcq"
        
        public string? Content { get; set; }

        // Navigation properties
        public Chapter Chapter { get; set; } = null!;
        public ICollection<Flashcard> Flashcards { get; set; } = new List<Flashcard>();
        public ICollection<Question> Questions { get; set; } = new List<Question>();
    }
}

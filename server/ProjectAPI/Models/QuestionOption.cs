using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class QuestionOption
    {
        [Key]
        public Guid OptionId { get; set; }
        
        [ForeignKey("Question")]
        public Guid QuestionId { get; set; }
        
        [Required]
        public string OptionText { get; set; } = string.Empty;
        
        public bool IsCorrect { get; set; }

        // Navigation properties
        public Question Question { get; set; } = null!;
    }
}

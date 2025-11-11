using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Flashcard
    {
        [Key]
        public Guid FcId { get; set; }
        
        [ForeignKey("Resource")]
        public Guid ResourceId { get; set; }
        
        public string? FrontText { get; set; }
        public string? BackText { get; set; }
        public int OrderIndex { get; set; }

        // Navigation properties
        public Resource Resource { get; set; } = null!;
    }
}

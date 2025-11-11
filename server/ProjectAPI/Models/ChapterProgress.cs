using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjectAPI.Models
{
    [PrimaryKey(nameof(UserId), nameof(ChapterId))]
    public class ChapterProgress
    {
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Chapter")]
        public Guid ChapterId { get; set; }
        
        public bool Completed { get; set; } = false;
        public int McqsAttempted { get; set; } = 0;
        public int McqsCorrect { get; set; } = 0;
        public DateTime? CompletedAt { get; set; }

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Chapter Chapter { get; set; } = null!;
    }
}

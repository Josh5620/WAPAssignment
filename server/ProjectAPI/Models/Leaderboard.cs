using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    public class Leaderboard
    {
        [Key]
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        public int XP { get; set; } = 0;
        public int Streaks { get; set; } = 0;
        public string? Badges { get; set; }

        // Navigation properties
        public Profile Profile { get; set; } = null!;
    }
}

namespace ProjectAPI.Models
{
    public class Leaderboard
    {
        public Guid UserId { get; set; }
        public int XP { get; set; } = 0;
        public int Streaks { get; set; } = 0;
        public string? Badges { get; set; }

        // Navigation
        public Profile Profile { get; set; } = null!;
    }
}

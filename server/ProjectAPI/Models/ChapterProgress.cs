namespace ProjectAPI.Models
{
    public class ChapterProgress
    {
        public Guid UserId { get; set; }
        public Guid ChapterId { get; set; }
        public bool Completed { get; set; } = false;
        public int McqsAttempted { get; set; } = 0;
        public int McqsCorrect { get; set; } = 0;

        // Navigation
        public Profile Profile { get; set; } = null!;
        public Chapter Chapter { get; set; } = null!;
    }
}

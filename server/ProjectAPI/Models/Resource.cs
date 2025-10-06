namespace ProjectAPI.Models
{
    public class Resource
    {
        public Guid Id { get; set; }
        public Guid ChapterId { get; set; }
        public string Type { get; set; } = string.Empty; // "note", "flashcard", "mcq"
        public string? Content { get; set; }

        // Navigation
        public Chapter Chapter { get; set; } = null!;
        public ICollection<Flashcard> Flashcards { get; set; } = new List<Flashcard>();
        public ICollection<Question> Questions { get; set; } = new List<Question>();
    }
}

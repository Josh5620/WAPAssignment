namespace ProjectAPI.Models
{
    public class Flashcard
    {
        public Guid Id { get; set; }
        public Guid ResourceId { get; set; }
        public string? FrontText { get; set; }
        public string? BackText { get; set; }
        public int OrderIndex { get; set; }

        // Navigation
        public Resource Resource { get; set; } = null!;
    }
}

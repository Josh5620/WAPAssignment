namespace ProjectAPI.Models
{
    public class Chapter
    {
        public Guid Id { get; set; }
        public Guid CourseId { get; set; }
        public int Number { get; set; }
        public string Title { get; set; } = string.Empty;
        public string? Summary { get; set; }

        // Navigation
        public Course Course { get; set; } = null!;
        public ICollection<Resource> Resources { get; set; } = new List<Resource>();
        public ICollection<ChapterProgress> ChapterProgress { get; set; } = new List<ChapterProgress>();
    }
}

namespace ProjectAPI.Models
{
    public class Question
    {
        public Guid Id { get; set; }
        public Guid ResourceId { get; set; }
        public required string Stem { get; set; }
        public required string Difficulty { get; set; } // easy, medium, hard
        public string? Explanation { get; set; }

        public Resource Resource { get; set; } = null!;
        public ICollection<QuestionOption> QuestionOptions { get; set; } = new List<QuestionOption>();
    }
}

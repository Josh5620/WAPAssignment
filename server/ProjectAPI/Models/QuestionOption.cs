namespace ProjectAPI.Models
{
    public class QuestionOption
    {
        public Guid Id { get; set; }
        public Guid QuestionId { get; set; }
        public string OptionText { get; set; } = string.Empty;
        public bool IsCorrect { get; set; }

        // Navigation
        public Question Question { get; set; } = null!;
    }
}

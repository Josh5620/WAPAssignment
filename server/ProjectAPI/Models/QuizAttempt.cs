using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    /// <summary>
    /// Tracks individual quiz attempts with timer, scores, and attempt history
    /// </summary>
    public class QuizAttempt
    {
        [Key]
        public Guid AttemptId { get; set; }
        
        [ForeignKey("Profile")]
        public Guid UserId { get; set; }
        
        [ForeignKey("Chapter")]
        public Guid ChapterId { get; set; }
        
        /// <summary>
        /// Time limit for this quiz in seconds (null = no limit)
        /// </summary>
        public int? TimeLimitSeconds { get; set; }
        
        /// <summary>
        /// Time spent on the quiz in seconds
        /// </summary>
        public int? TimeSpentSeconds { get; set; }
        
        /// <summary>
        /// Score percentage (0-100)
        /// </summary>
        public int ScorePercentage { get; set; }
        
        /// <summary>
        /// Number of correct answers
        /// </summary>
        public int CorrectAnswers { get; set; }
        
        /// <summary>
        /// Total number of questions
        /// </summary>
        public int TotalQuestions { get; set; }
        
        /// <summary>
        /// Whether the quiz was passed (typically >= 70%)
        /// </summary>
        public bool Passed { get; set; }
        
        /// <summary>
        /// Whether the quiz was completed within the time limit
        /// </summary>
        public bool CompletedInTime { get; set; }
        
        /// <summary>
        /// When the attempt was started
        /// </summary>
        public DateTime StartedAt { get; set; } = DateTime.UtcNow;
        
        /// <summary>
        /// When the attempt was submitted
        /// </summary>
        public DateTime? SubmittedAt { get; set; }
        
        /// <summary>
        /// JSON string storing the detailed results (question-by-question)
        /// </summary>
        public string? ResultsJson { get; set; }

        // Navigation properties
        public Profile Profile { get; set; } = null!;
        public Chapter Chapter { get; set; } = null!;
    }
}


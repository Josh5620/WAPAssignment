namespace ProjectAPI.Models
{
    public class Enrolment
    {
        public Guid UserId { get; set; }
        public Guid CourseId { get; set; }
        public string Status { get; set; } = "active"; // active, completed, withdrawn

        // Navigation
        public Profile Profile { get; set; } = null!;
        public Course Course { get; set; } = null!;
    }
}

namespace ProjectAPI.Models
{
    public class Course
    {
        public Guid Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string? Description { get; set; }
        public string? PreviewContent { get; set; }
        public bool Published { get; set; } = true;

        // Navigation
        public ICollection<Chapter> Chapters { get; set; } = new List<Chapter>();
        public ICollection<Enrolment> Enrolments { get; set; } = new List<Enrolment>();
        public ICollection<ForumPost> ForumPosts { get; set; } = new List<ForumPost>();
    }
}

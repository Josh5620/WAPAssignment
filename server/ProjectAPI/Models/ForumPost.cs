using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    [Table("forum_posts")]  // Maps to existing 'forum_posts' table in Supabase
    public class ForumPost
    {
        [Key]
        [Column("id")]
        public long Id { get; set; }

        [Column("author_id")]
        [Required]
        public Guid AuthorId { get; set; }

        [Column("title")]
        [Required]
        [MaxLength(500)]
        public string Title { get; set; } = string.Empty;

        [Column("content")]
        [Required]
        public string Content { get; set; } = string.Empty;

        [Column("created_at")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation property
        [ForeignKey("AuthorId")]
        public virtual User Author { get; set; } = null!;
    }
}

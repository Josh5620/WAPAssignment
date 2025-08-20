using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    [Table("resources")]  // Maps to existing 'resources' table in Supabase
    public class Resource
    {
        [Key]
        [Column("id")]
        public long Id { get; set; }

        [Column("title")]
        [Required]
        [MaxLength(500)]
        public string Title { get; set; } = string.Empty;

        [Column("description")]
        public string Description { get; set; } = string.Empty;

        [Column("type")]
        [MaxLength(100)]
        public string Type { get; set; } = string.Empty;

        [Column("url")]
        [MaxLength(1000)]
        public string? Url { get; set; }

        [Column("file_path")]
        [MaxLength(1000)]
        public string? FilePath { get; set; }

        [Column("is_approved")]
        public bool IsApproved { get; set; } = false;

        [Column("created_by")]
        [Required]
        public Guid CreatedBy { get; set; }

        [Column("created_at")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation property
        [ForeignKey("CreatedBy")]
        public virtual User Creator { get; set; } = null!;
    }
}

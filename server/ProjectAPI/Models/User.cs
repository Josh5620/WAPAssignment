using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models
{
    [Table("profiles")]  // Maps to existing 'profiles' table in Supabase
    public class User
    {
        [Key]
        [Column("id")]
        public Guid Id { get; set; } = Guid.NewGuid();

        [Column("login_id")]
        [Required]
        [MaxLength(255)]
        public string Email { get; set; } = string.Empty;

        [Column("password_hash")]
        [Required]
        [MaxLength(255)]
        public string PasswordHash { get; set; } = string.Empty;

        [Column("full_name")]
        [Required]
        [MaxLength(255)]
        public string FullName { get; set; } = string.Empty;

        [Column("role")]
        [MaxLength(50)]
        public string Role { get; set; } = "student"; // Default role

        [Column("created_at")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Computed property - not stored in DB
        [NotMapped]
        public bool IsAdmin => Role?.ToLower() == "admin";

        [NotMapped]
        public bool IsTeacher => Role?.ToLower() == "teacher";

        [NotMapped]
        public bool IsStudent => Role?.ToLower() == "student";

        // Navigation properties
        public virtual ICollection<ForumPost> ForumPosts { get; set; } = new List<ForumPost>();
        public virtual ICollection<Resource> Resources { get; set; } = new List<Resource>();
    }
}

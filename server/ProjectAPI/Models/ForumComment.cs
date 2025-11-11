using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models;

public class ForumComment
{
    [Key]
    public Guid CommentId { get; set; }

    [ForeignKey(nameof(ForumPost))]
    public Guid ForumId { get; set; }

    [ForeignKey(nameof(Profile))]
    public Guid UserId { get; set; }

    public Guid? ParentCommentId { get; set; }

    [Required]
    public string Content { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    // Navigation
    public ForumPost ForumPost { get; set; } = null!;
    public Profile Profile { get; set; } = null!;
    public ForumComment? ParentComment { get; set; }
    public ICollection<ForumComment> Replies { get; set; } = new List<ForumComment>();
}


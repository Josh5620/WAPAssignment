using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAPI.Models;

public class AnnouncementRead
{
    [ForeignKey(nameof(Announcement))]
    public Guid AnnouncementId { get; set; }

    [ForeignKey(nameof(Profile))]
    public Guid UserId { get; set; }

    public DateTime ReadAt { get; set; } = DateTime.UtcNow;

    // Navigation
    public Announcement Announcement { get; set; } = null!;
    public Profile Profile { get; set; } = null!;
}


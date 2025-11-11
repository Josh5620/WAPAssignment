using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api/notifications")]
[Authorize]
public class NotificationsController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<NotificationsController> _logger;

    public NotificationsController(ApplicationDbContext context, ILogger<NotificationsController> logger)
    {
        _context = context;
        _logger = logger;
    }

    /// <summary>
    /// Get notifications for the current user.
    /// </summary>
    [HttpGet]
    public async Task<IActionResult> GetNotifications(
        [FromQuery] bool unreadOnly = false,
        CancellationToken ct = default)
    {
        var userIdResult = GetUserId();
        if (!userIdResult.Success)
        {
            return userIdResult.ErrorResult!;
        }

        try
        {
            var query = _context.Notifications
                .Where(n => n.UserId == userIdResult.UserId)
                .OrderByDescending(n => n.CreatedAt)
                .AsQueryable();

            if (unreadOnly)
            {
                query = query.Where(n => !n.IsRead);
            }

            var notifications = await query
                .Select(n => new
                {
                    notificationId = n.NotificationId,
                    message = n.Message,
                    isRead = n.IsRead,
                    createdAt = n.CreatedAt
                })
                .ToListAsync(ct);

            return Ok(new
            {
                total = notifications.Count,
                unread = notifications.Count(n => !n.isRead),
                notifications
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to fetch notifications for user {UserId}", userIdResult.UserId);
            return StatusCode(500, new { error = "Unable to load notifications at this time." });
        }
    }

    /// <summary>
    /// Mark a specific notification as read.
    /// </summary>
    [HttpPost("{notificationId:guid}/read")]
    public async Task<IActionResult> MarkNotificationRead(Guid notificationId, CancellationToken ct = default)
    {
        var userIdResult = GetUserId();
        if (!userIdResult.Success)
        {
            return userIdResult.ErrorResult!;
        }

        try
        {
            var notification = await _context.Notifications
                .FirstOrDefaultAsync(n => n.NotificationId == notificationId && n.UserId == userIdResult.UserId, ct);

            if (notification == null)
            {
                return NotFound(new { error = "Notification not found." });
            }

            if (!notification.IsRead)
            {
                notification.IsRead = true;
                await _context.SaveChangesAsync(ct);
            }

            return Ok(new
            {
                notificationId = notification.NotificationId,
                notification.IsRead
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to mark notification {NotificationId} as read", notificationId);
            return StatusCode(500, new { error = "Unable to update notification status." });
        }
    }

    /// <summary>
    /// Mark all notifications as read for the current user.
    /// </summary>
    [HttpPost("mark-all-read")]
    public async Task<IActionResult> MarkAllRead(CancellationToken ct = default)
    {
        var userIdResult = GetUserId();
        if (!userIdResult.Success)
        {
            return userIdResult.ErrorResult!;
        }

        try
        {
            var unreadNotifications = await _context.Notifications
                .Where(n => n.UserId == userIdResult.UserId && !n.IsRead)
                .ToListAsync(ct);

            if (unreadNotifications.Count == 0)
            {
                return Ok(new { message = "All notifications were already read." });
            }

            foreach (var notification in unreadNotifications)
            {
                notification.IsRead = true;
            }

            await _context.SaveChangesAsync(ct);

            return Ok(new
            {
                updated = unreadNotifications.Count,
                message = "All notifications marked as read."
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to mark all notifications as read for user {UserId}", userIdResult.UserId);
            return StatusCode(500, new { error = "Unable to update notifications right now." });
        }
    }

    private (bool Success, Guid UserId, IActionResult? ErrorResult) GetUserId()
    {
        var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
        {
            return (false, Guid.Empty, Unauthorized(new { error = "Invalid or missing user context." }));
        }

        return (true, userId, null);
    }
}


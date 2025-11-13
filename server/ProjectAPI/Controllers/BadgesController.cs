using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;
using System.Security.Claims;

namespace ProjectAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class BadgesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public BadgesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/badges
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllBadges()
        {
            var badges = await _context.Badges
                .OrderBy(b => b.Category)
                .ThenBy(b => b.RequiredValue)
                .ToListAsync();

            return Ok(badges);
        }

        // GET: api/students/badges
        [HttpGet("students/badges")]
        public async Task<IActionResult> GetStudentBadges()
        {
            var userId = GetUserId();
            if (userId == null)
                return Unauthorized();

            var userBadges = await _context.UserBadges
                .Where(ub => ub.UserId == userId)
                .Include(ub => ub.Badge)
                .OrderByDescending(ub => ub.EarnedAt)
                .Select(ub => new
                {
                    badgeId = ub.BadgeId,
                    name = ub.Badge.Name,
                    description = ub.Badge.Description,
                    iconUrl = ub.Badge.IconUrl,
                    category = ub.Badge.Category,
                    earnedAt = ub.EarnedAt
                })
                .ToListAsync();

            return Ok(userBadges);
        }

        // POST: api/badges/check/{userId}
        [HttpPost("check/{userId:guid}")]
        public async Task<IActionResult> CheckBadges(Guid userId)
        {
            var badgeService = new Services.BadgeService(_context);
            var newBadges = await badgeService.CheckAndAwardBadges(userId);

            return Ok(newBadges.Select(b => new
            {
                badgeId = b.BadgeId,
                name = b.Name,
                description = b.Description,
                iconUrl = b.IconUrl,
                category = b.Category
            }).ToList());
        }

        // POST: api/badges/{badgeId}/award
        [HttpPost("{badgeId:guid}/award")]
        [Authorize(Roles = "admin,teacher")]
        public async Task<IActionResult> AwardBadge(Guid badgeId, [FromBody] AwardBadgeRequest request)
        {
            var badge = await _context.Badges.FindAsync(badgeId);
            if (badge == null)
                return NotFound(new { message = "Badge not found" });

            var user = await _context.Profiles.FindAsync(request.UserId);
            if (user == null)
                return NotFound(new { message = "User not found" });

            // Check if user already has this badge
            var existingBadge = await _context.UserBadges
                .FirstOrDefaultAsync(ub => ub.UserId == request.UserId && ub.BadgeId == badgeId);

            if (existingBadge != null)
                return Conflict(new { message = "User already has this badge" });

            var userBadge = new UserBadge
            {
                UserId = request.UserId,
                BadgeId = badgeId,
                EarnedAt = DateTime.UtcNow
            };

            _context.UserBadges.Add(userBadge);
            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Badge awarded successfully",
                badge = new
                {
                    badgeId = badge.BadgeId,
                    name = badge.Name,
                    description = badge.Description,
                    iconUrl = badge.IconUrl,
                    category = badge.Category,
                    earnedAt = userBadge.EarnedAt
                }
            });
        }

        private Guid? GetUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value
                ?? User.FindFirst("UserId")?.Value;
            return userIdClaim != null ? Guid.Parse(userIdClaim) : null;
        }
    }

    public class AwardBadgeRequest
    {
        public Guid UserId { get; set; }
    }
}

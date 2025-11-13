using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Services
{
    public class BadgeService
    {
        private readonly ApplicationDbContext _context;

        public BadgeService(ApplicationDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Check and award badges based on various achievement triggers
        /// </summary>
        public async Task<List<Badge>> CheckAndAwardBadges(Guid userId)
        {
            var newlyEarnedBadges = new List<Badge>();

            // Get all badges
            var allBadges = await _context.Badges.ToListAsync();
            
            // Get user's existing badges
            var userBadgeIds = await _context.UserBadges
                .Where(ub => ub.UserId == userId)
                .Select(ub => ub.BadgeId)
                .ToListAsync();

            // Check each badge category
            foreach (var badge in allBadges)
            {
                // Skip if user already has this badge
                if (userBadgeIds.Contains(badge.BadgeId))
                    continue;

                bool shouldAward = false;

                switch (badge.Category?.ToLower())
                {
                    case "course":
                        shouldAward = await CheckCourseBadge(userId, badge);
                        break;
                    case "quiz":
                        shouldAward = await CheckQuizBadge(userId, badge);
                        break;
                    case "streak":
                        shouldAward = await CheckStreakBadge(userId, badge);
                        break;
                    case "forum":
                        shouldAward = await CheckForumBadge(userId, badge);
                        break;
                }

                if (shouldAward)
                {
                    // Award the badge
                    var userBadge = new UserBadge
                    {
                        UserId = userId,
                        BadgeId = badge.BadgeId,
                        EarnedAt = DateTime.UtcNow
                    };

                    _context.UserBadges.Add(userBadge);
                    newlyEarnedBadges.Add(badge);
                }
            }

            if (newlyEarnedBadges.Any())
            {
                await _context.SaveChangesAsync();
            }

            return newlyEarnedBadges;
        }

        private async Task<bool> CheckCourseBadge(Guid userId, Badge badge)
        {
            // Count completed courses (chapters completed)
            var completedChapters = await _context.ChapterProgress
                .Where(cp => cp.UserId == userId && cp.Completed)
                .CountAsync();

            // For "First Course" badge (RequiredValue = 1)
            if (badge.RequiredValue == 1 && completedChapters >= 1)
                return true;

            // For "10 Courses" badge (RequiredValue = 10)
            if (badge.RequiredValue == 10 && completedChapters >= 10)
                return true;

            // Generic check
            return completedChapters >= badge.RequiredValue;
        }

        private async Task<bool> CheckQuizBadge(Guid userId, Badge badge)
        {
            // Check for perfect quiz scores
            var quizAttempts = await _context.QuizAttempts
                .Where(qa => qa.UserId == userId)
                .ToListAsync();

            // Check if any quiz has perfect score (100%)
            var perfectQuizzes = quizAttempts
                .Where(qa => qa.ScorePercentage == 100)
                .Count();

            return perfectQuizzes >= badge.RequiredValue;
        }

        private async Task<bool> CheckStreakBadge(Guid userId, Badge badge)
        {
            // Get user's leaderboard entry
            var leaderboard = await _context.Leaderboards
                .FirstOrDefaultAsync(l => l.UserId == userId);

            if (leaderboard == null)
                return false;

            // Check if streak meets requirement (e.g., 7 days)
            return leaderboard.Streaks >= badge.RequiredValue;
        }

        private async Task<bool> CheckForumBadge(Guid userId, Badge badge)
        {
            // Count forum contributions (posts + comments)
            var postCount = await _context.ForumPosts
                .Where(fp => fp.UserId == userId)
                .CountAsync();

            var commentCount = await _context.ForumComments
                .Where(fc => fc.UserId == userId)
                .CountAsync();

            var totalContributions = postCount + commentCount;

            return totalContributions >= badge.RequiredValue;
        }
    }
}

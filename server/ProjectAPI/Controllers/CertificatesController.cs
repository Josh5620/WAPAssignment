using System.Security.Claims;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAPI.Data;
using ProjectAPI.Models;

namespace ProjectAPI.Controllers;

[ApiController]
[Route("api")]
[Authorize]
public class CertificatesController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<CertificatesController> _logger;

    public CertificatesController(ApplicationDbContext context, ILogger<CertificatesController> logger)
    {
        _context = context;
        _logger = logger;
    }

    [HttpPost("courses/{courseId:guid}/generate-certificate")]
    public async Task<IActionResult> GenerateCertificate(Guid courseId, CancellationToken ct = default)
    {
        var userIdResult = GetUserId();
        if (!userIdResult.Success)
        {
            return userIdResult.ErrorResult!;
        }

        try
        {
            var course = await _context.Courses
                .Include(c => c.Chapters)
                .FirstOrDefaultAsync(c => c.CourseId == courseId, ct);

            if (course == null)
            {
                return NotFound(new { error = "Course not found." });
            }

            var enrolment = await _context.Enrolments
                .Include(e => e.Course)
                .FirstOrDefaultAsync(e => e.CourseId == courseId && e.UserId == userIdResult.UserId, ct);

            if (enrolment == null)
            {
                return Forbid("You must be enrolled in this course to generate a certificate.");
            }

            var totalChapters = course.Chapters.Count;
            if (totalChapters > 0)
            {
                var completedChapters = await _context.ChapterProgress
                    .Where(cp => cp.UserId == userIdResult.UserId && cp.Chapter.CourseId == courseId && cp.Completed)
                    .CountAsync(ct);

                if (completedChapters < totalChapters)
                {
                    return BadRequest(new
                    {
                        error = "You must complete all chapters before generating a certificate.",
                        completedChapters,
                        totalChapters
                    });
                }
            }

            var existingCertificate = await _context.Certificates
                .FirstOrDefaultAsync(c => c.CourseId == courseId && c.StudentId == userIdResult.UserId, ct);

            if (existingCertificate != null)
            {
                return Ok(existingCertificate);
            }

            var certificate = new Certificate
            {
                CourseId = courseId,
                StudentId = userIdResult.UserId,
                IssueDate = DateTime.UtcNow,
                CertificateUrl = $"/certificates/{Guid.NewGuid():N}.pdf"
            };

            _context.Certificates.Add(certificate);
            enrolment.Status = "completed";
            await _context.SaveChangesAsync(ct);

            return Ok(certificate);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error generating certificate for user {UserId} and course {CourseId}", userIdResult.UserId, courseId);
            return StatusCode(500, new { error = "Unable to generate certificate at this time." });
        }
    }

    [HttpGet("certificates/{certificateId:guid}")]
    public async Task<IActionResult> GetCertificate(Guid certificateId, CancellationToken ct = default)
    {
        try
        {
            var certificate = await _context.Certificates
                .Include(c => c.Course)
                .Include(c => c.Student)
                .FirstOrDefaultAsync(c => c.CertificateId == certificateId, ct);

            if (certificate == null)
            {
                return NotFound(new { error = "Certificate not found." });
            }

            return Ok(new
            {
                certificate.CertificateId,
                certificate.CourseId,
                courseTitle = certificate.Course.Title,
                certificate.StudentId,
                studentName = certificate.Student.FullName,
                certificate.IssueDate,
                certificate.CertificateUrl
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error fetching certificate {CertificateId}", certificateId);
            return StatusCode(500, new { error = "Unable to load certificate." });
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

using Microsoft.EntityFrameworkCore;
using ProjectAPI.Models;

namespace ProjectAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) {}

        // ======================
        // DbSets for all 15 Models
        // ======================
        public DbSet<Profile> Profiles { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Chapter> Chapters { get; set; }
        public DbSet<Resource> Resources { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<QuestionOption> QuestionOptions { get; set; }
        public DbSet<Flashcard> Flashcards { get; set; }
        public DbSet<Enrolment> Enrolments { get; set; }
        public DbSet<ChapterProgress> ChapterProgress { get; set; }
        public DbSet<ForumPost> ForumPosts { get; set; }
        public DbSet<Leaderboard> Leaderboards { get; set; }
        public DbSet<Testimonial> Testimonials { get; set; }
        public DbSet<Announcement> Announcements { get; set; }
        public DbSet<HelpRequest> HelpRequests { get; set; }
        public DbSet<Notification> Notifications { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // ======================
            // Composite Primary Keys
            // ======================
            
            // Enrolment: Composite key (UserId, CourseId)
            modelBuilder.Entity<Enrolment>()
                .HasKey(e => new { e.UserId, e.CourseId });

            // ChapterProgress: Composite key (UserId, ChapterId)
            modelBuilder.Entity<ChapterProgress>()
                .HasKey(cp => new { cp.UserId, cp.ChapterId });

            // ======================
            // One-to-One Relationships
            // ======================
            
            // Profile <-> Leaderboard (1:1)
            modelBuilder.Entity<Leaderboard>()
                .HasOne(l => l.Profile)
                .WithOne(p => p.Leaderboard)
                .HasForeignKey<Leaderboard>(l => l.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // ======================
            // One-to-Many Relationships
            // ======================

            // Profile (Teacher) -> Courses
            modelBuilder.Entity<Course>()
                .HasOne(c => c.Teacher)
                .WithMany(p => p.CoursesCreated)
                .HasForeignKey(c => c.TeacherId)
                .OnDelete(DeleteBehavior.Restrict);

            // Course -> Chapters
            modelBuilder.Entity<Chapter>()
                .HasOne(ch => ch.Course)
                .WithMany(c => c.Chapters)
                .HasForeignKey(ch => ch.CourseId)
                .OnDelete(DeleteBehavior.Cascade);

            // Chapter -> Resources
            modelBuilder.Entity<Resource>()
                .HasOne(r => r.Chapter)
                .WithMany(ch => ch.Resources)
                .HasForeignKey(r => r.ChapterId)
                .OnDelete(DeleteBehavior.Cascade);

            // Resource -> Flashcards
            modelBuilder.Entity<Flashcard>()
                .HasOne(f => f.Resource)
                .WithMany(r => r.Flashcards)
                .HasForeignKey(f => f.ResourceId)
                .OnDelete(DeleteBehavior.Cascade);

            // Resource -> Questions
            modelBuilder.Entity<Question>()
                .HasOne(q => q.Resource)
                .WithMany(r => r.Questions)
                .HasForeignKey(q => q.ResourceId)
                .OnDelete(DeleteBehavior.Cascade);

            // Question -> QuestionOptions
            modelBuilder.Entity<QuestionOption>()
                .HasOne(qo => qo.Question)
                .WithMany(q => q.QuestionOptions)
                .HasForeignKey(qo => qo.QuestionId)
                .OnDelete(DeleteBehavior.Cascade);

            // Profile -> Enrolments
            modelBuilder.Entity<Enrolment>()
                .HasOne(e => e.Profile)
                .WithMany(p => p.Enrolments)
                .HasForeignKey(e => e.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Course -> Enrolments
            modelBuilder.Entity<Enrolment>()
                .HasOne(e => e.Course)
                .WithMany(c => c.Enrolments)
                .HasForeignKey(e => e.CourseId)
                .OnDelete(DeleteBehavior.Cascade);

            // Profile -> ChapterProgress
            modelBuilder.Entity<ChapterProgress>()
                .HasOne(cp => cp.Profile)
                .WithMany(p => p.ChapterProgress)
                .HasForeignKey(cp => cp.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Chapter -> ChapterProgress
            modelBuilder.Entity<ChapterProgress>()
                .HasOne(cp => cp.Chapter)
                .WithMany(ch => ch.ChapterProgress)
                .HasForeignKey(cp => cp.ChapterId)
                .OnDelete(DeleteBehavior.Cascade);

            // Profile -> ForumPosts
            modelBuilder.Entity<ForumPost>()
                .HasOne(fp => fp.Profile)
                .WithMany(p => p.ForumPosts)
                .HasForeignKey(fp => fp.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Course -> ForumPosts
            modelBuilder.Entity<ForumPost>()
                .HasOne(fp => fp.Course)
                .WithMany(c => c.ForumPosts)
                .HasForeignKey(fp => fp.CourseId)
                .OnDelete(DeleteBehavior.Cascade);

            // Profile -> Testimonials
            modelBuilder.Entity<Testimonial>()
                .HasOne(t => t.Profile)
                .WithMany(p => p.Testimonials)
                .HasForeignKey(t => t.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // Course -> Testimonials (nullable)
            modelBuilder.Entity<Testimonial>()
                .HasOne(t => t.Course)
                .WithMany(c => c.Testimonials)
                .HasForeignKey(t => t.CourseId)
                .OnDelete(DeleteBehavior.SetNull);

            // Profile (Admin) -> Announcements
            modelBuilder.Entity<Announcement>()
                .HasOne(a => a.Admin)
                .WithMany(p => p.Announcements)
                .HasForeignKey(a => a.AdminId)
                .OnDelete(DeleteBehavior.Restrict);

            // Configure HelpRequest relationships to prevent cascade delete cycles
            // Profile (Student) -> HelpRequests
            modelBuilder.Entity<HelpRequest>()
                .HasOne(hr => hr.Student)
                .WithMany(p => p.HelpRequestsAsStudent)
                .HasForeignKey(hr => hr.StudentId)
                .OnDelete(DeleteBehavior.NoAction); // <-- This prevents cascade cycles

            // Chapter -> HelpRequests
            modelBuilder.Entity<HelpRequest>()
                .HasOne(hr => hr.Chapter)
                .WithMany(ch => ch.HelpRequests)
                .HasForeignKey(hr => hr.ChapterId)
                .OnDelete(DeleteBehavior.NoAction); // <-- Also set to NoAction

            // Profile (Teacher) -> HelpRequests (nullable)
            modelBuilder.Entity<HelpRequest>()
                .HasOne(hr => hr.ResolvedByTeacher)
                .WithMany(p => p.HelpRequestsAsTeacher)
                .HasForeignKey(hr => hr.ResolvedByTeacherId)
                .OnDelete(DeleteBehavior.NoAction); // <-- Also set to NoAction

            // Profile -> Notifications
            modelBuilder.Entity<Notification>()
                .HasOne(n => n.Profile)
                .WithMany(p => p.Notifications)
                .HasForeignKey(n => n.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            // ======================
            // Indexes for Performance
            // ======================
            
            modelBuilder.Entity<Profile>()
                .HasIndex(p => p.Email)
                .IsUnique();

            modelBuilder.Entity<Course>()
                .HasIndex(c => c.ApprovalStatus);

            modelBuilder.Entity<Chapter>()
                .HasIndex(ch => new { ch.CourseId, ch.Number });

            modelBuilder.Entity<ForumPost>()
                .HasIndex(fp => fp.CreatedAt);

            modelBuilder.Entity<HelpRequest>()
                .HasIndex(hr => hr.Status);

            modelBuilder.Entity<Notification>()
                .HasIndex(n => new { n.UserId, n.IsRead });
        }
    }
}

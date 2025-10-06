using Microsoft.EntityFrameworkCore;
using ProjectAPI.Models;

namespace ProjectAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) {}

        public DbSet<Profile> Profiles { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Chapter> Chapters { get; set; }
        public DbSet<Resource> Resources { get; set; }
        public DbSet<Flashcard> Flashcards { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<QuestionOption> QuestionOptions { get; set; }
        public DbSet<Enrolment> Enrolments { get; set; }
        public DbSet<ChapterProgress> ChapterProgress { get; set; }
        public DbSet<ForumPost> ForumPosts { get; set; }
        public DbSet<Leaderboard> Leaderboards { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // ======================
            // Composite Keys
            // ======================
            modelBuilder.Entity<Enrolment>()
                .HasKey(e => new { e.UserId, e.CourseId });

            modelBuilder.Entity<ChapterProgress>()
                .HasKey(cp => new { cp.UserId, cp.ChapterId });

            // ======================
            // One-to-One
            // ======================
            // Leaderboard -> Profile (1-1)
            modelBuilder.Entity<Leaderboard>()
                .HasKey(l => l.UserId); // Explicit PK

            modelBuilder.Entity<Leaderboard>()
                .HasOne(l => l.Profile)
                .WithOne(p => p.Leaderboard)
                .HasForeignKey<Leaderboard>(l => l.UserId);

            // ======================
            // One-to-Many Relationships
            // ======================

            // Course -> Chapters
            modelBuilder.Entity<Chapter>()
                .HasOne(c => c.Course)
                .WithMany(c => c.Chapters)
                .HasForeignKey(c => c.CourseId);

            // Chapter -> Resources
            modelBuilder.Entity<Resource>()
                .HasOne(r => r.Chapter)
                .WithMany(c => c.Resources)
                .HasForeignKey(r => r.ChapterId);

            // Resource -> Flashcards
            modelBuilder.Entity<Flashcard>()
                .HasOne(f => f.Resource)
                .WithMany(r => r.Flashcards)
                .HasForeignKey(f => f.ResourceId);

            // Resource -> Questions
            modelBuilder.Entity<Question>()
                .HasOne(q => q.Resource)
                .WithMany(r => r.Questions)
                .HasForeignKey(q => q.ResourceId);

            // Question -> QuestionOptions
            modelBuilder.Entity<QuestionOption>()
                .HasOne(o => o.Question)
                .WithMany(q => q.QuestionOptions)
                .HasForeignKey(o => o.QuestionId);

            // Profile -> ForumPosts
            modelBuilder.Entity<ForumPost>()
                .HasOne(fp => fp.Profile)
                .WithMany(p => p.ForumPosts)
                .HasForeignKey(fp => fp.UserId);

            // Course -> ForumPosts
            modelBuilder.Entity<ForumPost>()
                .HasOne(fp => fp.Course)
                .WithMany(c => c.ForumPosts)
                .HasForeignKey(fp => fp.CourseId);

            // ======================
            // Many-to-Many via join tables
            // ======================

            // Profile <-> Courses (Enrolments)
            modelBuilder.Entity<Enrolment>()
                .HasOne(e => e.Profile)
                .WithMany(p => p.Enrolments)
                .HasForeignKey(e => e.UserId);

            modelBuilder.Entity<Enrolment>()
                .HasOne(e => e.Course)
                .WithMany(c => c.Enrolments)
                .HasForeignKey(e => e.CourseId);

            // Profile <-> Chapters (ChapterProgress)
            modelBuilder.Entity<ChapterProgress>()
                .HasOne(cp => cp.Profile)
                .WithMany(p => p.ChapterProgress)
                .HasForeignKey(cp => cp.UserId);

            modelBuilder.Entity<ChapterProgress>()
                .HasOne(cp => cp.Chapter)
                .WithMany(c => c.ChapterProgress)
                .HasForeignKey(cp => cp.ChapterId);
        }
    }
}

using Microsoft.EntityFrameworkCore;
using ProjectAPI.Models;

namespace ProjectAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<ForumPost> ForumPosts { get; set; }
        public DbSet<Resource> Resources { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure relationships
            modelBuilder.Entity<ForumPost>()
                .HasOne(fp => fp.Author)
                .WithMany(u => u.ForumPosts)
                .HasForeignKey(fp => fp.AuthorId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Resource>()
                .HasOne(r => r.Creator)
                .WithMany(u => u.Resources)
                .HasForeignKey(r => r.CreatedBy)
                .OnDelete(DeleteBehavior.Cascade);

            // Configure indexes for better performance
            // modelBuilder.Entity<User>()
            //     .HasIndex(u => u.Email)
            //     .IsUnique();

            modelBuilder.Entity<ForumPost>()
                .HasIndex(fp => fp.CreatedAt);

            modelBuilder.Entity<Resource>()
                .HasIndex(r => r.IsApproved);

            // Configure decimal precision for any future decimal columns
            // Not needed for current schema but good practice
        }
    }
}

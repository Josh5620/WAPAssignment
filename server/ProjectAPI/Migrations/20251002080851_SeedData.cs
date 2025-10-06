using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProjectAPI.Migrations
{
    /// <inheritdoc />
    public partial class SeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
            {
                // Load and run seed scripts
                migrationBuilder.Sql(System.IO.File.ReadAllText("Seeds/SQL/seed_python.sql"));
                migrationBuilder.Sql(System.IO.File.ReadAllText("Seeds/SQL/seed_java.sql"));
                migrationBuilder.Sql(System.IO.File.ReadAllText("Seeds/SQL/seed_html&css.sql"));
            }

        protected override void Down(MigrationBuilder migrationBuilder)
            {
                // Optional: cleanup if rollback happens
                migrationBuilder.Sql("DELETE FROM QuestionOptions;");
                migrationBuilder.Sql("DELETE FROM Questions;");
                migrationBuilder.Sql("DELETE FROM Flashcards;");
                migrationBuilder.Sql("DELETE FROM Resources;");
                migrationBuilder.Sql("DELETE FROM Chapters;");
                migrationBuilder.Sql("DELETE FROM Courses;");
            }

    }
}

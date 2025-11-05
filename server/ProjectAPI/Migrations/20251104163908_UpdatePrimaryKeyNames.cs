using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProjectAPI.Migrations
{
    /// <inheritdoc />
    public partial class UpdatePrimaryKeyNames : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Resources",
                newName: "ResourceId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Questions",
                newName: "QuestionId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "QuestionOptions",
                newName: "OptionId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Profiles",
                newName: "UserId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "ForumPosts",
                newName: "ForumId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Flashcards",
                newName: "FcId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Courses",
                newName: "CourseId");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Chapters",
                newName: "ChapterId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ResourceId",
                table: "Resources",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "QuestionId",
                table: "Questions",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "OptionId",
                table: "QuestionOptions",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "Profiles",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "ForumId",
                table: "ForumPosts",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "FcId",
                table: "Flashcards",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "CourseId",
                table: "Courses",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "ChapterId",
                table: "Chapters",
                newName: "Id");
        }
    }
}

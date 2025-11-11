using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProjectAPI.Migrations
{
    /// <inheritdoc />
    public partial class NotificationsAndComments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AnnouncementReads",
                columns: table => new
                {
                    AnnouncementId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ReadAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AnnouncementReads", x => new { x.AnnouncementId, x.UserId });
                    table.ForeignKey(
                        name: "FK_AnnouncementReads_Announcements_AnnouncementId",
                        column: x => x.AnnouncementId,
                        principalTable: "Announcements",
                        principalColumn: "AnnouncementId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AnnouncementReads_Profiles_UserId",
                        column: x => x.UserId,
                        principalTable: "Profiles",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ForumComments",
                columns: table => new
                {
                    CommentId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ForumId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ParentCommentId = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ForumComments", x => x.CommentId);
                    table.ForeignKey(
                        name: "FK_ForumComments_ForumComments_ParentCommentId",
                        column: x => x.ParentCommentId,
                        principalTable: "ForumComments",
                        principalColumn: "CommentId",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_ForumComments_ForumPosts_ForumId",
                        column: x => x.ForumId,
                        principalTable: "ForumPosts",
                        principalColumn: "ForumId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ForumComments_Profiles_UserId",
                        column: x => x.UserId,
                        principalTable: "Profiles",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AnnouncementReads_UserId",
                table: "AnnouncementReads",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_ForumComments_CreatedAt",
                table: "ForumComments",
                column: "CreatedAt");

            migrationBuilder.CreateIndex(
                name: "IX_ForumComments_ForumId",
                table: "ForumComments",
                column: "ForumId");

            migrationBuilder.CreateIndex(
                name: "IX_ForumComments_ParentCommentId",
                table: "ForumComments",
                column: "ParentCommentId");

            migrationBuilder.CreateIndex(
                name: "IX_ForumComments_UserId",
                table: "ForumComments",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AnnouncementReads");

            migrationBuilder.DropTable(
                name: "ForumComments");
        }
    }
}

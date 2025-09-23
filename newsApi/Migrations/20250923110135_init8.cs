using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace newsApi.Migrations
{
    /// <inheritdoc />
    public partial class init8 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_News_Admins_AdminId",
                table: "News");

            migrationBuilder.DropForeignKey(
                name: "FK_News_Categories_CategoryId1",
                table: "News");

            migrationBuilder.DropIndex(
                name: "IX_News_AdminId",
                table: "News");

            migrationBuilder.DropIndex(
                name: "IX_News_CategoryId1",
                table: "News");

            migrationBuilder.DropColumn(
                name: "AdminId",
                table: "News");

            migrationBuilder.DropColumn(
                name: "CategoryId1",
                table: "News");

            migrationBuilder.AlterColumn<Guid>(
                name: "EditorId",
                table: "News",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "TEXT");

            migrationBuilder.AlterColumn<Guid>(
                name: "CategoryId",
                table: "News",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "TEXT");

            migrationBuilder.CreateIndex(
                name: "IX_News_EditorId",
                table: "News",
                column: "EditorId");

            migrationBuilder.AddForeignKey(
                name: "FK_News_Admins_EditorId",
                table: "News",
                column: "EditorId",
                principalTable: "Admins",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_News_Admins_EditorId",
                table: "News");

            migrationBuilder.DropIndex(
                name: "IX_News_EditorId",
                table: "News");

            migrationBuilder.AlterColumn<Guid>(
                name: "EditorId",
                table: "News",
                type: "TEXT",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AlterColumn<Guid>(
                name: "CategoryId",
                table: "News",
                type: "TEXT",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "AdminId",
                table: "News",
                type: "TEXT",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<int>(
                name: "CategoryId1",
                table: "News",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_News_AdminId",
                table: "News",
                column: "AdminId");

            migrationBuilder.CreateIndex(
                name: "IX_News_CategoryId1",
                table: "News",
                column: "CategoryId1");

            migrationBuilder.AddForeignKey(
                name: "FK_News_Admins_AdminId",
                table: "News",
                column: "AdminId",
                principalTable: "Admins",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_News_Categories_CategoryId1",
                table: "News",
                column: "CategoryId1",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

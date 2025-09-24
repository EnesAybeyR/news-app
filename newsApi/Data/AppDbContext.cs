using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using newsApi.Entities;

namespace newsApi.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions options) : base(options)
    {

    }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Admin> Admins { get; set; }
    public DbSet<News> News { get; set; }
    public DbSet<NewsContent> newsContents{ get; set; }
    public DbSet<Image> Images { get; set; }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<News>().HasOne<Admin>().WithMany().HasForeignKey(n => n.EditorId).OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<News>().HasOne<Category>().WithMany().HasForeignKey(n => n.CategoryId).OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<NewsContent>().HasOne<News>().WithMany(n => n.NewsContents).HasForeignKey(nc => nc.NewId).OnDelete(DeleteBehavior.Cascade);
        modelBuilder.Entity<Image>().HasOne<News>().WithMany(n => n.Images).HasForeignKey(nc => nc.NewId).OnDelete(DeleteBehavior.Cascade);
    }
}

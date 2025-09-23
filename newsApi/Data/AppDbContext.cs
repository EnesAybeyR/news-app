using System;
using Microsoft.EntityFrameworkCore;
using newsApi.Entities;

namespace newsApi.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions options) : base(options)
    {

    }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Admin> Admins { get; set; }
}

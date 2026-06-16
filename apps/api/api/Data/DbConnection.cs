using Microsoft.EntityFrameworkCore;
using api.Models;

namespace api.Data
{
  public class WorldCitiesDbContext : DbContext
  {
    public WorldCitiesDbContext(DbContextOptions dbContextOptions) : base(dbContextOptions)
    {

    }

    public DbSet<WorldCity> WorldCities { get; set; }
  }
}
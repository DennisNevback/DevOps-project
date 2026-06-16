using api.Data;
using Microsoft.EntityFrameworkCore;
using Swashbuckle.AspNetCore.SwaggerGen;
using Prometheus;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.WebHost.UseUrls("http://0.0.0.0:80");

builder.Services.AddDbContext<WorldCitiesDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        sqlOptions => sqlOptions.EnableRetryOnFailure()
    ));


var app = builder.Build();

// Create the database with retry
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<WorldCitiesDbContext>();

    var retries = 10;
    var delay = TimeSpan.FromSeconds(5);

    for (int i = 0; i < retries; i++)
    {
        try
        {
            Console.WriteLine("Running migrations...");
            db.Database.Migrate();
            Console.WriteLine("Database ready.");
            break;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Database not ready ({i + 1}/{retries})");
            Console.WriteLine(ex.Message);

            if (i == retries - 1)
                throw;

            Thread.Sleep(delay);
        }
    }
}

app.UseMetricServer();
app.UseHttpMetrics();

app.MapOpenApi();
app.MapSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

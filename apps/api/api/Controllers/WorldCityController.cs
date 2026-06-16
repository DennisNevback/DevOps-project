using Microsoft.AspNetCore.Mvc;
using api.Data;
using api.Mappers;
using api.Dtos.WorldCity;
using api.Models;

namespace api.Controllers
{
  [Route("api/worldcity")]
  [ApiController]
  public class WorldCityController : ControllerBase
  {
    private readonly WorldCitiesDbContext _context;

    public WorldCityController(WorldCitiesDbContext context)
    {
      _context = context;
    }

    [HttpGet]
    public IActionResult GetAll()
    {
      var worldCities = _context.WorldCities.Select(worldCity => worldCity.ToWorldCityDto()).ToList().OrderByDescending(worldCity => worldCity.Population);

      return Ok(worldCities);
    }

    [HttpGet("{id}")]
    public IActionResult GetById([FromRoute] int id)
    {
      var worldCities = _context.WorldCities.Find(id);
      if (worldCities == null)
      {
        return NotFound();
      }
      return Ok(worldCities.ToWorldCityDto());
    }

    [HttpPost]
    public IActionResult Register([FromBody] AddWorldCityDto worldCityDto)
    {
      WorldCity city = worldCityDto.ToCreateWorldCityRequestDto();
      _context.WorldCities.Add(city);
      _context.SaveChanges();
      return CreatedAtAction(nameof(GetById), new { id = city.CityId }, city.ToWorldCityDto());
    }

    [HttpPut("{id}")]
    public IActionResult Update([FromRoute] int id, [FromBody] UpdateWorldCityDto worldCityUpdateDto)
    {
      var city = _context.WorldCities.Find(id);
      if (city == null)
      {
        return NotFound();
      }
      city.City = worldCityUpdateDto.City;
      city.Country = worldCityUpdateDto.Country;
      city.Population = worldCityUpdateDto.Population;
      _context.SaveChanges();

      return Ok(new WorldCityDto
      {
        City = city.City,
        Country = city.Country,
        Population = city.Population
      });
    }

    [HttpDelete("{id}")]
    public IActionResult Delete([FromRoute] int id)
    {
      var worldCities = _context.WorldCities.Find(id);
      if (worldCities == null)
      {
        return NotFound();
      }
      _context.WorldCities.Remove(worldCities);
      _context.SaveChanges();
      return NoContent();
    }
  }
}
using api.Dtos.WorldCity;
using api.Models;

namespace api.Mappers
{
  public static class WorldCitiesMappers
  {
    public static WorldCityDto ToWorldCityDto(this WorldCity worldCityModel)
    {
      return new WorldCityDto
      {
        City = worldCityModel.City,
        Country = worldCityModel.Country,
        Population = worldCityModel.Population
      };
    }

    public static WorldCity ToCreateWorldCityRequestDto(this AddWorldCityDto worldCityModel)
    {
      return new WorldCity
      {
        City = worldCityModel.City,
        Country = worldCityModel.Country,
        Population = worldCityModel.Population
      };
    }

    public static WorldCity UpdateWorldCityRequestDto(this UpdateWorldCityDto worldCityModel)
    {
      return new WorldCity
      {
        City = worldCityModel.City,
        Country = worldCityModel.Country,
        Population = worldCityModel.Population
      };
    }

  }
}
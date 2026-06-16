namespace api.Dtos.WorldCity
{
  public class UpdateWorldCityDto()
  {
    public string City { get; set; } = string.Empty;
    public string Country { get; set; } = string.Empty;
    public int Population { get; set; }
  }
}
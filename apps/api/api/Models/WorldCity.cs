using System.ComponentModel.DataAnnotations;

namespace api.Models
{
  public class WorldCity
  {
    [Key]
    public int CityId { get; set; }
    public string City { get; set; } = string.Empty;
    public string Country { get; set; } = string.Empty;
    public int Population { get; set; }
  }
}
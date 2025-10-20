namespace WebApi.Models
{
    public class Availability
    {
        public int Id { get; set; }
        public int VendorListingId { get; set; }
        public DateTime AvailableFrom { get; set; }
        public DateTime AvailableTo { get; set; }
    }
}

namespace WebApi.Models
{
    public class ListingPhoto
    {
        public int Id { get; set; }
        public int VendorListingId { get; set; }
        public string? Url { get; set; }
    }
}

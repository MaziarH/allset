namespace WebApi.Models
{
    public class FavoriteVendor
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int VendorId { get; set; }
        public DateTime FavoritedOn { get; set; }
    }
}

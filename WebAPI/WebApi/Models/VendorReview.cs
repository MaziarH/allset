namespace WebApi.Models
{
    public class VendorReview
    {
        public int Id { get; set; }
        public int VendorId { get; set; }
        public int UserId { get; set; }
        public int Rating { get; set; }
        public string? Title { get; set; }
        public string? Comment { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}

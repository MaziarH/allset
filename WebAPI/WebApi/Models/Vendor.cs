namespace WebApi.Models
{
    public class Vendor
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string? BusinessName { get; set; }
        public string? ContactName { get; set; }
        public string? BusinessPhone { get; set; }
        public string? BusinessEmail { get; set; }
        public string? BusinessAddress { get; set; }
        public string? ServiceArea { get; set; } // from the City enum
        public string? ServiceType { get; set; } // from the ServiceType enum: Catering, Rentals, Entertainment, Staffing.
        public string? Description { get; set; }
        public string? Website { get; set; }
        public string? Instagram { get; set; }
        public string? Facebook { get; set; }
        public string? Linkedin { get; set; }

        public double RatingAverage { get; set; }
        public int ReviewCount { get; set; }

        public ICollection<VendorListing>? Listings { get; set; }

    }
}

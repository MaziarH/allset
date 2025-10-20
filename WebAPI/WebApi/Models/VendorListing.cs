using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models
{
    public class VendorListing
    {
        public int Id { get; set; }
        public int VendorId { get; set; }
        public string? ServiceType { get; set; }  // from the ServiceType enum: Catering, Rentals, Entertainment, Staffing.
        public string? CuisineStyle { get; set; }  // froom the CuisineStyle enum: BBQ, Buffet, Beverages, FastFood, StreetFood, Healthy, ...
        public string? CuisineRegion { get; set; } // from the CuisineRegion enum: Italian, Chinese, Indian, Mediterranean, Persian, Caribbean, ...
        public string? Dining { get; set; }  // from the Dining enum: LiveCooking, FoodTruck, Delivery, Pickup
        public string? DietaryType { get; set; }  // from the DietaryType enum: Vegan, Vegetarian, GlutenFree, NutFree, Halal, Kosher

        [Column(TypeName = "decimal(18,4)")]
        public decimal PriceFrom { get; set; }
        [Column(TypeName = "decimal(18,4)")]
        public decimal PriceTo { get; set; }
        public string? Description { get; set; }
        public bool Featured { get; set; }
        public bool InstantQuoteAvailable { get; set; }

        public Vendor Vendor { get; set; } = null!;

        //public ICollection<ListingPhoto>? Photos { get; set; }
        //public ICollection<Availability>? Availability { get; set; }
    }
}

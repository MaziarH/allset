using System.ComponentModel.DataAnnotations;

namespace WebApi.Models.Constants
{
    public enum UserRole
    {
        [Display(Name = "Customer")]
        Customer,
        [Display(Name = "Vendor")]
        Vendor,
        [Display(Name = "Admin")]
        Admin
    }


    public enum Region
    {
        [Display(Name = "Ontario")]
        Ontario
    }

    public enum City
    {
        [Display(Name = "Toronto")]
        Toronto,
        [Display(Name = "Mississauga")]
        Mississauga,
        [Display(Name = "Markham")]
        Markham,
        [Display(Name = "Brampton")]
        Brampton,
        [Display(Name = "Vaughan")]
        Vaughan,
        [Display(Name = "Burlington")]
        Burlington,
        [Display(Name = "Oakville")]
        Oakville,
        [Display(Name = "Milton")]
        Milton,
        [Display(Name = "Newmarket")]
        Newmarket,
        [Display(Name = "Richmond Hill")]
        RichmondHill,
        [Display(Name = "Pickering")]
        Pickering,
        [Display(Name = "Ajax")]
        Ajax,
        [Display(Name = "Aurora")]
        Aurora
    }

    public enum ServiceType
    {
        [Display(Name = "Catering")]
        Catering,
        [Display(Name = "Rentals")]
        Rentals,
        [Display(Name = "Entertainment")]
        Entertainment,
        [Display(Name = "Staffing")]
        Staffing,
        [Display(Name = "Photography")]
        Photography
    }

    public enum CuisineStyle
    {
        [Display(Name = "BBQ")]
        BBQ,
        [Display(Name = "Buffet")]
        Buffet,
        [Display(Name = "Beverages")]
        Beverages,
        [Display(Name = "Fast Food")]
        FastFood,
        [Display(Name = "Street Food")]
        StreetFood,
        [Display(Name = "Healthy")]
        Healthy,
        [Display(Name = "Comfort Food")]
        ComfortFood,
        [Display(Name = "Dessert")]
        Dessert,
        [Display(Name = "Sweets")]
        Sweets
    }

    public enum CuisineRegion
    {
        [Display(Name = "Canadian")]
        Canadian,
        [Display(Name = "Caribbean")]
        Caribbean,
        [Display(Name = "Chinese")]
        Chinese,
        [Display(Name = "Indian")]
        Indian,
        [Display(Name = "Italian")]
        Italian,
        [Display(Name = "Jamaican")]
        Jamaican,
        [Display(Name = "Mediterranean")]
        Mediterranean,
        [Display(Name = "Mexican")]
        Mexican,
        [Display(Name = "Korean")]
        Korean,
        [Display(Name = "Thai")]
        Thai,
        [Display(Name = "Turkish")]
        Turkish,
        [Display(Name = "Persian")]
        Persian,
        [Display(Name = "Arabian")]
        Arabian
    }

    public enum Dining
    {
        [Display(Name = "Live Cooking")]
        LiveCooking,
        [Display(Name = "Food Truck")]
        FoodTruck,
        [Display(Name = "Delivery")]
        Delivery,
        [Display(Name = "Pickup")]
        Pickup
    }

    public enum PriceRange
    {
        [Display(Name = "$$ - Average")]
        Average,

        [Display(Name = "$ - Low")]
        Low
    }


    public enum EventType
    {
        [Display(Name = "Wedding")]
        Wedding,
        [Display(Name = "Corporate Event")]
        CorporateEvent,
        [Display(Name = "Birthday Party")]
        BirthdayParty,
        [Display(Name = "Anniversary")]
        Anniversary,
        [Display(Name = "Baby Shower")]
        BabyShower,
        [Display(Name = "Graduation Party")]
        GraduationParty, 
        [Display(Name = "Cultural Celebration")]
        CulturalCelebration,
        [Display(Name = "Holiday Party")]
        HolidayParty,
        [Display(Name = "Other")]
        Other
    }

    public enum DietaryType
    {
        [Display(Name = "Vegetarian")]
        Vegetarian,
        [Display(Name = "Vegan")]
        Vegan,
        [Display(Name = "Gluten free")]
        GlutenFree,
        [Display(Name = "Nut free")]
        NutFree,
        [Display(Name = "Halal")]
        Halal,
        [Display(Name = "Kosher")]
        Kosher
    }
}


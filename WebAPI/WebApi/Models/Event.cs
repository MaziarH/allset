using System.ComponentModel.DataAnnotations.Schema;

namespace WebApi.Models
{
    public class Event
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string? EventType { get; set; }  // from the EventType enum: Wedding, CorporateEvent, Birthday, Anniversary, Other
        public DateTime? EventDate { get; set; }
        public string? DietaryRestrictions { get; set; }  // from DietaryType enum: Vegan, Vegetarian, GlutenFree, NutFree, Halal, Kosher

        [Column(TypeName = "decimal(18,4)")] 
        public decimal? BudgetMin { get; set; }
        
        [Column(TypeName = "decimal(18,4)")]
        public decimal? BudgetMax { get; set; }
    }
}

using Microsoft.Extensions.Logging;
using System.Numerics;

namespace WebApi.Models
{
    public class User
    {
        public int Id { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; } // Unique
        public string? Phone { get; set; }
        public string? PasswordHash { get; set; }
        public string? Address { get; set; }
        public string? Role { get; set; } // Customer, Vendor, Admin
        public DateTime CreatedAt { get; set; }

    }
}

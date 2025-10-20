namespace WebApi.Models.DTO
{
    // DTO for registration request
    public class RegisterDto
    {
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public string? Password { get; set; } // plain text from Flutter
        public string? Address { get; set; }
        public string? Role { get; set; } // Customer, Vendor, Admin

    }
}

class AppConfig {
  // switch this flag depending on environment
  static const bool isProduction = true;

  //static const String localBaseUrl = "http://10.0.2.2:5047/api";  // 10.0.2.2  62066 | 7078
  static const String localBaseUrl = "https://localhost:7078/api";  
  static const String prodBaseUrl = "https://allset.aitnt.ca/api";

  static String get baseUrl => isProduction ? prodBaseUrl : localBaseUrl;

  // User endpoints
  static String get registerUrl => "$baseUrl/Users/register";
  static String get loginUrl => "$baseUrl/Users/login";

  // Vendor endpoints
  static String vendorById(int id) => "$baseUrl/Vendors/$id";              // GET/PUT/DELETE by vendorId
  static String vendorByUserId(int userId) => "$baseUrl/Vendors/byUser/$userId"; // GET by userId
  static String createVendor(int userId) => "$baseUrl/Vendors/byUser/$userId";   // POST by userId

  // Optional: if you add a "get-or-create" endpoint on the server:
  static String ensureVendor(int userId) => "$baseUrl/Vendors/ensure/$userId";  // POST ensure
}

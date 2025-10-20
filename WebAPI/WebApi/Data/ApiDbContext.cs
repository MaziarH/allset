using WebApi.Models;
using Microsoft.EntityFrameworkCore;
using static System.Net.Mime.MediaTypeNames;
using System;

namespace WebApi.Data
{
    public class ApiDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Vendor> Vendors { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<VendorListing> VendorListings { get; set; }
        public DbSet<ListingPhoto> listingPhotos { get; set; }
        public DbSet<VendorReview> VendorReviews { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<Availability> Availabilities { get; set; }

        //public DbSet<Subscription> Subscriptions { get; set; }
        //public DbSet<Payment> Payments { get; set; }
        //public DbSet<FavoriteVendor> FavoriteVendors { get; set; }

        public ApiDbContext(DbContextOptions<ApiDbContext> options)
          : base(options)
        {
        }
        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    //string connection = @"Server=p1405.use1.mysecurecloudhost.com;Initial Catalog=adwallca_FoodirDb;User ID=adwallca_maziar;Password=M@zy4966;TrustServerCertificate=True;";
        //    string connection = @"Server=(localdb)\MSSQLLocalDB;Database=FoodirDb;";
        //    optionsBuilder.UseSqlServer(connection);
        //}


    }
}

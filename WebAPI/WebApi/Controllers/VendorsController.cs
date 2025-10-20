using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApi.Data;
using WebApi.Models;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VendorsController : ControllerBase
    {
        private readonly ApiDbContext _context;
        private IConfiguration _config;

        public VendorsController(ApiDbContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        // GET: api/Vendors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Vendor>>> GetVendors()
        {
            return await _context.Vendors.ToListAsync();
        }

        // GET: api/vendors/5   (by vendorId)
        [HttpGet("{id:int}")]
        public async Task<ActionResult<Vendor>> GetVendor(int id)
        {
            var vendor = await _context.Vendors.FindAsync(id);

            if (vendor == null)
            {
                return NotFound();
            }

            return vendor;
        }

        // GET: api/vendors/byUser/7   (by userId)
        [HttpGet("byUser/{userId:int}")]
        public async Task<ActionResult<Vendor>> GetVendorByUserId(int userId)
        {
            var vendor = await _context.Vendors.FirstOrDefaultAsync(u => u.UserId == userId);

            if (vendor == null)
            {
                return NotFound();
            }

            return vendor;
        }


        // POST: api/vendors/byUser/7
        [HttpPost("byUser/{userId:int}")]
        public async Task<ActionResult<Vendor>> PostVendor(int userId, Vendor vendor)
        {
            // ensure the vendor is linked to the correct user
            vendor.UserId = userId;

            _context.Vendors.Add(vendor);
            await _context.SaveChangesAsync();

            // return Created with the vendor resource location
            return CreatedAtAction(nameof(GetVendor), new { id = vendor.Id }, vendor);
        }

        // PUT: api/vendors/5
        [HttpPut("{id:int}")]
        public async Task<IActionResult> PutVendor(int id, Vendor vendor)
        {
            if (id != vendor.Id)
            {
                return BadRequest();
            }

            _context.Entry(vendor).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VendorExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }


        // DELETE: api/vendors/5
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> DeleteVendor(int id)
        {
            var vendor = await _context.Vendors.FindAsync(id);
            if (vendor == null)
            {
                return NotFound();
            }

            _context.Vendors.Remove(vendor);
            await _context.SaveChangesAsync();

            return NoContent();
        }


        private bool VendorExists(int id)
        {
            return _context.Vendors.Any(e => e.Id == id);
        }

        //
        // ---------------------------------------------------------------
        // GET: api/vendors/search
        [HttpGet("search")]
        public async Task<IActionResult> GetVendors(
                              [FromQuery] string? serviceArea,
                              [FromQuery] string? serviceType,
                              [FromQuery] string? cuisineStyle,
                              [FromQuery] string? cuisineRegion)
        {
            var query = _context.Vendors
                .Include(v => v.Listings)   
                .AsQueryable();

            if (!string.IsNullOrEmpty(serviceArea))
                query = query.Where(v => v.ServiceArea == serviceArea);

            if (!string.IsNullOrEmpty(serviceType))
                query = query.Where(v => v.Listings.Any(l => l.ServiceType == serviceType));

            if (!string.IsNullOrEmpty(cuisineStyle))
                query = query.Where(v => v.Listings.Any(l => l.CuisineStyle == cuisineStyle));

            if (!string.IsNullOrEmpty(cuisineRegion))
                query = query.Where(v => v.Listings.Any(l => l.CuisineRegion == cuisineRegion));

            var vendors = await query.ToListAsync();

            return Ok(vendors);
        }
    }
}

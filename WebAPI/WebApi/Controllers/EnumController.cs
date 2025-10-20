using Microsoft.AspNetCore.Mvc;
using WebApi.Helpers;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EnumController : ControllerBase
    {
        [HttpGet("{enumName}")]
        public IActionResult GetEnumValues(string enumName)
        {
            var values = EnumHelper.GetEnumValuesWithDisplay(enumName);

            if (!values.Any())
                return NotFound(new { Message = $"Enum '{enumName}' not found." });

            return Ok(values);
        }
    }

}

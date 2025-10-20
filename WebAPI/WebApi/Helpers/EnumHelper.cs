using System.ComponentModel.DataAnnotations;
using System.Reflection;

namespace WebApi.Helpers
{
    public static class EnumHelper
    {
        public static List<string> GetEnumValuesWithDisplay(string enumName)
        {
            var assembly = Assembly.GetExecutingAssembly(); // or typeof(Dining).Assembly if enums are in another assembly
            var enumType = assembly.GetTypes()
                                   .FirstOrDefault(t => t.IsEnum && t.Name.Equals(enumName, StringComparison.OrdinalIgnoreCase));

            if (enumType == null)
                return new List<string>();

            return Enum.GetValues(enumType)
                       .Cast<Enum>()
                       .Select(value =>
                       {
                           var field = enumType.GetField(value.ToString());
                           var displayAttr = field.GetCustomAttribute<DisplayAttribute>();
                           return displayAttr?.Name ?? value.ToString();
                       })
                       .ToList();
        }
    }
}

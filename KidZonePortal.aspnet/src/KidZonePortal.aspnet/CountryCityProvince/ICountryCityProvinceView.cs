using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TestSprocGenerator.Business.SingleTable.Bo;

namespace KidZonePortal.aspnet.CountryCityProvinceManagement
{
    public interface ICountryCityProvinceView
    {
        List<Country> Countries {get; set;}
        List<City> Cities { get; set; }        
        
        string TitleForDisplay { get; set; }        
    }
}

using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using CommonLibrary.Base.Database;
using CommonLibrary;
using CountryCityProvinceBusinessLayer;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace CountryCityProvinceServiceUnitTests
{
    [TestClass]
    public class UnitTestsCountryCityProvinceService
    {
        [TestMethod]
        public void TestGetCountries()
        {
            ConnectionStringHelper.GetConnectionStrings();
            CountryCityProvinceService.CountryCityProvinceService serviceInstance =
                new CountryCityProvinceService.CountryCityProvinceService();
            DatabaseSmoObjectsAndSettings settings = 
                serviceInstance.CountryCityProvinceManager_Property.SmoSettings[CountryCityProvinceManager.CONNECTION_STRING_NAME];
            List<Country> returnedValue = serviceInstance.GetCountries();
        }

        [TestMethod]
        public void TestGetCities()
        {
            ConnectionStringHelper.GetConnectionStrings();
            CountryCityProvinceService.CountryCityProvinceService serviceInstance =
                new CountryCityProvinceService.CountryCityProvinceService();
            DatabaseSmoObjectsAndSettings settings =
                serviceInstance.CountryCityProvinceManager_Property.SmoSettings[CountryCityProvinceManager.CONNECTION_STRING_NAME];
            List<City> returnedValue = serviceInstance.GetCities(1);
        }
    }
}

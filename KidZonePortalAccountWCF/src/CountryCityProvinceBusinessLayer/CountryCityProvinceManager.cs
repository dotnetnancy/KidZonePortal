using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Configuration;
using log4net;
using System.Data.SqlClient;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace CountryCityProvinceBusinessLayer
{
    public class CountryCityProvinceManager
    {
        static ILog _log = null;
        ConnectionStringsSection _connectionStrings = null;
        Dictionary<string, CommonLibrary.DatabaseSmoObjectsAndSettings> _smoSettings = null;

        public Dictionary<string, CommonLibrary.DatabaseSmoObjectsAndSettings> SmoSettings
        {
            get { return _smoSettings; }
            set { _smoSettings = value; }
        }

        public const string CONNECTION_STRING_NAME = "CityCountryStateProvinceDatabase";
        private const string DEFAULT_ACCOUNT_CODE = "INTERNET_USER";

        static CountryCityProvinceManager()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public CountryCityProvinceManager()
        {
            _connectionStrings = CommonLibrary.Base.Database.ConnectionStringHelper.GetConnectionStrings();
            populateSmoSettings();
        }

        private void populateSmoSettings()
        {
            foreach (ConnectionStringSettings conSetting in _connectionStrings.ConnectionStrings)
            {
                if (_smoSettings == null)
                {
                    _smoSettings = new Dictionary<string, CommonLibrary.DatabaseSmoObjectsAndSettings>();
                }
                else
                    if (!_smoSettings.ContainsKey(conSetting.Name))
                    {
                        SqlConnectionStringBuilder sb = new SqlConnectionStringBuilder(conSetting.ConnectionString);

                        _smoSettings.Add(conSetting.Name, new CommonLibrary.DatabaseSmoObjectsAndSettings(
                            sb.InitialCatalog, sb.DataSource, sb.InitialCatalog,
                            sb.UserID, sb.Password, sb.IntegratedSecurity));

                    }
            }
        }

        public List<TestSprocGenerator.Business.SingleTable.Bo.Country> GetCountries()
        {
            CountryCityProvinceDataLayer.CityCountryProvinceStateDataAccess dataLayer =
                new CountryCityProvinceDataLayer.CityCountryProvinceStateDataAccess();

            Country bo = new Country(_smoSettings[CONNECTION_STRING_NAME]);

            TestSprocGenerator.Business.SingleTable.Bo.List.Country countryBoList = 
                new TestSprocGenerator.Business.SingleTable.Bo.List.Country(_smoSettings[CONNECTION_STRING_NAME]);

            countryBoList.FillByGetAll(bo);
            return countryBoList.ConvertAll(new Converter<TestSprocGenerator.Data.SingleTable.Dto.Country,
            TestSprocGenerator.Business.SingleTable.Bo.Country>(CountryFromDtoToBo));            
        }

        public static TestSprocGenerator.Business.SingleTable.Bo.Country CountryFromDtoToBo(TestSprocGenerator.Data.SingleTable.Dto.Country dto)
        {
            return (TestSprocGenerator.Business.SingleTable.Bo.Country)dto;
        }        

        public List<TestSprocGenerator.Business.SingleTable.Bo.City> GetCities(System.Nullable<int> countryID)
        {
            CountryCityProvinceDataLayer.CityCountryProvinceStateDataAccess dataLayer =
                new CountryCityProvinceDataLayer.CityCountryProvinceStateDataAccess();

            City bo = new City(_smoSettings[CONNECTION_STRING_NAME]);
            bo.CountryID = countryID;

            TestSprocGenerator.Business.SingleTable.Bo.List.City cityBoList =
                new TestSprocGenerator.Business.SingleTable.Bo.List.City(_smoSettings[CONNECTION_STRING_NAME]);


            cityBoList.FillByCriteriaExact(bo);
            return cityBoList.ConvertAll(new Converter<TestSprocGenerator.Data.SingleTable.Dto.City,
            TestSprocGenerator.Business.SingleTable.Bo.City>(CityFromDtoToBo));
        }

        public static TestSprocGenerator.Business.SingleTable.Bo.City CityFromDtoToBo(TestSprocGenerator.Data.SingleTable.Dto.City dto)
        {
            return (TestSprocGenerator.Business.SingleTable.Bo.City)dto;
        }
    }
}

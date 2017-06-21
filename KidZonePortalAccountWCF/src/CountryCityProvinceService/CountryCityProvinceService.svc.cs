using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.ServiceModel.Activation;
using CountryCityProvinceBusinessLayer;
using log4net;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace CountryCityProvinceService
{
    [ServiceBehavior(Namespace = "http://KidZonePortal.com/services/CountryCityProvinceServices",
       InstanceContextMode = InstanceContextMode.PerCall, ConcurrencyMode = ConcurrencyMode.Multiple)]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class CountryCityProvinceService : ICountryCityProvinceService
    {
         CountryCityProvinceManager _countryCityProvinceManager = null;

        public CountryCityProvinceManager CountryCityProvinceManager_Property
        {
            get { return _countryCityProvinceManager; }
            set { _countryCityProvinceManager = value; }
        }

        static ILog _log = null;

        static CountryCityProvinceService()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
            //CommonLibrary.Base.Database.ConnectionStringHelper.ProtectConfiguration();
            
            
        }

        public CountryCityProvinceService()
        {
            if (_countryCityProvinceManager == null)
                _countryCityProvinceManager = new CountryCityProvinceManager();
        }

        public List<Country> GetCountries()
        {
            if (_countryCityProvinceManager == null)
                _countryCityProvinceManager = new CountryCityProvinceManager();

            return _countryCityProvinceManager.GetCountries();
        }

        public List<City> GetCities(System.Nullable<int> countryID)
        {
            if (_countryCityProvinceManager == null)
                _countryCityProvinceManager = new CountryCityProvinceManager();

            return _countryCityProvinceManager.GetCities(countryID);
        }
    }
}

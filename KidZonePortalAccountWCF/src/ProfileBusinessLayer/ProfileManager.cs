using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using log4net;
using System.Data.SqlClient;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace ProfileBusinessLayer
{
    public class ProfileManager
    {
        static ILog _log = null;
        ConnectionStringsSection _connectionStrings = null;
        Dictionary<string, CommonLibrary.DatabaseSmoObjectsAndSettings> _smoSettings = null;

        public Dictionary<string, CommonLibrary.DatabaseSmoObjectsAndSettings> SmoSettings
        {
            get { return _smoSettings; }
            set { _smoSettings = value; }
        }

        public const string CONNECTION_STRING_NAME = "KidZonePortalDatabase";
        private  const string DEFAULT_ACCOUNT_CODE = "INTERNET_USER";

        static ProfileManager()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public ProfileManager()
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

                        _smoSettings.Add(conSetting.Name,new CommonLibrary.DatabaseSmoObjectsAndSettings(
                            sb.InitialCatalog,sb.DataSource,sb.InitialCatalog,
                            sb.UserID,sb.Password,sb.IntegratedSecurity));

                    }
            }
        }



        public List<TestSprocGenerator.Business.SingleTable.Bo.ProfileType> RetrieveProfileTypesForInternetUsers()
        {
            //make sure to not include Administrator!!!

            TestSprocGenerator.Business.SingleTable.Bo.List.ProfileType searchProfileType = 
                new TestSprocGenerator.Business.SingleTable.Bo.List.ProfileType(_smoSettings[CONNECTION_STRING_NAME]);

            searchProfileType.FillByGetAll(new ProfileType(_smoSettings[CONNECTION_STRING_NAME]));

            if (searchProfileType != null && searchProfileType.Count > 0)
            {

                ProfileType profileTypeToRemove = null;

                foreach (ProfileType profileType in searchProfileType)
                {
                    if (profileType.ProfileName.ToLower().Contains("admin"))
                    {
                        profileTypeToRemove = profileType;
                    }
                }

                searchProfileType.Remove(profileTypeToRemove);
            }
            else
            {
                throw new ApplicationException("Error retrieving Profile Types for Registration");
            }

            List<ProfileType> returnList =  searchProfileType.ConvertAll(new Converter<TestSprocGenerator.Data.SingleTable.Dto.ProfileType,
            TestSprocGenerator.Business.SingleTable.Bo.ProfileType>(ProfileTypeFromDtoToBo));

            return returnList;
        }

        public static TestSprocGenerator.Business.SingleTable.Bo.ProfileType ProfileTypeFromDtoToBo(TestSprocGenerator.Data.SingleTable.Dto.ProfileType dto)
        {
            return (TestSprocGenerator.Business.SingleTable.Bo.ProfileType)dto;
        }        
    }
}

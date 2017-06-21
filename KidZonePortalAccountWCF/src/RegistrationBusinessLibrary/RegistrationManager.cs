using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using log4net;
using System.Configuration;
using System.Data.SqlClient;


namespace RegistrationBusinessLibrary
{
    public class RegistrationManager
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

        static RegistrationManager()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public RegistrationManager()
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

        public bool Register(TestSprocGenerator.Business.SingleTable.Bo.Account accountInfo,
                             TestSprocGenerator.Business.SingleTable.Bo.Person personInfo,
                             TestSprocGenerator.Business.SingleTable.Bo.Address addressInfo,
                             TestSprocGenerator.Business.SingleTable.Bo.PhoneNumber phoneNumberInfo,
                             TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressInfo,
                             TestSprocGenerator.Business.SingleTable.Bo.ProfileType profileType)
        {
            RegistrationDataAccess registrationDataAccess =
                new RegistrationDataAccess();

            AccountBusinessLayer.AccountManager accountManager = new AccountBusinessLayer.AccountManager();

            
            bool exists = accountManager.DoesUserNameExist(accountInfo.AccountUsername);

            if(exists)
                throw new ArgumentException("AccountUsername is in Use, Please pick another username");

            return registrationDataAccess.Register((TestSprocGenerator.Data.SingleTable.Dto.Account)accountInfo,
                (TestSprocGenerator.Data.SingleTable.Dto.Person)personInfo,
                (TestSprocGenerator.Data.SingleTable.Dto.Address) addressInfo,
                (TestSprocGenerator.Data.SingleTable.Dto.PhoneNumber) phoneNumberInfo,
                    (TestSprocGenerator.Data.SingleTable.Dto.EmailAddress)emailAddressInfo,
                     (TestSprocGenerator.Data.SingleTable.Dto.ProfileType)profileType);


        }

        public bool DeleteRegistration(string username, out bool didItExist)
        {
            bool successful = false;

            RegistrationDataAccess registrationDataAccess = new RegistrationDataAccess();
            AccountBusinessLayer.AccountManager accountManager = new AccountBusinessLayer.AccountManager();
            TestSprocGenerator.Business.SingleTable.Bo.Account account = null;

            didItExist = accountManager.DoesUserNameExist(username, out account);

            if (didItExist)
            {
                
                TestSprocGenerator.Data.SingleTable.Dto.Profile profile = null;
                bool isParentProfile = IsParentProfile(account, out profile);

                
                return registrationDataAccess.DeleteRegistration(account, profile,isParentProfile,CommonLibrary.Base.Database.BaseDatabase.TransactionBehavior.Begin);
            }
            else
            {
                return successful;
            }
        }

        public bool IsParentProfile(TestSprocGenerator.Business.SingleTable.Bo.Account account, out TestSprocGenerator.Data.SingleTable.Dto.Profile profile)
        {
            RegistrationDataAccess registrationDataAccess = new RegistrationDataAccess();
            TestSprocGenerator.Data.SingleTable.Dto.Profile_Account profile_account = null;

            profile = registrationDataAccess.GetProfile(account.AccountID, out profile_account);            

            TestSprocGenerator.Business.SingleTable.Bo.ProfileType profileTypeCriteria =
                new TestSprocGenerator.Business.SingleTable.Bo.ProfileType() { ProfileTypeID = profile.ProfileTypeID };

            TestSprocGenerator.Business.SingleTable.Bo.List.ProfileType search =
                new TestSprocGenerator.Business.SingleTable.Bo.List.ProfileType(_smoSettings[CONNECTION_STRING_NAME]);
            search.FillByCriteriaExact(profileTypeCriteria);

            if (search != null && search.Count > 0)
            {
                if (search[0].ProfileName.Contains("Parent"))
                {
                    return true;
                }
            }

            return false;          
            
        }

        public bool DoesEmailExist(string email)
        {
            bool exists = false;

            RegistrationDataAccess registrationDataAccess = new RegistrationDataAccess();
            TestSprocGenerator.Data.SingleTable.Dto.EmailAddress emailAssociatedWithAnAccount = registrationDataAccess.GetEmailIfAssociatedWithAValidAccount(email);
            if (emailAssociatedWithAnAccount != null)
            {
                exists = true;
            }

            return exists;
        }
    }
}

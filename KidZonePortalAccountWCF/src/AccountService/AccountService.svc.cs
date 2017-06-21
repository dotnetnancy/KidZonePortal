using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using TestSprocGenerator.Business.SingleTable.Bo;
using AccountBusinessLayer;
using log4net;
using System.Reflection;
using System.ServiceModel.Activation;


namespace AccountService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    [ServiceBehavior(Namespace="http://KidZonePortal.com/services/AccountServices",
        InstanceContextMode=InstanceContextMode.Single, ConcurrencyMode=ConcurrencyMode.Multiple)]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class AccountService : IAccountService
    {
        AccountManager _accountManager = null;

        public AccountManager AccountManager_Property
        {
            get { return _accountManager; }
            set { _accountManager = value; }
        }

        static ILog _log = null;

        static AccountService()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
            //CommonLibrary.Base.Database.ConnectionStringHelper.ProtectConfiguration();            
            
        }

        public AccountService()
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();
            
        }

        public bool DoesUsernameExist(string username)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.DoesUserNameExist(username);
        }

       

        public bool LoginUser(string username, string password)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();
            return _accountManager.LoginUser(username, password);
        }

        public bool AccountCreate(Account accountModel)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.AccountCreate(accountModel);
        }

        public bool AccountDeleteByCriteria(Account accountModel)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.AccountDeleteByCriteria(accountModel);
        }

        public bool AccountDeleteByPrimaryKey(Guid accountID)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.AccountDeleteByPrimaryKey(accountID);
        }

        public bool AccountUpdate(Account accountModel)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.AccountUpdate(accountModel);
        }

        public List<Account> AccountRetrieveByCriteria(Account accountModel)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

           return _accountManager.AccountRetrieveByCriteria(accountModel);
        }

        public Account AccountRetrieveByUsernameAndPassword(string username, string password)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.AccountRetrieveByUsernameAndPassword(username, password);
        }

        public string ResetPasswordRequest(string username, string email)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.ResetPasswordRequest(username, email);

        }

        public bool ResetPassword(string username, string email, string passwordResetRequestCode, string newPassword)
        {
            if (_accountManager == null)
                _accountManager = new AccountManager();

            return _accountManager.ResetPassword(username, email, passwordResetRequestCode, newPassword);

        }

        public bool SendTestEmail(string email)
        {
            if (_accountManager == null)
            {
                _accountManager = new AccountManager();
            }
            return _accountManager.SendTestEmail(email);
        }

    }
}

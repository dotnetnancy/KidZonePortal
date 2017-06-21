using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;
using System.Configuration;
using System.Reflection;
using System.Data.SqlClient;
using CommonLibrary.Base.Database;
using TestSprocGenerator.Data.SingleTable.Dto;

namespace AccountDataLayer
{
    public class AccountDataAccess
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
        private const string DEFAULT_ACCOUNT_CODE = "INTERNET_USER";

        static AccountDataAccess()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public AccountDataAccess()
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

        public bool InsertNewPasswordResetRequestAndSetAccountDeleted(TestSprocGenerator.Data.SingleTable.Dto.Account account,
            string passwordResetCode)
        {
            bool successful = true;

            BaseDatabase baseDatabase = new BaseDatabase();

            SqlTransaction transaction = null;

            try
            {


                using (_smoSettings[CONNECTION_STRING_NAME].Connection)
                {

                    baseDatabase.OpenConnectionIfClosed(_smoSettings[CONNECTION_STRING_NAME].Connection);

                    //this caused errors cause we were beginning the transaction at the whole server caused big problems
                    //transaction = _smoSettings[CONNECTION_STRING_NAME].Connection.BeginTransaction();
                    transaction = null;

                    bool passwordResetRequestInsertOK = InsertPasswordResetRequest(account, passwordResetCode, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Begin);

                    if (!passwordResetRequestInsertOK)
                    {
                        successful = false;
                        throw new ApplicationException("Password Reset Request Insert Failed");
                    }

                    bool updateAccountToDeletedOK = UpdateAccount(account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!updateAccountToDeletedOK)
                    {
                        successful = false;
                        throw new ApplicationException("Update to Account Set to Deleted Failed");
                    }

                    if (successful == true)
                    {
                        baseDatabase.CommitTransaction(ref transaction);
                    }
                    else
                    {
                        throw new ApplicationException("Insert new Password Reset Request Method failed  in AccountDataAccess Failed, transaction has been rolled back");
                    }

                }
            }
            catch (Exception ex)
            {
                baseDatabase.RollbackTransaction(ref transaction);
                throw new ApplicationException("Insert new Password Reset Request Method in RegistrationDataAccess Failed", ex);
            }

            return successful;
        }


        private bool UpdateAccount(Account account, SqlConnection sqlConnection, ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Account> bdAccount = new BaseDataAccess<Account>(_smoSettings[CONNECTION_STRING_NAME]);

            account.Deleted = true;
            account.ModifiedDateTime = DateTime.Now;


            returnValue = bdAccount.Update(account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool updateAccountProblem = DoWeHaveASingleRecordInsertProblem(returnValue);

            account = (Account)returnValue;

            return !updateAccountProblem;
        }

        private bool InsertPasswordResetRequest(Account account, string passwordResetCode, SqlConnection connection,
        ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<PasswordResetRequest> bdPasswordResetRequest = new BaseDataAccess<PasswordResetRequest>(_smoSettings[CONNECTION_STRING_NAME]);

            PasswordResetRequest passwordResetRequest = new PasswordResetRequest();
            passwordResetRequest.PasswordResetRequestID = Guid.NewGuid();
            passwordResetRequest.PasswordResetCode = passwordResetCode;
            passwordResetRequest.AccountID = account.AccountID;


            returnValue = bdPasswordResetRequest.Insert(passwordResetRequest, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertPasswordResetRequest = DoWeHaveASingleRecordInsertProblem(returnValue);

            passwordResetRequest = (PasswordResetRequest)returnValue;

            return !insertPasswordResetRequest;
        }

        private bool DoWeHaveASingleRecordInsertProblem(object returnValue)
        {
            bool doWeHaveAnInsertProblem = false;

            if (returnValue == null)
            {
                doWeHaveAnInsertProblem = true;
            }

            return doWeHaveAnInsertProblem;
        }
    }
}

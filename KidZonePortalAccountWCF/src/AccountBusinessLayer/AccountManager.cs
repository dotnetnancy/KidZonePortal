using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using log4net;
using System.Configuration;
using System.Data.SqlClient;
using TestSprocGenerator.Business.SingleTable.Bo;
using TestSprocGenerator.Business.SingleTable.Bo.List;
using CommonLibrary.Security;
using AccountDataLayer;
using System.Net.Mail;
using System.Security.Cryptography;

namespace AccountBusinessLayer
{

    public class AccountManager
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

        static AccountManager()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public AccountManager()
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


        public bool DoesUserNameExist(string username)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                TestSprocGenerator.Business.SingleTable.Bo.Account criteria =
                    new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountUsername = username };

                TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

                searchReturned.FillByCriteriaExact(criteria);

                if (searchReturned != null && searchReturned.Count > 0)
                {
                    return true;
                }
                return false;

            }
            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

            return false;
        }

        public bool DoesUserNameExist(string username, out TestSprocGenerator.Business.SingleTable.Bo.Account account)
        {
            account = null;
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                TestSprocGenerator.Business.SingleTable.Bo.Account criteria =
                    new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountUsername = username };

                TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

                searchReturned.FillByCriteriaExact(criteria);

                if (searchReturned != null && searchReturned.Count > 0)
                {
                    account = (TestSprocGenerator.Business.SingleTable.Bo.Account)searchReturned[0];
                    return true;
                }
                return false;

            }
            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

            return false;
        }

        public bool LoginUser(string username, string password)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentNullException("Username");

                if (string.IsNullOrEmpty(password))
                    throw new ArgumentNullException("Password");

                //get the user by username first then we can figure out if the password is ok
                TestSprocGenerator.Business.SingleTable.Bo.Account criteria =
                   new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountUsername = username, Deleted = false };

                TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

                searchReturned.FillByCriteriaExact(criteria);


                if (searchReturned != null && searchReturned.Count > 0)
                {
                    //now that we have a user with that username we need to compare/verify the hashed password
                    if (!string.IsNullOrEmpty(searchReturned[0].AccountPassword))
                    {
                        string salt = searchReturned[0].AccountPassword.Substring(searchReturned[0].AccountPassword.Length -
                            CommonLibrary.Security.HashSaltHelper.SALT_SIZE);

                        string hashedPasswordAndSalt = HashSaltHelper.CreatePasswordHash(password, salt);

                        bool passwordMatch = hashedPasswordAndSalt.Equals(searchReturned[0].AccountPassword);
                        if (passwordMatch)
                        {
                            return true;
                        }
                    }
                }

                return false;
            }
            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

            return false;

        }

        /// <summary>
        /// Generate a regular Account from the UI, the Administrative Accounts need to go through an Administrative
        /// set of interfaces/code
        /// </summary>
        /// <param name="accountModel"></param>
        /// <returns></returns>
        public bool AccountCreate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                accountModel.DatabaseSmoObjectsAndSettings = _smoSettings[CONNECTION_STRING_NAME];

                if (string.IsNullOrEmpty(accountModel.AccountUsername))
                    throw new ArgumentNullException("AccountUsername");

                if (string.IsNullOrEmpty(accountModel.AccountPassword))
                    throw new ArgumentNullException("AccountPassword");

                if (DoesUserNameExist(accountModel.AccountUsername))
                    throw new ArgumentException("AccountUsername is in Use, Please pick another username");


                //Set default values for insertion of new account
                accountModel.AccountCode = DEFAULT_ACCOUNT_CODE;
                accountModel.AccountID = Guid.NewGuid();
                accountModel.AccountPassword = HashSaltHelper.CreatePasswordHash(accountModel.AccountPassword,
                    HashSaltHelper.CreateSalt());
                accountModel.Deleted = false;
                accountModel.InsertedDateTime = DateTime.Now;
                accountModel.ModifiedDateTime = DateTime.Now;

                accountModel.Insert();

                return true;
            }

            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

        }

        public bool AccountDeleteByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                accountModel.DatabaseSmoObjectsAndSettings = _smoSettings[CONNECTION_STRING_NAME];
                //do a get first cause there may be more than one record this may cause an issue
                TestSprocGenerator.Business.SingleTable.Bo.List.Account listReturned =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(accountModel.DatabaseSmoObjectsAndSettings);

                listReturned.FillByCriteriaExact(accountModel);

                foreach (TestSprocGenerator.Business.SingleTable.Bo.Account accountToDelete in listReturned)
                {

                    accountToDelete.Delete();
                }
                return true;
            }
            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

            return false;
        }

        public bool AccountDeleteByPrimaryKey(Guid accountID)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                if (accountID == Guid.Empty)
                    throw new ArgumentNullException("AccountID To Delete is Null");

                TestSprocGenerator.Business.SingleTable.Bo.Account toDelete =
                    new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]);

                toDelete.AccountID = accountID;
                toDelete.Delete();
                return true;
            }
            else
            {
                throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
            }

            return false;

        }

        public bool AccountUpdate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                accountModel.Update();
            }
            throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");

        }

        public List<TestSprocGenerator.Business.SingleTable.Bo.Account> AccountRetrieveByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                  new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

                searchReturned.FillByCriteriaExact(accountModel);
            }
            throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");

        }

        public TestSprocGenerator.Business.SingleTable.Bo.Account AccountRetrieveByUsernameAndPassword(string username, string password)
        {
            if (_smoSettings.ContainsKey(CONNECTION_STRING_NAME))
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentNullException("Username");

                if (string.IsNullOrEmpty(password))
                    throw new ArgumentNullException("Password");

                //get the user by username first then we can figure out if the password is ok
                TestSprocGenerator.Business.SingleTable.Bo.Account criteria =
                   new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountUsername = username };

                TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

                searchReturned.FillByCriteriaExact(criteria);

                if (searchReturned != null && searchReturned.Count > 0)
                {
                    //now that we have a user with that username we need to compare/verify the hashed password
                    if (!string.IsNullOrEmpty(searchReturned[0].AccountPassword))
                    {
                        string salt = searchReturned[0].AccountPassword.Substring(searchReturned[0].AccountPassword.Length -
                            CommonLibrary.Security.HashSaltHelper.SALT_SIZE);

                        string hashedPasswordAndSalt = HashSaltHelper.CreatePasswordHash(password, salt);

                        bool passwordMatch = hashedPasswordAndSalt.Equals(searchReturned[0].AccountPassword);
                        if (passwordMatch)
                        {
                            return (TestSprocGenerator.Business.SingleTable.Bo.Account)searchReturned[0];
                        }
                    }
                }
                return null;
            }
            throw new ApplicationException("Database Connection String Not in Configuration File or not loaded from Config File");
        }

        public bool IsParentProfile(string username)
        {
            throw new NotImplementedException();
        }

        public string ResetPasswordRequest(string username, string email)
        {
            string  resetPasswordCode = ProcessPasswordReset(username, email);
            return resetPasswordCode;           
        }

        public bool SendTestEmail(string email)
        {
            bool success = true;
            try
            {
                SmtpClient serv = new SmtpClient();
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("no-reply@kidzoneportal.com");
                msg.To.Add("nancyconceicao@hotmail.com");
                msg.Body = "body";
                msg.Subject = "test";
                msg.BodyEncoding = System.Text.Encoding.ASCII;
                msg.IsBodyHtml = false;
                serv.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;
                //serv.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["SmtpServerUserName"], ConfigurationManager.AppSettings["SmtpServerPassword"]);
                serv.Send(msg);
            }
            catch (Exception ex)
            {
                success = false;
            }
            return success;
        }


        private string  ProcessPasswordReset(string username, string email)
        {         
            TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount = null;
            string emailAddress = DetermineEmailGetAccountByEmailOrUsername(username, email, out foundAccount);
            string passwordResetRequestCode = null;

            if (!string.IsNullOrEmpty(emailAddress) && (foundAccount != null))
            {
                bool passwordResetRequestOK = false;

                    //check if a reset request is already in the table, we already have the account by username or email determined
                    TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest passwordResetRequestFound =
                        GetPasswordResetRequest(foundAccount.AccountID);

                    if (passwordResetRequestFound != null)
                    {
                        passwordResetRequestCode = passwordResetRequestFound.PasswordResetCode;
                        passwordResetRequestOK = true;
                    }
                    else
                    {
                        passwordResetRequestCode = GenerateNewPasswordResetCode();
                        passwordResetRequestOK = InsertNewPasswordResetRequestAndSetAccountDeleted(foundAccount, passwordResetRequestCode);
                    }

                    if (passwordResetRequestOK)
                    {
                        bool emailOK = EmailPasswordResetRequestCode(foundAccount, emailAddress,passwordResetRequestCode);
                        if (!emailOK)
                        {
                            throw new ApplicationException("Error sending email for password Reset, Account is Disabled, please try password reset request later and contact Administrator");
                        }
                    }
                    else
                    {
                        throw new ApplicationException("Error processing Password Reset, contact administrator");
                    }                
                
                //if no request already present then generate random reset password code,
                //determine the email (which we do in both cases anyway), insert a record into the table,
                //set the account to deleted = true (basically disabled) then finally email the code to the email address determined
            }
            else
            {
                throw new ApplicationException("Cannot determine email address password and or Account, reset not possible without it");
            }

            return passwordResetRequestCode;            
        }

        private bool EmailPasswordResetRequestCode(TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount,
            string emailAddress, string passwordResetRequestCode)
        {
            bool success = true;
            try
            {
                SmtpClient serv = new SmtpClient();
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress("no-reply@kidzoneportal.com");
                msg.To.Add(emailAddress);
                msg.Body = "Here is your password reset code for KidZonePortal:  " + passwordResetRequestCode;
                msg.Subject = "Your password reset code from KidZonePortal";
                msg.BodyEncoding = System.Text.Encoding.ASCII;
                msg.IsBodyHtml = false;
                serv.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;
                //serv.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["SmtpServerUserName"], ConfigurationManager.AppSettings["SmtpServerPassword"]);
                serv.Send(msg);
            }
            catch (Exception)
            {
                success = false;
            }
            return success;
        }

        private bool InsertNewPasswordResetRequestAndSetAccountDeleted(TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount, string passwordResetRequestCode)
        {
            bool success = false;

            AccountDataAccess dataAccess = new AccountDataAccess();

            TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest passwordResetRequest =
                new TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest(_smoSettings[CONNECTION_STRING_NAME]);

            passwordResetRequest.PasswordResetRequestID = Guid.NewGuid();
            passwordResetRequest.AccountID = foundAccount.AccountID;
            passwordResetRequest.PasswordResetCode = passwordResetRequestCode;

            foundAccount.Deleted = true;

            success = dataAccess.InsertNewPasswordResetRequestAndSetAccountDeleted(foundAccount, passwordResetRequestCode);

            return success;
        }

        private string GenerateNewPasswordResetCode()
        {
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] rndBytes = new byte[4];
            rng.GetBytes(rndBytes);
            int rand = BitConverter.ToInt32(rndBytes, 0);
            return rand.ToString();

        }

        private TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest GetPasswordResetRequest(Guid accountID)
        {
            TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest foundPasswordResetRequest = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest foundPasswordRequestCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest(_smoSettings[CONNECTION_STRING_NAME]) {  AccountID = accountID };

            TestSprocGenerator.Business.SingleTable.Bo.List.PasswordResetRequest searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.PasswordResetRequest(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(foundPasswordRequestCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundPasswordResetRequest = (TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one email address with this profile, but there is more than one, contact administrator");

                }
            }
            return foundPasswordResetRequest;
        }

        private string DetermineEmailGetAccountByEmailOrUsername(string username, string email, out TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount)
        {
            string returnEmail = null;
            foundAccount = null;

            if (!string.IsNullOrEmpty(email))
            {
                returnEmail = email;
                foundAccount = GetAccountByEmailAddress(email);
            }
            else
            {
                TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressFound = GetEmailByUsername(username, out foundAccount);
                if (emailAddressFound != null && (!string.IsNullOrEmpty(emailAddressFound.EmailAddress_Property)))
                {
                    returnEmail = emailAddressFound.EmailAddress_Property;
                }
            }

            return returnEmail;
        }       

        private TestSprocGenerator.Business.SingleTable.Bo.EmailAddress GetEmailByUsername(string username, out TestSprocGenerator.Business.SingleTable.Bo.Account accountByUsernameFound)
        {
            accountByUsernameFound = 
                GetAccountByUsername(username);

            TestSprocGenerator.Business.SingleTable.Bo.Profile_Account profileAccountFound = 
                GetProfileAccount(accountByUsernameFound.AccountID);

            TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress profileEmailAddressFound =
                GetProfileEmail(profileAccountFound.ProfileID);

            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressFound =
                GetEmailAddress(profileEmailAddressFound.EmailAddressID);

            return emailAddressFound;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.EmailAddress GetEmailAddress(Guid emailAddressID)
        {
            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress foundEmailAddress = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.EmailAddress(_smoSettings[CONNECTION_STRING_NAME]) { EmailAddressID = emailAddressID };

            TestSprocGenerator.Business.SingleTable.Bo.List.EmailAddress searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.EmailAddress(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(emailCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundEmailAddress = (TestSprocGenerator.Business.SingleTable.Bo.EmailAddress)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one email address with this profile, but there is more than one, contact administrator");

                }
            }
            return foundEmailAddress;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress GetProfileEmail(Guid profileID)
        {
           TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress foundProfileEmail = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress profileEmailCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress(_smoSettings[CONNECTION_STRING_NAME]) { ProfileID = profileID };

            TestSprocGenerator.Business.SingleTable.Bo.List.Profile_EmailAddress searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Profile_EmailAddress(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(profileEmailCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundProfileEmail = (TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one email address with this profile, but there is more than one, contact administrator");

                }
            }
            return foundProfileEmail;
        } 
        
   

        private TestSprocGenerator.Business.SingleTable.Bo.Account GetAccountByUsername(string username)
        {
            TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.Account accountSearchCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountUsername = username };

            TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(accountSearchCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundAccount = (TestSprocGenerator.Business.SingleTable.Bo.Account)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one account with that username, but there is more than one, contact administrator");
                }
            }
            return foundAccount;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.Account GetAccountByEmailAddress(string email)
        {
            TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount = null;

            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress foundEmailAddress = null;

            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressSearchCriteria =
                new TestSprocGenerator.Business.SingleTable.Bo.EmailAddress(_smoSettings[CONNECTION_STRING_NAME]) { EmailAddress_Property = email };
            
            TestSprocGenerator.Business.SingleTable.Bo.List.EmailAddress emailAddressSearchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.EmailAddress(_smoSettings[CONNECTION_STRING_NAME]);
            
            emailAddressSearchReturned.FillByCriteriaExact(emailAddressSearchCriteria);

            if (emailAddressSearchReturned != null && emailAddressSearchReturned.Count > 0)
            {
                if (emailAddressSearchReturned.Count == 1)
                {
                    foundEmailAddress = (TestSprocGenerator.Business.SingleTable.Bo.EmailAddress)emailAddressSearchReturned[0];
                    
                    TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress foundProfileEmail = 
                        GetProfileEmailByEmailID(foundEmailAddress.EmailAddressID);

                    if (foundProfileEmail != null)
                    {
                        TestSprocGenerator.Business.SingleTable.Bo.Profile_Account foundProfileAccount =
                            GetProfileAccountByProfileID(foundProfileEmail.ProfileID);

                        if (foundProfileAccount != null)
                        {
                            foundAccount = GetAccountAccountByAccountID(foundProfileAccount.AccountID);
                            if (foundAccount == null)
                            {
                                throw new ApplicationException("Account not found");
                            }
                        }
                        else
                        {
                            throw new ApplicationException("Profile_Account not found");
                        }
                    }
                    else
                    {
                        throw new ApplicationException("Profile_Email  record not found");
                    }

                }
                else
                {
                    throw new ApplicationException("There should only be one Profile for this Account, but there is more than one, contact administrator");

                }
            }

            return foundAccount;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.Account GetAccountAccountByAccountID(Guid accountID)
        {
            TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.Account accountSearchCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountID = accountID };

            TestSprocGenerator.Business.SingleTable.Bo.List.Account searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(accountSearchCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundAccount = (TestSprocGenerator.Business.SingleTable.Bo.Account)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one account with that accountID, but there is more than one, contact administrator");
                }
            }
            return foundAccount;
        }

        

        private TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress GetProfileEmailByEmailID(Guid emailID)
        {
            TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress foundProfileEmail = null;

            //get the user by username first then we can figure out if the password is ok
            TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress profileEmailCriteria =
               new TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress(_smoSettings[CONNECTION_STRING_NAME]) { EmailAddressID = emailID };

            TestSprocGenerator.Business.SingleTable.Bo.List.Profile_EmailAddress searchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Profile_EmailAddress(_smoSettings[CONNECTION_STRING_NAME]);

            searchReturned.FillByCriteriaExact(profileEmailCriteria);

            if (searchReturned != null && searchReturned.Count > 0)
            {
                //there should only be one
                if (searchReturned.Count == 1)
                {
                    foundProfileEmail = (TestSprocGenerator.Business.SingleTable.Bo.Profile_EmailAddress)searchReturned[0];
                }
                else
                {
                    throw new ApplicationException("There should only be one email address with this profile, but there is more than one, contact administrator");

                }
            }
            return foundProfileEmail;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.Profile_Account GetProfileAccountByProfileID(Guid profileID)
        {
            TestSprocGenerator.Business.SingleTable.Bo.Profile_Account foundProfileAccount = null;

            TestSprocGenerator.Business.SingleTable.Bo.Profile_Account profileAccountSearchCriteria =
                new TestSprocGenerator.Business.SingleTable.Bo.Profile_Account(_smoSettings[CONNECTION_STRING_NAME]) { ProfileID = profileID };

            TestSprocGenerator.Business.SingleTable.Bo.List.Profile_Account profileAccountSearchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Profile_Account(_smoSettings[CONNECTION_STRING_NAME]);
            profileAccountSearchReturned.FillByCriteriaExact(profileAccountSearchCriteria);

            if (profileAccountSearchReturned != null && profileAccountSearchReturned.Count > 0)
            {
                if (profileAccountSearchReturned.Count == 1)
                {

                    foundProfileAccount = (TestSprocGenerator.Business.SingleTable.Bo.Profile_Account)profileAccountSearchReturned[0];
                }
                else
                {
                    //again there should only be one...if not big problem
                    throw new ApplicationException("There should only be one Account for this Profile, but there is more than one, contact administrator");

                }
            }
            return foundProfileAccount;
        }

        private TestSprocGenerator.Business.SingleTable.Bo.Profile_Account GetProfileAccount(Guid accountID)
        {
            //now that we have a user with that username we need to get the email we do that by getting
            //Account_Profile and then from there getting Profile_Email
            TestSprocGenerator.Business.SingleTable.Bo.Profile_Account foundProfileAccount = null;

            TestSprocGenerator.Business.SingleTable.Bo.Profile_Account profileAccountSearchCriteria =
                new TestSprocGenerator.Business.SingleTable.Bo.Profile_Account(_smoSettings[CONNECTION_STRING_NAME]) { AccountID = accountID };

            TestSprocGenerator.Business.SingleTable.Bo.List.Profile_Account profileAccountSearchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.Profile_Account(_smoSettings[CONNECTION_STRING_NAME]);
            profileAccountSearchReturned.FillByCriteriaExact(profileAccountSearchCriteria);

            if (profileAccountSearchReturned != null && profileAccountSearchReturned.Count > 0)
            {
                if (profileAccountSearchReturned.Count == 1)
                {

                    foundProfileAccount = (TestSprocGenerator.Business.SingleTable.Bo.Profile_Account)profileAccountSearchReturned[0];
                }
                else
                {
                    //again there should only be one...if not big problem
                    throw new ApplicationException("There should only be one Profile for this Account, but there is more than one, contact administrator");

                }
            }
            return foundProfileAccount;
        }


        public bool ResetPassword(string username, string email, string passwordResetRequestCode, string newPassword)
        {
            bool success = false;

            //1) Find the passwordResetRequestCode Record if it exists, which gives the account id
            //2) Get the AccountRecord
            //3) Update the Password = newPassword and the Deleted flag = true, call update on bo to update in database
             TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest foundPasswordResetRequest = null;

            TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest passwordResetSearchCriteria =
                new TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest(_smoSettings[CONNECTION_STRING_NAME]) {  PasswordResetCode = passwordResetRequestCode };

            TestSprocGenerator.Business.SingleTable.Bo.List.PasswordResetRequest passwordResetSearchReturned =
                new TestSprocGenerator.Business.SingleTable.Bo.List.PasswordResetRequest(_smoSettings[CONNECTION_STRING_NAME]);
            passwordResetSearchReturned.FillByCriteriaExact(passwordResetSearchCriteria);

            if (passwordResetSearchReturned != null && passwordResetSearchReturned.Count > 0)
            {
                if (passwordResetSearchReturned.Count == 1)
                {
                    foundPasswordResetRequest = (TestSprocGenerator.Business.SingleTable.Bo.PasswordResetRequest)passwordResetSearchReturned[0];
                    //make sure that the email or username is valid
                    TestSprocGenerator.Business.SingleTable.Bo.Account foundAccount = null;
                    string emailAddress = DetermineEmailGetAccountByEmailOrUsername(username, email, out foundAccount);
                    if (foundAccount != null)
                    {
                        //account is valid if the accountid of the returned record and the password request record accountID match
                        if (foundAccount.AccountID == foundPasswordResetRequest.AccountID)
                        {
                            //TODO: should probably do this in a transaction instead of having the possibility of one of these
                            //failing

                            foundAccount.Deleted = false;
                            foundAccount.AccountPassword = HashSaltHelper.CreatePasswordHash(newPassword,
                                HashSaltHelper.CreateSalt());

                            foundAccount.Update();

                            foundPasswordResetRequest.Delete();
                            success = true;
                        }
                        else
                        {
                            throw new ApplicationException("Email or Username provided does not match the Password Reset Request code record");
                        }
                    }
                    else
                    {
                        throw new ApplicationException("Email or Username provided is not valid");
                    }

                }
            }
            return success;
        }
    }
}

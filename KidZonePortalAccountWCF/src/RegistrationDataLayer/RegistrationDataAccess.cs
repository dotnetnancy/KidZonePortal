using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TestSprocGenerator.Data.SingleTable.Dto;
using System.Configuration;
using System.Reflection;
using System.Data.SqlClient;
using CommonLibrary.Base.Database;
using log4net;
using CommonLibrary.Enumerations;
using CommonLibrary;
using CommonLibrary.Security;

namespace RegistrationBusinessLibrary
{
    public class RegistrationDataAccess
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

        static RegistrationDataAccess()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public RegistrationDataAccess()
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

        public bool DeleteRegistration(Account account, TestSprocGenerator.Data.SingleTable.Dto.Profile profile, bool isParent,
            BaseDatabase.TransactionBehavior transactionBehavior)
        {

            //basically to Delete a Registration really means to delete the Account and the Profile and the Person but  all of the
            //dependencies on these tables must be deleted first, this may be slightly complicated but should be better afer my changes base
            //with transactions

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


                    successful = DeleteRegistration(account, profile, isParent, ref transaction, baseDatabase);

                    if (successful)
                    {
                        baseDatabase.CommitTransaction(ref transaction);
                    }
                    else
                    {
                        baseDatabase.RollbackTransaction(ref transaction);
                    }
                }

            }
            catch (Exception ex)
            {
                baseDatabase.RollbackTransaction(ref transaction);
                throw new ApplicationException("Register Method in RegistrationDataAccess Failed", ex);
            }

            return successful;



        }

        private bool DeleteChildRegistration(Account account, TestSprocGenerator.Data.SingleTable.Dto.Profile profile,
    bool isParent
    , ref SqlTransaction transaction, BaseDatabase baseDatabase, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            bool success = true;
            //before dealing with the transaction of items that need to succeed or fail as a whole lets Get the 
            //relevant records to delete
            //i think that we will not ever actually delete the records but instead mark them as deleted instead
            //which would result in Update rather than Delete calls

            Account accountToDelete = null;

            accountToDelete = account;

            Profile_Account profile_account = null;

            if (accountToDelete != null)
            {

                Profile profileToDelete = null;

                profileToDelete = GetProfile(profile, out profile_account);

                if (profileToDelete != null)
                {
                    Person personToDelete = null;

                    Profile_Person profile_person = null;
                    Profile_EmailAddress profile_emailAddress = null;
                    Profile_Content profile_content = null;
                    Profile_Blog profile_blog = null;
                    Profile_Library profile_library = null;
                    Profile_WebsiteLink profile_websiteLink = null;

                    personToDelete = GetPersonToDelete(profileToDelete.ProfileID, out profile_person);

                    EmailAddress emailAddressToDelete = null;

                    emailAddressToDelete = GetEmailAddressToDelete(profileToDelete.ProfileID, out profile_emailAddress);

                    List<Content> contentToDelete = null;

                    contentToDelete = GetContentToDelete(profileToDelete.ProfileID, out profile_content);

                    List<Blog> blogToDelete = null;

                    blogToDelete = GetBlogToDelete(profileToDelete.ProfileID, out profile_blog);

                    List<Library> libraryToDelete = null;

                    libraryToDelete = GetLibraryToDelete(profileToDelete.ProfileID, out profile_library);

                    List<WebsiteLink> websiteLinkToDelete = null;

                    websiteLinkToDelete = GetWebsiteLinkToDelete(profileToDelete.ProfileID, out profile_websiteLink);

                    success = DeleteFullRegistrationAndAllData(accountToDelete, profileToDelete, personToDelete, emailAddressToDelete,
                        contentToDelete, blogToDelete, libraryToDelete, websiteLinkToDelete, isParent,
                        ref transaction, baseDatabase, transactionBehavior);

                }


            }
            else
            {
                //if the account is not found we probably have an issue but this should be rare?
                success = false;
            }

            return success;

        }




        private bool DeleteRegistration(Account account, TestSprocGenerator.Data.SingleTable.Dto.Profile profile,
            bool isParent
            , ref SqlTransaction transaction, BaseDatabase baseDatabase)
        {
            bool success = true;
            //before dealing with the transaction of items that need to succeed or fail as a whole lets Get the 
            //relevant records to delete
            //i think that we will not ever actually delete the records but instead mark them as deleted instead
            //which would result in Update rather than Delete calls

            Account accountToDelete = null;

            accountToDelete = account;

            Profile_Account profile_account = null;

            if (accountToDelete != null)
            {

                Profile profileToDelete = null;

                profileToDelete = GetProfile(profile, out profile_account);

                if (profileToDelete != null)
                {
                    Person personToDelete = null;

                    Profile_Person profile_person = null;
                    Profile_EmailAddress profile_emailAddress = null;
                    Profile_Content profile_content = null;
                    Profile_Blog profile_blog = null;
                    Profile_Library profile_library = null;
                    Profile_WebsiteLink profile_websiteLink = null;

                    personToDelete = GetPersonToDelete(profileToDelete.ProfileID, out profile_person);

                    EmailAddress emailAddressToDelete = null;

                    emailAddressToDelete = GetEmailAddressToDelete(profileToDelete.ProfileID, out profile_emailAddress);

                    List<Content> contentToDelete = null;

                    contentToDelete = GetContentToDelete(profileToDelete.ProfileID, out profile_content);

                    List<Blog> blogToDelete = null;

                    blogToDelete = GetBlogToDelete(profileToDelete.ProfileID, out profile_blog);

                    List<Library> libraryToDelete = null;

                    libraryToDelete = GetLibraryToDelete(profileToDelete.ProfileID, out profile_library);

                    List<WebsiteLink> websiteLinkToDelete = null;

                    websiteLinkToDelete = GetWebsiteLinkToDelete(profileToDelete.ProfileID, out profile_websiteLink);

                    success = DeleteFullRegistrationAndAllData(accountToDelete, profileToDelete, personToDelete, emailAddressToDelete,
                        contentToDelete, blogToDelete, libraryToDelete, websiteLinkToDelete, isParent,
                        ref transaction, baseDatabase, BaseDatabase.TransactionBehavior.Begin);

                }


            }
            else
            {
                //if the account is not found we probably have an issue but this should be rare?
                success = false;
            }

            return success;

        }


        /// <summary>
        /// if isParent by this point we need to delete all the children also this may end up being a recursion or similar iterative
        /// </summary>
        /// <param name="accountToDelete"></param>
        /// <param name="profileToDelete"></param>
        /// <param name="personToDelete"></param>
        /// <param name="emailAddressToDelete"></param>
        /// <param name="contentToDelete"></param>
        /// <param name="blogToDelete"></param>
        /// <param name="libraryToDelete"></param>
        /// <param name="websiteLinkToDelete"></param>
        /// <param name="isParent"></param>
        /// <param name="transaction"></param>
        /// <param name="baseDatabase"></param>
        /// <returns></returns>
        private bool DeleteFullRegistrationAndAllData(Account accountToDelete, Profile profileToDelete,
            Person personToDelete, EmailAddress emailAddressToDelete,
            List<Content> contentToDelete, List<Blog> blogToDelete, List<Library> libraryToDelete,
            List<WebsiteLink> websiteLinkToDelete, bool isParent,
            ref SqlTransaction transaction, BaseDatabase baseDatabase, BaseDatabase.TransactionBehavior transactionBehavior)
        {


            try
            {

                //this should all be in a Transaction and succeed or fail as a whole i am assuming.  i think we will go ahead
                //and delete all the records for now and then if we need undelete functionality we can change it

                if (isParent)
                {
                    return DeleteChildRegistrations(profileToDelete, ref transaction, transactionBehavior);
                }
                else
                {
                    return DeleteRegistration(accountToDelete, profileToDelete, personToDelete, emailAddressToDelete, contentToDelete,
                        blogToDelete, libraryToDelete, websiteLinkToDelete, isParent, ref transaction, baseDatabase, transactionBehavior);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;


        }

        private bool DeleteChildRegistrations(Profile parentProfile, ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;
                //get all children of this parent
                BaseDataAccess<Parent_Child> bdParent_Child = new BaseDataAccess<Parent_Child>(readSettings);

                List<Parent_Child> parentChildList = bdParent_Child.Get(new Parent_Child() { Parent_ProfileID = parentProfile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                List<Profile> childProfiles = new List<Profile>();

                BaseDataAccess<Profile> bdProfile = new BaseDataAccess<Profile>(readSettings);

                if (parentChildList != null && parentChildList.Count > 0)
                {
                    foreach (Parent_Child child in parentChildList)
                    {
                        List<Profile> currentProfileList = bdProfile.Get(new Profile() { ProfileID = child.Child_ProfileID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentProfileList != null && currentProfileList.Count > 0)
                        {
                            childProfiles.AddRange(currentProfileList);
                        }
                    }
                }

                if (childProfiles.Count > 0)
                {
                    //need to get the Account associated with the child, which may or may not exist
                    //if there is no account then there is nothing to do from here on this would be the case where
                    //the parent added a child but the child has not gone in and created their account, with no account there is no
                    //login and you cannot do anything in the system without logging in and having an account.

                    foreach (Profile childProfile in childProfiles)
                    {
                        BaseDataAccess<Profile_Account> bdProfileAccount = new BaseDataAccess<Profile_Account>(readSettings);
                        BaseDataAccess<Account> bdAccount = new BaseDataAccess<Account>(readSettings);

                        List<Profile_Account> profile_Accounts = bdProfileAccount.Get(new Profile_Account() { ProfileID = childProfile.ProfileID },
                            GetPermutations.ByExplicitCriteria);

                        if (profile_Accounts != null && profile_Accounts.Count == 1)
                        {
                            List<Account> accounts = bdAccount.Get(new Account() { AccountID = profile_Accounts[0].AccountID },
                                GetPermutations.ByExplicitCriteria);

                            if (accounts != null && accounts.Count == 1)
                            {
                                bool isParent = false;
                                DeleteChildRegistration(accounts[0], childProfile, isParent,
                                    ref transaction, new BaseDatabase(), transactionBehavior);
                            }
                            else
                            {
                                //there should only ever be one profile_account record there is clearly an issue if there are more than one..
                                //TODO what do we do here?
                            }

                        }
                        else
                        {
                            //there should only ever be one profile_account record there is clearly an issue if there are more than one..
                            //TODO what do we do here?
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;


        }

        private bool DeleteRegistration(Account accountToDelete, Profile profileToDelete,
            Person personToDelete, EmailAddress emailAddressToDelete,
            List<Content> contentToDelete, List<Blog> blogToDelete, List<Library> libraryToDelete,
            List<WebsiteLink> websiteLinkToDelete, bool isParent,
            ref SqlTransaction transaction, BaseDatabase baseDatabase, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            bool success = false;


            bool deletePersonSuccess = DeletePerson(personToDelete, ref transaction, BaseDatabase.TransactionBehavior.Begin);

            bool deleteAccountSuccess = DeleteAccount(accountToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist);

            bool deleteEmailAddressSuccess = DeleteEmailAddress(emailAddressToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist);

            bool deleteContentSuccess = DeleteContent(profileToDelete, contentToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist, isParent);

            bool deleteBlogSuccess = DeleteBlog(profileToDelete, blogToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist, isParent);

            bool deleteLibrarySuccess = DeleteLibrary(profileToDelete, libraryToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist, isParent);

            bool deleteWebsiteLinkSuccess = DeleteWebsiteLink(profileToDelete, websiteLinkToDelete, ref transaction,
                BaseDatabase.TransactionBehavior.Enlist, isParent);

            bool deleteNotificationsSuccess = DeleteNotification(profileToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist,
                isParent);


            bool deleteProfileSuccess = DeleteProfile(profileToDelete, ref transaction, BaseDatabase.TransactionBehavior.Enlist,
                isParent);

            return (deletePersonSuccess && deleteAccountSuccess && deleteEmailAddressSuccess && deleteContentSuccess && deleteBlogSuccess
                && deleteLibrarySuccess && deleteWebsiteLinkSuccess && deleteNotificationsSuccess && deleteProfileSuccess);
        }

        private bool DeleteProfile(Profile profileToDelete, ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<Profile> bdProfile = new BaseDataAccess<Profile>(readSettings);

                bdProfile.Delete(profileToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                    ref transaction, transactionBehavior, out returnValue);


            }
            catch (Exception ex)
            {
                return false;
            }

            return true;

        }

        private bool DeleteNotification(Profile profile, ref SqlTransaction transaction,
  BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            //TODO need to mark as deleted the individual Notification records and the Profile_Notification Records for this NotificationIDs
            // we also need to mark all Library_Notification records as deleted for this NotificationID then NotificationRequests that "i am allowed to see",
            //and notification requests that i am the child of a parent 

            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<Notification> bdNotification = new BaseDataAccess<Notification>(readSettings);

                List<Notification> notificationSentToThisProfile = bdNotification.Get(new Notification() { ProfileIDTo = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                List<Notification> notificationsSentFromThisProfile = bdNotification.Get(new Notification() { ProfileIDFrom = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (notificationSentToThisProfile != null && notificationSentToThisProfile.Count > 0)
                {
                    notificationSentToThisProfile.ForEach(a => a.Deleted = true);
                    bdNotification.Delete(notificationSentToThisProfile, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);
                }

                if (notificationsSentFromThisProfile != null && notificationsSentFromThisProfile.Count > 0)
                {
                    notificationsSentFromThisProfile.ForEach(a => a.Deleted = true);
                    bdNotification.Delete(notificationsSentFromThisProfile, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);
                }

                if (isParent)
                    DeleteNotificationRequestsThatThisProfileHasGranted(profile, ref transaction,
                        transactionBehavior);
                else
                    DeleteNotificationRequestsThatHaveBeenGrantedToThisProfile(profile, ref transaction,
                        transactionBehavior);

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteNotificationRequestsThatHaveBeenGrantedToThisProfile(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<NotificationAccessRequest> bdNotificationAccessRequest = new BaseDataAccess<NotificationAccessRequest>(readSettings);

                //all the ones that have a ProfileIDChild as this ProfileID
                List<NotificationAccessRequest> notificationAccessRequests = bdNotificationAccessRequest.Get(new NotificationAccessRequest() { ProfileIDChild = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (notificationAccessRequests != null && notificationAccessRequests.Count > 0)
                {
                    notificationAccessRequests.ForEach(a => a.Deleted = true);
                    bdNotificationAccessRequest.Delete(notificationAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                notificationAccessRequests = bdNotificationAccessRequest.Get(new NotificationAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (notificationAccessRequests != null && notificationAccessRequests.Count > 0)
                {
                    notificationAccessRequests.ForEach(a => a.Deleted = true);
                    bdNotificationAccessRequest.Delete(notificationAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }
            catch (Exception ex)
            {
                return false;

            }

            return true;
        }

        private bool DeleteNotificationRequestsThatThisProfileHasGranted(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<NotificationAccessRequest> bdNotificationAccessRequest = new BaseDataAccess<NotificationAccessRequest>(readSettings);

                List<NotificationAccessRequest> notificationAccessRequests = bdNotificationAccessRequest.Get(new NotificationAccessRequest() { ProfileIDParent = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (notificationAccessRequests != null && notificationAccessRequests.Count > 0)
                {
                    notificationAccessRequests.ForEach(a => a.Deleted = true);
                    bdNotificationAccessRequest.Delete(notificationAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                notificationAccessRequests = bdNotificationAccessRequest.Get(new NotificationAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (notificationAccessRequests != null && notificationAccessRequests.Count > 0)
                {
                    notificationAccessRequests.ForEach(a => a.Deleted = true);
                    bdNotificationAccessRequest.Delete(notificationAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }


            catch (Exception ex)
            {
                return false;
            }

            return true;
        }



        private bool DeleteWebsiteLink(Profile profile, List<WebsiteLink> websiteLinkToDelete, ref SqlTransaction transaction,
BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            //TODO need to mark as deleted the individual WebsiteLink records and the Profile_WebsiteLink Records for this WebsiteLinkIDs
            // we also need to mark all WebsiteLink_WebsiteLink records as deleted for this WebsiteLinkID then WebsiteLinkRequests that "i am allowed to see",
            //and websiteLink requests that i am the child of a parent 

            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_WebsiteLink> bdProfile_WebsiteLink = new BaseDataAccess<Profile_WebsiteLink>(readSettings);

                BaseDataAccess<WebsiteLink> bdWebsiteLink = new BaseDataAccess<WebsiteLink>(readSettings);

                List<Profile_WebsiteLink> profile_websiteLinks = new List<Profile_WebsiteLink>();

                object returnValue = null;

                if (websiteLinkToDelete != null)
                {

                    foreach (WebsiteLink websiteLink in websiteLinkToDelete)
                    {
                        List<Profile_WebsiteLink> currentProfileWebsiteLinks = bdProfile_WebsiteLink.Get(new Profile_WebsiteLink() { WebsiteLinkID = websiteLink.WebsiteLinkID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentProfileWebsiteLinks != null && currentProfileWebsiteLinks.Count > 0)
                        {
                            profile_websiteLinks.AddRange(currentProfileWebsiteLinks);
                        }

                    }


                    if (profile_websiteLinks.Count > 0)
                    {
                        profile_websiteLinks.ForEach(a => a.Deleted = true);
                        bdProfile_WebsiteLink.Delete(profile_websiteLinks, _smoSettings[CONNECTION_STRING_NAME].Connection,
                            ref transaction, transactionBehavior, out returnValue);
                    }

                    websiteLinkToDelete.ForEach(a => a.Deleted = true);
                    bdWebsiteLink.Delete(websiteLinkToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);

                    if (isParent)
                        DeleteWebsiteLinkRequestsThatThisProfileHasGranted(profile, ref transaction,
                            transactionBehavior);
                    else
                        DeleteWebsiteLinkRequestsThatHaveBeenGrantedToThisProfile(profile, ref transaction,
                            transactionBehavior);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteWebsiteLinkRequestsThatHaveBeenGrantedToThisProfile(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<WebsiteLinkAccessRequest> bdWebsiteLinkAccessRequest = new BaseDataAccess<WebsiteLinkAccessRequest>(readSettings);

                //all the ones that have a ProfileIDChild as this ProfileID
                List<WebsiteLinkAccessRequest> websiteLinkAccessRequests = bdWebsiteLinkAccessRequest.Get(new WebsiteLinkAccessRequest() { ProfileIDChild = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (websiteLinkAccessRequests != null && websiteLinkAccessRequests.Count > 0)
                {
                    websiteLinkAccessRequests.ForEach(a => a.Deleted = true);
                    bdWebsiteLinkAccessRequest.Delete(websiteLinkAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                websiteLinkAccessRequests = bdWebsiteLinkAccessRequest.Get(new WebsiteLinkAccessRequest() { ProfileIDOtherProfileID = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (websiteLinkAccessRequests != null && websiteLinkAccessRequests.Count > 0)
                {
                    websiteLinkAccessRequests.ForEach(a => a.Deleted = true);
                    bdWebsiteLinkAccessRequest.Delete(websiteLinkAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteWebsiteLinkRequestsThatThisProfileHasGranted(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<WebsiteLinkAccessRequest> bdWebsiteLinkAccessRequest = new BaseDataAccess<WebsiteLinkAccessRequest>(readSettings);

                List<WebsiteLinkAccessRequest> websiteLinkAccessRequests = bdWebsiteLinkAccessRequest.Get(new WebsiteLinkAccessRequest() { ProfileIDParent = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (websiteLinkAccessRequests != null && websiteLinkAccessRequests.Count > 0)
                {
                    websiteLinkAccessRequests.ForEach(a => a.Deleted = true);
                    bdWebsiteLinkAccessRequest.Delete(websiteLinkAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                websiteLinkAccessRequests = bdWebsiteLinkAccessRequest.Get(new WebsiteLinkAccessRequest() { ProfileIDOtherProfileID = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (websiteLinkAccessRequests != null && websiteLinkAccessRequests.Count > 0)
                {
                    websiteLinkAccessRequests.ForEach(a => a.Deleted = true);
                    bdWebsiteLinkAccessRequest.Delete(websiteLinkAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }

            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteLibrary(Profile profile, List<Library> libraryToDelete, ref SqlTransaction transaction,
BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            //TODO need to mark as deleted the individual Library records and the Profile_Library Records for this LibraryIDs
            // we also need to mark all Library_Library records as deleted for this LibraryID then LibraryRequests that "i am allowed to see",
            //and library requests that i am the child of a parent 

            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_Library> bdProfile_Library = new BaseDataAccess<Profile_Library>(readSettings);

                BaseDataAccess<Library> bdLibrary = new BaseDataAccess<Library>(readSettings);

                List<Profile_Library> profile_librarys = new List<Profile_Library>();

                object returnValue = null;

                if (libraryToDelete != null)
                {
                    foreach (Library library in libraryToDelete)
                    {
                        List<Profile_Library> currentProfileLibrarys = bdProfile_Library.Get(new Profile_Library() { LibraryID = library.LibraryID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentProfileLibrarys != null && currentProfileLibrarys.Count > 0)
                        {
                            profile_librarys.AddRange(currentProfileLibrarys);
                        }

                    }


                    if (profile_librarys.Count > 0)
                    {
                        profile_librarys.ForEach(a => a.Deleted = true);
                        bdProfile_Library.Delete(profile_librarys, _smoSettings[CONNECTION_STRING_NAME].Connection,
                            ref transaction, transactionBehavior, out returnValue);
                    }

                    libraryToDelete.ForEach(a => a.Deleted = true);
                    bdLibrary.Delete(libraryToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);

                    if (isParent)
                        DeleteLibraryRequestsThatThisProfileHasGranted(profile, ref transaction,
                            transactionBehavior);
                    else
                        DeleteLibraryRequestsThatHaveBeenGrantedToThisProfile(profile, ref transaction,
                            transactionBehavior);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteLibraryRequestsThatHaveBeenGrantedToThisProfile(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<LibraryAccessRequest> bdLibraryAccessRequest = new BaseDataAccess<LibraryAccessRequest>(readSettings);

                //all the ones that have a ProfileIDChild as this ProfileID
                List<LibraryAccessRequest> libraryAccessRequests = bdLibraryAccessRequest.Get(new LibraryAccessRequest() { ProfileIDChild = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (libraryAccessRequests != null && libraryAccessRequests.Count > 0)
                {
                    libraryAccessRequests.ForEach(a => a.Deleted = true);
                    bdLibraryAccessRequest.Delete(libraryAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                libraryAccessRequests = bdLibraryAccessRequest.Get(new LibraryAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (libraryAccessRequests != null && libraryAccessRequests.Count > 0)
                {
                    libraryAccessRequests.ForEach(a => a.Deleted = true);
                    bdLibraryAccessRequest.Delete(libraryAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }
            catch (Exception ex)
            {
                return false;

            }

            return true;
        }

        private bool DeleteLibraryRequestsThatThisProfileHasGranted(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<LibraryAccessRequest> bdLibraryAccessRequest = new BaseDataAccess<LibraryAccessRequest>(readSettings);

                List<LibraryAccessRequest> libraryAccessRequests = bdLibraryAccessRequest.Get(new LibraryAccessRequest() { ProfileIDParent = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (libraryAccessRequests != null && libraryAccessRequests.Count > 0)
                {
                    libraryAccessRequests.ForEach(a => a.Deleted = true);
                    bdLibraryAccessRequest.Delete(libraryAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                libraryAccessRequests = bdLibraryAccessRequest.Get(new LibraryAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (libraryAccessRequests != null && libraryAccessRequests.Count > 0)
                {
                    libraryAccessRequests.ForEach(a => a.Deleted = true);
                    bdLibraryAccessRequest.Delete(libraryAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }


            catch (Exception ex)
            {
                return false;
            }

            return true;
        }


        private bool DeleteContent(Profile profile, List<Content> contentToDelete, ref SqlTransaction transaction,
           BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            //TODO need to mark as deleted the individual Content records and the Profile_Content Records for this ContentIDs
            // we also need to mark all Library_Content records as deleted for this ContentID then ContentRequests that "i am allowed to see",
            //and content requests that i am the child of a parent 

            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_Content> bdProfile_Content = new BaseDataAccess<Profile_Content>(readSettings);

                BaseDataAccess<Library_Content> bdLibrary_Content = new BaseDataAccess<Library_Content>(readSettings);

                BaseDataAccess<Content> bdContent = new BaseDataAccess<Content>(readSettings);

                List<Profile_Content> profile_contents = new List<Profile_Content>();
                List<Library_Content> library_contents = new List<Library_Content>();

                object returnValue = null;

                if (contentToDelete != null)
                {

                    foreach (Content content in contentToDelete)
                    {
                        List<Profile_Content> currentProfileContents = bdProfile_Content.Get(new Profile_Content() { ContentID = content.ContentID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentProfileContents != null && currentProfileContents.Count > 0)
                        {
                            profile_contents.AddRange(currentProfileContents);
                        }

                        List<Library_Content> currentLibraryContents = bdLibrary_Content.Get(new Library_Content() { ContentID = content.ContentID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentLibraryContents != null && currentLibraryContents.Count > 0)
                        {
                            library_contents.AddRange(currentLibraryContents);
                        }

                    }


                    if (profile_contents.Count > 0)
                    {
                        profile_contents.ForEach(a => a.Deleted = true);
                        bdProfile_Content.Delete(profile_contents, _smoSettings[CONNECTION_STRING_NAME].Connection,
                            ref transaction, transactionBehavior, out returnValue);
                    }

                    if (library_contents.Count > 0)
                    {
                        library_contents.ForEach(a => a.Deleted = true);
                        bdLibrary_Content.Delete(library_contents, _smoSettings[CONNECTION_STRING_NAME].Connection,
                            ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);
                    }

                    contentToDelete.ForEach(a => a.Deleted = true);
                    bdContent.Delete(contentToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);

                    if (isParent)
                        DeleteContentRequestsThatThisProfileHasGranted(profile, ref transaction,
                            transactionBehavior);
                    else
                        DeleteContentRequestsThatHaveBeenGrantedToThisProfile(profile, ref transaction,
                            transactionBehavior);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteContentRequestsThatHaveBeenGrantedToThisProfile(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<ContentAccessRequest> bdContentAccessRequest = new BaseDataAccess<ContentAccessRequest>(readSettings);

                //all the ones that have a ProfileIDChild as this ProfileID
                List<ContentAccessRequest> contentAccessRequests = bdContentAccessRequest.Get(new ContentAccessRequest() { ProfileIDChild = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (contentAccessRequests != null && contentAccessRequests.Count > 0)
                {
                    contentAccessRequests.ForEach(a => a.Deleted = true);
                    bdContentAccessRequest.Delete(contentAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                contentAccessRequests = bdContentAccessRequest.Get(new ContentAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (contentAccessRequests != null && contentAccessRequests.Count > 0)
                {
                    contentAccessRequests.ForEach(a => a.Deleted = true);
                    bdContentAccessRequest.Delete(contentAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }


        private bool DeleteContentRequestsThatThisProfileHasGranted(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<ContentAccessRequest> bdContentAccessRequest = new BaseDataAccess<ContentAccessRequest>(readSettings);

                List<ContentAccessRequest> contentAccessRequests = bdContentAccessRequest.Get(new ContentAccessRequest() { ProfileIDParent = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (contentAccessRequests != null && contentAccessRequests.Count > 0)
                {
                    contentAccessRequests.ForEach(a => a.Deleted = true);
                    bdContentAccessRequest.Delete(contentAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                contentAccessRequests = bdContentAccessRequest.Get(new ContentAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (contentAccessRequests != null && contentAccessRequests.Count > 0)
                {
                    contentAccessRequests.ForEach(a => a.Deleted = true);
                    bdContentAccessRequest.Delete(contentAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }


        private bool DeleteBlog(Profile profile, List<Blog> blogToDelete, ref SqlTransaction transaction,
   BaseDatabase.TransactionBehavior transactionBehavior, bool isParent)
        {
            //TODO need to mark as deleted the individual Blog records and the Profile_Blog Records for this BlogIDs
            // we also need to mark all Library_Blog records as deleted for this BlogID then BlogRequests that "i am allowed to see",
            //and blog requests that i am the child of a parent 

            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_Blog> bdProfile_Blog = new BaseDataAccess<Profile_Blog>(readSettings);

                BaseDataAccess<Blog> bdBlog = new BaseDataAccess<Blog>(readSettings);

                List<Profile_Blog> profile_blogs = new List<Profile_Blog>();

                object returnValue = null;

                if (blogToDelete != null)
                {
                    foreach (Blog blog in blogToDelete)
                    {
                        List<Profile_Blog> currentProfileBlogs = bdProfile_Blog.Get(new Profile_Blog() { BlogID = blog.BlogID },
                            GetPermutations.ByExplicitCriteria);

                        if (currentProfileBlogs != null && currentProfileBlogs.Count > 0)
                        {
                            profile_blogs.AddRange(currentProfileBlogs);
                        }
                    }

                    if (profile_blogs.Count > 0)
                    {
                        profile_blogs.ForEach(a => a.Deleted = true);
                        bdProfile_Blog.Delete(profile_blogs, _smoSettings[CONNECTION_STRING_NAME].Connection,
                            ref transaction, transactionBehavior, out returnValue);
                    }

                    blogToDelete.ForEach(a => a.Deleted = true);
                    bdBlog.Delete(blogToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);

                    if (isParent)
                        DeleteBlogRequestsThatThisProfileHasGranted(profile, ref transaction,
                            transactionBehavior);
                    else
                        DeleteBlogRequestsThatHaveBeenGrantedToThisProfile(profile, ref transaction,
                            transactionBehavior);
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteBlogRequestsThatHaveBeenGrantedToThisProfile(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<BlogAccessRequest> bdBlogAccessRequest = new BaseDataAccess<BlogAccessRequest>(readSettings);

                //all the ones that have a ProfileIDChild as this ProfileID
                List<BlogAccessRequest> blogAccessRequests = bdBlogAccessRequest.Get(new BlogAccessRequest() { ProfileIDChild = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (blogAccessRequests != null && blogAccessRequests.Count > 0)
                {
                    blogAccessRequests.ForEach(a => a.Deleted = true);
                    bdBlogAccessRequest.Delete(blogAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                blogAccessRequests = bdBlogAccessRequest.Get(new BlogAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (blogAccessRequests != null && blogAccessRequests.Count > 0)
                {
                    blogAccessRequests.ForEach(a => a.Deleted = true);
                    bdBlogAccessRequest.Delete(blogAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        private bool DeleteBlogRequestsThatThisProfileHasGranted(Profile profile,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            try
            {
                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                object returnValue = null;

                BaseDataAccess<BlogAccessRequest> bdBlogAccessRequest = new BaseDataAccess<BlogAccessRequest>(readSettings);

                List<BlogAccessRequest> blogAccessRequests = bdBlogAccessRequest.Get(new BlogAccessRequest() { ProfileIDParent = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (blogAccessRequests != null && blogAccessRequests.Count > 0)
                {
                    blogAccessRequests.ForEach(a => a.Deleted = true);
                    bdBlogAccessRequest.Delete(blogAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                //get the ones that this profile is the OtherID
                blogAccessRequests = bdBlogAccessRequest.Get(new BlogAccessRequest() { ProfileIDOtherProfile = profile.ProfileID },
                    GetPermutations.ByExplicitCriteria);

                if (blogAccessRequests != null && blogAccessRequests.Count > 0)
                {
                    blogAccessRequests.ForEach(a => a.Deleted = true);
                    bdBlogAccessRequest.Delete(blogAccessRequests, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }


        private bool DeleteEmailAddress(EmailAddress emailAddressToDelete, ref SqlTransaction transaction,
           BaseDatabase.TransactionBehavior transactionBehavior)
        {
            //TODO need to mark as deleted the EmailAddress and the Profile_EmailAddress records by this EmailAddressID
            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_EmailAddress> bdProfile_EmailAddress = new BaseDataAccess<Profile_EmailAddress>(readSettings);

                BaseDataAccess<EmailAddress> bdEmailAddress = new BaseDataAccess<EmailAddress>(readSettings);

                List<Profile_EmailAddress> profile_emailAddresss = bdProfile_EmailAddress.Get(new Profile_EmailAddress() { EmailAddressID = emailAddressToDelete.EmailAddressID },
                    GetPermutations.ByExplicitCriteria);

                object returnValue = null;

                if (profile_emailAddresss != null && profile_emailAddresss.Count > 0)
                {
                    profile_emailAddresss.ForEach(a => a.Deleted = true);
                    bdProfile_EmailAddress.Delete(profile_emailAddresss, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                emailAddressToDelete.Deleted = true;

                bdEmailAddress.Delete(emailAddressToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                    ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);


            }
            catch (Exception ex)
            {
                return false;
            }

            return true;

        }

        private bool DeleteAccount(Account accountToDelete, ref SqlTransaction transaction,
            BaseDatabase.TransactionBehavior transactionBehavior)
        {
            //TODO need to mark as deleted the Account and the Profile_Account records by this AccountID
            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);

                BaseDataAccess<Profile_Account> bdProfile_Account = new BaseDataAccess<Profile_Account>(readSettings);

                BaseDataAccess<Account> bdAccount = new BaseDataAccess<Account>(readSettings);

                List<Profile_Account> profile_accounts = bdProfile_Account.Get(new Profile_Account() { AccountID = accountToDelete.AccountID },
                    GetPermutations.ByExplicitCriteria);

                object returnValue = null;

                if (profile_accounts != null && profile_accounts.Count > 0)
                {
                    profile_accounts.ForEach(a => a.Deleted = true);
                    bdProfile_Account.Delete(profile_accounts, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                accountToDelete.Deleted = true;

                bdAccount.Delete(accountToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                    ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);


            }
            catch (Exception ex)
            {
                return false;
            }

            return true;

        }

        private bool DeletePerson(Person personToDelete, ref SqlTransaction transaction,
            CommonLibrary.Base.Database.BaseDatabase.TransactionBehavior transactionBehavior)
        {
            //TODO need to mark as deleted the Person_Address, Person_PhoneNumber records by this Person ID
            //accumulate the ids or get the xref records for these and then mark as deleted the PhoneNumbers and Addresses,
            //and finally Person
            try
            {

                BaseDatabase baseDatabase = new BaseDatabase();
                DatabaseSmoObjectsAndSettings readSettings =
                    baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);


                BaseDataAccess<Person_Address> bdPerson_Address = new BaseDataAccess<Person_Address>(readSettings);

                BaseDataAccess<Person_PhoneNumber> bdPerson_PhoneNumber = new BaseDataAccess<Person_PhoneNumber>(readSettings);

                List<Person_Address> person_Addresses = bdPerson_Address.Get(new Person_Address() { PersonID = personToDelete.PersonID },
                    GetPermutations.ByExplicitCriteria);

                List<Person_PhoneNumber> person_PhoneNumbers = bdPerson_PhoneNumber.Get(new Person_PhoneNumber() { PersonID = personToDelete.PersonID },
                    GetPermutations.ByExplicitCriteria);

                object returnValue = null;

                if (person_Addresses != null && person_Addresses.Count > 0)
                {

                    person_Addresses.ForEach(a => a.Deleted = true);
                    //what ever was passed is how we will use the transaction behavior but subsequent calls we explicitly say Enlist
                    bdPerson_Address.Delete(person_Addresses, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, transactionBehavior, out returnValue);
                }

                if (person_PhoneNumbers != null && person_PhoneNumbers.Count > 0)
                {
                    person_PhoneNumbers.ForEach(a => a.Deleted = true);
                    bdPerson_PhoneNumber.Delete(person_PhoneNumbers, _smoSettings[CONNECTION_STRING_NAME].Connection,
                  ref transaction, BaseDatabase.TransactionBehavior.Enlist,
                  out returnValue);
                }

                BaseDataAccess<Person> bdPerson = new BaseDataAccess<Person>(readSettings);

                personToDelete.Deleted = true;

                bdPerson.Delete(personToDelete, _smoSettings[CONNECTION_STRING_NAME].Connection,
                    ref transaction, BaseDatabase.TransactionBehavior.Enlist, out returnValue);
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        public Profile GetProfile(Profile profile, out Profile_Account profile_account)
        {


            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an account to delete
            //Get Profile_Account
            Profile_Account profileAccountCriteria = new Profile_Account() { ProfileID = profile.ProfileID };

            profile_account = null;

            BaseDataAccess<Profile_Account> bdProfile_Account =
                new BaseDataAccess<Profile_Account>(readSettings);

            List<Profile_Account> profile_accounts =
                bdProfile_Account.Get(profileAccountCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            Profile profileToDelete = null;

            if (profile_accounts != null && profile_accounts.Count > 0)
            {
                BaseDataAccess<Profile> bdProfile =
                new BaseDataAccess<Profile>(_smoSettings[CONNECTION_STRING_NAME]);

                profile_account = profile_accounts[0];

                profileToDelete = profile;

            }

            return profileToDelete;
        }


        public Profile GetProfile(Guid accountID, out Profile_Account profile_account)
        {

            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an account to delete
            //Get Profile_Account
            Profile_Account profileAccountCriteria = new Profile_Account() { AccountID = accountID };

            profile_account = null;

            BaseDataAccess<Profile_Account> bdProfile_Account =
                new BaseDataAccess<Profile_Account>(readSettings);

            List<Profile_Account> profile_accounts =
                bdProfile_Account.Get(profileAccountCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            Profile profileToDelete = null;

            if (profile_accounts != null && profile_accounts.Count > 0)
            {
                BaseDataAccess<Profile> bdProfile =
                new BaseDataAccess<Profile>(readSettings);

                profile_account = profile_accounts[0];

                Profile profileCriteria = new Profile() { ProfileID = profile_accounts[0].ProfileID };

                List<Profile> profiles = bdProfile.Get(profileCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (profiles != null && profiles.Count > 0)
                {
                    profileToDelete = profiles[0];
                }

            }

            return profileToDelete;
        }

        private Person GetPersonToDelete(Guid profileID, out Profile_Person profile_person)
        {


            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an person to delete
            //Get Profile_Person
            Profile_Person profilePersonCriteria = new Profile_Person() { ProfileID = profileID };

            profile_person = null;

            BaseDataAccess<Profile_Person> bdProfile_Person =
                new BaseDataAccess<Profile_Person>(readSettings);

            List<Profile_Person> profile_persons =
                bdProfile_Person.Get(profilePersonCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            Person personToDelete = null;

            if (profile_persons != null && profile_persons.Count > 0)
            {
                BaseDataAccess<Person> bdProfile =
                new BaseDataAccess<Person>(readSettings);

                profile_person = profile_persons[0];

                Person personCriteria = new Person() { PersonID = profile_persons[0].PersonID };

                List<Person> persons = bdProfile.Get(personCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (persons != null && persons.Count > 0)
                {
                    personToDelete = persons[0];
                }

            }

            return personToDelete;
        }

        private EmailAddress GetEmailAddressToDelete(Guid profileID, out Profile_EmailAddress profile_emailAddress)
        {

            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an emailAddress to delete
            //Get Profile_EmailAddress
            Profile_EmailAddress profileEmailAddressCriteria = new Profile_EmailAddress() { ProfileID = profileID };

            profile_emailAddress = null;

            BaseDataAccess<Profile_EmailAddress> bdProfile_EmailAddress =
                new BaseDataAccess<Profile_EmailAddress>(readSettings);

            List<Profile_EmailAddress> profile_emailAddresss =
                bdProfile_EmailAddress.Get(profileEmailAddressCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            EmailAddress emailAddressToDelete = null;

            if (profile_emailAddresss != null && profile_emailAddresss.Count > 0)
            {
                BaseDataAccess<EmailAddress> bdProfile =
                new BaseDataAccess<EmailAddress>(readSettings);

                profile_emailAddress = profile_emailAddresss[0];

                EmailAddress emailAddressCriteria = new EmailAddress() { EmailAddressID = profile_emailAddresss[0].EmailAddressID };

                List<EmailAddress> emailAddresss = bdProfile.Get(emailAddressCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (emailAddresss != null && emailAddresss.Count > 0)
                {
                    emailAddressToDelete = emailAddresss[0];
                }

            }

            return emailAddressToDelete;
        }

        private List<Content> GetContentToDelete(Guid profileID, out Profile_Content profile_content)
        {

            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an content to delete
            //Get Profile_Content
            Profile_Content profileContentCriteria = new Profile_Content() { ProfileID = profileID };

            List<Content> contentsToDelete = null;

            profile_content = null;

            BaseDataAccess<Profile_Content> bdProfile_Content =
                new BaseDataAccess<Profile_Content>(readSettings);

            List<Profile_Content> profile_contents =
                bdProfile_Content.Get(profileContentCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            BaseDataAccess<Content> bdContent =
               new BaseDataAccess<Content>(readSettings);

            foreach (Profile_Content profile_Content in profile_contents)
            {

                Content contentCriteria = new Content() { ContentID = profile_content.ContentID };

                List<Content> contents = bdContent.Get(contentCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (contents != null && contents.Count > 0)
                {
                    contentsToDelete.AddRange(contents);
                }

            }

            return contentsToDelete;
        }

        private List<Blog> GetBlogToDelete(Guid profileID, out Profile_Blog profile_blog)
        {

            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an blog to delete
            //Get Profile_Blog
            Profile_Blog profileBlogCriteria = new Profile_Blog() { ProfileID = profileID };

            List<Blog> blogsToDelete = null;

            profile_blog = null;

            BaseDataAccess<Profile_Blog> bdProfile_Blog =
                new BaseDataAccess<Profile_Blog>(readSettings);

            List<Profile_Blog> profile_blogs =
                bdProfile_Blog.Get(profileBlogCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            BaseDataAccess<Blog> bdBlog =
               new BaseDataAccess<Blog>(readSettings);

            foreach (Profile_Blog profile_Blog in profile_blogs)
            {

                Blog blogCriteria = new Blog() { BlogID = profile_blog.BlogID };

                List<Blog> blogs = bdBlog.Get(blogCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (blogs != null && blogs.Count > 0)
                {
                    blogsToDelete.AddRange(blogs);
                }

            }

            return blogsToDelete;
        }

        private List<Library> GetLibraryToDelete(Guid profileID, out Profile_Library profile_library)
        {

            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an library to delete
            //Get Profile_Library
            Profile_Library profileLibraryCriteria = new Profile_Library() { ProfileID = profileID };

            List<Library> librarysToDelete = null;

            profile_library = null;

            BaseDataAccess<Profile_Library> bdProfile_Library =
                new BaseDataAccess<Profile_Library>(readSettings);

            List<Profile_Library> profile_librarys =
                bdProfile_Library.Get(profileLibraryCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            BaseDataAccess<Library> bdLibrary =
               new BaseDataAccess<Library>(readSettings);

            foreach (Profile_Library profile_Library in profile_librarys)
            {

                Library libraryCriteria = new Library() { LibraryID = profile_library.LibraryID };

                List<Library> librarys = bdLibrary.Get(libraryCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (librarys != null && librarys.Count > 0)
                {
                    librarysToDelete.AddRange(librarys);
                }

            }

            return librarysToDelete;
        }

        private List<WebsiteLink> GetWebsiteLinkToDelete(Guid profileID, out Profile_WebsiteLink profile_websiteLink)
        {


            BaseDatabase baseDatabase = new BaseDatabase();
            DatabaseSmoObjectsAndSettings readSettings =
                baseDatabase.GetNewDatabaseSmoObjectsAndSettings(_smoSettings[CONNECTION_STRING_NAME].ConnectionString);
            //if we get here we have an websiteLink to delete
            //Get Profile_WebsiteLink
            Profile_WebsiteLink profileWebsiteLinkCriteria = new Profile_WebsiteLink() { ProfileID = profileID };

            List<WebsiteLink> websiteLinksToDelete = null;

            profile_websiteLink = null;

            BaseDataAccess<Profile_WebsiteLink> bdProfile_WebsiteLink =
                new BaseDataAccess<Profile_WebsiteLink>(readSettings);

            List<Profile_WebsiteLink> profile_websiteLinks =
                bdProfile_WebsiteLink.Get(profileWebsiteLinkCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

            BaseDataAccess<WebsiteLink> bdWebsiteLink =
               new BaseDataAccess<WebsiteLink>(readSettings);

            foreach (Profile_WebsiteLink profile_WebsiteLink in profile_websiteLinks)
            {

                WebsiteLink websiteLinkCriteria = new WebsiteLink() { WebsiteLinkID = profile_websiteLink.WebsiteLinkID };

                List<WebsiteLink> websiteLinks = bdWebsiteLink.Get(websiteLinkCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

                if (websiteLinks != null && websiteLinks.Count > 0)
                {
                    websiteLinksToDelete.AddRange(websiteLinks);
                }

            }

            return websiteLinksToDelete;
        }


        //public Account GetAccount(string username)
        //{
        //    BaseDataAccess<Account> bdAccount = new BaseDataAccess<Account>(_smoSettings[CONNECTION_STRING_NAME]);
        //    Account accountCriteria = new Account() { AccountUsername = username };
        //    List<Account> accounts = bdAccount.Get(accountCriteria, CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria);

        //    Account accountToDelete = null;

        //    if (accounts != null && accounts.Count > 0)
        //    {
        //        //TODO:  there really should only be one with this username as it is supposed to be unique, if there are more should
        //        //i raise an exception?
        //        accountToDelete = accounts[0];

        //    }
        //    return accountToDelete;
        //}



        /// <summary>
        /// i do not like how long this method is but all of these tables need to have inserts successfully as a whole
        /// or fail as a whole including the xrefs, this is probably the most complicated insert that we will see
        /// in this entire system.
        /// </summary>
        /// <param name="account"></param>
        /// <param name="person"></param>
        /// <param name="address"></param>
        /// <param name="phoneNumber"></param>
        /// <param name="emailAddress"></param>
        /// <param name="profileType"></param>
        /// <returns></returns>
        public bool Register(Account account,
            Person person,
            Address address,
            PhoneNumber phoneNumber,
            EmailAddress emailAddress,
            ProfileType profileType)
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

                    #region insert into individual tables

                    bool accountOk = InsertAccount(account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Begin);

                    if (!accountOk)
                    {
                        successful = false;
                        throw new ApplicationException("Account Insert Failed");
                    }

                    bool personOK = InsertPerson(person, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!personOK)
                    {
                        successful = false;
                        throw new ApplicationException("Person Insert Failed");
                    }

                    bool addressOK = InsertAddress(address, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!addressOK)
                    {
                        successful = false;
                        throw new ApplicationException("Address Insert Failed");
                    }

                    bool phoneNumberOK = InsertPhoneNumber(phoneNumber, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!phoneNumberOK)
                    {
                        successful = false;
                        throw new ApplicationException("PhoneNumber Insert Failed");
                    }

                    bool emailAddressOK = InsertEmailAddress(emailAddress, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!emailAddressOK)
                    {
                        successful = false;
                        throw new ApplicationException("EmailAddress Insert failed");
                    }

                    Profile profile = new Profile();
                    profile.ProfileTypeID = profileType.ProfileTypeID;

                    if (profile.ProfileTypeID == Guid.Empty)
                    {
                        profile.ProfileTypeID = GetProfileIdByProfileName(profileType.ProfileName);
                    }

                    bool profileOK = false;

                    if (profile.ProfileTypeID != Guid.Empty)
                    {
                        profileOK = InsertProfile(profile, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);
                    }

                    if (!profileOK)
                    {
                        successful = false;
                        throw new ApplicationException("Profile Insert Failed");
                    }

                    #endregion insert into individual tables

                    #region insert into xref tables

                    bool profile_AccountOK = InsertProfile_Account(profile, account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                        ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!profile_AccountOK)
                    {
                        successful = false;
                        throw new ApplicationException("Profile_Account Insert Failed");
                    }

                    bool profile_EmailAddressOK = InsertProfile_EmailAddress(profile, emailAddress, _smoSettings[CONNECTION_STRING_NAME].Connection,
                       ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!profile_EmailAddressOK)
                    {
                        successful = false;
                        throw new ApplicationException("Profile_EmailAddress Insert Failed");
                    }

                    bool profile_PersonOK = InsertProfile_Person(profile, person, _smoSettings[CONNECTION_STRING_NAME].Connection,
                      ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!profile_PersonOK)
                    {
                        successful = false;
                        throw new ApplicationException("Profile_Person Insert Failed");
                    }

                    bool person_AddressOK = InsertPerson_Address(person, address, _smoSettings[CONNECTION_STRING_NAME].Connection,
                      ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!person_AddressOK)
                    {
                        successful = false;
                        throw new ApplicationException("Person_Address Insert Failed");
                    }

                    bool person_PhoneNumberOK = InsertPerson_PhoneNumber(person, phoneNumber, _smoSettings[CONNECTION_STRING_NAME].Connection,
                      ref transaction, BaseDatabase.TransactionBehavior.Enlist);

                    if (!person_PhoneNumberOK)
                    {
                        successful = false;
                        throw new ApplicationException("Person_PhoneNumber Insert Failed");
                    }

                    #endregion insert into xref tables

                    if (successful == true)
                    {
                        baseDatabase.CommitTransaction(ref transaction);
                    }
                    else
                    {
                        throw new ApplicationException("Register Method in RegistrationDataAccess Failed, transaction has been rolled back");
                    }

                }
            }
            catch (Exception ex)
            {
                baseDatabase.RollbackTransaction(ref transaction);
                throw new ApplicationException("Register Method in RegistrationDataAccess Failed", ex);
            }

            return successful;

        }

        private Guid GetProfileIdByProfileName(string p)
        {
            throw new NotImplementedException();
        }

        private bool InsertAccount(Account account, SqlConnection connection,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Account> bdAccount = new BaseDataAccess<Account>(_smoSettings[CONNECTION_STRING_NAME]);

            if (string.IsNullOrEmpty(account.AccountUsername))
                throw new ArgumentNullException("AccountUsername");

            if (string.IsNullOrEmpty(account.AccountPassword))
                throw new ArgumentNullException("AccountPassword");

            //initialize values, this is necessary for the insert to work correctly
            account.AccountCode = "INTERNET_REGISTRATION";
            account.AccountID = Guid.NewGuid();
            account.Deleted = false;
            account.InsertedDateTime = DateTime.Now;
            account.ModifiedDateTime = DateTime.Now;
            //NH - special handling to store the hashed password

            string passwordPassedIn = account.AccountPassword;

            account.AccountPassword = HashSaltHelper.CreatePasswordHash(passwordPassedIn,
                    HashSaltHelper.CreateSalt());


            returnValue = bdAccount.Insert(account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertAccount = DoWeHaveASingleRecordInsertProblem(returnValue);

            account = (Account)returnValue;

            //opposite of whether we have a problem == success or failure to insert record
            return !insertAccount;
        }

        private bool InsertPerson(Person person, SqlConnection connection,
           ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Person> bdPerson = new BaseDataAccess<Person>(_smoSettings[CONNECTION_STRING_NAME]);

            if (string.IsNullOrEmpty(person.PersonFirstName))
                throw new ArgumentNullException("PersonFirstName");

            if (string.IsNullOrEmpty(person.PersonLastName))
                throw new ArgumentNullException("PersonLastName");

            person.PersonID = Guid.NewGuid();
            person.Deleted = false;
            person.InsertedDateTime = DateTime.Now;
            person.ModifiedDateTime = DateTime.Now;

            returnValue = bdPerson.Insert(person, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertPerson = DoWeHaveASingleRecordInsertProblem(returnValue);

            person = (Person)returnValue;

            return !insertPerson;
        }

        private bool InsertAddress(Address address, SqlConnection connection,
          ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Address> bdAddress = new BaseDataAccess<Address>(_smoSettings[CONNECTION_STRING_NAME]);

            if (address.AddressTypeID == Guid.Empty)
                throw new ArgumentNullException("AddressTypeID");

            if (string.IsNullOrEmpty(address.AddressStreet))
                throw new ArgumentNullException("AddressStreet");

            if (string.IsNullOrEmpty(address.AddressCity))
                throw new ArgumentNullException("AddressCity");

            if (string.IsNullOrEmpty(address.AddressCountry))
                throw new ArgumentNullException("AddressCountry");

            if (string.IsNullOrEmpty(address.AddressZipCode))
                throw new ArgumentNullException("AddressZipCode");

            address.AddressID = Guid.NewGuid();
            address.Deleted = false;
            address.InsertedDateTime = DateTime.Now;
            address.ModifiedDateTime = DateTime.Now;

            returnValue = bdAddress.Insert(address, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertAddress = DoWeHaveASingleRecordInsertProblem(returnValue);

            address = (Address)returnValue;

            return !insertAddress;
        }

        private bool InsertPhoneNumber(PhoneNumber phoneNumber, SqlConnection connection,
          ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<PhoneNumber> bdPhoneNumber = new BaseDataAccess<PhoneNumber>(_smoSettings[CONNECTION_STRING_NAME]);

            if (phoneNumber.PhoneNumberTypeID == Guid.Empty)
                throw new ArgumentNullException("PhoneNumberTypeID");

            if (string.IsNullOrEmpty(phoneNumber.PhoneNumber_Property))
                throw new ArgumentNullException("PhoneNumber_Property");

            phoneNumber.PhoneNumberID = Guid.NewGuid();
            phoneNumber.Deleted = false;
            phoneNumber.InsertedDateTime = DateTime.Now;
            phoneNumber.ModifiedDateTime = DateTime.Now;

            returnValue = bdPhoneNumber.Insert(phoneNumber, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertPhoneNumber = DoWeHaveASingleRecordInsertProblem(returnValue);

            phoneNumber = (PhoneNumber)returnValue;

            return !insertPhoneNumber;
        }

        private bool InsertEmailAddress(EmailAddress emailAddress, SqlConnection connection,
        ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            if (string.IsNullOrEmpty(emailAddress.EmailAddress_Property))
                throw new ArgumentNullException("EmailAddress_Property");

            emailAddress.EmailAddressID = Guid.NewGuid();

            emailAddress.Deleted = false;
            emailAddress.InsertedDateTime = DateTime.Now;
            emailAddress.ModifiedDateTime = DateTime.Now;


            BaseDataAccess<EmailAddress> bdEmailAddress = new BaseDataAccess<EmailAddress>(_smoSettings[CONNECTION_STRING_NAME]);
            returnValue = bdEmailAddress.Insert(emailAddress, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertEmailAddress = DoWeHaveASingleRecordInsertProblem(returnValue);

            emailAddress = (EmailAddress)returnValue;

            return !insertEmailAddress;
        }

        private bool InsertProfile(Profile profile, SqlConnection connection,
      ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Profile> bdProfile = new BaseDataAccess<Profile>(_smoSettings[CONNECTION_STRING_NAME]);

            if (profile.ProfileTypeID == Guid.Empty)
                throw new ArgumentNullException("ProfileTypeID");

            profile.ProfileID = Guid.NewGuid();
            profile.Deleted = false;
            profile.InsertedDateTime = DateTime.Now;
            profile.ModifiedDateTime = DateTime.Now;

            returnValue = bdProfile.Insert(profile, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertProfile = DoWeHaveASingleRecordInsertProblem(returnValue);

            profile = (Profile)returnValue;

            return !insertProfile;
        }

        private bool InsertProfile_Account(Profile profile, Account account, SqlConnection connection,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Profile_Account> bdAccount = new BaseDataAccess<Profile_Account>(_smoSettings[CONNECTION_STRING_NAME]);
            Profile_Account profile_Account = new Profile_Account();

            profile_Account.ProfileID = profile.ProfileID;
            profile_Account.AccountID = account.AccountID;

            profile_Account.Profile_AccountID = Guid.NewGuid();
            profile_Account.Deleted = false;
            profile_Account.InsertedDateTime = DateTime.Now;
            profile_Account.ModifiedDateTime = DateTime.Now;


            returnValue = bdAccount.Insert(profile_Account, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertProfile_Account = DoWeHaveASingleRecordInsertProblem(returnValue);

            profile_Account = (Profile_Account)returnValue;

            return !insertProfile_Account;
        }

        private bool InsertProfile_EmailAddress(Profile profile, EmailAddress EmailAddress, SqlConnection connection,
           ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Profile_EmailAddress> bdEmailAddress = new BaseDataAccess<Profile_EmailAddress>(_smoSettings[CONNECTION_STRING_NAME]);

            Profile_EmailAddress profile_EmailAddress = new Profile_EmailAddress();

            profile_EmailAddress.ProfileID = profile.ProfileID;
            profile_EmailAddress.EmailAddressID = EmailAddress.EmailAddressID;

            //TODO:  rename this property appropriately!!this should be Profile_EmailID...
            profile_EmailAddress.Profile_EmailAddressID = Guid.NewGuid();

            //TODO:  make email address consistent the other tables/classes by adding these properties
            profile_EmailAddress.Deleted = false;
            profile_EmailAddress.InsertedDateTime = DateTime.Now;
            profile_EmailAddress.ModifiedDateTime = DateTime.Now;

            returnValue = bdEmailAddress.Insert(profile_EmailAddress, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertProfile_EmailAddress = DoWeHaveASingleRecordInsertProblem(returnValue);

            profile_EmailAddress = (Profile_EmailAddress)returnValue;

            return !insertProfile_EmailAddress;
        }

        private bool InsertProfile_Person(Profile profile, Person Person, SqlConnection connection,
          ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Profile_Person> bdPerson = new BaseDataAccess<Profile_Person>(_smoSettings[CONNECTION_STRING_NAME]);

            Profile_Person profile_Person = new Profile_Person();

            profile_Person.ProfileID = profile.ProfileID;
            profile_Person.PersonID = Person.PersonID;

            //TODO:  Rename this appropriately the property should be Profile_PersonID!!
            profile_Person.Profile_PersonID = Guid.NewGuid();
            profile_Person.Deleted = false;
            profile_Person.InsertedDateTime = DateTime.Now;
            profile_Person.ModifiedDateTime = DateTime.Now;


            returnValue = bdPerson.Insert(profile_Person, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertProfile_Person = DoWeHaveASingleRecordInsertProblem(returnValue);

            profile_Person = (Profile_Person)returnValue;

            return !insertProfile_Person;
        }

        private bool InsertPerson_Address(Person Person, Address Address, SqlConnection connection,
            ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Person_Address> bdAddress = new BaseDataAccess<Person_Address>(_smoSettings[CONNECTION_STRING_NAME]);

            Person_Address person_Address = new Person_Address();

            person_Address.PersonID = Person.PersonID;
            person_Address.AddressID = Address.AddressID;

            person_Address.Person_AddressID = Guid.NewGuid();
            person_Address.Deleted = false;
            person_Address.InsertedDateTime = DateTime.Now;
            person_Address.ModifiedDateTime = DateTime.Now;

            returnValue = bdAddress.Insert(person_Address, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertPerson_Address = DoWeHaveASingleRecordInsertProblem(returnValue);

            person_Address = (Person_Address)returnValue;

            return !insertPerson_Address;
        }

        private bool InsertPerson_PhoneNumber(Person Person, PhoneNumber PhoneNumber, SqlConnection connection,
           ref SqlTransaction transaction, BaseDatabase.TransactionBehavior transactionBehavior)
        {
            object returnValue = null;

            BaseDataAccess<Person_PhoneNumber> bdPhoneNumber = new BaseDataAccess<Person_PhoneNumber>(_smoSettings[CONNECTION_STRING_NAME]);

            Person_PhoneNumber person_PhoneNumber = new Person_PhoneNumber();

            person_PhoneNumber.PersonID = Person.PersonID;
            person_PhoneNumber.PhoneNumberID = PhoneNumber.PhoneNumberID;

            person_PhoneNumber.Person_PhoneNumberID = Guid.NewGuid();
            person_PhoneNumber.Deleted = false;
            person_PhoneNumber.InsertedDateTime = DateTime.Now;
            person_PhoneNumber.ModifiedDateTime = DateTime.Now;


            returnValue = bdPhoneNumber.Insert(person_PhoneNumber, _smoSettings[CONNECTION_STRING_NAME].Connection,
                   ref transaction, transactionBehavior,
                   out returnValue);

            bool insertPerson_PhoneNumber = DoWeHaveASingleRecordInsertProblem(returnValue);

            person_PhoneNumber = (Person_PhoneNumber)returnValue;
            return !insertPerson_PhoneNumber;
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





        public EmailAddress GetEmailIfAssociatedWithAValidAccount(string email)
        {
            EmailAddress result = null;

            BaseDataAccess<EmailAddress> baseDataAccessEmailAddress = new BaseDataAccess<EmailAddress>(_smoSettings[CONNECTION_STRING_NAME]);

            EmailAddress emailDto = new EmailAddress();
            emailDto.EmailAddress_Property = email;

            List<EmailAddress> emailAddressesFound = baseDataAccessEmailAddress.Get(emailDto, GetPermutations.ByExplicitCriteria);
            BaseDataAccess<Profile_EmailAddress> baseDataAccessProfileEmailAddress = new BaseDataAccess<Profile_EmailAddress>(_smoSettings[CONNECTION_STRING_NAME]);
            BaseDataAccess<Profile_Account> baseDataAccessProfileAccount = new BaseDataAccess<Profile_Account>(_smoSettings[CONNECTION_STRING_NAME]);
            BaseDataAccess<Account> baseDataAccessAccount = new BaseDataAccess<Account>(_smoSettings[CONNECTION_STRING_NAME]);

            if (emailAddressesFound != null)
            {

                foreach (EmailAddress emailAddress in emailAddressesFound)
                {
                    List<Profile_EmailAddress> profileEmailAddressesFound = baseDataAccessProfileEmailAddress.Get(new Profile_EmailAddress() { EmailAddressID = emailAddress.EmailAddressID },
                        GetPermutations.ByExplicitCriteria);

                    if (profileEmailAddressesFound != null)
                    {
                        foreach (Profile_EmailAddress profile_emailaddress in profileEmailAddressesFound)
                        {
                            List<Profile_Account> profileAccountsFound = baseDataAccessProfileAccount.Get(
                                new Profile_Account() { ProfileID = profile_emailaddress.ProfileID },
                                GetPermutations.ByExplicitCriteria);

                            if (profileAccountsFound != null)
                            {
                                foreach (Profile_Account profileAccount in profileAccountsFound)
                                {
                                    List<Account> accountsFound = baseDataAccessAccount.Get(new Account() { AccountID = profileAccount.AccountID},
                                        GetPermutations.ByExplicitCriteria);

                                    if (accountsFound != null)
                                    {                                        
                                        result = emailAddress;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (result != null)
                    {
                        break;
                    }

                }
            }
            return result;
        }
        
    }

}
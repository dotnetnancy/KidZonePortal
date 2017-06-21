using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using AccountService;
using TestSprocGenerator.Business.SingleTable.Bo;
using CommonLibrary.Base.Database;
using CommonLibrary;
using AccountBusinessLayer;
using RegistrationBusinessLibrary;

namespace AccountServiceUnitTests
{
    [TestClass]
    public class UnitTestsAccountService
    {
        //[TestMethod]
        public void TestAccountInstantiation()
        {
            AccountService.AccountService serviceInstance = new AccountService.AccountService();
        }

       

        //[TestMethod]
        public void TestRegistrationInstantiation()
        {
            RegistrationService.RegistrationService registrationInstance = new RegistrationService.RegistrationService();
            Assert.IsTrue(registrationInstance != null);
        }

        [TestMethod]
        public void TestRegisterUser()
        {
            RegistrationService.RegistrationService registrationInstance = new RegistrationService.RegistrationService();

            DatabaseSmoObjectsAndSettings settings = registrationInstance.RegistrationManager_Property.SmoSettings[RegistrationManager.CONNECTION_STRING_NAME];

            bool didItExist = false;

            //first Delete everything then create a new registration for testing
            //For this test i need to make sure that an existing registration for this username does not exist
            bool deletedSuccess = registrationInstance.DeleteRegistration("testusername-registration", out didItExist);

            Assert.AreEqual<bool>(deletedSuccess, didItExist);

                Account account =
                new Account(settings)
                {
                    AccountID = Guid.NewGuid(),
                    AccountUsername = "testusername-registration",
                    AccountPassword = "testpassword-registration",
                    AccountCode = "REGISTRATION"
                };          

               

            Person person =
                new Person(settings)
                {
                    PersonID = Guid.NewGuid(),
                    PersonFirstName = "Register",
                    PersonMiddleInitials = "RG",
                    PersonLastName = "User"
                };
                
            Address address =
                new Address(settings)
                {
                    AddressID = Guid.NewGuid(),
                    AddressStreet = "1234 anytown",
                    AddressCity = "Bellingham",
                    AddressZipCode = "98229",
                    AddressCountry = "USA",
                    AddressTypeID = new Guid("74EE21B4-29F0-4EA9-B1C0-40CCD2D5BE00")
                };
                

            PhoneNumber phoneNumber =
                new PhoneNumber(settings)
                {
                    PhoneNumberTypeID = new Guid("B7CC6F6C-F435-4EF1-BFD8-92BCAFB2C4C3"),
                    PhoneNumber_Property = "555-123-4567"
                };

            EmailAddress emailAddress =
                new EmailAddress(settings)
                {
                    EmailAddressID = Guid.NewGuid(),
                    EmailAddress_Property = "test@test.com"
                };

            ProfileType profileType =
                new ProfileType(settings)
                {
                    ProfileTypeID = new Guid("4CCBD7AB-8725-41C8-93EA-CC5A14718A1D"),
                    ProfileName= "Administrator"
                };

            bool success = registrationInstance.Register(account,
                                                         person,
                                                         address,
                                                         phoneNumber,
                                                         emailAddress,
                                                         profileType);

            Assert.IsTrue(success);                                           


        }

        [TestMethod]
        public void TestLoginUser()
        {
            ConnectionStringHelper.GetConnectionStrings();
            AccountService.AccountService serviceInstance = new AccountService.AccountService();
            DatabaseSmoObjectsAndSettings settings = serviceInstance.AccountManager_Property.SmoSettings[AccountManager.CONNECTION_STRING_NAME];



            string username = "testusername-registration";
            string password = "testpassword-registration";

            //check if user exists
            //bool exists = serviceInstance.DoesUsernameExist(username);


            //if exists delete user
            //if (exists)
            //{
            //    serviceInstance.AccountDeleteByCriteria(new Account(settings) { AccountUsername = username });
            //}

            //create user
            //exists = serviceInstance.DoesUsernameExist(username);
            //Assert.IsFalse(exists);

            //serviceInstance.AccountCreate(new Account(settings) { AccountUsername = username, AccountPassword = password });

            ////login user
            //exists = serviceInstance.DoesUsernameExist(username);
            //Assert.IsTrue(exists);

            bool login = serviceInstance.LoginUser(username, password);
            Assert.IsTrue(login);

            ////delete user
            //bool deleted = serviceInstance.AccountDeleteByCriteria(new Account(settings) { AccountUsername = username });
            //Assert.IsTrue(deleted);

        }
    }
}

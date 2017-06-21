using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using log4net;
using System.Reflection;
using System.Web.Security;
using System.ServiceModel;
using CommonLibrary;
using TestSprocGenerator.Business.SingleTable.Bo;
using System.Net;
using System.Text;
using System.IO;

namespace KidZonePortal.aspnet.RegistrationManagement
{
    public class RegistrationPresenter
    {

        static ILog _log = null;
        IRegistrationView _view = null;

        static RegistrationPresenter()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public RegistrationPresenter(IRegistrationView view)
        {
            _view = view;
        }

        public bool Register(string username, string password,string firstName, string middleInits, string lastName,
            string streetAddress, string zipCode, string country, string city, string homePhone, string mobilePhone,
            string email, ProfileType profileType)
        {
            bool result = false;

            RegistrationServiceClient registrationClient =
             new RegistrationServiceClient();

            Account account =
             new Account()
             {
                 AccountID = Guid.NewGuid(),
                 AccountUsername = username,
                 AccountPassword = password,
                 AccountCode = "INTERNET-REGISTRATION"
             };

            Person person =
                new Person()
                {
                    PersonID = Guid.NewGuid(),
                    PersonFirstName = firstName,
                    PersonMiddleInitials = middleInits,
                    PersonLastName = lastName
                };

            Address address =
                new Address()
                {
                    AddressID = Guid.NewGuid(),
                    AddressStreet = streetAddress,
                    AddressCity = city,
                    AddressZipCode = zipCode,
                    AddressCountry = country,
                    //TODO:  hard coding this for now instead of having user choose the type of address
                    AddressTypeID = new Guid("74EE21B4-29F0-4EA9-B1C0-40CCD2D5BE00")
                };

            //TODO:  this is a problem but just store mobile for now            
            PhoneNumber phoneNumber =
                new PhoneNumber()
                {
                    PhoneNumberTypeID = new Guid("B7CC6F6C-F435-4EF1-BFD8-92BCAFB2C4C3"),
                    PhoneNumber_Property = mobilePhone
                };

            EmailAddress emailAddress =
                new EmailAddress()
                {
                    EmailAddressID = Guid.NewGuid(),
                    EmailAddress_Property = email
                };

            

            result = registrationClient.Register(account,
                                                         person,
                                                         address,
                                                         phoneNumber,
                                                         emailAddress,
                                                         profileType);
            return result;
        }



        public bool DoesEmailExist(string email)
        {
            bool result = false;

            RegistrationServiceClient registrationClient =
             new RegistrationServiceClient();

            result = registrationClient.DoesEmailExistForAccount(email);

            return result;
        }
    }

}
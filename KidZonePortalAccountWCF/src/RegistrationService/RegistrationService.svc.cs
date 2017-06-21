using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using RegistrationBusinessLibrary;
using log4net;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;
using System.ServiceModel.Activation;

namespace RegistrationService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    [ServiceBehavior(Namespace = "http://KidZonePortal.com/services/RegistrationServices",
        InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class RegistrationService : IRegistrationService
    {
       RegistrationManager _registrationManager = null;

        public RegistrationManager RegistrationManager_Property
        {
            get { return _registrationManager; }
            set { _registrationManager = value; }
        }

        static ILog _log = null;

        static RegistrationService()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
           
            //string processIdentity = System.Security.Principal.WindowsIdentity.GetCurrent().Name;

            //CommonLibrary.Base.Database.ConnectionStringHelper.ProtectConfiguration();           
        }

        public RegistrationService()
        {
            if (_registrationManager == null)
                _registrationManager = new RegistrationManager();
        }

      


        public bool Register(TestSprocGenerator.Business.SingleTable.Bo.Account accountInfo,
            TestSprocGenerator.Business.SingleTable.Bo.Person personInfo,
            TestSprocGenerator.Business.SingleTable.Bo.Address addressInfo,
            TestSprocGenerator.Business.SingleTable.Bo.PhoneNumber phoneNumberInfo,
            TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressInfo,
            TestSprocGenerator.Business.SingleTable.Bo.ProfileType profileType)
        {
            return _registrationManager.Register(accountInfo, personInfo, 
                                                addressInfo, phoneNumberInfo, 
                                                emailAddressInfo, profileType);
        }

        public bool DeleteRegistration(string username, out bool didItExist)
        {            
            return _registrationManager.DeleteRegistration(username, out didItExist);
        }
       
        public bool DoesEmailExistForAccount(string email)
        {
            return _registrationManager.DoesEmailExist(email);
        }
    }
}

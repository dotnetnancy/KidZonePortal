using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace RegistrationService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract(Namespace = "http://KidZonePortal.com/services/RegistrationServices")]
    public interface IRegistrationService
    {

        [OperationContract(Name="DoesEmailExistForAccount")]
        bool DoesEmailExistForAccount(string email);


        [OperationContract(Name="Register")]
        bool Register(Account accountInfo,
                        Person personInfo,
                        Address addressInfo,
                        PhoneNumber phoneNumberInfo,
                        EmailAddress emailAddressInfo,
                        ProfileType profileType);

        [OperationContract(Name = "DeleteRegistration")]
        bool DeleteRegistration(string username, out bool didItExist);
       
    }
}

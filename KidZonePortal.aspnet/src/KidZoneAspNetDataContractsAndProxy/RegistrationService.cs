﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.235
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
[System.ServiceModel.ServiceContractAttribute(Namespace="http://KidZonePortal.com/services/RegistrationServices", ConfigurationName="IRegistrationService")]
public interface IRegistrationService
{
    
    [System.ServiceModel.OperationContractAttribute(Action="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/DoesE" +
        "mailExistForAccount", ReplyAction="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/DoesE" +
        "mailExistForAccountResponse")]
    bool DoesEmailExistForAccount(string email);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/Regis" +
        "ter", ReplyAction="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/Regis" +
        "terResponse")]
    bool Register(TestSprocGenerator.Business.SingleTable.Bo.Account accountInfo, TestSprocGenerator.Business.SingleTable.Bo.Person personInfo, TestSprocGenerator.Business.SingleTable.Bo.Address addressInfo, TestSprocGenerator.Business.SingleTable.Bo.PhoneNumber phoneNumberInfo, TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressInfo, TestSprocGenerator.Business.SingleTable.Bo.ProfileType profileType);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/Delet" +
        "eRegistration", ReplyAction="http://KidZonePortal.com/services/RegistrationServices/IRegistrationService/Delet" +
        "eRegistrationResponse")]
    bool DeleteRegistration(out bool didItExist, string username);
}

[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public interface IRegistrationServiceChannel : IRegistrationService, System.ServiceModel.IClientChannel
{
}

[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public partial class RegistrationServiceClient : System.ServiceModel.ClientBase<IRegistrationService>, IRegistrationService
{
    
    public RegistrationServiceClient()
    {
    }
    
    public RegistrationServiceClient(string endpointConfigurationName) : 
            base(endpointConfigurationName)
    {
    }
    
    public RegistrationServiceClient(string endpointConfigurationName, string remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public RegistrationServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public RegistrationServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(binding, remoteAddress)
    {
    }
    
    public bool DoesEmailExistForAccount(string email)
    {
        return base.Channel.DoesEmailExistForAccount(email);
    }
    
    public bool Register(TestSprocGenerator.Business.SingleTable.Bo.Account accountInfo, TestSprocGenerator.Business.SingleTable.Bo.Person personInfo, TestSprocGenerator.Business.SingleTable.Bo.Address addressInfo, TestSprocGenerator.Business.SingleTable.Bo.PhoneNumber phoneNumberInfo, TestSprocGenerator.Business.SingleTable.Bo.EmailAddress emailAddressInfo, TestSprocGenerator.Business.SingleTable.Bo.ProfileType profileType)
    {
        return base.Channel.Register(accountInfo, personInfo, addressInfo, phoneNumberInfo, emailAddressInfo, profileType);
    }
    
    public bool DeleteRegistration(out bool didItExist, string username)
    {
        return base.Channel.DeleteRegistration(out didItExist, username);
    }
}

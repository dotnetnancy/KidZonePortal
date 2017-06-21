﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.235
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestSprocGenerator.Data.SingleTable.Dto
{
    using System.Runtime.Serialization;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Account", Namespace="http://schemas.datacontract.org/2004/07/TestSprocGenerator.Data.SingleTable.Dto")]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(TestSprocGenerator.Business.SingleTable.Bo.Account))]
    public partial class Account : object, System.Runtime.Serialization.IExtensibleDataObject
    {
        
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        private string AccountCodeField;
        
        private System.Guid AccountIDField;
        
        private string AccountPasswordField;
        
        private string AccountUsernameField;
        
        private bool DeletedField;
        
        private System.DateTime InsertedDateTimeField;
        
        private System.Collections.Generic.Dictionary<string, bool> IsModifiedDictionaryField;
        
        private System.DateTime ModifiedDateTimeField;
        
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData
        {
            get
            {
                return this.extensionDataField;
            }
            set
            {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string AccountCode
        {
            get
            {
                return this.AccountCodeField;
            }
            set
            {
                this.AccountCodeField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Guid AccountID
        {
            get
            {
                return this.AccountIDField;
            }
            set
            {
                this.AccountIDField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string AccountPassword
        {
            get
            {
                return this.AccountPasswordField;
            }
            set
            {
                this.AccountPasswordField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string AccountUsername
        {
            get
            {
                return this.AccountUsernameField;
            }
            set
            {
                this.AccountUsernameField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool Deleted
        {
            get
            {
                return this.DeletedField;
            }
            set
            {
                this.DeletedField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.DateTime InsertedDateTime
        {
            get
            {
                return this.InsertedDateTimeField;
            }
            set
            {
                this.InsertedDateTimeField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Collections.Generic.Dictionary<string, bool> IsModifiedDictionary
        {
            get
            {
                return this.IsModifiedDictionaryField;
            }
            set
            {
                this.IsModifiedDictionaryField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.DateTime ModifiedDateTime
        {
            get
            {
                return this.ModifiedDateTimeField;
            }
            set
            {
                this.ModifiedDateTimeField = value;
            }
        }
    }
}
namespace TestSprocGenerator.Business.SingleTable.Bo
{
    using System.Runtime.Serialization;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Account", Namespace="http://schemas.datacontract.org/2004/07/TestSprocGenerator.Business.SingleTable.B" +
        "o")]
    public partial class Account : TestSprocGenerator.Data.SingleTable.Dto.Account
    {
        
        private CommonLibrary.DatabaseSmoObjectsAndSettings DatabaseSmoObjectsAndSettingsField;
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public CommonLibrary.DatabaseSmoObjectsAndSettings DatabaseSmoObjectsAndSettings
        {
            get
            {
                return this.DatabaseSmoObjectsAndSettingsField;
            }
            set
            {
                this.DatabaseSmoObjectsAndSettingsField = value;
            }
        }
    }
}
namespace CommonLibrary
{
    using System.Runtime.Serialization;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="DatabaseSmoObjectsAndSettings", Namespace="http://schemas.datacontract.org/2004/07/CommonLibrary")]
    public partial class DatabaseSmoObjectsAndSettings : object, System.Runtime.Serialization.IExtensibleDataObject
    {
        
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData
        {
            get
            {
                return this.extensionDataField;
            }
            set
            {
                this.extensionDataField = value;
            }
        }
    }
}


[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
[System.ServiceModel.ServiceContractAttribute(ConfigurationName="IAccountService")]
public interface IAccountService
{
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/DoesUsernameExist", ReplyAction="http://tempuri.org/IAccountService/DoesUsernameExistResponse")]
    bool DoesUsernameExist(string username);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/LoginUser", ReplyAction="http://tempuri.org/IAccountService/LoginUserResponse")]
    bool LoginUser(string username, string password);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountCreate", ReplyAction="http://tempuri.org/IAccountService/AccountCreateResponse")]
    bool AccountCreate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountDeleteByCriteria", ReplyAction="http://tempuri.org/IAccountService/AccountDeleteByCriteriaResponse")]
    bool AccountDeleteByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountDeleteByPrimaryKey", ReplyAction="http://tempuri.org/IAccountService/AccountDeleteByPrimaryKeyResponse")]
    bool AccountDeleteByPrimaryKey(System.Guid accountID);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountUpdate", ReplyAction="http://tempuri.org/IAccountService/AccountUpdateResponse")]
    bool AccountUpdate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountRetrieveByCriteria", ReplyAction="http://tempuri.org/IAccountService/AccountRetrieveByCriteriaResponse")]
    TestSprocGenerator.Business.SingleTable.Bo.Account[] AccountRetrieveByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel);
    
    [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IAccountService/AccountRetrieveByUsernameAndPassword", ReplyAction="http://tempuri.org/IAccountService/AccountRetrieveByUsernameAndPasswordResponse")]
    TestSprocGenerator.Business.SingleTable.Bo.Account AccountRetrieveByUsernameAndPassword(string username, string password);
}

[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public interface IAccountServiceChannel : IAccountService, System.ServiceModel.IClientChannel
{
}

[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
public partial class AccountServiceClient : System.ServiceModel.ClientBase<IAccountService>, IAccountService
{
    
    public AccountServiceClient()
    {
    }
    
    public AccountServiceClient(string endpointConfigurationName) : 
            base(endpointConfigurationName)
    {
    }
    
    public AccountServiceClient(string endpointConfigurationName, string remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public AccountServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(endpointConfigurationName, remoteAddress)
    {
    }
    
    public AccountServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
            base(binding, remoteAddress)
    {
    }
    
    public bool DoesUsernameExist(string username)
    {
        return base.Channel.DoesUsernameExist(username);
    }
    
    public bool LoginUser(string username, string password)
    {
        return base.Channel.LoginUser(username, password);
    }
    
    public bool AccountCreate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
    {
        return base.Channel.AccountCreate(accountModel);
    }
    
    public bool AccountDeleteByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
    {
        return base.Channel.AccountDeleteByCriteria(accountModel);
    }
    
    public bool AccountDeleteByPrimaryKey(System.Guid accountID)
    {
        return base.Channel.AccountDeleteByPrimaryKey(accountID);
    }
    
    public bool AccountUpdate(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
    {
        return base.Channel.AccountUpdate(accountModel);
    }
    
    public TestSprocGenerator.Business.SingleTable.Bo.Account[] AccountRetrieveByCriteria(TestSprocGenerator.Business.SingleTable.Bo.Account accountModel)
    {
        return base.Channel.AccountRetrieveByCriteria(accountModel);
    }
    
    public TestSprocGenerator.Business.SingleTable.Bo.Account AccountRetrieveByUsernameAndPassword(string username, string password)
    {
        return base.Channel.AccountRetrieveByUsernameAndPassword(username, password);
    }
}

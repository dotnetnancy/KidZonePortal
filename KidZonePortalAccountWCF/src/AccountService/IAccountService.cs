using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using TestSprocGenerator.Business.SingleTable.Bo;
using System.ServiceModel.Activation;

namespace AccountService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IAccountService
    {

       //this one is called from an ajax function on a page
        [OperationContract(Name = "DoesUsernameExist")]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, 
        ResponseFormat = WebMessageFormat.Json)]
        bool DoesUsernameExist(string username);      

        [OperationContract(Name = "LoginUser")]
        [WebInvoke(Method = "POST", BodyStyle=WebMessageBodyStyle.WrappedRequest,
        ResponseFormat = WebMessageFormat.Json)]
        bool LoginUser(string username, string password);

        [OperationContract(Name = "AccountCreate")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool AccountCreate(Account accountModel);

        [OperationContract(Name = "AccountDeleteByCriteria")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool AccountDeleteByCriteria(Account accountModel);

        [OperationContract(Name = "AccountDeleteByPrimaryKey")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool AccountDeleteByPrimaryKey(Guid accountID);

        [OperationContract(Name = "AccountUpdate")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool AccountUpdate(Account accountModel);

        [OperationContract(Name = "AccountRetrieveByCriteria")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        List<Account> AccountRetrieveByCriteria(Account accountModel);

        [OperationContract(Name = "AccountRetrieveByUsernameAndPassword")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        Account AccountRetrieveByUsernameAndPassword(string username, string password);

        [OperationContract(Name = "ResetPasswordRequest")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        string ResetPasswordRequest(string username, string email);

        [OperationContract(Name = "SendTestEmail")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool SendTestEmail(string email);

        [OperationContract(Name = "ResetPassword")]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.WrappedRequest)]
        bool ResetPassword(string username, string email, string passwordResetRequestCode, string newPassword);
 
       

       
    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    //[DataContract]
    //public class CompositeType
    //{
    //    bool boolValue = true;
    //    string stringValue = "Hello ";

    //    [DataMember]
    //    public bool BoolValue
    //    {
    //        get { return boolValue; }
    //        set { boolValue = value; }
    //    }

    //    [DataMember]
    //    public string StringValue
    //    {
    //        get { return stringValue; }
    //        set { stringValue = value; }
    //    }
    //}
}

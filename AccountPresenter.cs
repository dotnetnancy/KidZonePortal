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


namespace KidZonePortal.aspnet.AccountManagement
{
    public class AccountPresenter
    {

        static ILog _log = null;        
        IAccountView _view = null;
        

        static AccountPresenter()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public AccountPresenter(IAccountView view)
        {
            _view = view;
        }

        public bool Login(string username, string password)
        {
            
            //custom authentication
            AccountServiceClient client = null;            
            
            try
            {
               
                client = new AccountServiceClient();
                bool authenticated = client.LoginUser(username, password);

                if (authenticated)
                {
                    Account accountCriteria = new Account();
                    accountCriteria.AccountUsername = username;
                    accountCriteria.AccountPassword = password;
                    
                    _view.Accounts = client.AccountRetrieveByCriteria(accountCriteria).ToList();
                    _view.TitleForDisplay = "Login Successful";
                }
                else
                {
                    _view.Accounts = null;
                    _view.TitleForDisplay = "Sorry, username and/or password are not correct";
                    return false;
                }

            }
            catch (TimeoutException te)
            {
                _log.Fatal(te);

            }
            catch (FaultException fe)
            {
                _log.Fatal(fe);

            }
            catch (CommunicationException ce)
            {

                _log.Fatal(ce);
            }

            catch (Exception ex)
            {

                _log.Fatal(ex);
            }

            finally
            {
                if (client != null)
                {
                    client.CloseProxy();
                }

            }
           
            return true;
        }
    }

    
}
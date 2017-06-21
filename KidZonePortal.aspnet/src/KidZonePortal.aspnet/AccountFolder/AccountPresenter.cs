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

        public bool DoesUsernameExist(string username)
        {
            bool usernameExists = true;

            try
            {
                WebRequest request = HttpWebRequest.Create("http://localhost/AccountService/AccountService.svc/DoesUsernameExist");
                request.Method = "POST";
                request.ContentType = "application/json";

                StringBuilder data = new StringBuilder();
                data.Append("{\"username\":\"" + username + "\"}");

                // Create a byte array of the data we want to send
                byte[] byteData = UTF8Encoding.UTF8.GetBytes(data.ToString());

                // Set the content length in the request headers
                request.ContentLength = byteData.Length;

                // Write data
                using (Stream postStream = request.GetRequestStream())
                {
                    postStream.Write(byteData, 0, byteData.Length);
                }

                string output = null;

                // Get response
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    // Get the response stream
                    StreamReader reader = new StreamReader(response.GetResponseStream());

                    output = reader.ReadToEnd();
                }

                bool flag = default(bool);
                if (bool.TryParse(output, out flag))
                {
                    usernameExists = flag;
                }
                else
                {

                    if (!string.IsNullOrEmpty(output))
                    {
                        usernameExists = GetBooleanValueFromJsonString(output);
                    }
                }

            }
            catch (Exception)
            {
                usernameExists = true;
            }

            if (usernameExists)
            {
                _view.Accounts = null;
                _view.TitleForDisplay = "Sorry, username is in use already";
            }
            else
            {
                _view.Accounts = null;
                _view.TitleForDisplay = "Username is not in use already";
            }
            return usernameExists;
        }


        public bool Login(string username, string password)
        {
            bool authenticated = false;

            try
            {
                WebRequest request = HttpWebRequest.Create("http://localhost/AccountService/AccountService.svc/LoginUser");
                request.Method = "POST";
                request.ContentType = "application/json";

                StringBuilder data = new StringBuilder();
                data.Append("{\"username\":\"" + username + "\",");
                data.Append("\"password\":\"" + password + "\"}");

                // Create a byte array of the data we want to send
                byte[] byteData = UTF8Encoding.UTF8.GetBytes(data.ToString());

                // Set the content length in the request headers
                request.ContentLength = byteData.Length;

                // Write data
                using (Stream postStream = request.GetRequestStream())
                {
                    postStream.Write(byteData, 0, byteData.Length);
                }

                string output = null;

                // Get response
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    // Get the response stream
                    StreamReader reader = new StreamReader(response.GetResponseStream());

                    output = reader.ReadToEnd();
                }

                //not sure what happened here it may be the way my client calls right now but the response is not json
                //it can be also just plain true or false
                bool flag = default(bool);
                if (bool.TryParse(output, out flag))
                {
                    authenticated = flag;
                }
                else
                {

                    if (!string.IsNullOrEmpty(output))
                    {
                        authenticated = GetBooleanValueFromJsonString(output);
                    }
                }

            }
            catch (Exception ex)
            {
                authenticated = false;
                _view.TitleForDisplay = ex.StackTrace;
            }

            if (authenticated)
            {
                _view.Accounts = null;
                _view.TitleForDisplay = "Login Successful";
            }
            else
            {
                _view.Accounts = null;
                _view.TitleForDisplay = "Sorry, username and/or password are not correct";
            }
            return authenticated;
        }
      

        private bool GetBooleanValueFromJsonString(string output)
        {
            bool authenticated = false;
            //we know that we are looking for something that looks like:
            //{d:true} or {d:false}
            string[] strings = output.Split(':');

            if (strings.Length == 2)
            {
                //then we at least have a 2 part json string returned if greater than or less than 2 parts we did not get
                //what we are expecting we should now have 2 parts {d and either true} or false}
                if (strings[1].ToLower().Contains("true")) 
                {
                    authenticated = true;
                }              
            }
            return authenticated;
        }

        public bool LoginAndRedirect(string username, string password)
        {
            bool authenticated = this.Login(username, password);
            if (authenticated)
            {                
                FormsAuthentication.RedirectFromLoginPage(username, false);
            }
            return authenticated;
        }

        public string ResetPasswordRequest(string username, string email)
        {
            //here we would make our wcf service call or do a webhttp request
            //for the purposes of this demo return the password code and fill the password code box, indicate that
            //on the page to the consumer that they would have gotten an email otherwise
            AccountServiceClient client = null;
            bool result = false;
            string passwordResetCode = null;

            try
            {
                client = new AccountServiceClient();
                passwordResetCode = client.ResetPasswordRequest(username, email);
                
                result = true;
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

            if (result)
            {
                return passwordResetCode;
            }
            return "There was an error and password reset code was not generated successfully";

        }

        public bool ResetPassword(string username, string email, string passwordResetCode, string newPassword)
        {
            //here we would make our wcf service call or do a webhttp request
            //for the purposes of this demo return the password code and fill the password code box, indicate that
            //on the page to the consumer that they would have gotten an email otherwise
            AccountServiceClient client = null;
            bool result = false;            

            try
            {
                client = new AccountServiceClient();
                result = client.ResetPassword(username, email,passwordResetCode,newPassword);
                
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
            return result;
        }

    }
    
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using KidZonePortal.aspnet.AccountManagement;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;
using System.Web.Security;

namespace KidZonePortal.aspnet.AccountNamespace
{
    public partial class KidZoneLogin : System.Web.UI.Page,IAccountView
    {
        static ILog _log = null;
        static AccountPresenter _presenter = null;
        static string _titleToDisplay = string.Empty;

        static KidZoneLogin()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _presenter = new AccountPresenter(this);
            Control navControl = Master.Page.Controls[0].FindControl("NavigationMenu");

            if (navControl != null)
            {
                navControl.Visible = false;
            }         
        }

        protected void btnLogon_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            bool authenticated = _presenter.Login(username, password);
            if (authenticated)
                FormsAuthentication.RedirectFromLoginPage(username, false);
            else
            {
                lblErrors.Text = _titleToDisplay;
                lblErrors.Text += Environment.NewLine;
                lblErrors.Text += " OR Account is disabled.  Check your email address associated with the account if you have attempted to Reset password, you will need to provide the Reset Password Code to successfully change your password.  In the meantime the Account would remain disabled if you did not provide the Password Reset Code.";
            }
      

        }


        #region IAccountView implementation

        List<Account> IAccountView.Accounts
        {
            get
            {
                return ((List<Account>)Session["Account"]);
            }
            set
            {
                Session["Account"] = value;
            }
        }

        string IAccountView.TitleForDisplay
        {
            get
            {
                return _titleToDisplay;
            }
            set
            {
                _titleToDisplay = value;
            }
        }

        #endregion IAccountView implementation

       

        
        
    }
    
}

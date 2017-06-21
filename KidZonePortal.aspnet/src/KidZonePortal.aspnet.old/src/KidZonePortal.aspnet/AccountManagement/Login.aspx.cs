using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using TestSprocGenerator.Business.SingleTable.Bo;
using log4net;
using System.Reflection;
using System.ServiceModel;
using CommonLibrary;

namespace KidZonePortal.aspnet.AccountManagement
{
    public partial class Login : System.Web.UI.Page,IAccountView
    {
       

        static ILog _log = null;
        static AccountPresenter _presenter = null;
        static string _titleToDisplay = string.Empty;

        static Login()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _presenter = new AccountPresenter(this);
         
        }

        protected void btnLogon_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            bool authenticated = _presenter.Login(username, password);
            if (authenticated)
                FormsAuthentication.RedirectFromLoginPage(username, false);
            else
                lblErrors.Text = _titleToDisplay;           

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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KidZonePortal.aspnet.AccountManagement;
using log4net;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;
using KidZonePortal.aspnet.RegistrationManagement;

namespace KidZonePortal.aspnet.AccountFolder
{
    public partial class ResetPassword : System.Web.UI.Page,IAccountView,IRegistrationView
    {
        static ILog _log = null;      
        static AccountPresenter _accountPresenter = null;
        static RegistrationPresenter _registrationPresenter = null;

        static string _titleToDisplay = string.Empty;

        static ResetPassword()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {           
            _accountPresenter = new AccountManagement.AccountPresenter(this);
            _registrationPresenter = new RegistrationPresenter(this);

            Control navControl = Master.Page.Controls[0].FindControl("NavigationMenu");

            if (navControl != null)
            {
                navControl.Visible = false;
            }

            if (Page.IsPostBack)
            {
                if (string.IsNullOrEmpty(txtChangePasswordCode.Text))
                {
                    string resetCodeGeneratedOrRetrieved = _accountPresenter.ResetPasswordRequest(txtUsername.Text, txtEmail.Text);
                    txtChangePasswordCode.Text = resetCodeGeneratedOrRetrieved;
                    txtPassword.Visible = true;
                    txtConfirmPassword.Visible = true;
                    txtPassword.Focus();
                    
                }
                else
                {
                    bool resultOfResetPassword = _accountPresenter.ResetPassword(txtUsername.Text, txtEmail.Text, txtChangePasswordCode.Text, txtPassword.Text);
                    if (resultOfResetPassword)
                    {
                        lblErrors.Text = "Password Change was successful";
                    }
                    else
                    {
                        lblErrors.Text = "Password Change was not successful";
                    }
                }                
            }          

        }

        protected void customUsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = false;
            if (!string.IsNullOrEmpty(txtUsername.Text))
            {
                if (_accountPresenter.DoesUsernameExist(txtUsername.Text))
                {
                    args.IsValid = true;
                    this.txtChangePasswordCode.Focus();
                }
               
            }
        }

        protected void customEmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = false;
            if (!string.IsNullOrEmpty(txtEmail.Text))
            {
                if (_registrationPresenter.DoesEmailExist(txtEmail.Text))
                {
                    args.IsValid = true;
                    this.txtChangePasswordCode.Focus();
                }
               
            }
        }

        List<Account> IAccountView.Accounts
        {
            get
            {
                return ((List<Account>)Session["RegistrationAccount"]);
            }
            set
            {
                Session["RegistrationAccount"] = value;
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
    }
}
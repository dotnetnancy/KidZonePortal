using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using KidZonePortal.aspnet.CountryCityProvinceManagement;
using System.Reflection;
using TestSprocGenerator.Business.SingleTable.Bo;
using KidZonePortal.aspnet.AccountManagement;
using KidZonePortal.aspnet.ProfileManagement;
using System.Text.RegularExpressions;
using KidZonePortal.aspnet.RegistrationManagement;
using System.Text;

namespace KidZonePortal.aspnet.AccountNamespace
{
    public partial class Register : System.Web.UI.Page, ICountryCityProvinceView,IAccountView, IProfileView,
        IRegistrationView
    {

        static ILog _log = null;
        static CountryCityProvincePresenter _presenter = null;
        static AccountPresenter _accountPresenter = null;
        static ProfilePresenter _profilePresenter = null;
        static RegistrationPresenter _registrationPresenter = null;

        static string _titleToDisplay = string.Empty;

        static Register()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _presenter = new CountryCityProvincePresenter(this);
            _accountPresenter = new AccountManagement.AccountPresenter(this);
            _profilePresenter = new ProfilePresenter(this);
            _registrationPresenter = new RegistrationPresenter(this);

            Control navControl = Master.Page.Controls[0].FindControl("NavigationMenu");

            if (navControl != null)
            {
                navControl.Visible = false;
            }

            if (!Page.IsPostBack)
            {
                FillCountriesList();
                PopulateCountryDropDown();
                ddlCountry.Items.FindByText("UNITED STATES").Selected = true;
                FillCitiesList(Convert.ToInt32(ddlCountry.SelectedItem.Value));
                PopulateCityDropDown();
                FillProfileTypeList();
                PopulateProfileTypeDropDown();
            }
        }

        private void FillProfileTypeList()
        {
            _profilePresenter.LoadProfileTypes();
        }

        private void PopulateProfileTypeDropDown()
        {
            ddlProfileType.DataSource = ((List<ProfileType>)Session["ProfileType"]);
            ddlProfileType.DataTextField = "ProfileName";
            ddlProfileType.DataValueField = "ProfileTypeID";
            ddlProfileType.DataBind();
        }

        private void PopulateCountryDropDown()
        {
            ddlCountry.DataSource = ((List<Country>)Session["Country"]);
            ddlCountry.DataTextField = "Name";
            ddlCountry.DataValueField = "CountryID";
            ddlCountry.DataBind();
        }

        private void FillCountriesList()
        {
            _presenter.LoadCountries();             
        }

        private void FillCitiesList(Nullable<int> countryID)
        {
            _presenter.LoadCities(countryID);
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            Nullable<int> countryID = Convert.ToInt32(((DropDownList)sender).SelectedValue);
            FillCitiesList(countryID);
            PopulateCityDropDown();
        }

        private void PopulateCityDropDown()
        {
            ddlCity.DataSource = ((List<City>)Session["City"]);
            ddlCity.DataTextField = "Name";
            ddlCity.DataValueField = "CityID";
            ddlCity.DataBind();
        }

        protected void customValidatorUsername_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = txtUsername.Text;
            args.IsValid = true;

            if (!string.IsNullOrEmpty(username))
            {
                if(_accountPresenter.DoesUsernameExist(username))
                {
                    args.IsValid = false;                    
                }
            }
            else
            {
                args.IsValid = false;
            }


        }

        List<TestSprocGenerator.Business.SingleTable.Bo.Country> ICountryCityProvinceView.Countries
        {
            get
            {
                return ((List<Country>)Session["Country"]);
            }
            set
            {
                Session["Country"] = value;
            }
        }

        List<TestSprocGenerator.Business.SingleTable.Bo.City> ICountryCityProvinceView.Cities
        {
            get
            {
                return ((List<City>)Session["City"]);
            }
            set
            {
                Session["City"] = value;
            }
        }

        string ICountryCityProvinceView.TitleForDisplay
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

        List<ProfileType> IProfileView.ProfileTypes
        {
            get
            {
                return ((List<ProfileType>)Session["ProfileType"]);
            }
            set
            {
                Session["ProfileType"] = value;
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                //1.  here we need to double check the validations that may or may not have been done
                //on the client in case javascript is disabled for example - done because i added asp.net
                //validator controls that do server validations including the username in use check using
                //a customvalidator control

                //2.  here we also need to make sure the input is not malicious, for FName, LName, ZipCode,
                //and Address - i guess we could go up to 255 characters for address 
                //still pushing it though

                bool validInput = false;
                string errors = null;

                validInput = ValidateInputFields(txtFirstName.Text,
                    txtLastName.Text, txtMiddleInitials.Text, txtZipCode.Text,
                    txtStreetAddress.Text, out errors);

                if (validInput)
                {

                    //3.  We need to call the method to actually submit a registration to the registration 
                    //    service which will then create an account profile and other dependent objects
                    bool registrationSuccess = _registrationPresenter.Register(txtUsername.Text,
                         txtPassword.Text, txtFirstName.Text, txtMiddleInitials.Text, txtLastName.Text,
                         txtStreetAddress.Text, txtZipCode.Text, ddlCountry.SelectedItem.Text,
                         ddlCity.SelectedItem.Text, this.txtHomePhone.Text, this.txtMobilePhone.Text,
                         this.txtEmail.Text, new ProfileType()
                         {
                             ProfileTypeID = new Guid(ddlProfileType.SelectedItem.Value),
                             ProfileName = ddlProfileType.SelectedItem.Text
                         });

                    //4.  We need to verify the captcha control has the correct answer - done i did this using
                    // a custom validation control that checks the captcha Text property for True

                    //5.  IF all is well then we also need to login the user and redirect them to the
                    //    Default.aspx page
                    if (registrationSuccess)
                    {
                        bool loginSuccess = _accountPresenter.LoginAndRedirect(txtUsername.Text, txtPassword.Text);
                        //if we got here login was not successful so it will prompt them to login when they get
                        //to the default.aspx page
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                        lblErrors.Text = "Sorry there was an error and your registration was not successful";

                }
                else
                {
                    this.lblErrors.Text = "Please fix the following Errors:  " + Environment.NewLine +
                        errors;
                }
            }
            catch (Exception)
            {
                lblErrors.Text = "Sorry there was an error and your registration was not successful";
            }
        }
            

        protected bool ValidateInputFields(string fname, string lname, string middleInits,
            string zipCode, string streetAddress, out string errors)
        {
            bool result = false;

            bool isValid = false;

            errors = null;

            StringBuilder sb = new StringBuilder();

            isValid = Regex.IsMatch(fname, @"^[a-zA-Z'.\-]{1,40}$");

            if (!isValid)
            {
               sb.Append(@"First Name can contain up to 40 letters and numbers and the .-' characters only");
               sb.Append(Environment.NewLine);
            }

            isValid = Regex.IsMatch(lname, @"^[a-zA-Z'.\-]{1,40}$");

            if (!isValid)
            {
                sb.Append(@"Last Name can contain up to 40 letters and the .-' characters only");
                sb.Append(Environment.NewLine);
            }

            isValid = Regex.IsMatch(middleInits, @"^[a-zA-Z'.\-]{1,20}$");

            if (!isValid)
            {
                sb.Append(@"Middle Initials can contain up to 20 letters and the .-' characters only");
                sb.Append(Environment.NewLine);
            }

            isValid = Regex.IsMatch(zipCode, @"^[a-zA-Z0-9.\-]{1,20}$");

            if (!isValid)
            {
                sb.Append(@"Zip Code can contain up to 20 letters and numbers and the .- characters only");
                sb.Append(Environment.NewLine);
            }

            isValid = Regex.IsMatch(streetAddress, @"^[\w ]{1,255}$");

            if (!isValid)
            {
                sb.Append(@"Address  can contain up to 255 letters and numbers and the .-' characters only");
            }

            errors = sb.ToString();

            if (string.IsNullOrEmpty(errors))
            {
                //if no errors then the result is valid ie true this input is valid
                result = true;
            }

            return result;
        }

        protected void checkCaptchaValidation_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string captchaResult = captcha.Text;
            if (string.IsNullOrEmpty(captchaResult))
            {
                //no answer
                args.IsValid = false;
                return;
            }

            if (Convert.ToBoolean(captchaResult))
            {
                args.IsValid = true;
            }
            else
                args.IsValid = false;

        }
}
}

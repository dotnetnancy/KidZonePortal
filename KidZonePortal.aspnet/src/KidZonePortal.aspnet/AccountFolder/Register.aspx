<%@ Page Language="C#"  AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="~/AccountFolder/Register.aspx.cs"
     Inherits="KidZonePortal.aspnet.AccountNamespace.Register" %>
 
  <%@ Register Assembly="CaptchaControl"
             Namespace="CaptchaControl"
             TagPrefix="CC" %>


<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>    
    <script src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>


 <%--//cross domain issues will cause a 405 Method Not Allowed Error to occur
         //to fix this i had to make sure the service and the origin of this 
         //ajax call were from the same domain, in our case http://localhost
         //i also had to make the service calls to the wcf service restful
         //and had to change the wcf service itself to be able to support POST or GET
         //and the aspcompatibility attributes and then i had to add a custom behavior
         //to the wcf service to be able to handle ajax.  i had to do quite a few things
         //to get this all to work first the errors were 404 errors etc then we got to 405
         //cross domain issues, i think that a better approach would be to make a
         //server side method call that is responsible for making the wcf call and return
         //the results.  i also had to make sure the wcf service was being hosted in IIS
         //instead of the default service host when you start debugging (so that they were
         //in the same domain)                     //this is a bit weird but the status of the response is 200 OK but still is evaluated as an error
                     //the z.responseText is either true or false which is the correct response from the wcf service
--%>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent" ViewStateMode="Enabled">
     <script>       

         $(document).ready(function () {
             var validator = $("#form1").validate({
                 rules: {
                     '<%=txtUsername.UniqueID %>': "required",
                     '<%=txtPassword.UniqueID %>': { required: true, minlength: 8 }
                 },
                 messages: {
                     '<%=txtUsername.UniqueID %>': "please enter your username",
                     '<%=txtPassword.UniqueID %>': { required: "Please enter your password",
                         minlength: "password should be at least 8 characters long"
                     }
                 },
                 wrapper: 'li',
                 errorLabelContainer: $('<%=lblErrors.UniqueID %>')
             });

             $("#MainContent_btnUsernameCheck").click(function (e) {
                 e.preventDefault();

                 SendData($("#MainContent_txtUsername").val());
             });
          
             function SendData(username) {
//                 alert("we are in send data function, value:  " + username);

                 jQuery.support.cors = true;

                 $.ajax({
                     type: "POST",
                     url: "http://localhost/AccountService/AccountService.svc/DoesUsernameExist",
                     data: '{"username":"' + username + '"}',
                     type: "POST",
                     processData: false,
                     contentType: "application/json",
                     //timeout: 10000, 
                     dataType: "json",                      

                     success: function (msg) {
                         if (msg.d)
//                             alert("The username is already in use");
                               $("#MainContent_lblUsernameError").text("The username is already in use");
                         else
                             $("#MainContent_lblUsernameError").text("The username is available");

//                             alert("The username is not already in use");
                     },
                     error: function (z) {
                         alert("Error occured:  " + z.responseText);
                     }
                 });
             }

         });



         function Test() {
             alert("test called");
         }

         

         

           </script>
          

       
     
           
                <h1>
                    Register
                    User:</h1>
           
         

    <table class="style1">
    <tr>
        <td class="style2">
            <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtFirstName" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqFieldValidatorFName" runat="server" 
                ControlToValidate="txtFirstName" ErrorMessage="Please enter First Name"></asp:RequiredFieldValidator>
        &nbsp;
            </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtLastName" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RequiredFieldValidator ID="requiredFieldValidatorLName" runat="server" 
                ControlToValidate="txtLastName" ErrorMessage="Please enter Last Name"></asp:RequiredFieldValidator>
        &nbsp;
            </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblMiddleInitial" runat="server" Text="Middle Initials"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtMiddleInitials" runat="server" ViewStateMode="Enabled"></asp:TextBox>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblAddress" runat="server" Text="Street Address"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtStreetAddress" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RequiredFieldValidator ID="requiredFieldValidator" runat="server" 
                ControlToValidate="txtStreetAddress" ErrorMessage="Please enter street address"></asp:RequiredFieldValidator>
        &nbsp;
            </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            Zip Code</td>
        <td class="style5">
            <asp:TextBox ID="txtZipCode" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RequiredFieldValidator ID="requiredFieldValidatorZip" runat="server" 
                ControlToValidate="txtZipCode" ErrorMessage="Please enter zip code"></asp:RequiredFieldValidator>
        &nbsp;
            </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblCountry" runat="server" Text="Country"></asp:Label>
        </td>
        <td class="style5">
            <asp:DropDownList ID="ddlCountry" runat="server" ViewStateMode="Enabled" 
                AutoPostBack="True" onselectedindexchanged="ddlCountry_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>
        </td>
        <td class="style5">
            <asp:DropDownList ID="ddlCity" runat="server" ViewStateMode="Enabled">
            </asp:DropDownList>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblMobilePhone" runat="server" Text="Mobile Phone Number"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtMobilePhone" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RegularExpressionValidator ID="regexValidateMobilePhone" runat="server" 
                ControlToValidate="txtMobilePhone" 
                ErrorMessage="Please enter valid phone number" 
                ValidationExpression="1?\s*\W?\s*([2-9][0-8][0-9])\s*\W?\s*([2-9][0-9]{2})\s*\W?\s*([0-9]{4})(\se?x?t?(\d*))?"></asp:RegularExpressionValidator>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblHomePhoneNumber" runat="server" Text="Home Phone Number"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtHomePhone" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RegularExpressionValidator ID="regexValidatorHomePhone" runat="server" 
                ControlToValidate="txtHomePhone" ErrorMessage="Please enter valid phone number" 
                ValidationExpression="1?\s*\W?\s*([2-9][0-8][0-9])\s*\W?\s*([2-9][0-9]{2})\s*\W?\s*([0-9]{4})(\se?x?t?(\d*))?"></asp:RegularExpressionValidator>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblEmailAddress" runat="server" Text="Email Address"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtEmail" runat="server" ViewStateMode="Enabled"></asp:TextBox>
            <asp:RegularExpressionValidator runat="server" ID="emailValidator"
            ControlToValidate="txtEmail"
            validationExpression="[a-zA-Z_0-9.-]+\@[a-zA-Z_0-9.-]+\.\w+"
            ErrorMessage="Must be a valid email address" ViewStateMode="Enabled"/>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="lblUsername" runat="server" Text="Username (must be unique)"></asp:Label>
        </td>
        <td class="style5">
            <asp:TextBox ID="txtUsername" runat="server" ViewStateMode="Enabled"></asp:TextBox>&nbsp<asp:CustomValidator 
                ID="customValidatorUsername" runat="server" ControlToValidate="txtUsername" 
                ErrorMessage="Username must be unique" 
                onservervalidate="customValidatorUsername_ServerValidate">Please check if username is already in use</asp:CustomValidator>
&nbsp;<br />
            <asp:Button ID="btnUsernameCheck" runat="server" Text="Check Username" 
                Width="121px" Height="20px"/>
        &nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblUsernameError" runat="server"></asp:Label>
        </td>
        <td class="style3">            

        </td>
    </tr>
    <tr>
        <td class="style2" colspan="3">          
       
          <CC:WhoWhatWhere runat="server" ViewStateMode="Enabled" ID="captcha">
          </CC:WhoWhatWhere>
    
        </td>
        
    </tr>
    <tr>
        <td class="style2">
            Password</td>
        <td class="style5">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ViewStateMode="Enabled"></asp:TextBox>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            Confirm Password</td>
        <td class="style5">
            <asp:TextBox ID="txtPasswordConfirmation" runat="server" TextMode="Password" ViewStateMode="Enabled"></asp:TextBox>
            <asp:CompareValidator ID="compareValidatorPassword" runat="server" 
                ControlToCompare="txtPassword" ControlToValidate="txtPasswordConfirmation" 
                ErrorMessage="Password and Confirm Password do not match">Enter Password Again</asp:CompareValidator>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            Profile Type</td>
        <td class="style5">
            <asp:DropDownList ID="ddlProfileType" runat="server" ViewStateMode="Enabled">
            </asp:DropDownList>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style5">
            <asp:Label ID="lblErrors" runat="server"></asp:Label>
            <asp:CustomValidator ID="checkCaptchaValidation" runat="server" 
                ErrorMessage="Please Enter Correct Answer to Capcha Question (to determine that you are a human)" 
                onservervalidate="checkCaptchaValidation_ServerValidate"></asp:CustomValidator>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style5">
            <asp:Button ID="btnRegister" runat="server" Text="Register" 
                onclick="btnRegister_Click" />
            <p></p>
            <p></p>
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
</table>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="KidZonePortal.aspnet.AccountFolder.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 135px;
        }
    </style>
   
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>    
    <script src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">       
     <script>

         $(document).ready(function () {
             if ($("#MainContent_txtChangePasswordCode").val() == "" || $("#MainContent_txtChangePasswordCode").val() == null) {


                 $("#MainContent_txtPassword").hide();
                 $("#MainContent_txtConfirmPassword").hide();
             }
             else {
                 $("#MainContent_txtPassword").show();
                 $("#MainContent_txtConfirmPassword").show();
                 $("#MainContent_txtPassword").focus();

             }



             $("#MainContent_txtChangePasswordCode").change(function (e) {

                 e.preventDefault();

                 if ($("#MainContent_txtChangePasswordCode").val() == "" || $("#MainContent_txtChangePasswordCode").val() == null) {

                     $("#MainContent_txtPassword").hide();
                     $("#MainContent_txtPassword").val("");
                     $("#MainContent_txtConfirmPassword").hide();
                     $("#MainContent_txtConfirmPassword").val("");

                 }


                 if ($("#MainContent_txtChangePasswordCode").val() != "" && $("#MainContent_txtChangePasswordCode").val() != null) {

                     $("#MainContent_txtPassword").show();
                     $("#MainContent_txtPassword").val("");
                     $("#MainContent_txtConfirmPassword").show();
                     $("#MainContent_txtConfirmPassword").val("");
                     $("#MainContent_txtPassword").focus();
                 }

             });

             $("#MainContent_btnSubmitChangePassword").click(function (e) {

                 if ($("#MainContent_txtChangePasswordCode").val() != "" && $("#MainContent_txtChangePasswordCode").val() != null) {

                     $("#MainContent_txtPassword").show();                    
                     $("#MainContent_txtConfirmPassword").show();                   
                   
                     var validator = $("#form1").validate({
                         rules: {
                             '<%=txtConfirmPassword.UniqueID %>': { required: true, minlength: 8 },
                             '<%=txtPassword.UniqueID %>': { required: true, minlength: 8 }
                         },
                         messages: {
                             '<%=txtPassword.UniqueID %>': { required: "Please enter your password",
                                 minlength: "password should be at least 8 characters long"
                             },
                             '<%=txtConfirmPassword.UniqueID %>': { required: "Please enter confirm password",
                                 minlength: "password should be at least 8 characters long"
                             }

                         },
                         wrapper: 'li',
                         errorLabelContainer: $('<%=lblErrors.UniqueID %>')
                     });

                 }
             });

         });      



         function Test(whoCalled) {
             alert(whoCalled);
         }

         

         

           </script>

             
    <table class="style1">
        <tr>
            <td colspan=3>
                <h1>Password Reset</h1></td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="bottom">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                <br />
                <br />
            </td>
            <td valign="top">
                <asp:TextBox ID="txtUsername" runat="server" ViewStateMode="Enabled"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="customUsernameValidator" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Error:  You must provide a valid username or you should provide a valid email address instead" 
                    onservervalidate="customUsernameValidator_ServerValidate"></asp:CustomValidator>
            </td>
            <td valign="top">
                <asp:Label ID="lblUsernameInstructions" runat="server" Width="100%"
                    
                    Text="You can Enter the Username for the Account you wish to change the password for.  The email address associated with the account is where the Password Code will be sent only."></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                Email<br />
                <br />
            </td>
            <td valign="top">
                <asp:TextBox ID="txtEmail" runat="server" ViewStateMode="Enabled"></asp:TextBox>
&nbsp;<br />
                <asp:CustomValidator ID="customEmailValidator" runat="server" 
                    ControlToValidate="txtEmail" 
                    ErrorMessage="Error:  You must provide a valid email address associated with an account or you should provide a valid username  instead" 
                    onservervalidate="customEmailValidator_ServerValidate"></asp:CustomValidator>
</td>
            <td valign="top">
                <asp:Label ID="lblEmailInstructions" runat="server" Width="100%"
                    Text="Or you can enter the email address associated with the account, the username and Change Password Code will be sent only to the email address provided if it is associated with an account"></asp:Label>
</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <asp:Label ID="lblChangePasswordCode" runat="server" 
                    Text="Change Password Code"></asp:Label>
            </td>
            <td valign="top">
                <asp:TextBox ID="txtChangePasswordCode" runat="server"></asp:TextBox>
&nbsp;
                </td>
            <td valign="top">
                <asp:Label ID="lblInstructions" runat="server" Width="100%" 
                    Text="Leave this Blank and You will be Emailed the Password Change Code.  Click on Submit with Change Password Code Blank and you will be emailed the Password Change Code.  If you have the Change Password Code that you were emailed then please enter it to actually reset the password. (For the purposes of this demo i will populate it for you instead of just email)"></asp:Label>
</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <asp:Label ID="lblNewPassword" runat="server" Text="New Password"></asp:Label>
            </td>
            <td valign="top" colspan="2">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <br />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <asp:Label ID="lblConfirmNewPassword" runat="server" 
                    Text="Confirm New Password"></asp:Label>
            </td>
            <td valign="top" colspan="2">
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" ></asp:TextBox>
                <br />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td valign="bottom" colspan="2">
                <asp:Label ID="lblErrors" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td colspan="2">
                <asp:Button ID="btnSubmitChangePassword" runat="server" 
                    Text="Submit Change Password Request" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

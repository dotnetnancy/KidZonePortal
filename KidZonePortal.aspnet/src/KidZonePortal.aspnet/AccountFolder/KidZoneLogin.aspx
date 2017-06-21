<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="KidZoneLogin.aspx.cs" Inherits="KidZonePortal.aspnet.AccountNamespace.KidZoneLogin" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>    
    <script src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

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
        $("#MainContent_btnRegister").click(function (e) {
            e.preventDefault();

            window.location = "http://localhost/KidZonePortal.aspnet/AccountFolder/Register.aspx"

        });

        $("#MainContent_btnForgotPassword").click(function (e) {
            e.preventDefault();

            window.location = "http://localhost/KidZonePortal.aspnet/AccountFolder/ResetPassword.aspx"

        });

    });
    
   </script>
    <h2>
        Log In
    </h2>
    <p>
        Please enter your username and password.
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">Register</asp:HyperLink> if you don't have an account.
    </p>

     <table>
            <tr>
                <td>
                    <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                    :</td>
                <td>
                    <asp:TextBox ID="txtUsername" runat="server" ViewStateMode="Enabled"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td >
                    <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                </td>
                <td >
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnLogon" runat="server" Text="Login" 
                        onclick="btnLogon_Click" />
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblErrors" runat="server"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblRegister" runat="server" Text="Don't Have a Login?"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="btnRegister" runat="server" Text="Register"  PostBackUrl="~/AccountFolder/Register.aspx"
                         />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    Forgot Your Password?</td>
                <td>
                    <asp:Button ID="btnForgotPassword" runat="server" Text="Reset Password" 
                        PostBackUrl="AccountFolder/ResetPassword.aspx"/>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
</asp:Content>

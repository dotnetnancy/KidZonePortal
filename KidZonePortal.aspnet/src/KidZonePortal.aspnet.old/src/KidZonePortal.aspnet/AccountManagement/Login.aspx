<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KidZonePortal.aspnet.AccountManagement.Login" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
    <form id="Form1" runat="server">
    <div class="page">
        <div class="header">
            <div class="title">
                <h1>
                    Kid Zone Portal
                </h1>
            </div>
            <div class="clear hideSkiplink">
              
            </div>
        </div>
        <div class="main">
    
    
        <table class="style1" >
            <tr>
                <td class="style2">
                    <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                    :</td>
                <td class="style3">
                    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style3">
                    <asp:Button ID="btnLogon" runat="server" Text="Login" 
                        onclick="btnLogon_Click" />
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style3">
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblErrors" runat="server"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style3">
                    <asp:Label ID="lblRegister" runat="server" Text="Don't Have a Login?"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style3">
                    Forgot Your Password?</td>
                <td>
                    <asp:Button ID="btnForgotPassword" runat="server" Text="Reset Password" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
          </div>
        <div class="clear">
        </div>
    </div>
    <div class="footer">
        
    </div>
    </form>
</body>
</html>

    
  


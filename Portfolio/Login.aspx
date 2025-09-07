<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Portfolio.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login</title>
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <h3>Login</h3>
                    <asp:Label ID="MessageLabel" runat="server" ForeColor="Red" />
                    <div class="form-group">
                        <label>Username</label>
                        <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" />
                        <asp:CheckBox ID="RememberMeCheckBox" runat="server" Text="&nbsp; Remember Me" />
                    </div>
                    <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="btn btn-primary btn-block" OnClick="LoginButton_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>

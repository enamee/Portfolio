<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Portfolio.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login</title>
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
/*    background: linear-gradient(135deg, #6a11cb, #2575fc);*/
    font-family: Arial, sans-serif;
}

.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
}

.login-box {
    background: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
    width: 300px;
    text-align: center;
}

.login-box h3 {
    margin-bottom: 1.5rem;
    color: #333;
}

.form-group {
    margin-bottom: 1rem;
    text-align: left;
}

.input-text {
    width: 100%;
    padding: 10px;
    margin-top: 0.3rem;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.remember-me {
    display: flex;
    align-items: center;
    font-size: 0.9rem;
    color: #444;
}

.remember-me label {
    margin-left: 5px;
}

.btn-login {
    width: 100%;
    padding: 10px;
    background: #2575fc;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    margin-top: 1rem;
    transition: background 0.3s ease;
}

.btn-login:hover {
    background: #1a5adf;
}

.error-message {
    color: red;
    font-size: 0.9rem;
    margin-bottom: 1rem;
    display: block;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
    <div class="login-box">
        <h3>Login</h3>
        <asp:Label ID="MessageLabel" runat="server" CssClass="error-message" />
        
        <div class="form-group">
            <label for="UsernameTextBox">Username</label>
            <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="input-text" />
        </div>
        
        <div class="form-group">
            <label for="PasswordTextBox">Password</label>
            <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="input-text" />
        </div>
        
        <div class="form-group remember-me">
            <asp:CheckBox ID="RememberMeCheckBox" runat="server" />
            <label for="RememberMeCheckBox">Remember Me</label>
        </div>
        
        <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="btn-login" OnClick="LoginButton_Click" />
    </div>
</div>
    </form>
</body>
</html>

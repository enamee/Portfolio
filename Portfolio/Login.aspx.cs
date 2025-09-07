using Portfolio.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request.QueryString["timeout"] == "true")
            //{
            //    MessageLabel.Text = "Your session has expired. Please log in again.";
            //}
        }
        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string username = UsernameTextBox.Text.Trim();
            string password = PasswordTextBox.Text.Trim();

            // Using DatabaseHelper.ExecuteScalar instead of raw ADO.NET
            string query = @"
            SELECT COUNT(*) 
            FROM Admin 
            WHERE Username = @Username AND Password = @Password";

            object result = DatabaseHelper.ExecuteScalar(query,
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", password));

            int userExists = Convert.ToInt32(result);

            if (userExists == 1)
            {
                Session["LoggedInUser"] = username;

                if (RememberMeCheckBox.Checked)
                {
                    HttpCookie userCookie = new HttpCookie("AuthUser", username);
                    userCookie.Expires = DateTime.Now.AddDays(7); // Valid for 7 days
                    Response.Cookies.Add(userCookie);
                }

                Response.Redirect("Admin.aspx");
            }
            else
            {
                MessageLabel.Text = "Invalid username or password.";
            }
        }
    }
}
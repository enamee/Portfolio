using Portfolio.Utilities;
using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedInUser"] == null)
            {
                HttpCookie cookie = Request.Cookies["AuthUser"];
                if (cookie != null)
                {
                    Session["LoggedInUser"] = cookie.Value; // Restore session from cookie
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

            }

            if (!IsPostBack)
            {
                BindHome();
                BindAbout();
                BindCategories();
                BindSkills();
            }
        }
    }
}

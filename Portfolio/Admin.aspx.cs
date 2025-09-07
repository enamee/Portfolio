using Portfolio.Utilities;
using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

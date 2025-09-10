using Portfolio.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin
    {
        private readonly AboutRepository _aboutRepo = new AboutRepository();

        protected void BindAbout()
        {
            DataTable dt = _aboutRepo.GetAll();
            gvAbout.DataSource = dt;
            gvAbout.DataBind();
            //Response.Redirect(Request.RawUrl);
        }

        protected void gvAbout_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAbout.EditIndex = e.NewEditIndex;
            BindAbout();
            
        }

        protected void gvAbout_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAbout.EditIndex = -1;
            BindAbout();
        }

        protected void gvAbout_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int aboutId = Convert.ToInt32(gvAbout.DataKeys[e.RowIndex].Value);

            TextBox txtEditAboutText = (TextBox)gvAbout.Rows[e.RowIndex].FindControl("txtEditAboutText");
            TextBox txtEditAboutImage = (TextBox)gvAbout.Rows[e.RowIndex].FindControl("txtEditAboutImage");

            _aboutRepo.Update(aboutId, txtEditAboutText.Text.Trim(), txtEditAboutImage.Text.Trim());

            gvAbout.EditIndex = -1;
            BindAbout();
            Response.Redirect(Request.RawUrl);
        }
    }
}
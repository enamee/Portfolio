using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portfolio.Utilities;

namespace Portfolio
{
    public partial class Admin
    {
        private readonly HomeRepository _homeRepo = new HomeRepository();

        protected void BindHome()
        {
            gvHome.DataSource = _homeRepo.GetAll();
            gvHome.DataBind();
        }

        protected void gvHome_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvHome.EditIndex = e.NewEditIndex;
            BindHome();
        }

        protected void gvHome_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvHome.DataKeys[e.RowIndex].Value);
            string subtitle = ((System.Web.UI.WebControls.TextBox)gvHome.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string description = ((System.Web.UI.WebControls.TextBox)gvHome.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string profileImage = ((System.Web.UI.WebControls.TextBox)gvHome.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            string profileImageBack = ((System.Web.UI.WebControls.TextBox)gvHome.Rows[e.RowIndex].Cells[4].Controls[0]).Text;

            _homeRepo.Update(id, subtitle, description, profileImage, profileImageBack);

            gvHome.EditIndex = -1;
            BindHome();
            Response.Redirect(Request.RawUrl);
        }

        protected void gvHome_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvHome.EditIndex = -1;
            BindHome();
        }

        protected void gvHome_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvHome.DataKeys[e.RowIndex].Value);
            _homeRepo.Delete(id);
            BindHome();
            Response.Redirect(Request.RawUrl);
        }
    }
}
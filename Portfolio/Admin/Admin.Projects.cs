using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin
    {
        private readonly ProjectsRepository _projectsRepo = new ProjectsRepository();

        protected void BindProjects()
        {
            gvProjects.DataSource = _projectsRepo.GetAll();
            gvProjects.DataBind();
        }

        protected void gvProjects_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProjects.EditIndex = e.NewEditIndex;
            BindProjects();
        }

        protected void gvProjects_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProjects.EditIndex = -1;
            BindProjects();
        }

        protected void gvProjects_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int projectId = Convert.ToInt32(gvProjects.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvProjects.Rows[e.RowIndex];

            string title = (row.FindControl("txtEditTitle") as TextBox).Text;
            string description = (row.FindControl("txtEditDescription") as TextBox).Text;
            string image = (row.FindControl("txtEditImage") as TextBox).Text;
            string link = (row.FindControl("txtEditLink") as TextBox).Text;
            string github = (row.FindControl("txtEditGithub") as TextBox).Text;

            _projectsRepo.Update(projectId, title, description, image, link, github);

            gvProjects.EditIndex = -1;
            BindProjects();
        }

        protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MoveUp")
            {
                _projectsRepo.SwapOrder(Convert.ToInt32(e.CommandArgument), "Up");
                BindProjects();
            }
            else if (e.CommandName == "MoveDown")
            {
                _projectsRepo.SwapOrder(Convert.ToInt32(e.CommandArgument), "Down");
                BindProjects();
            }
        }
    }
}
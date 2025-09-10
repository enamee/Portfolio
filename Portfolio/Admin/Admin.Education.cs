using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin
    {
        private readonly EducationRepository _eduRepo = new EducationRepository();

        //protected void BindEducation()
        //{
        //    gvEducation.DataSource = _eduRepo.GetAll();
        //    gvEducation.DataBind();
        //}

        //protected void gvEducation_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    int id = Convert.ToInt32(e.CommandArgument);

        //    if (e.CommandName == "DeleteEdu")
        //    {
        //        _eduRepo.Delete(id);
        //        Response.Redirect(Request.RawUrl);
        //    }
        //}

        //protected void gvEducation_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvEducation.EditIndex = e.NewEditIndex;
        //    BindEducation();
        //}

        //protected void gvEducation_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        //{
        //    gvEducation.EditIndex = -1;
        //    BindEducation();
        //}

        //protected void gvEducation_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    GridViewRow row = gvEducation.Rows[e.RowIndex];

        //    int id = Convert.ToInt32(gvEducation.DataKeys[e.RowIndex].Value);
        //    string degree = (row.FindControl("txtDegree") as TextBox).Text;
        //    string institution = (row.FindControl("txtInstitution") as TextBox).Text;
        //    int startYear = int.Parse((row.FindControl("txtStartYear") as TextBox).Text);
        //    string endYearStr = (row.FindControl("txtEndYear") as TextBox).Text;
        //    int? endYear = string.IsNullOrWhiteSpace(endYearStr) ? (int?)null : int.Parse(endYearStr);
        //    string gpa = (row.FindControl("txtGPA") as TextBox).Text;
        //    string description = (row.FindControl("txtDescription") as TextBox).Text;
        //    int displayOrder = int.Parse((row.FindControl("txtDisplayOrder") as TextBox).Text);

        //    _eduRepo.Update(id, degree, institution, startYear, endYear, gpa, description, displayOrder);

        //    gvEducation.EditIndex = -1;
        //    Response.Redirect(Request.RawUrl);
        //}

        //protected void btnAddEducation_Click(object sender, EventArgs e)
        //{
        //    // Redirect to a separate AddEducation.aspx OR open modal form
        //    Response.Redirect("AddEducation.aspx");
        //}
    }
}
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
        private readonly SkillsRepository _skillsRepo = new SkillsRepository();

        protected void BindSkills()
        {
            gvSkills.DataSource = _skillsRepo.GetAll();
            gvSkills.DataBind();
        }

        //protected void btnAddSkill_Click(object sender, EventArgs e)
        //{
        //    DataTable dt = _skillsRepo.GetAll();
        //    int maxOrder = dt.Rows.Count > 0 ? Convert.ToInt32(dt.Compute("MAX(DisplayOrder)", "")) : 0;

        //    // Default: assign to first category
        //    SkillCategoriesRepository categoryRepo = new SkillCategoriesRepository();
        //    DataTable categories = categoryRepo.GetAll();
        //    if (categories.Rows.Count == 0) return;

        //    int defaultCategoryId = Convert.ToInt32(categories.Rows[0]["CategoryID"]);

        //    _skillsRepo.Add("New Skill", defaultCategoryId, 50, maxOrder + 1);
        //    BindSkills();
        //}

        //protected void gvSkills_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    gvSkills.EditIndex = e.NewEditIndex;
        //    BindSkills();
        //}

        protected void gvSkills_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSkills.EditIndex = -1;
            BindSkills();
        }

        //protected void gvSkills_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int id = (int)gvSkills.DataKeys[e.RowIndex].Value;
        //    string name = ((TextBox)gvSkills.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
        //    int proficiency = int.Parse(((TextBox)gvSkills.Rows[e.RowIndex].Cells[3].Controls[0]).Text);

        //    DataTable dt = _skillsRepo.GetAll();
        //    DataRow row = dt.Select($"SkillID={id}")[0];

        //    _skillsRepo.Update(id, name, Convert.ToInt32(row["CategoryID"]), proficiency, Convert.ToInt32(row["DisplayOrder"]));

        //    gvSkills.EditIndex = -1;
        //    BindSkills();
        //}

        protected void gvSkills_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvSkills.DataKeys[e.RowIndex].Value;
            _skillsRepo.Delete(id);
            BindSkills();
            Response.Redirect(Request.RawUrl);
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MoveUp" || e.CommandName == "MoveDown")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int id = (int)gvSkills.DataKeys[index].Value;

                DataTable dt = _skillsRepo.GetAll();
                DataRow currentRow = dt.Select($"SkillID={id}")[0];
                int order = Convert.ToInt32(currentRow["DisplayOrder"]);

                int swapOrder = (e.CommandName == "MoveUp") ? order - 1 : order + 1;
                if (swapOrder < 1) return;

                DataRow[] swapRows = dt.Select($"DisplayOrder={swapOrder}");
                if (swapRows.Length == 0) return;

                int swapId = Convert.ToInt32(swapRows[0]["SkillID"]);

                _skillsRepo.Update(id, currentRow["SkillName"].ToString(), Convert.ToInt32(currentRow["CategoryID"]),
                                   Convert.ToInt32(currentRow["ProficiencyLevel"]), swapOrder);

                _skillsRepo.Update(swapId, swapRows[0]["SkillName"].ToString(), Convert.ToInt32(swapRows[0]["CategoryID"]),
                                   Convert.ToInt32(swapRows[0]["ProficiencyLevel"]), order);

                BindSkills();
            }
        }
        protected void gvSkills_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSkills.EditIndex = e.NewEditIndex;
            BindSkills();

            // Bind Category dropdown inside the edit row
            DropDownList ddlCategories = (DropDownList)gvSkills.Rows[e.NewEditIndex].FindControl("ddlCategories");
            if (ddlCategories != null)
            {
                SkillCategoriesRepository categoryRepo = new SkillCategoriesRepository();
                ddlCategories.DataSource = categoryRepo.GetAll();
                ddlCategories.DataTextField = "CategoryName";
                ddlCategories.DataValueField = "CategoryID";
                ddlCategories.DataBind();

                //// Set selected value = current skill’s category
                //int currentCategoryId = Convert.ToInt32(((HiddenField)gvSkills.Rows[e.NewEditIndex].FindControl("hfCategoryId")).Value);
                //ddlCategories.SelectedValue = currentCategoryId.ToString();
                // Get current category ID from hidden field
                HiddenField hfCategoryId = (HiddenField)gvSkills.Rows[e.NewEditIndex].FindControl("hfCategoryId");
                if (hfCategoryId != null)
                {
                    ddlCategories.SelectedValue = hfCategoryId.Value;
                }
            }
        }

        //protected void gvSkills_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    int id = (int)gvSkills.DataKeys[e.RowIndex].Value;

        //    // Find controls by ID
        //    TextBox txtName = (TextBox)gvSkills.Rows[e.RowIndex].FindControl("txtSkillName");
        //    TextBox txtProficiency = (TextBox)gvSkills.Rows[e.RowIndex].FindControl("txtProficiency");
        //    DropDownList ddlCategories = (DropDownList)gvSkills.Rows[e.RowIndex].FindControl("ddlCategories");

        //    if (txtName == null || txtProficiency == null || ddlCategories == null)
        //        return; // sanity check

        //    string name = txtName.Text;
        //    int proficiency = int.Parse(txtProficiency.Text);
        //    int categoryId = int.Parse(ddlCategories.SelectedValue);

        //    DataTable dt = _skillsRepo.GetAll();
        //    DataRow row = dt.Select($"SkillID={id}")[0];
        //    int displayOrder = Convert.ToInt32(row["DisplayOrder"]);

        //    _skillsRepo.Update(id, name, categoryId, proficiency, displayOrder);

        //    gvSkills.EditIndex = -1;

        //    // PRG to avoid form resubmission
        //    Response.Redirect(Request.RawUrl, false);
        //    Context.ApplicationInstance.CompleteRequest();
        //}

        protected void gvSkills_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = (int)gvSkills.DataKeys[e.RowIndex].Value;

            TextBox txtName = (TextBox)gvSkills.Rows[e.RowIndex].FindControl("txtSkillName");
            TextBox txtProficiency = (TextBox)gvSkills.Rows[e.RowIndex].FindControl("txtProficiency");
            DropDownList ddlCategories = (DropDownList)gvSkills.Rows[e.RowIndex].FindControl("ddlCategories");

            if (txtName == null || txtProficiency == null || ddlCategories == null)
                return;

            string name = txtName.Text;
            int proficiency = int.Parse(txtProficiency.Text);
            int categoryId = int.Parse(ddlCategories.SelectedValue);

            if (id == -1)
            {
                // Insert new skill into DB
                int maxOrder = _skillsRepo.GetAll().Rows.Count + 1;
                _skillsRepo.Add(name, categoryId, proficiency, maxOrder);
            }
            else
            {
                // Update existing skill
                DataTable dt = _skillsRepo.GetAll();
                DataRow row = dt.Select($"SkillID={id}")[0];
                int displayOrder = Convert.ToInt32(row["DisplayOrder"]);

                _skillsRepo.Update(id, name, categoryId, proficiency, displayOrder);
            }

            gvSkills.EditIndex = -1;
            // simple redirect to avoid postback resubmission
            Response.Redirect(Request.RawUrl);
        }

        //protected void btnAddSkill_Click(object sender, EventArgs e)
        //{
        //    DataTable dt = _skillsRepo.GetAll();
        //    int maxOrder = dt.Rows.Count > 0 ? Convert.ToInt32(dt.Compute("MAX(DisplayOrder)", "")) : 0;

        //    SkillCategoriesRepository categoryRepo = new SkillCategoriesRepository();
        //    DataTable categories = categoryRepo.GetAll();
        //    if (categories.Rows.Count == 0) return;

        //    int defaultCategoryId = Convert.ToInt32(categories.Rows[0]["CategoryID"]);

        //    _skillsRepo.Add("New Skill", defaultCategoryId, 50, maxOrder + 1);

        //    // Redirect to avoid resubmission
        //    Response.Redirect(Request.RawUrl, false);
        //    Context.ApplicationInstance.CompleteRequest();
        //}

        protected void btnAddSkill_Click(object sender, EventArgs e)
        {
            SkillCategoriesRepository categoryRepo = new SkillCategoriesRepository();
            DataTable categories = categoryRepo.GetAll();
            if (categories.Rows.Count == 0) return;

            int defaultCategoryId = Convert.ToInt32(categories.Rows[0]["CategoryID"]);

            // Get current skills
            DataTable dt = _skillsRepo.GetAll();

            // Create a temporary row for edit (ID = -1 means new)
            DataRow newRow = dt.NewRow();
            newRow["SkillID"] = -1;  // temporary ID
            newRow["SkillName"] = "";
            newRow["CategoryID"] = defaultCategoryId;
            //newRow["CategoryName"] = categories.Rows[0]["CategoryName"];
            newRow["ProficiencyLevel"] = 50;
            newRow["DisplayOrder"] = dt.Rows.Count + 1;

            dt.Rows.Add(newRow);

            gvSkills.EditIndex = dt.Rows.Count - 1; // set last row to edit mode
            gvSkills.DataSource = dt;
            gvSkills.DataBind();
        }
        protected void gvSkills_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex == gvSkills.EditIndex)
            {
                DropDownList ddlCategories = (DropDownList)e.Row.FindControl("ddlCategories");
                if (ddlCategories != null)
                {
                    SkillCategoriesRepository categoryRepo = new SkillCategoriesRepository();
                    DataTable categories = categoryRepo.GetAll();

                    ddlCategories.DataSource = categories;
                    ddlCategories.DataTextField = "CategoryName";
                    ddlCategories.DataValueField = "CategoryID";
                    ddlCategories.DataBind();

                    // Pre-select current category
                    HiddenField hfCategoryId = (HiddenField)e.Row.FindControl("hfCategoryId");

                    if (hfCategoryId != null)
                    {
                        ddlCategories.SelectedValue = hfCategoryId.Value;
                    }
                    else
                    {
                        // For new row: pick the first category if hf not found
                        if (categories.Rows.Count > 0)
                            ddlCategories.SelectedValue = categories.Rows[0]["CategoryID"].ToString();
                    }
                }
            }
        }

    }
}
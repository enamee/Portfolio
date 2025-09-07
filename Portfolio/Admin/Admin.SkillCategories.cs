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
        private readonly SkillCategoriesRepository _categoryRepo = new SkillCategoriesRepository();

        protected void BindCategories()
        {
            gvCategories.DataSource = _categoryRepo.GetAll();
            gvCategories.DataBind();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            // Find the next DisplayOrder
            DataTable dt = _categoryRepo.GetAll();
            int maxOrder = dt.Rows.Count > 0 ? Convert.ToInt32(dt.Compute("MAX(DisplayOrder)", "")) : 0;

            _categoryRepo.Add("New Category", maxOrder + 1);
            BindCategories();
            Response.Redirect(Request.RawUrl);
        }

        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            BindCategories();
        }

        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = (int)gvCategories.DataKeys[e.RowIndex].Value;
            string name = ((TextBox)gvCategories.Rows[e.RowIndex].Cells[1].Controls[0]).Text;

            // Keep the same DisplayOrder
            DataTable dt = _categoryRepo.GetAll();
            int order = Convert.ToInt32(dt.Select($"CategoryID={id}")[0]["DisplayOrder"]);

            _categoryRepo.Update(id, name, order);

            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvCategories.DataKeys[e.RowIndex].Value;
            _categoryRepo.Delete(id);
            BindCategories();
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MoveUp" || e.CommandName == "MoveDown")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int id = (int)gvCategories.DataKeys[index].Value;

                DataTable dt = _categoryRepo.GetAll();
                DataRow currentRow = dt.Select($"CategoryID={id}")[0];
                int order = Convert.ToInt32(currentRow["DisplayOrder"]);

                int swapOrder = (e.CommandName == "MoveUp") ? order - 1 : order + 1;
                if (swapOrder < 1) return;

                DataRow[] swapRows = dt.Select($"DisplayOrder={swapOrder}");
                if (swapRows.Length == 0) return;

                int swapId = Convert.ToInt32(swapRows[0]["CategoryID"]);

                // Swap orders
                _categoryRepo.Update(id, currentRow["CategoryName"].ToString(), swapOrder);
                _categoryRepo.Update(swapId, swapRows[0]["CategoryName"].ToString(), order);

                BindCategories();
            }
        }
    }
}
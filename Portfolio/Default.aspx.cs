using Portfolio.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //LoadHeader();
                LoadHome();
                LoadAbout();
                LoadSkills();
                LoadPortfolio();
                LoadEducation();
                LoadContact();
            }
        }

        //private void LoadHeader()
        //{
        //    // Logo
        //    DataTable dtLogo = DatabaseHelper.ExecuteSelect("SELECT Circle, Name FROM Logo");
        //    if (dtLogo.Rows.Count > 0)
        //    {
        //        litLogoCircle.Text = dtLogo.Rows[0]["Circle"].ToString();
        //        litLogoName.Text = dtLogo.Rows[0]["Name"].ToString();
        //    }

        //    // Menu
        //    rptMenu.DataSource = DatabaseHelper.ExecuteSelect("SELECT SectionId, SectionName FROM Menu ORDER BY SortOrder");
        //    rptMenu.DataBind();
        //}

        private void LoadHome()
        {
            DataTable dt = DatabaseHelper.ExecuteSelect("SELECT * FROM HomeContent");
            if (dt.Rows.Count > 0)
            {
                litHeroSubtitle.Text = dt.Rows[0]["HeroSubtitle"].ToString();
                litHeroDescription.Text = dt.Rows[0]["HeroDescription"].ToString();
                imgProfile.ImageUrl = dt.Rows[0]["ProfileImage"].ToString();
                imgProfileBack.ImageUrl = dt.Rows[0]["ProfileImageBack"].ToString();
            }
        }

        private void LoadAbout()
        {
            DataTable dt = DatabaseHelper.ExecuteSelect("SELECT AboutText, AboutImage FROM AboutContent");
            if (dt.Rows.Count > 0)
            {
                litAbout.Text = dt.Rows[0]["AboutText"].ToString();
                imgAbout.ImageUrl = dt.Rows[0]["AboutImage"].ToString();
            }
        }

        private void LoadSkills()
        {
            string query = @"
        SELECT 
            c.CategoryID,
            c.CategoryName,
            c.DisplayOrder AS CategoryOrder,
            s.SkillName,
            s.DisplayOrder AS SkillOrder
        FROM Skills s
        INNER JOIN SkillCategories c ON s.CategoryID = c.CategoryID
        ORDER BY c.DisplayOrder, s.DisplayOrder";

            DataTable dt = DatabaseHelper.ExecuteSelect(query);

            var grouped = dt.AsEnumerable()
                .GroupBy(r => new
                {
                    CategoryID = (int)r["CategoryID"],
                    CategoryName = r["CategoryName"].ToString(),
                    CategoryOrder = (int)r["CategoryOrder"]
                })
                .OrderBy(g => g.Key.CategoryOrder) // ✅ order before projection
                .Select(g => new
                {
                    g.Key.CategoryName,
                    Skills = g.OrderBy(x => (int)x["SkillOrder"])
                              .Select(x => new { SkillName = x["SkillName"].ToString() })
                              .ToList()
                })
                .ToList();

            rptCategories.DataSource = grouped;
            rptCategories.DataBind();
        }

        private void LoadPortfolio()
        {
            // Get Featured Projects (max 2)
            string featuredQuery = @"
        SELECT TOP 2 * 
        FROM Projects
        WHERE IsFeatured = 1
        ORDER BY DisplayOrder";

            DataTable dtFeatured = DatabaseHelper.ExecuteSelect(featuredQuery);
            rptFeatured.DataSource = dtFeatured;
            rptFeatured.DataBind();

            // Get Other Projects
            string othersQuery = @"
        SELECT * 
        FROM Projects
        WHERE IsFeatured = 0
        ORDER BY CreatedAt DESC";  // Or DisplayOrder if you want

            DataTable dtOthers = DatabaseHelper.ExecuteSelect(othersQuery);
            rptOthers.DataSource = dtOthers;
            rptOthers.DataBind();
        }

        private void LoadEducation()
        {
            string query = @"
        SELECT Degree, Institution, StartYear, EndYear, Result, Description
        FROM Education
        ORDER BY DisplayOrder";

            DataTable dt = DatabaseHelper.ExecuteSelect(query);
            rptEducation.DataSource = dt;
            rptEducation.DataBind();
        }

        private void LoadContact()
        {
            string query = "SELECT TOP 1 * FROM ContactDetails ORDER BY CreatedAt DESC";
            DataTable dt = DatabaseHelper.ExecuteSelect(query);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                litContactInfo.Text = $@"
            <h3>Get in Touch</h3>
            <p>If you’d like to discuss a project, collaborate, or just say hi, feel free to reach out!</p>
            <ul>
                <li><strong>Email:</strong> {row["Email"]}</li>
                <li><strong>Phone:</strong> {row["Phone"]}</li>
                <li><strong>Location:</strong> {row["Location"]}</li>
            </ul>
            <div class='social-links'>
                <a href='{row["LinkedIn"]}' target='_blank'>LinkedIn</a>
                <a href='{row["GitHub"]}' target='_blank'>GitHub</a>
                <a href='{row["Twitter"]}' target='_blank'>Twitter</a>
            </div>
        ";
            }
        }
        protected void btnSend_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            // Check for empty fields
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
            {
                lblStatus.Text = "All fields are required!";
                lblStatus.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                string insertQuery = @"
            INSERT INTO ContactMessages (Name, Email, Message)
            VALUES (@Name, @Email, @Message)";

                DatabaseHelper.ExecuteNonQuery(insertQuery,
                    new SqlParameter("@Name", name),
                    new SqlParameter("@Email", email),
                    new SqlParameter("@Message", message));

                // Clear form fields
                txtName.Text = "";
                txtEmail.Text = "";
                txtMessage.Text = "";

                // Show success message
                lblStatus.Text = "Message sent successfully!";
                lblStatus.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                // Handle exception if needed
                lblStatus.Text = "Error sending message. Please try again later.";
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
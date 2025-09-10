using Portfolio.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Portfolio
{
    public class ProjectsRepository
    {
        public DataTable GetAll()
        {
            string query = "SELECT * FROM Projects ORDER BY DisplayOrder";
            return DatabaseHelper.ExecuteSelect(query);
        }

        public void Update(int id, string title, string description, string image, string link, string github)
        {
            string query = @"UPDATE Projects 
                             SET ProjectTitle=@title, ProjectDescription=@desc, ProjectImage=@image, 
                                 ProjectLink=@link, GithubLink=@github, UpdatedAt=GETDATE() 
                             WHERE ProjectID=@id";

            SqlParameter[] parameters = {
                new SqlParameter("@title", title),
                new SqlParameter("@desc", description),
                new SqlParameter("@image", image),
                new SqlParameter("@link", link),
                new SqlParameter("@github", github),
                new SqlParameter("@id", id)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        public void SwapOrder(int projectId, string direction)
        {
            // 1. Get current order
            string getOrderQuery = "SELECT DisplayOrder FROM Projects WHERE ProjectID=@id";
            int currentOrder = (int)DatabaseHelper.ExecuteScalar(getOrderQuery, new SqlParameter("@id", projectId));

            // 2. Get neighbor project
            string swapQuery = direction == "Up"
                ? "SELECT TOP 1 ProjectID, DisplayOrder FROM Projects WHERE DisplayOrder < @order ORDER BY DisplayOrder DESC"
                : "SELECT TOP 1 ProjectID, DisplayOrder FROM Projects WHERE DisplayOrder > @order ORDER BY DisplayOrder ASC";

            DataTable dt = DatabaseHelper.ExecuteSelect(swapQuery, new SqlParameter("@order", currentOrder));

            if (dt.Rows.Count > 0)
            {
                int swapId = (int)dt.Rows[0]["ProjectID"];
                int swapOrder = (int)dt.Rows[0]["DisplayOrder"];

                // 3. Swap values
                string updateQuery = "UPDATE Projects SET DisplayOrder=@order WHERE ProjectID=@id";

                DatabaseHelper.ExecuteNonQuery(updateQuery,
                    new SqlParameter("@order", swapOrder),
                    new SqlParameter("@id", projectId));

                DatabaseHelper.ExecuteNonQuery(updateQuery,
                    new SqlParameter("@order", currentOrder),
                    new SqlParameter("@id", swapId));
            }
        }
        public void Insert(string title, string description, string image, string link, string github)
        {
            string query = @"INSERT INTO Projects 
                     (ProjectTitle, ProjectDescription, ProjectImage, ProjectLink, GithubLink, IsFeatured, DisplayOrder, CreatedAt, UpdatedAt)
                     VALUES (@title, @desc, @image, @link, @github, 0, 
                             (SELECT ISNULL(MAX(DisplayOrder),0)+1 FROM Projects), GETDATE(), GETDATE())";

            SqlParameter[] parameters = {
                new SqlParameter("@title", title),
                new SqlParameter("@desc", description),
                new SqlParameter("@image", image),
                new SqlParameter("@link", link),
                new SqlParameter("@github", github)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }
    }
}
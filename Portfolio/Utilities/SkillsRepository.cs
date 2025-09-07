using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Portfolio.Utilities
{
    public class SkillsRepository
    {
        // Get all skills with category name
        public DataTable GetAll()
        {
            string query = @"
            SELECT s.SkillID, s.SkillName, s.CategoryID, s.ProficiencyLevel, s.DisplayOrder, c.CategoryName
            FROM Skills s
            INNER JOIN SkillCategories c ON s.CategoryID = c.CategoryID
            ORDER BY c.DisplayOrder, s.DisplayOrder";

            return DatabaseHelper.ExecuteSelect(query);
        }

        // Add new skill
        public void Add(string skillName, int categoryId, int proficiencyLevel, int displayOrder)
        {
            string query = @"INSERT INTO Skills (SkillName, CategoryID, ProficiencyLevel, DisplayOrder) 
                         VALUES (@name, @category, @level, @order)";
            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@name", skillName),
                new SqlParameter("@category", categoryId),
                new SqlParameter("@level", proficiencyLevel),
                new SqlParameter("@order", displayOrder));
        }

        // Update existing skill
        public void Update(int skillId, string skillName, int categoryId, int proficiencyLevel, int displayOrder)
        {
            string query = @"UPDATE Skills 
                         SET SkillName=@name, CategoryID=@category, ProficiencyLevel=@level, DisplayOrder=@order, UpdatedAt=GETDATE()
                         WHERE SkillID=@id";
            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@id", skillId),
                new SqlParameter("@name", skillName),
                new SqlParameter("@category", categoryId),
                new SqlParameter("@level", proficiencyLevel),
                new SqlParameter("@order", displayOrder));
        }

        // Delete skill
        public void Delete(int skillId)
        {
            string query = "DELETE FROM Skills WHERE SkillID=@id";
            DatabaseHelper.ExecuteNonQuery(query, new SqlParameter("@id", skillId));
        }
    }
}
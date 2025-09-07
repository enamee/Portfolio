using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Portfolio.Utilities
{
    public class SkillCategoriesRepository
    {
        // Get all categories ordered by DisplayOrder
        public DataTable GetAll()
        {
            string query = "SELECT * FROM SkillCategories ORDER BY DisplayOrder";
            return DatabaseHelper.ExecuteSelect(query);
        }

        // Add new category
        public void Add(string categoryName, int displayOrder)
        {
            string query = "INSERT INTO SkillCategories (CategoryName, DisplayOrder) VALUES (@name, @order)";
            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@name", categoryName),
                new SqlParameter("@order", displayOrder));
        }

        // Update category
        public void Update(int categoryId, string categoryName, int displayOrder)
        {
            string query = @"UPDATE SkillCategories 
                         SET CategoryName=@name, DisplayOrder=@order, UpdatedAt=GETDATE() 
                         WHERE CategoryID=@id";
            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@id", categoryId),
                new SqlParameter("@name", categoryName),
                new SqlParameter("@order", displayOrder));
        }

        // Delete category
        public void Delete(int categoryId)
        {
            string query = "DELETE FROM SkillCategories WHERE CategoryID=@id";
            DatabaseHelper.ExecuteNonQuery(query, new SqlParameter("@id", categoryId));
        }
    }
}
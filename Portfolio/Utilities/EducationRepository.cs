using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Portfolio.Utilities;

namespace Portfolio
{
    public class EducationRepository
    {
        public DataTable GetAll()
        {
            string query = "SELECT * FROM Education ORDER BY DisplayOrder, StartYear DESC";
            return DatabaseHelper.ExecuteSelect(query);
        }

        public void Delete(int id)
        {
            string query = "DELETE FROM Education WHERE EducationID = @id";
            DatabaseHelper.ExecuteNonQuery(query, new SqlParameter("@id", id));
        }

        public void Update(int id, string degree, string institution, int startYear, int? endYear, string gpa, string description, int displayOrder)
        {
            string query = @"
                UPDATE Education
                SET Degree = @degree,
                    Institution = @institution,
                    StartYear = @startYear,
                    EndYear = @endYear,
                    GPA = @gpa,
                    Description = @description,
                    DisplayOrder = @displayOrder,
                    CreatedAt = CreatedAt
                WHERE EducationID = @id";

            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@degree", degree),
                new SqlParameter("@institution", institution),
                new SqlParameter("@startYear", startYear),
                new SqlParameter("@endYear", (object)endYear ?? DBNull.Value),
                new SqlParameter("@gpa", (object)gpa ?? DBNull.Value),
                new SqlParameter("@description", (object)description ?? DBNull.Value),
                new SqlParameter("@displayOrder", displayOrder),
                new SqlParameter("@id", id));
        }

        public void Add(string degree, string institution, int startYear, int? endYear, string gpa, string description, int displayOrder)
        {
            string query = @"
                INSERT INTO Education (Degree, Institution, StartYear, EndYear, GPA, Description, DisplayOrder)
                VALUES (@degree, @institution, @startYear, @endYear, @gpa, @description, @displayOrder)";

            DatabaseHelper.ExecuteNonQuery(query,
                new SqlParameter("@degree", degree),
                new SqlParameter("@institution", institution),
                new SqlParameter("@startYear", startYear),
                new SqlParameter("@endYear", (object)endYear ?? DBNull.Value),
                new SqlParameter("@gpa", (object)gpa ?? DBNull.Value),
                new SqlParameter("@description", (object)description ?? DBNull.Value),
                new SqlParameter("@displayOrder", displayOrder));
        }
    }
}
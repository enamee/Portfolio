using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Portfolio.Utilities
{
    public class AboutRepository
    {
        public DataTable GetAll()
        {
            string query = "SELECT * FROM AboutContent";
            return DatabaseHelper.ExecuteSelect(query);
        }

        public void Insert(string aboutText, string aboutImage)
        {
            string query = @"INSERT INTO AboutContent (AboutText, AboutImage) 
                             VALUES (@text, @img)";

            SqlParameter[] parameters =
            {
                new SqlParameter("@text", aboutText),
                new SqlParameter("@img", aboutImage)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        public void Update(int aboutId, string aboutText, string aboutImage)
        {
            string query = @"UPDATE AboutContent 
                             SET AboutText=@text, AboutImage=@img 
                             WHERE AboutId=@id";

            SqlParameter[] parameters =
            {
                new SqlParameter("@id", aboutId),
                new SqlParameter("@text", aboutText),
                new SqlParameter("@img", aboutImage)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        public void Delete(int aboutId)
        {
            string query = "DELETE FROM AboutContent WHERE AboutId=@id";

            SqlParameter[] parameters =
            {
                new SqlParameter("@id", aboutId)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }
    }
}
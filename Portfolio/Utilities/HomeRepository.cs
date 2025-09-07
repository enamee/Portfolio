using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Portfolio.Utilities
{
    public class HomeRepository
    {
        public DataTable GetAll()
        {
            string query = "SELECT * FROM HomeContent";
            return DatabaseHelper.ExecuteSelect(query);
        }

        public void Insert(string subtitle, string description, string profileImage, string profileImageBack)
        {
            string query = @"INSERT INTO HomeContent (HeroSubtitle, HeroDescription, ProfileImage, ProfileImageBack) 
                             VALUES (@sub, @desc, @img, @imgBack)";

            SqlParameter[] parameters =
            {
                new SqlParameter("@sub", subtitle),
                new SqlParameter("@desc", description),
                new SqlParameter("@img", profileImage),
                new SqlParameter("@imgBack", profileImageBack)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        public void Update(int homeId, string subtitle, string description, string profileImage, string profileImageBack)
        {
            string query = @"UPDATE HomeContent 
                             SET HeroSubtitle=@sub, HeroDescription=@desc, ProfileImage=@img, ProfileImageBack=@imgBack 
                             WHERE HomeId=@id";

            SqlParameter[] parameters =
            {
                new SqlParameter("@id", homeId),
                new SqlParameter("@sub", subtitle),
                new SqlParameter("@desc", description),
                new SqlParameter("@img", profileImage),
                new SqlParameter("@imgBack", profileImageBack)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }

        public void Delete(int homeId)
        {
            string query = "DELETE FROM HomeContent WHERE HomeId=@id";

            SqlParameter[] parameters =
            {
                new SqlParameter("@id", homeId)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);
        }
    }
}
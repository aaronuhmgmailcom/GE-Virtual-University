namespace GE.MyLearning.BL.Interface
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Utility;

    public class InstituteCoursesProvider
    {
        public static DataSet GetStudentCourseInfoByStudentID(int studentID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@StudentId", SqlDbType.Int, 4) };
            parameters[0].Value = studentID;
            return DbHelperSQL.RunProcedure("GE_InstituteCourses_GetByStudentId", parameters, "CourseInfo");
        }

        public static DataSet GetStudentInfoByInstituteID(string instituteID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@instituteID", SqlDbType.VarChar, 20) };
            parameters[0].Value = instituteID;
            return DbHelperSQL.RunProcedure("GE_Students_GetByInstituteID", parameters, "Students");
        }
    }
}


namespace GE.MyLearning.BL.Interface
{
    using GE.MyLearning.BL;
    using GE.MyLearning.DL;
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Utility;

    public class Courses_Extend
    {
        public static string GetCourseId()
        {
            return CommonClass.BindId(DbHelperSQL.GetMaxID("CourseID", "dbo.Courses"));
        }

        public static string GetCourseRelationId()
        {
            return CommonClass.BindId(DbHelperSQL.GetMaxID("CourseRelationID", "dbo.CourseRelation"));
        }

        public static DataTable GetCourseRelationTable(string CourseID, int CourseRelationType)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@CourseID", SqlDbType.VarChar), new SqlParameter("@CourseRelationType", SqlDbType.Int) };
            parameters[0].Value = CourseID;
            parameters[1].Value = CourseRelationType;
            return DbHelperSQL.RunProcedure("dbo.GE_Course_CourseRelation", parameters, "CourseRelation").Tables[0];
        }

        public static TList<Courses> GetCoursesByCourseName(string coursename)
        {
            string whereClause = "status = 0 and CourseName=" + CommonClass.sqlString(coursename);
            int count = 0;
            return DataRepository.CoursesProvider.GetPaged(whereClause, null, 0, 0x7fffffff, out count);
        }

        public enum CourseRelationType
        {
            Exam,
            survey
        }

        public enum IsInvestigation
        {
            No = -1,
            Yes = 0
        }

        public enum IsTest
        {
            No = -1,
            Yes = 0
        }
    }
}


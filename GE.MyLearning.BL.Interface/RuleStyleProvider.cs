namespace GE.MyLearning.BL.Interface
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Utility;

    public class RuleStyleProvider
    {
        public static DataTable GetRuleStyleAll(int ruleStyleID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RuleStyleID", SqlDbType.Int) };
            parameters[0].Value = ruleStyleID;
            return DbHelperSQL.RunProcedure("GE_RuleStyle_GetALL", parameters, "ruleStyle").Tables[0];
        }
    }
}


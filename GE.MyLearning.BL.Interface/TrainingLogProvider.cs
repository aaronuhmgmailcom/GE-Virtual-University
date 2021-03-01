namespace GE.MyLearning.BL.Interface
{
    using System;
    using Utility;

    public class TrainingLogProvider
    {
        public static bool IsExistUserTrainingRecord(string UserSSO, string trainingID)
        {
            return (DbHelperSQL.Exists(string.Format("SELECT COUNT(*) FROM [LearningRecordExcel] WHERE [SSO#]='{0}'AND [courseid]='{1}'", UserSSO, trainingID)) || DbHelperSQL.Exists(string.Format("SELECT COUNT(*) FROM [LearningRecordCsv] WHERE [User ID]='{0}'AND [courseid]='{1}'", UserSSO, trainingID)));
        }
    }
}


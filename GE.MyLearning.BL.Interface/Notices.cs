namespace GE.MyLearning.BL.Interface
{
    using GE.MyLearning.BL;
    using GE.MyLearning.DL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Runtime.InteropServices;
    using Utility;

    public class Notices
    {
        public const int MaxNoticeCount = 9;

        public static List<NoticeCountItem> CountNoticeByUserID(string userid)
        {
            List<NoticeCountItem> items = new List<NoticeCountItem>();
            string procedureName = "GE_Notices_CountNoticeByUserID";
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@userid", userid) };
            DataSet ds = DbHelperSQL.RunProcedure(procedureName, parms, "NoticeCount");
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                items.Add(new NoticeCountItem((int) dr["NoticeType"], (int) dr["NoticeCount"]));
            }
            return items;
        }

        public static GE.MyLearning.BL.Notices CreateNotice(string from, string to, string title, string content, NoticeType type)
        {
            GE.MyLearning.BL.Notices data = NoticesBase.CreateNotices(title, content, (int) type, to, null, DateTime.Now, from, 0);
            DataRepository.NoticesProvider.Insert(data);
            return data;
        }

        public static GE.MyLearning.BL.Notices GetNoticeByTitle(string userid, string title)
        {
            string whereClause = "UserID=" + CommonClass.sqlString(userid) + " and NoticeTitle=" + CommonClass.sqlString(title);
            int count = 0;
            TList<GE.MyLearning.BL.Notices> notices = DataRepository.NoticesProvider.GetPaged(whereClause, null, 0, 1, out count);
            return ((notices.Count > 0) ? notices[0] : null);
        }

        public static TList<GE.MyLearning.BL.Notices> GetNoticeList(string userid, int type, int notRead, int pageIndex, int pageLength, out int count)
        {
            string whereClause = "UserID=" + CommonClass.sqlString(userid);
            if (type > 0)
            {
                whereClause = whereClause + " and NoticeType=" + type.ToString();
            }
            if (notRead > 0)
            {
                whereClause = whereClause + " and UserReadTime " + ((notRead == 1) ? "is not null" : "is null");
            }
            string orderBy = "CreateTime desc";
            return DataRepository.NoticesProvider.GetPaged(whereClause, orderBy, pageIndex, pageLength, out count);
        }

        public static string GetNoticeTypeText(NoticeType type)
        {
            switch (type)
            {
                case NoticeType.CourseAssign:
                    return "课程分配通知";

                case NoticeType.CourseApply:
                    return "课程申请通知";

                case NoticeType.CourseApplyResult:
                    return "课程申批通知";

                case NoticeType.TestingComplete:
                    return "考试成绩通知";

                case NoticeType.CheckingComplete:
                    return "阅卷完成通知";

                case NoticeType.StatuteIssue:
                    return "法规发布通知";

                case NoticeType.ApplyChecking:
                    return "阅卷申请通知";

                case NoticeType.ApplyDegree:
                    return "学位申请通知";

                case NoticeType.DegreeAuditingComplete:
                    return "学位审批通知";
            }
            return "";
        }

        public static bool GiveNoticeToCourseAuditor(string userid)
        {
            int count = 0;
            TList<GE.MyLearning.BL.Notices> datalist = GetNoticeList(userid, 2, 0, 0, 1, out count);
            if (datalist.Count > 0)
            {
                datalist[0].CreateTime = DateTime.Now;
                datalist[0].UserReadTime = null;
                DataRepository.NoticesProvider.Update(datalist[0]);
            }
            else
            {
                string title = "有新的课程申请";
                string content = "有新的课程申请，请尽快进入\"课程管理\"的\"课程审批\"频道，审批这些申请。";
                CreateNotice("", userid, title, content, NoticeType.CourseApply);
            }
            return true;
        }

        public static bool GiveNoticeToDegreeAuditor(string userid, string instituteName, string degreeName)
        {
            string title = "学院\"" + instituteName + "\"有新的学位申请";
            string content = "有新的学位申请，请尽快进入\"学院管理\"的\"学院维护\"频道，审批这些申请。<br>\n申请学院：" + instituteName + "<br>\n申请学位：" + degreeName;
            GE.MyLearning.BL.Notices notice = GetNoticeByTitle(userid, title);
            if (notice != null)
            {
                notice.CreateTime = DateTime.Now;
                notice.UserReadTime = null;
                notice.NoticeDetail = content;
                DataRepository.NoticesProvider.Update(notice);
            }
            else
            {
                CreateNotice("", userid, title, content, NoticeType.ApplyDegree);
            }
            return true;
        }

        public static bool GiveNoticeToDegreeStudent(int studentid, bool state)
        {
            bool returnValue = false;
            GE.MyLearning.BL.Students student = DataRepository.StudentsProvider.GetByStudentId(studentid);
            if (student == null)
            {
                return returnValue;
            }
            Degrees degree = DataRepository.DegreesProvider.GetByDegreeId(student.DegreeId);
            if (degree == null)
            {
                return returnValue;
            }
            GE.MyLearning.BL.Institutes institute = DataRepository.InstitutesProvider.GetByInstituteId(degree.InstituteId);
            if (institute == null)
            {
                return returnValue;
            }
            string title = "您于" + student.CreateTime.Value.ToLongDateString() + "申请的学位\"" + degree.DegreeName + "\"" + (state ? "已被批准" : "被拒绝");
            string[] info = new string[] { title, "<br><br>申请学院：", institute.InstituteName, "<br>申请学位：", degree.DegreeName, "<br>申请时间：", student.CreateTime.ToString(), "<br>审批结果：", state ? "<span style='color:green'>批准</span>" : "<span style='color:red'>拒绝</span>" };
            string content = string.Concat(info);
            GE.MyLearning.BL.Notices notice = GetNoticeByTitle(student.UserId, title);
            if (notice != null)
            {
                notice.CreateTime = DateTime.Now;
                notice.UserReadTime = null;
                notice.NoticeDetail = content;
                DataRepository.NoticesProvider.Update(notice);
            }
            else
            {
                CreateNotice("", student.UserId, title, content, NoticeType.DegreeAuditingComplete);
            }
            return true;
        }

        public static bool GiveNoticeToTestingChecker(string userid)
        {
            int count = 0;
            TList<GE.MyLearning.BL.Notices> datalist = GetNoticeList(userid, 7, 0, 0, 1, out count);
            if (datalist.Count > 0)
            {
                datalist[0].CreateTime = DateTime.Now;
                datalist[0].UserReadTime = null;
                DataRepository.NoticesProvider.Update(datalist[0]);
            }
            else
            {
                string title = "有新的阅卷申请";
                string content = "有新的阅卷申请，请尽快进入\"人工阅卷\"频道，为考试答题判分。";
                CreateNotice("", userid, title, content, NoticeType.ApplyChecking);
            }
            return true;
        }

        public class NoticeCountItem
        {
            private GE.MyLearning.BL.Interface.Notices.NoticeType _code;
            private int _count;

            public NoticeCountItem(int code, int count)
            {
                if ((code >= 0) && (code <= 9))
                {
                    this._code = (GE.MyLearning.BL.Interface.Notices.NoticeType) code;
                }
                this._count = count;
            }

            public GE.MyLearning.BL.Interface.Notices.NoticeType Code
            {
                get
                {
                    return this._code;
                }
                set
                {
                    this._code = value;
                }
            }

            public int Count
            {
                get
                {
                    return this._count;
                }
                set
                {
                    this._count = value;
                }
            }

            public string Text
            {
                get
                {
                    return GE.MyLearning.BL.Interface.Notices.GetNoticeTypeText(this._code);
                }
            }
        }

        public enum NoticeType
        {
            Unknow,
            CourseAssign,
            CourseApply,
            CourseApplyResult,
            TestingComplete,
            CheckingComplete,
            StatuteIssue,
            ApplyChecking,
            ApplyDegree,
            DegreeAuditingComplete
        }
    }
}


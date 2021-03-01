namespace GE.MyLearning.BL.Interface
{
    using GE.MyLearning.DL;
    using System;
    using System.Data;
    using System.IO;
    using System.Runtime.InteropServices;
    using System.Text.RegularExpressions;
    using System.Web;

    public class CommonClass
    {
        public static string applyErrMsg = "申请失败!";
        public static string applySucMsg = "申请成功!";
        public static string deleteErrMsg = "删除数据失败!";
        public static string deleteSucMsg = "删除数据成功!";
        public static string insertErrMsg = "新增数据失败!";
        public static string insertSucMsg = "新增数据成功!";
        public static string saveErrMsg = "保存失败!";
        public static string saveSucMsg = "保存成功!";
        public static string updateErrMsg = "更新数据失败!";
        public static string updateSucMsg = "更新数据成功!";

        public static string BindId(int id)
        {
            return id.ToString().PadLeft(9, '0');
        }

        public static TransactionManager CreateTransaction()
        {
            TransactionManager transactionManager = null;
            if (DataRepository.Provider.IsTransactionSupported)
            {
                transactionManager = DataRepository.Provider.CreateTransaction();
                transactionManager.BeginTransaction(IsolationLevel.ReadUncommitted);
            }
            return transactionManager;
        }

        public static string DelFolderAndFiles(string folderPath)
        {
            string strBack = string.Empty;
            try
            {
                DirectoryInfo dir = new DirectoryInfo(folderPath);
                if (dir.Exists)
                {
                    dir.Delete(true);
                }
            }
            catch (Exception eD)
            {
                strBack = eD.ToString();
            }
            return strBack;
        }

        public static int GetNumber(string str)
        {
            int result = 0;
            if ((str != null) && (str != string.Empty))
            {
                str = Regex.Replace(str, @"[^\d.\d]", "");
                if (Regex.IsMatch(str, @"^[+-]?\d*[.]?\d*$"))
                {
                    result = int.Parse(str);
                }
            }
            return result;
        }

        public static void GetTimeLine(int Totalseconds, out string hours, out string minutes, out string seconds)
        {
            double dHour = (Totalseconds / 60) / 60;
            int hour = (int) Math.Floor(dHour);
            double dMinute = Totalseconds - ((hour * 60) * 60);
            int minute = (int) Math.Floor((double) (dMinute / 60.0));
            double dSecond = dMinute - (minute * 60);
            int second = (int) Math.Floor(dSecond);
            hours = hour.ToString("00");
            minutes = minute.ToString("00");
            seconds = second.ToString("00");
        }

        public static void RefreshOpener()
        {
            HttpContext.Current.Response.Write("<script>window.opener.location.reload();</script>");
        }

        public static string sqlString(string s)
        {
            if ((s == null) || (s == ""))
            {
                return "''";
            }
            return ("'" + s.Replace("'", "") + "'");
        }

        public static void WriteErrorLog(string errortype, string errorinfo)
        {
            string strpath = HttpContext.Current.Server.MapPath("/ErrorLog");
            DirectoryInfo dir = new DirectoryInfo(strpath);
            if (!dir.Exists)
            {
                dir.Create();
            }
            string todayName = DateTime.Today.ToString("yyyyMMdd");
            string fileName = strpath + "//" + todayName + ".log";
            string strtime = DateTime.Now.ToString();
            using (StreamWriter sw = File.AppendText(fileName))
            {
                sw.WriteLine("-------------------" + errortype + "---" + strtime + "-----Start-----------");
                sw.WriteLine(errorinfo);
                sw.WriteLine("-------------------" + errortype + "---" + strtime + "-----End-------------");
                sw.WriteLine(" ");
                sw.Flush();
                sw.Close();
            }
        }

        public enum DataFlag
        {
            delete = -1,
            validity = 0
        }
    }
}


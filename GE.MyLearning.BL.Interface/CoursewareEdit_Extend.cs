using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using Utility;

namespace GE.MyLearning.BL.Interface
{
    public class CoursewareEdit_Extend
    {
        /// <summary>
        /// Return a datatable of the courseware type binding.
        /// </summary>
        /// <param name="flag">(0:get all list,1:get list except download resource,2:get the download resource.</param>
        /// <returns>A DataTbale.</returns>
        public static DataTable CoursewareTypeTable(int flag)
        {
            List<string> listType = new List<string>();
            listType.Add(GetCoursewareTypeInfo(CoursewareType.PPT));
            listType.Add(GetCoursewareTypeInfo(CoursewareType.PDF));
            listType.Add(GetCoursewareTypeInfo(CoursewareType.Media));
            listType.Add(GetCoursewareTypeInfo(CoursewareType.MediaAddText));
            listType.Add(GetCoursewareTypeInfo(CoursewareType.Flash));
            listType.Add(GetCoursewareTypeInfo(CoursewareType.Resource));

            DataTable dt = new DataTable();
            dt.Columns.Add("value", typeof(string));
            dt.Columns.Add("text", typeof(string));
            int len = 0;
            int i = 0;
            switch (flag)
            {
                case 0:
                    len = listType.Count;
                    break;
                case 1:
                    len = listType.Count - 1;
                    break;
                case 2:
                    i = listType.Count - 1;
                    len = listType.Count;
                    break;
            }
            DataRow oNewRow;
            for (int j = i; j < len; j++)
            {
                oNewRow = dt.NewRow();
                oNewRow["value"] = j;
                oNewRow["text"] = listType[j];
                dt.Rows.Add(oNewRow);
            }
            return dt;
        }

        public static string GetCoursewareId()
        {
            int id = DbHelperSQL.GetMaxID("CoursewareID", "dbo.Coursewares");
            return CommonClass.BindId(id);
        }

        public enum ResuouceType
        {
            Courseware = 0,
            Resource= 1
        }

        /// <summary>
        /// The enum of the courseware type.
        /// </summary>
        public enum CoursewareType
        {
            PPT = 0,
            PDF = 1,
            Media = 2,
            MediaAddText = 3,
            Flash = 4,
            Resource = 5
        }

        public static string GetCoursewareTypeInfo(CoursewareType ct)
        {
            string strTypeInfo = string.Empty;
            switch (ct)
            {
                case CoursewareType.PPT:
                    strTypeInfo = "数据文件";
                    break;
                case CoursewareType.PDF:
                    strTypeInfo = "URL地址";
                    break;
                case CoursewareType.Media:
                    strTypeInfo = "Media文件(wmv,wma,mp3)";
                    break;
                case CoursewareType.MediaAddText:
                    strTypeInfo = "Media文件需添加文本";
                    break;
                case CoursewareType.Flash:
                    strTypeInfo = "Flash文件(swf)";
                    break;
                case CoursewareType.Resource:
                    strTypeInfo = "下载资源";
                    break;
            }
            return strTypeInfo;
        }

        public static CoursewareType GetCoursewarePath(BL.Coursewares cw,out string imagePath,out string filePath,out bool haveMediaText)
        {
            string fileFullPath = Path.Combine(cw.CoursewareFilePath, cw.CoursewareFileName).Replace("\\","/");
            string fileRelPath = fileRelPath = fileFullPath.Substring(fileFullPath.ToLower().IndexOf("clientbin") - 1);
           
            imagePath = string.Empty;
            filePath = string.Empty;
            haveMediaText = false;
            switch ((CoursewareType)cw.CoursewareType)
            {
                case CoursewareType.PPT:
                case CoursewareType.PDF:
                    imagePath = fileRelPath.Split('.')[0] + "/Images.xml";
                    break;
                case CoursewareType.Media:
                    filePath = fileRelPath.ToLower().Replace("/clientbin/", "");
                    break;
                case CoursewareType.MediaAddText:
                    filePath = fileRelPath.ToLower().Replace("/clientbin/", "");
                    break;
                case CoursewareType.Flash:
                case CoursewareType.Resource:
                    filePath = fileRelPath;
                    break;
            }
            if(File.Exists(fileFullPath.Replace(cw.CoursewareFileName,"mediaText.xml")))
            {
                haveMediaText = true;
            }
            return (CoursewareType)cw.CoursewareType;
        }

        public static string GetCoursewareResourcePath(BL.Coursewares cw)
        {
            string fileFullPath = Path.Combine(cw.CoursewareFilePath, cw.CoursewareFileName).Replace("\\", "/");
            string fileRelPath = fileFullPath.Substring(fileFullPath.ToLower().IndexOf("clientbin") - 1);
            return fileRelPath;
        }
    }

 
}

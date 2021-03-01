namespace GE.MyLearning.BL.Interface
{
    using GE.MyLearning.BL;
    using GE.MyLearning.DL;
    using System;
    using Utility;

    public class UserInfo
    {
        public const string Permission_Evaluation = "Evaluation";
        public const string Permission_EvaluationReport = "EvaluationReport";
        public const string Permission_MgtChecking = "MgtChecking";
        public const string Permission_MgtCourse = "MgtCourse";
        public const string Permission_MgtEvaluation = "MgtEvaluation";
        public const string Permission_MgtInstitute = "MgtInstitute";
        public const string Permission_MgtLibrary = "MgtLibrary";
        public const string Permission_MgtRule = "MgtRule";
        public const string Permission_MgtStatute = "MgtStatute";
        public const string Permission_MgtSurvery = "MgtSurvery";
        public const string Permission_MgtSystem = "MgtSystem";
        public const string Permission_MgtTesting = "MgtTesting";
        public const string Permission_MyLearning = "MyLearning";

        public static TList<GE.MyLearning.BL.Groups> GetGroupsByPermissionID(string permissionId)
        {
            string whereClause = "GroupID in ( select GroupID from (UserGroup inner join UserRole on UserGroup.UserID=UserRole.UserID)   inner join RolePermission on UserRole.RoleID=RolePermission.RoleID where RolePermission.PermissionID=" + CommonClass.sqlString(permissionId) + ")";
            string orderBy = "GroupName";
            int count = -1;
            return DataRepository.GroupsProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
        }

        public static VList<VwUserGroup> GetGroupUserListByPermissionID(string permissionId)
        {
            string whereClause = "UserID in ( select UserID from UserRole as a inner join RolePermission as b on a.RoleID=b.RoleID where PermissionId=" + CommonClass.sqlString(permissionId) + ")";
            string orderBy = "GroupName,UserCNName";
            int count = -1;
            return DataRepository.VwUserGroupProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
        }

        public static TList<GE.MyLearning.BL.Menus> GetMenusByUserID(string userid)
        {
            string whereClause = "ParentMenuID is not null and ParentMenuID<>'' and ParentMenuID<>'0' and PermissionID in (   select PermissionID   from RolePermission as a inner join UserRole as b on a.RoleID=b.RoleID   where userid=" + CommonClass.sqlString(userid) + " ) and status=" + ConfigInfo.Instance().VertualUniversityStyle.ToString();
            string orderBy = "ParentMenuID,ShowOrder";
            int count = -1;
            TList<GE.MyLearning.BL.Menus> menus = DataRepository.MenusProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
            whereClause = "(ParentMenuID is null or ParentMenuID='' or ParentMenuID='0') and status=" + ConfigInfo.Instance().VertualUniversityStyle.ToString();
            orderBy = "ShowOrder";
            TList<GE.MyLearning.BL.Menus> groups = DataRepository.MenusProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
            for (int i = 0; i < groups.Count; i++)
            {
                if (menus.FindAll(MenusColumn.ParentMenuId, groups[i].MenuId).Count > 0)
                {
                    menus.Add(groups[i]);
                }
            }
            if (ConfigInfo.Instance().VertualUniversityStyle.ToString() == "0")
            {
                DataRepository.UserRoleProvider.GetPaged(string.Format("(UserID='{0}') and (RoleID='000000003' or RoleID='000000004')", userid), null, 0, 0x7fffffff, out count);
                if (count != 0)
                {
                    return menus;
                }
                DataRepository.UserInfoProvider.GetPaged(string.Format("OHR_HR_Rep='{0}'", userid), null, 0, 0x7fffffff, out count);
                if (count == 0)
                {
                    return menus;
                }
                groups = DataRepository.MenusProvider.GetPaged("PermissionID='MgtInstitute03'", null, 0, 0x7fffffff, out count);
                foreach (GE.MyLearning.BL.Menus menu in groups)
                {
                    menus.Add(menu);
                }
            }
            return menus;
        }

        public static TList<GE.MyLearning.BL.Permission> GetPermissionsByUserID(string userid)
        {
            string whereClause = "PermissionID in (select PermissionID from RolePermission as a inner join UserRole as b on a.RoleID=b.RoleID where userid=" + CommonClass.sqlString(userid) + ")";
            int count = -1;
            return DataRepository.PermissionProvider.GetPaged(whereClause, "", 0, 0x7fffffff, out count);
        }

        public static TList<GE.MyLearning.BL.Roles> GetRolsbyUserID(string userid)
        {
            string whereClause = "RoleID in (SELECT RoleID FROM UserRole WHERE UserID=" + CommonClass.sqlString(userid) + ")";
            int count = -1;
            return DataRepository.RolesProvider.GetPaged(whereClause, "", 0, 0x7fffffff, out count);
        }

        public static GE.MyLearning.BL.UserInfo GetUserInfoByUserID(string userid)
        {
            string whereClause = "UserID=" + CommonClass.sqlString(userid) + " and UserStatus=0";
            int count = -1;
            TList<GE.MyLearning.BL.UserInfo> datalist = DataRepository.UserInfoProvider.GetPaged(whereClause, null, 0, int.MaxValue, out count);
            return ((datalist.Count > 0) ? datalist[0] : null);
        }

        public static TList<GE.MyLearning.BL.UserInfo> GetUserListByGroupID(string groupid)
        {
            string whereClause = "";
            if ((groupid == null) || (groupid == ""))
            {
                whereClause = "UserID not in (select UserID from UserGroup)";
            }
            else
            {
                whereClause = "UserID in (select UserID from UserGroup where GroupID=" + CommonClass.sqlString(groupid) + ")";
            }
            string orderBy = "UserCNName";
            int count = -1;
            return DataRepository.UserInfoProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
        }

        public static TList<GE.MyLearning.BL.UserInfo> GetUserListByGroupIDAndPermissionID(string groupid, string permissionId)
        {
            string whereClause = "UserID in ( select UserID from UserRole as a inner join RolePermission as b on a.RoleID=b.RoleID where PermissionId=" + CommonClass.sqlString(permissionId) + ")";
            if ((groupid == "") || (groupid == null))
            {
                whereClause = whereClause + " and UserID not in (select UserID from UserGroup)";
            }
            else
            {
                whereClause = whereClause + " and UserID in (select UserID from UserGroup where GroupID=" + CommonClass.sqlString(groupid) + ")";
            }
            string orderBy = "UserCNName";
            int count = -1;
            return DataRepository.UserInfoProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
        }

        public static TList<GE.MyLearning.BL.UserInfo> GetUserListByPermissionID(string permissionId)
        {
            string whereClause = "UserID in ( select UserID from UserRole as a inner join RolePermission as b on a.RoleID=b.RoleID where PermissionId=" + CommonClass.sqlString(permissionId) + ")";
            string orderBy = "UserCNName";
            int count = -1;
            return DataRepository.UserInfoProvider.GetPaged(whereClause, orderBy, 0, 0x7fffffff, out count);
        }

        public static string GetUserNameByUserID(string userid)
        {
            GE.MyLearning.BL.UserInfo info = DataRepository.UserInfoProvider.GetByUserId(userid);
            return ((info != null) ? info.UserCnName : "");
        }

        public static TreeList GetUserTree(string permissionId)
        {
            TreeList list = new TreeList();
            TList<GE.MyLearning.BL.UserInfo> users = null;
            VList<VwUserGroup> usergroups = DataRepository.VwUserGroupProvider.GetAll();
            if ((permissionId != null) && (permissionId != ""))
            {
                users = GetUserListByPermissionID(permissionId);
            }
            else
            {
                users = DataRepository.UserInfoProvider.GetAll();
            }
            foreach (GE.MyLearning.BL.UserInfo user1 in users)
            {
                if (user1.UserStatus == 0)
                {
                    bool isGroupUser = false;
                    VList<VwUserGroup> usergroup = usergroups.FindAll(VwUserGroupColumn.UserId, user1.UserId);
                    foreach (VwUserGroup usergroup1 in usergroup)
                    {
                        if (usergroup1.GroupStatus == 0)
                        {
                            isGroupUser = true;
                            list.Add("Group_" + usergroup1.GroupId, usergroup1.GroupName, null);
                            list.Add(usergroup1.GroupId + "_" + user1.UserId, user1.UserCnName, "Group_" + usergroup1.GroupId);
                        }
                    }
                    if (!isGroupUser)
                    {
                        list.Add(user1.UserId, user1.UserCnName, null);
                    }
                }
            }
            foreach (TreeList.Node node1 in list.Nodes)
            {
                if (!((node1.ID.IndexOf('_') <= 0) || node1.ID.StartsWith("Group_")))
                {
                    node1.ID = node1.ID.Substring(node1.ID.IndexOf('_') + 1);
                }
            }
            return list;
        }
    }
}


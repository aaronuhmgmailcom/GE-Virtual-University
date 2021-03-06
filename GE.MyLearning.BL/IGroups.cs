﻿using System;
using System.ComponentModel;

namespace GE.MyLearning.BL
{
	/// <summary>
	///		The data structure representation of the 'Groups' table via interface.
	/// </summary>
	/// <remarks>
	/// 	This struct is generated by a tool and should never be modified.
	/// </remarks>
	public interface IGroups 
	{
		/// <summary>			
		/// GroupID : 
		/// </summary>
		/// <remarks>Member of the primary key of the underlying table "Groups"</remarks>
		System.String GroupId { get; set; }
				
		/// <summary>
		/// keep a copy of the original so it can be used for editable primary keys.
		/// </summary>
		System.String OriginalGroupId { get; set; }
			
		
		
		/// <summary>
		/// GroupName : 
		/// </summary>
		System.String  GroupName  { get; set; }
		
		/// <summary>
		/// Description : 
		/// </summary>
		System.String  Description  { get; set; }
		
		/// <summary>
		/// Status : 
		/// </summary>
		System.Int32  Status  { get; set; }
		
		/// <summary>
		/// LeaderUserID : 
		/// </summary>
		System.String  LeaderUserId  { get; set; }
		
		/// <summary>
		/// CreateTime : 
		/// </summary>
		System.DateTime  CreateTime  { get; set; }
		
		/// <summary>
		/// CreateUserID : 
		/// </summary>
		System.String  CreateUserId  { get; set; }
			
		/// <summary>
		/// Creates a new object that is a copy of the current instance.
		/// </summary>
		/// <returns>A new object that is a copy of this instance.</returns>
		System.Object Clone();
		
		#region Data Properties

		#endregion Data Properties

	}
}



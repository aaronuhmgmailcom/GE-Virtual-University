﻿using System;
using System.ComponentModel;

namespace GE.MyLearning.BL
{
	/// <summary>
	///		The data structure representation of the 'Permission' table via interface.
	/// </summary>
	/// <remarks>
	/// 	This struct is generated by a tool and should never be modified.
	/// </remarks>
	public interface IPermission 
	{
		/// <summary>			
		/// PermissionID : 
		/// </summary>
		/// <remarks>Member of the primary key of the underlying table "Permission"</remarks>
		System.String PermissionId { get; set; }
				
		/// <summary>
		/// keep a copy of the original so it can be used for editable primary keys.
		/// </summary>
		System.String OriginalPermissionId { get; set; }
			
		
		
		/// <summary>
		/// PermissionName : 
		/// </summary>
		System.String  PermissionName  { get; set; }
		
		/// <summary>
		/// PermissionURL : 
		/// </summary>
		System.String  PermissionUrl  { get; set; }
		
		/// <summary>
		/// Status : 
		/// </summary>
		System.Int32  Status  { get; set; }
		
		/// <summary>
		/// MenuID : 
		/// </summary>
		System.String  MenuId  { get; set; }
			
		/// <summary>
		/// Creates a new object that is a copy of the current instance.
		/// </summary>
		/// <returns>A new object that is a copy of this instance.</returns>
		System.Object Clone();
		
		#region Data Properties

		#endregion Data Properties

	}
}



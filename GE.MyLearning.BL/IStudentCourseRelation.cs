﻿using System;
using System.ComponentModel;

namespace GE.MyLearning.BL
{
	/// <summary>
	///		The data structure representation of the 'StudentCourseRelation' table via interface.
	/// </summary>
	/// <remarks>
	/// 	This struct is generated by a tool and should never be modified.
	/// </remarks>
	public interface IStudentCourseRelation 
	{
		/// <summary>			
		/// AutoID : 
		/// </summary>
		/// <remarks>Member of the primary key of the underlying table "StudentCourseRelation"</remarks>
		System.Int32 AutoId { get; set; }
				
		
		
		/// <summary>
		/// StudentID : 
		/// </summary>
		System.Int32  StudentId  { get; set; }
		
		/// <summary>
		/// degreeCourseID : 
		/// </summary>
		System.Int32  DegreeCourseId  { get; set; }
		
		/// <summary>
		/// Credentials : 
		/// </summary>
		System.Byte[]  Credentials  { get; set; }
		
		/// <summary>
		/// Updatetime : 
		/// </summary>
		System.DateTime?  Updatetime  { get; set; }
		
		/// <summary>
		/// UpdateUserID : 
		/// </summary>
		System.String  UpdateUserId  { get; set; }
		
		/// <summary>
		/// CredentialsStyle : 
		/// </summary>
		System.Int32?  CredentialsStyle  { get; set; }
		
		/// <summary>
		/// AttachmentFileStyle : 
		/// </summary>
		System.String  AttachmentFileStyle  { get; set; }
		
		/// <summary>
		/// AttachmentFilePath : 
		/// </summary>
		System.String  AttachmentFilePath  { get; set; }
		
		/// <summary>
		/// courseID : 
		/// </summary>
		System.String  CourseId  { get; set; }
		
		/// <summary>
		/// UserID : 
		/// </summary>
		System.String  UserId  { get; set; }
			
		/// <summary>
		/// Creates a new object that is a copy of the current instance.
		/// </summary>
		/// <returns>A new object that is a copy of this instance.</returns>
		System.Object Clone();
		
		#region Data Properties

		#endregion Data Properties

	}
}


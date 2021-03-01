﻿/*
	File generated by NetTiers templates [www.nettiers.com]
	Important: Do not modify this file. Edit the file EvlVLearningRecordExcel.cs instead.
*/
#region Using Directives
using System;
using System.ComponentModel;
using System.Collections;
using System.Runtime.Serialization;
using System.Xml.Serialization;
#endregion

namespace GE.MyLearning.BL
{
	///<summary>
	/// An object representation of the 'evl_v_LearningRecordExcel' view. [No description found in the database]	
	///</summary>
	[Serializable]
	[CLSCompliant(true)]
	[ToolboxItem("EvlVLearningRecordExcelBase")]
	public abstract partial class EvlVLearningRecordExcelBase : System.IComparable, System.ICloneable, INotifyPropertyChanged
	{
		
		#region Variable Declarations
		
		/// <summary>
		/// CourseName : 
		/// </summary>
		private System.String		  _courseName = null;
		
		/// <summary>
		/// SSO : 
		/// </summary>
		private System.String		  _sso = null;
		
		/// <summary>
		/// UserName : 
		/// </summary>
		private System.String		  _userName = null;
		
		/// <summary>
		/// Function : 
		/// </summary>
		private System.String		  _function = null;
		
		/// <summary>
		/// StartDate : 
		/// </summary>
		private System.DateTime?		  _startDate = null;
		
		/// <summary>
		/// CompletedDate : 
		/// </summary>
		private System.DateTime?		  _completedDate = null;
		
		/// <summary>
		/// Location : 
		/// </summary>
		private System.String		  _location = null;
		
		/// <summary>
		/// Trainer : 
		/// </summary>
		private System.String		  _trainer = null;
		
		/// <summary>
		/// courseid : 
		/// </summary>
		private System.String		  _courseid = null;
		
		/// <summary>
		/// ID : 
		/// </summary>
		private System.Int32		  _id = (int)0;
		
		/// <summary>
		/// CreatedDate : 
		/// </summary>
		private System.DateTime?		  _createdDate = null;
		
		/// <summary>
		/// Object that contains data to associate with this object
		/// </summary>
		private object _tag;
		
		/// <summary>
		/// Suppresses Entity Events from Firing, 
		/// useful when loading the entities from the database.
		/// </summary>
	    [NonSerialized] 
		private bool suppressEntityEvents = false;
		
		#endregion Variable Declarations
		
		#region Constructors
		///<summary>
		/// Creates a new <see cref="EvlVLearningRecordExcelBase"/> instance.
		///</summary>
		public EvlVLearningRecordExcelBase()
		{
		}		
		
		///<summary>
		/// Creates a new <see cref="EvlVLearningRecordExcelBase"/> instance.
		///</summary>
		///<param name="_courseName"></param>
		///<param name="_sso"></param>
		///<param name="_userName"></param>
		///<param name="_function"></param>
		///<param name="_startDate"></param>
		///<param name="_completedDate"></param>
		///<param name="_location"></param>
		///<param name="_trainer"></param>
		///<param name="_courseid"></param>
		///<param name="_id"></param>
		///<param name="_createdDate"></param>
		public EvlVLearningRecordExcelBase(System.String _courseName, System.String _sso, System.String _userName, System.String _function, System.DateTime? _startDate, System.DateTime? _completedDate, System.String _location, System.String _trainer, System.String _courseid, System.Int32 _id, System.DateTime? _createdDate)
		{
			this._courseName = _courseName;
			this._sso = _sso;
			this._userName = _userName;
			this._function = _function;
			this._startDate = _startDate;
			this._completedDate = _completedDate;
			this._location = _location;
			this._trainer = _trainer;
			this._courseid = _courseid;
			this._id = _id;
			this._createdDate = _createdDate;
		}
		
		///<summary>
		/// A simple factory method to create a new <see cref="EvlVLearningRecordExcel"/> instance.
		///</summary>
		///<param name="_courseName"></param>
		///<param name="_sso"></param>
		///<param name="_userName"></param>
		///<param name="_function"></param>
		///<param name="_startDate"></param>
		///<param name="_completedDate"></param>
		///<param name="_location"></param>
		///<param name="_trainer"></param>
		///<param name="_courseid"></param>
		///<param name="_id"></param>
		///<param name="_createdDate"></param>
		public static EvlVLearningRecordExcel CreateEvlVLearningRecordExcel(System.String _courseName, System.String _sso, System.String _userName, System.String _function, System.DateTime? _startDate, System.DateTime? _completedDate, System.String _location, System.String _trainer, System.String _courseid, System.Int32 _id, System.DateTime? _createdDate)
		{
			EvlVLearningRecordExcel newEvlVLearningRecordExcel = new EvlVLearningRecordExcel();
			newEvlVLearningRecordExcel.CourseName = _courseName;
			newEvlVLearningRecordExcel.Sso = _sso;
			newEvlVLearningRecordExcel.UserName = _userName;
			newEvlVLearningRecordExcel.Function = _function;
			newEvlVLearningRecordExcel.StartDate = _startDate;
			newEvlVLearningRecordExcel.CompletedDate = _completedDate;
			newEvlVLearningRecordExcel.Location = _location;
			newEvlVLearningRecordExcel.Trainer = _trainer;
			newEvlVLearningRecordExcel.Courseid = _courseid;
			newEvlVLearningRecordExcel.Id = _id;
			newEvlVLearningRecordExcel.CreatedDate = _createdDate;
			return newEvlVLearningRecordExcel;
		}
				
		#endregion Constructors
		
		#region Properties	
		/// <summary>
		/// 	Gets or Sets the CourseName property. 
		///		
		/// </summary>
		/// <value>This type is nvarchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String CourseName
		{
			get
			{
				return this._courseName; 
			}
			set
			{
				if (_courseName == value)
					return;
					
				this._courseName = value;
				this._isDirty = true;
				
				OnPropertyChanged("CourseName");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the SSO property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Sso
		{
			get
			{
				return this._sso; 
			}
			set
			{
				if (_sso == value)
					return;
					
				this._sso = value;
				this._isDirty = true;
				
				OnPropertyChanged("Sso");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the UserName property. 
		///		
		/// </summary>
		/// <value>This type is nvarchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String UserName
		{
			get
			{
				return this._userName; 
			}
			set
			{
				if (_userName == value)
					return;
					
				this._userName = value;
				this._isDirty = true;
				
				OnPropertyChanged("UserName");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the Function property. 
		///		
		/// </summary>
		/// <value>This type is nvarchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Function
		{
			get
			{
				return this._function; 
			}
			set
			{
				if (_function == value)
					return;
					
				this._function = value;
				this._isDirty = true;
				
				OnPropertyChanged("Function");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the StartDate property. 
		///		
		/// </summary>
		/// <value>This type is smalldatetime</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return DateTime.MinValue. It is up to the developer
		/// to check the value of IsStartDateNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.DateTime? StartDate
		{
			get
			{
				return this._startDate; 
			}
			set
			{
				if (_startDate == value && StartDate != null )
					return;
					
				this._startDate = value;
				this._isDirty = true;
				
				OnPropertyChanged("StartDate");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the CompletedDate property. 
		///		
		/// </summary>
		/// <value>This type is smalldatetime</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return DateTime.MinValue. It is up to the developer
		/// to check the value of IsCompletedDateNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.DateTime? CompletedDate
		{
			get
			{
				return this._completedDate; 
			}
			set
			{
				if (_completedDate == value && CompletedDate != null )
					return;
					
				this._completedDate = value;
				this._isDirty = true;
				
				OnPropertyChanged("CompletedDate");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the Location property. 
		///		
		/// </summary>
		/// <value>This type is nvarchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Location
		{
			get
			{
				return this._location; 
			}
			set
			{
				if (_location == value)
					return;
					
				this._location = value;
				this._isDirty = true;
				
				OnPropertyChanged("Location");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the Trainer property. 
		///		
		/// </summary>
		/// <value>This type is nvarchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Trainer
		{
			get
			{
				return this._trainer; 
			}
			set
			{
				if (_trainer == value)
					return;
					
				this._trainer = value;
				this._isDirty = true;
				
				OnPropertyChanged("Trainer");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the courseid property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Courseid
		{
			get
			{
				return this._courseid; 
			}
			set
			{
				if (_courseid == value)
					return;
					
				this._courseid = value;
				this._isDirty = true;
				
				OnPropertyChanged("Courseid");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the ID property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32 Id
		{
			get
			{
				return this._id; 
			}
			set
			{
				if (_id == value)
					return;
					
				this._id = value;
				this._isDirty = true;
				
				OnPropertyChanged("Id");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the CreatedDate property. 
		///		
		/// </summary>
		/// <value>This type is datetime</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return DateTime.MinValue. It is up to the developer
		/// to check the value of IsCreatedDateNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.DateTime? CreatedDate
		{
			get
			{
				return this._createdDate; 
			}
			set
			{
				if (_createdDate == value && CreatedDate != null )
					return;
					
				this._createdDate = value;
				this._isDirty = true;
				
				OnPropertyChanged("CreatedDate");
			}
		}
		
		
		/// <summary>
		///     Gets or sets the object that contains supplemental data about this object.
		/// </summary>
		/// <value>Object</value>
		[System.ComponentModel.Bindable(false)]
		[LocalizableAttribute(false)]
		[DescriptionAttribute("Object containing data to be associated with this object")]
		public virtual object Tag
		{
			get
			{
				return this._tag;
			}
			set
			{
				if (this._tag == value)
					return;
		
				this._tag = value;
			}
		}
	
		/// <summary>
		/// Determines whether this entity is to suppress events while set to true.
		/// </summary>
		[System.ComponentModel.Bindable(false)]
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public bool SuppressEntityEvents
		{	
			get
			{
				return suppressEntityEvents;
			}
			set
			{
				suppressEntityEvents = value;
			}	
		}

		private bool _isDeleted = false;
		/// <summary>
		/// Gets a value indicating if object has been <see cref="MarkToDelete"/>. ReadOnly.
		/// </summary>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public virtual bool IsDeleted
		{
			get { return this._isDeleted; }
		}


		private bool _isDirty = false;
		/// <summary>
		///	Gets a value indicating  if the object has been modified from its original state.
		/// </summary>
		///<value>True if object has been modified from its original state; otherwise False;</value>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public virtual bool IsDirty
		{
			get { return this._isDirty; }
		}
		

		private bool _isNew = true;
		/// <summary>
		///	Gets a value indicating if the object is new.
		/// </summary>
		///<value>True if objectis new; otherwise False;</value>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public virtual bool IsNew
		{
			get { return this._isNew; }
			set { this._isNew = value; }
		}

		/// <summary>
		///		The name of the underlying database table.
		/// </summary>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public string ViewName
		{
			get { return "evl_v_LearningRecordExcel"; }
		}

		
		#endregion
		
		#region Methods	
		
		/// <summary>
		/// Accepts the changes made to this object by setting each flags to false.
		/// </summary>
		public virtual void AcceptChanges()
		{
			this._isDeleted = false;
			this._isDirty = false;
			this._isNew = false;
			OnPropertyChanged(string.Empty);
		}
		
		
		///<summary>
		///  Revert all changes and restore original values.
		///  Currently not supported.
		///</summary>
		/// <exception cref="NotSupportedException">This method is not currently supported and always throws this exception.</exception>
		public virtual void CancelChanges()
		{
			throw new NotSupportedException("Method currently not Supported.");
		}
		
		///<summary>
		///   Marks entity to be deleted.
		///</summary>
		public virtual void MarkToDelete()
		{
			this._isDeleted = true;
		}
		
		#region ICloneable Members
		///<summary>
		///  Returns a Typed EvlVLearningRecordExcelBase Entity 
		///</summary>
		public virtual EvlVLearningRecordExcelBase Copy()
		{
			//shallow copy entity
			EvlVLearningRecordExcel copy = new EvlVLearningRecordExcel();
				copy.CourseName = this.CourseName;
				copy.Sso = this.Sso;
				copy.UserName = this.UserName;
				copy.Function = this.Function;
				copy.StartDate = this.StartDate;
				copy.CompletedDate = this.CompletedDate;
				copy.Location = this.Location;
				copy.Trainer = this.Trainer;
				copy.Courseid = this.Courseid;
				copy.Id = this.Id;
				copy.CreatedDate = this.CreatedDate;
			copy.AcceptChanges();
			return (EvlVLearningRecordExcel)copy;
		}
		
		///<summary>
		/// ICloneable.Clone() Member, returns the Deep Copy of this entity.
		///</summary>
		public object Clone(){
			return this.Copy();
		}
		
		///<summary>
		/// Returns a deep copy of the child collection object passed in.
		///</summary>
		public static object MakeCopyOf(object x)
		{
			if (x is ICloneable)
			{
				// Return a deep copy of the object
				return ((ICloneable)x).Clone();
			}
			else
				throw new System.NotSupportedException("Object Does Not Implement the ICloneable Interface.");
		}
		#endregion
		
		
		///<summary>
		/// Returns a value indicating whether this instance is equal to a specified object.
		///</summary>
		///<param name="toObject">An object to compare to this instance.</param>
		///<returns>true if toObject is a <see cref="EvlVLearningRecordExcelBase"/> and has the same value as this instance; otherwise, false.</returns>
		public virtual bool Equals(EvlVLearningRecordExcelBase toObject)
		{
			if (toObject == null)
				return false;
			return Equals(this, toObject);
		}
		
		
		///<summary>
		/// Determines whether the specified <see cref="EvlVLearningRecordExcelBase"/> instances are considered equal.
		///</summary>
		///<param name="Object1">The first <see cref="EvlVLearningRecordExcelBase"/> to compare.</param>
		///<param name="Object2">The second <see cref="EvlVLearningRecordExcelBase"/> to compare. </param>
		///<returns>true if Object1 is the same instance as Object2 or if both are null references or if objA.Equals(objB) returns true; otherwise, false.</returns>
		public static bool Equals(EvlVLearningRecordExcelBase Object1, EvlVLearningRecordExcelBase Object2)
		{
			// both are null
			if (Object1 == null && Object2 == null)
				return true;

			// one or the other is null, but not both
			if (Object1 == null ^ Object2 == null)
				return false;

			bool equal = true;
			if (Object1.CourseName != null && Object2.CourseName != null )
			{
				if (Object1.CourseName != Object2.CourseName)
					equal = false;
			}
			else if (Object1.CourseName == null ^ Object1.CourseName == null )
			{
				equal = false;
			}
			if (Object1.Sso != null && Object2.Sso != null )
			{
				if (Object1.Sso != Object2.Sso)
					equal = false;
			}
			else if (Object1.Sso == null ^ Object1.Sso == null )
			{
				equal = false;
			}
			if (Object1.UserName != null && Object2.UserName != null )
			{
				if (Object1.UserName != Object2.UserName)
					equal = false;
			}
			else if (Object1.UserName == null ^ Object1.UserName == null )
			{
				equal = false;
			}
			if (Object1.Function != null && Object2.Function != null )
			{
				if (Object1.Function != Object2.Function)
					equal = false;
			}
			else if (Object1.Function == null ^ Object1.Function == null )
			{
				equal = false;
			}
			if (Object1.StartDate != null && Object2.StartDate != null )
			{
				if (Object1.StartDate != Object2.StartDate)
					equal = false;
			}
			else if (Object1.StartDate == null ^ Object1.StartDate == null )
			{
				equal = false;
			}
			if (Object1.CompletedDate != null && Object2.CompletedDate != null )
			{
				if (Object1.CompletedDate != Object2.CompletedDate)
					equal = false;
			}
			else if (Object1.CompletedDate == null ^ Object1.CompletedDate == null )
			{
				equal = false;
			}
			if (Object1.Location != null && Object2.Location != null )
			{
				if (Object1.Location != Object2.Location)
					equal = false;
			}
			else if (Object1.Location == null ^ Object1.Location == null )
			{
				equal = false;
			}
			if (Object1.Trainer != null && Object2.Trainer != null )
			{
				if (Object1.Trainer != Object2.Trainer)
					equal = false;
			}
			else if (Object1.Trainer == null ^ Object1.Trainer == null )
			{
				equal = false;
			}
			if (Object1.Courseid != null && Object2.Courseid != null )
			{
				if (Object1.Courseid != Object2.Courseid)
					equal = false;
			}
			else if (Object1.Courseid == null ^ Object1.Courseid == null )
			{
				equal = false;
			}
			if (Object1.Id != Object2.Id)
				equal = false;
			if (Object1.CreatedDate != null && Object2.CreatedDate != null )
			{
				if (Object1.CreatedDate != Object2.CreatedDate)
					equal = false;
			}
			else if (Object1.CreatedDate == null ^ Object1.CreatedDate == null )
			{
				equal = false;
			}
			return equal;
		}
		
		#endregion
		
		#region IComparable Members
		///<summary>
		/// Compares this instance to a specified object and returns an indication of their relative values.
		///<param name="obj">An object to compare to this instance, or a null reference (Nothing in Visual Basic).</param>
		///</summary>
		///<returns>A signed integer that indicates the relative order of this instance and obj.</returns>
		public virtual int CompareTo(object obj)
		{
			throw new NotImplementedException();
		}
	
		#endregion
		
		#region INotifyPropertyChanged Members
		
		/// <summary>
      /// Event to indicate that a property has changed.
      /// </summary>
		[field:NonSerialized]
		public event PropertyChangedEventHandler PropertyChanged;

		/// <summary>
      /// Called when a property is changed
      /// </summary>
      /// <param name="propertyName">The name of the property that has changed.</param>
		protected virtual void OnPropertyChanged(string propertyName)
		{ 
			OnPropertyChanged(new PropertyChangedEventArgs(propertyName));
		}
		
		/// <summary>
      /// Called when a property is changed
      /// </summary>
      /// <param name="e">PropertyChangedEventArgs</param>
		protected virtual void OnPropertyChanged(PropertyChangedEventArgs e)
		{
			if (!SuppressEntityEvents)
			{
				if (null != PropertyChanged)
				{
					PropertyChanged(this, e);
				}
			}
		}
		
		#endregion
				
		/// <summary>
		/// Gets the property value by name.
		/// </summary>
		/// <param name="entity">The entity.</param>
		/// <param name="propertyName">Name of the property.</param>
		/// <returns></returns>
		public static object GetPropertyValueByName(EvlVLearningRecordExcel entity, string propertyName)
		{
			switch (propertyName)
			{
				case "CourseName":
					return entity.CourseName;
				case "Sso":
					return entity.Sso;
				case "UserName":
					return entity.UserName;
				case "Function":
					return entity.Function;
				case "StartDate":
					return entity.StartDate;
				case "CompletedDate":
					return entity.CompletedDate;
				case "Location":
					return entity.Location;
				case "Trainer":
					return entity.Trainer;
				case "Courseid":
					return entity.Courseid;
				case "Id":
					return entity.Id;
				case "CreatedDate":
					return entity.CreatedDate;
			}
			return null;
		}
				
		/// <summary>
		/// Gets the property value by name.
		/// </summary>
		/// <param name="propertyName">Name of the property.</param>
		/// <returns></returns>
		public object GetPropertyValueByName(string propertyName)
		{			
			return GetPropertyValueByName(this as EvlVLearningRecordExcel, propertyName);
		}
		
		///<summary>
		/// Returns a String that represents the current object.
		///</summary>
		public override string ToString()
		{
			return string.Format(System.Globalization.CultureInfo.InvariantCulture,
				"{12}{11}- CourseName: {0}{11}- Sso: {1}{11}- UserName: {2}{11}- Function: {3}{11}- StartDate: {4}{11}- CompletedDate: {5}{11}- Location: {6}{11}- Trainer: {7}{11}- Courseid: {8}{11}- Id: {9}{11}- CreatedDate: {10}{11}", 
				(this.CourseName == null) ? string.Empty : this.CourseName.ToString(),
			     
				(this.Sso == null) ? string.Empty : this.Sso.ToString(),
			     
				(this.UserName == null) ? string.Empty : this.UserName.ToString(),
			     
				(this.Function == null) ? string.Empty : this.Function.ToString(),
			     
				(this.StartDate == null) ? string.Empty : this.StartDate.ToString(),
			     
				(this.CompletedDate == null) ? string.Empty : this.CompletedDate.ToString(),
			     
				(this.Location == null) ? string.Empty : this.Location.ToString(),
			     
				(this.Trainer == null) ? string.Empty : this.Trainer.ToString(),
			     
				(this.Courseid == null) ? string.Empty : this.Courseid.ToString(),
			     
				this.Id,
				(this.CreatedDate == null) ? string.Empty : this.CreatedDate.ToString(),
			     
				System.Environment.NewLine, 
				this.GetType());
		}
	
	}//End Class
	
	
	/// <summary>
	/// Enumerate the EvlVLearningRecordExcel columns.
	/// </summary>
	[Serializable]
	public enum EvlVLearningRecordExcelColumn
	{
		/// <summary>
		/// CourseName : 
		/// </summary>
		[EnumTextValue("CourseName")]
		[ColumnEnum("CourseName", typeof(System.String), System.Data.DbType.String, false, false, true, 255)]
		CourseName,
		/// <summary>
		/// SSO : 
		/// </summary>
		[EnumTextValue("SSO")]
		[ColumnEnum("SSO", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 20)]
		Sso,
		/// <summary>
		/// UserName : 
		/// </summary>
		[EnumTextValue("UserName")]
		[ColumnEnum("UserName", typeof(System.String), System.Data.DbType.String, false, false, true, 255)]
		UserName,
		/// <summary>
		/// Function : 
		/// </summary>
		[EnumTextValue("Function")]
		[ColumnEnum("Function", typeof(System.String), System.Data.DbType.String, false, false, true, 255)]
		Function,
		/// <summary>
		/// StartDate : 
		/// </summary>
		[EnumTextValue("StartDate")]
		[ColumnEnum("StartDate", typeof(System.DateTime), System.Data.DbType.DateTime, false, false, true)]
		StartDate,
		/// <summary>
		/// CompletedDate : 
		/// </summary>
		[EnumTextValue("CompletedDate")]
		[ColumnEnum("CompletedDate", typeof(System.DateTime), System.Data.DbType.DateTime, false, false, true)]
		CompletedDate,
		/// <summary>
		/// Location : 
		/// </summary>
		[EnumTextValue("Location")]
		[ColumnEnum("Location", typeof(System.String), System.Data.DbType.String, false, false, true, 255)]
		Location,
		/// <summary>
		/// Trainer : 
		/// </summary>
		[EnumTextValue("Trainer")]
		[ColumnEnum("Trainer", typeof(System.String), System.Data.DbType.String, false, false, true, 255)]
		Trainer,
		/// <summary>
		/// courseid : 
		/// </summary>
		[EnumTextValue("courseid")]
		[ColumnEnum("courseid", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 50)]
		Courseid,
		/// <summary>
		/// ID : 
		/// </summary>
		[EnumTextValue("ID")]
		[ColumnEnum("ID", typeof(System.Int32), System.Data.DbType.Int32, false, false, false)]
		Id,
		/// <summary>
		/// CreatedDate : 
		/// </summary>
		[EnumTextValue("CreatedDate")]
		[ColumnEnum("CreatedDate", typeof(System.DateTime), System.Data.DbType.DateTime, false, false, true)]
		CreatedDate
	}//End enum

} // end namespace
﻿/*
	File generated by NetTiers templates [www.nettiers.com]
	Important: Do not modify this file. Edit the file VwEvlUser.cs instead.
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
	/// An object representation of the 'VW_EvlUser' view. [No description found in the database]	
	///</summary>
	[Serializable]
	[CLSCompliant(true)]
	[ToolboxItem("VwEvlUserBase")]
	public abstract partial class VwEvlUserBase : System.IComparable, System.ICloneable, INotifyPropertyChanged
	{
		
		#region Variable Declarations
		
		/// <summary>
		/// UserID : 
		/// </summary>
		private System.String		  _userId = string.Empty;
		
		/// <summary>
		/// UserCNName : 
		/// </summary>
		private System.String		  _userCnName = string.Empty;
		
		/// <summary>
		/// name : 
		/// </summary>
		private System.String		  _name = null;
		
		/// <summary>
		/// validdateStart : 
		/// </summary>
		private System.DateTime?		  _validdateStart = null;
		
		/// <summary>
		/// validdateend : 
		/// </summary>
		private System.DateTime?		  _validdateend = null;
		
		/// <summary>
		/// isused : 
		/// </summary>
		private System.Int32		  _isused = (int)0;
		
		/// <summary>
		/// evltimes : 
		/// </summary>
		private System.Int32		  _evltimes = (int)0;
		
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
		/// Creates a new <see cref="VwEvlUserBase"/> instance.
		///</summary>
		public VwEvlUserBase()
		{
		}		
		
		///<summary>
		/// Creates a new <see cref="VwEvlUserBase"/> instance.
		///</summary>
		///<param name="_userId"></param>
		///<param name="_userCnName"></param>
		///<param name="_name"></param>
		///<param name="_validdateStart"></param>
		///<param name="_validdateend"></param>
		///<param name="_isused"></param>
		///<param name="_evltimes"></param>
		public VwEvlUserBase(System.String _userId, System.String _userCnName, System.String _name, System.DateTime? _validdateStart, System.DateTime? _validdateend, System.Int32 _isused, System.Int32 _evltimes)
		{
			this._userId = _userId;
			this._userCnName = _userCnName;
			this._name = _name;
			this._validdateStart = _validdateStart;
			this._validdateend = _validdateend;
			this._isused = _isused;
			this._evltimes = _evltimes;
		}
		
		///<summary>
		/// A simple factory method to create a new <see cref="VwEvlUser"/> instance.
		///</summary>
		///<param name="_userId"></param>
		///<param name="_userCnName"></param>
		///<param name="_name"></param>
		///<param name="_validdateStart"></param>
		///<param name="_validdateend"></param>
		///<param name="_isused"></param>
		///<param name="_evltimes"></param>
		public static VwEvlUser CreateVwEvlUser(System.String _userId, System.String _userCnName, System.String _name, System.DateTime? _validdateStart, System.DateTime? _validdateend, System.Int32 _isused, System.Int32 _evltimes)
		{
			VwEvlUser newVwEvlUser = new VwEvlUser();
			newVwEvlUser.UserId = _userId;
			newVwEvlUser.UserCnName = _userCnName;
			newVwEvlUser.Name = _name;
			newVwEvlUser.ValiddateStart = _validdateStart;
			newVwEvlUser.Validdateend = _validdateend;
			newVwEvlUser.Isused = _isused;
			newVwEvlUser.Evltimes = _evltimes;
			return newVwEvlUser;
		}
				
		#endregion Constructors
		
		#region Properties	
		/// <summary>
		/// 	Gets or Sets the UserID property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		/// <exception cref="ArgumentNullException">If you attempt to set to null.</exception>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String UserId
		{
			get
			{
				return this._userId; 
			}
			set
			{
				if ( value == null )
					throw new ArgumentNullException("value", "UserId does not allow null values.");
				if (_userId == value)
					return;
					
				this._userId = value;
				this._isDirty = true;
				
				OnPropertyChanged("UserId");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the UserCNName property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		/// <exception cref="ArgumentNullException">If you attempt to set to null.</exception>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String UserCnName
		{
			get
			{
				return this._userCnName; 
			}
			set
			{
				if ( value == null )
					throw new ArgumentNullException("value", "UserCnName does not allow null values.");
				if (_userCnName == value)
					return;
					
				this._userCnName = value;
				this._isDirty = true;
				
				OnPropertyChanged("UserCnName");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the name property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Name
		{
			get
			{
				return this._name; 
			}
			set
			{
				if (_name == value)
					return;
					
				this._name = value;
				this._isDirty = true;
				
				OnPropertyChanged("Name");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the validdateStart property. 
		///		
		/// </summary>
		/// <value>This type is datetime</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return DateTime.MinValue. It is up to the developer
		/// to check the value of IsValiddateStartNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.DateTime? ValiddateStart
		{
			get
			{
				return this._validdateStart; 
			}
			set
			{
				if (_validdateStart == value && ValiddateStart != null )
					return;
					
				this._validdateStart = value;
				this._isDirty = true;
				
				OnPropertyChanged("ValiddateStart");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the validdateend property. 
		///		
		/// </summary>
		/// <value>This type is datetime</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return DateTime.MinValue. It is up to the developer
		/// to check the value of IsValiddateendNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.DateTime? Validdateend
		{
			get
			{
				return this._validdateend; 
			}
			set
			{
				if (_validdateend == value && Validdateend != null )
					return;
					
				this._validdateend = value;
				this._isDirty = true;
				
				OnPropertyChanged("Validdateend");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the isused property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32 Isused
		{
			get
			{
				return this._isused; 
			}
			set
			{
				if (_isused == value)
					return;
					
				this._isused = value;
				this._isDirty = true;
				
				OnPropertyChanged("Isused");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the evltimes property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32 Evltimes
		{
			get
			{
				return this._evltimes; 
			}
			set
			{
				if (_evltimes == value)
					return;
					
				this._evltimes = value;
				this._isDirty = true;
				
				OnPropertyChanged("Evltimes");
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
			get { return "VW_EvlUser"; }
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
		///  Returns a Typed VwEvlUserBase Entity 
		///</summary>
		public virtual VwEvlUserBase Copy()
		{
			//shallow copy entity
			VwEvlUser copy = new VwEvlUser();
				copy.UserId = this.UserId;
				copy.UserCnName = this.UserCnName;
				copy.Name = this.Name;
				copy.ValiddateStart = this.ValiddateStart;
				copy.Validdateend = this.Validdateend;
				copy.Isused = this.Isused;
				copy.Evltimes = this.Evltimes;
			copy.AcceptChanges();
			return (VwEvlUser)copy;
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
		///<returns>true if toObject is a <see cref="VwEvlUserBase"/> and has the same value as this instance; otherwise, false.</returns>
		public virtual bool Equals(VwEvlUserBase toObject)
		{
			if (toObject == null)
				return false;
			return Equals(this, toObject);
		}
		
		
		///<summary>
		/// Determines whether the specified <see cref="VwEvlUserBase"/> instances are considered equal.
		///</summary>
		///<param name="Object1">The first <see cref="VwEvlUserBase"/> to compare.</param>
		///<param name="Object2">The second <see cref="VwEvlUserBase"/> to compare. </param>
		///<returns>true if Object1 is the same instance as Object2 or if both are null references or if objA.Equals(objB) returns true; otherwise, false.</returns>
		public static bool Equals(VwEvlUserBase Object1, VwEvlUserBase Object2)
		{
			// both are null
			if (Object1 == null && Object2 == null)
				return true;

			// one or the other is null, but not both
			if (Object1 == null ^ Object2 == null)
				return false;

			bool equal = true;
			if (Object1.UserId != Object2.UserId)
				equal = false;
			if (Object1.UserCnName != Object2.UserCnName)
				equal = false;
			if (Object1.Name != null && Object2.Name != null )
			{
				if (Object1.Name != Object2.Name)
					equal = false;
			}
			else if (Object1.Name == null ^ Object1.Name == null )
			{
				equal = false;
			}
			if (Object1.ValiddateStart != null && Object2.ValiddateStart != null )
			{
				if (Object1.ValiddateStart != Object2.ValiddateStart)
					equal = false;
			}
			else if (Object1.ValiddateStart == null ^ Object1.ValiddateStart == null )
			{
				equal = false;
			}
			if (Object1.Validdateend != null && Object2.Validdateend != null )
			{
				if (Object1.Validdateend != Object2.Validdateend)
					equal = false;
			}
			else if (Object1.Validdateend == null ^ Object1.Validdateend == null )
			{
				equal = false;
			}
			if (Object1.Isused != Object2.Isused)
				equal = false;
			if (Object1.Evltimes != Object2.Evltimes)
				equal = false;
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
		public static object GetPropertyValueByName(VwEvlUser entity, string propertyName)
		{
			switch (propertyName)
			{
				case "UserId":
					return entity.UserId;
				case "UserCnName":
					return entity.UserCnName;
				case "Name":
					return entity.Name;
				case "ValiddateStart":
					return entity.ValiddateStart;
				case "Validdateend":
					return entity.Validdateend;
				case "Isused":
					return entity.Isused;
				case "Evltimes":
					return entity.Evltimes;
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
			return GetPropertyValueByName(this as VwEvlUser, propertyName);
		}
		
		///<summary>
		/// Returns a String that represents the current object.
		///</summary>
		public override string ToString()
		{
			return string.Format(System.Globalization.CultureInfo.InvariantCulture,
				"{8}{7}- UserId: {0}{7}- UserCnName: {1}{7}- Name: {2}{7}- ValiddateStart: {3}{7}- Validdateend: {4}{7}- Isused: {5}{7}- Evltimes: {6}{7}", 
				this.UserId,
				this.UserCnName,
				(this.Name == null) ? string.Empty : this.Name.ToString(),
			     
				(this.ValiddateStart == null) ? string.Empty : this.ValiddateStart.ToString(),
			     
				(this.Validdateend == null) ? string.Empty : this.Validdateend.ToString(),
			     
				this.Isused,
				this.Evltimes,
				System.Environment.NewLine, 
				this.GetType());
		}
	
	}//End Class
	
	
	/// <summary>
	/// Enumerate the VwEvlUser columns.
	/// </summary>
	[Serializable]
	public enum VwEvlUserColumn
	{
		/// <summary>
		/// UserID : 
		/// </summary>
		[EnumTextValue("UserID")]
		[ColumnEnum("UserID", typeof(System.String), System.Data.DbType.AnsiString, false, false, false, 20)]
		UserId,
		/// <summary>
		/// UserCNName : 
		/// </summary>
		[EnumTextValue("UserCNName")]
		[ColumnEnum("UserCNName", typeof(System.String), System.Data.DbType.AnsiString, false, false, false, 20)]
		UserCnName,
		/// <summary>
		/// name : 
		/// </summary>
		[EnumTextValue("name")]
		[ColumnEnum("name", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 50)]
		Name,
		/// <summary>
		/// validdateStart : 
		/// </summary>
		[EnumTextValue("validdateStart")]
		[ColumnEnum("validdateStart", typeof(System.DateTime), System.Data.DbType.DateTime, false, false, true)]
		ValiddateStart,
		/// <summary>
		/// validdateend : 
		/// </summary>
		[EnumTextValue("validdateend")]
		[ColumnEnum("validdateend", typeof(System.DateTime), System.Data.DbType.DateTime, false, false, true)]
		Validdateend,
		/// <summary>
		/// isused : 
		/// </summary>
		[EnumTextValue("isused")]
		[ColumnEnum("isused", typeof(System.Int32), System.Data.DbType.Int32, false, false, false)]
		Isused,
		/// <summary>
		/// evltimes : 
		/// </summary>
		[EnumTextValue("evltimes")]
		[ColumnEnum("evltimes", typeof(System.Int32), System.Data.DbType.Int32, false, false, false)]
		Evltimes
	}//End enum

} // end namespace

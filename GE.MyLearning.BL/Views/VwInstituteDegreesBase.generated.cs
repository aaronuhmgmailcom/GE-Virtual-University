﻿/*
	File generated by NetTiers templates [www.nettiers.com]
	Important: Do not modify this file. Edit the file VwInstituteDegrees.cs instead.
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
	/// An object representation of the 'VW_InstituteDegrees' view. [No description found in the database]	
	///</summary>
	[Serializable]
	[CLSCompliant(true)]
	[ToolboxItem("VwInstituteDegreesBase")]
	public abstract partial class VwInstituteDegreesBase : System.IComparable, System.ICloneable, INotifyPropertyChanged
	{
		
		#region Variable Declarations
		
		/// <summary>
		/// InstituteID : 
		/// </summary>
		private System.String		  _instituteId = string.Empty;
		
		/// <summary>
		/// InstituteName : 
		/// </summary>
		private System.String		  _instituteName = null;
		
		/// <summary>
		/// Description : 
		/// </summary>
		private System.String		  _description = null;
		
		/// <summary>
		/// InstituteDean : 
		/// </summary>
		private System.String		  _instituteDean = null;
		
		/// <summary>
		/// InstituteStatus : 
		/// </summary>
		private System.Int32		  _instituteStatus = (int)0;
		
		/// <summary>
		/// DegreeId : 
		/// </summary>
		private System.Int32		  _degreeId = (int)0;
		
		/// <summary>
		/// DegreeName : 
		/// </summary>
		private System.String		  _degreeName = null;
		
		/// <summary>
		/// DegreesDescription : 
		/// </summary>
		private System.String		  _degreesDescription = null;
		
		/// <summary>
		/// Credithour : 
		/// </summary>
		private System.Int32?		  _credithour = null;
		
		/// <summary>
		/// DegreeStatus : 
		/// </summary>
		private System.Int32?		  _degreeStatus = null;
		
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
		/// Creates a new <see cref="VwInstituteDegreesBase"/> instance.
		///</summary>
		public VwInstituteDegreesBase()
		{
		}		
		
		///<summary>
		/// Creates a new <see cref="VwInstituteDegreesBase"/> instance.
		///</summary>
		///<param name="_instituteId"></param>
		///<param name="_instituteName"></param>
		///<param name="_description"></param>
		///<param name="_instituteDean"></param>
		///<param name="_instituteStatus"></param>
		///<param name="_degreeId"></param>
		///<param name="_degreeName"></param>
		///<param name="_degreesDescription"></param>
		///<param name="_credithour"></param>
		///<param name="_degreeStatus"></param>
		public VwInstituteDegreesBase(System.String _instituteId, System.String _instituteName, System.String _description, System.String _instituteDean, System.Int32 _instituteStatus, System.Int32 _degreeId, System.String _degreeName, System.String _degreesDescription, System.Int32? _credithour, System.Int32? _degreeStatus)
		{
			this._instituteId = _instituteId;
			this._instituteName = _instituteName;
			this._description = _description;
			this._instituteDean = _instituteDean;
			this._instituteStatus = _instituteStatus;
			this._degreeId = _degreeId;
			this._degreeName = _degreeName;
			this._degreesDescription = _degreesDescription;
			this._credithour = _credithour;
			this._degreeStatus = _degreeStatus;
		}
		
		///<summary>
		/// A simple factory method to create a new <see cref="VwInstituteDegrees"/> instance.
		///</summary>
		///<param name="_instituteId"></param>
		///<param name="_instituteName"></param>
		///<param name="_description"></param>
		///<param name="_instituteDean"></param>
		///<param name="_instituteStatus"></param>
		///<param name="_degreeId"></param>
		///<param name="_degreeName"></param>
		///<param name="_degreesDescription"></param>
		///<param name="_credithour"></param>
		///<param name="_degreeStatus"></param>
		public static VwInstituteDegrees CreateVwInstituteDegrees(System.String _instituteId, System.String _instituteName, System.String _description, System.String _instituteDean, System.Int32 _instituteStatus, System.Int32 _degreeId, System.String _degreeName, System.String _degreesDescription, System.Int32? _credithour, System.Int32? _degreeStatus)
		{
			VwInstituteDegrees newVwInstituteDegrees = new VwInstituteDegrees();
			newVwInstituteDegrees.InstituteId = _instituteId;
			newVwInstituteDegrees.InstituteName = _instituteName;
			newVwInstituteDegrees.Description = _description;
			newVwInstituteDegrees.InstituteDean = _instituteDean;
			newVwInstituteDegrees.InstituteStatus = _instituteStatus;
			newVwInstituteDegrees.DegreeId = _degreeId;
			newVwInstituteDegrees.DegreeName = _degreeName;
			newVwInstituteDegrees.DegreesDescription = _degreesDescription;
			newVwInstituteDegrees.Credithour = _credithour;
			newVwInstituteDegrees.DegreeStatus = _degreeStatus;
			return newVwInstituteDegrees;
		}
				
		#endregion Constructors
		
		#region Properties	
		/// <summary>
		/// 	Gets or Sets the InstituteID property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		/// <exception cref="ArgumentNullException">If you attempt to set to null.</exception>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String InstituteId
		{
			get
			{
				return this._instituteId; 
			}
			set
			{
				if ( value == null )
					throw new ArgumentNullException("value", "InstituteId does not allow null values.");
				if (_instituteId == value)
					return;
					
				this._instituteId = value;
				this._isDirty = true;
				
				OnPropertyChanged("InstituteId");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the InstituteName property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String InstituteName
		{
			get
			{
				return this._instituteName; 
			}
			set
			{
				if (_instituteName == value)
					return;
					
				this._instituteName = value;
				this._isDirty = true;
				
				OnPropertyChanged("InstituteName");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the Description property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String Description
		{
			get
			{
				return this._description; 
			}
			set
			{
				if (_description == value)
					return;
					
				this._description = value;
				this._isDirty = true;
				
				OnPropertyChanged("Description");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the InstituteDean property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String InstituteDean
		{
			get
			{
				return this._instituteDean; 
			}
			set
			{
				if (_instituteDean == value)
					return;
					
				this._instituteDean = value;
				this._isDirty = true;
				
				OnPropertyChanged("InstituteDean");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the InstituteStatus property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32 InstituteStatus
		{
			get
			{
				return this._instituteStatus; 
			}
			set
			{
				if (_instituteStatus == value)
					return;
					
				this._instituteStatus = value;
				this._isDirty = true;
				
				OnPropertyChanged("InstituteStatus");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the DegreeId property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32 DegreeId
		{
			get
			{
				return this._degreeId; 
			}
			set
			{
				if (_degreeId == value)
					return;
					
				this._degreeId = value;
				this._isDirty = true;
				
				OnPropertyChanged("DegreeId");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the DegreeName property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String DegreeName
		{
			get
			{
				return this._degreeName; 
			}
			set
			{
				if (_degreeName == value)
					return;
					
				this._degreeName = value;
				this._isDirty = true;
				
				OnPropertyChanged("DegreeName");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the DegreesDescription property. 
		///		
		/// </summary>
		/// <value>This type is varchar</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.String DegreesDescription
		{
			get
			{
				return this._degreesDescription; 
			}
			set
			{
				if (_degreesDescription == value)
					return;
					
				this._degreesDescription = value;
				this._isDirty = true;
				
				OnPropertyChanged("DegreesDescription");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the Credithour property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return (int)0. It is up to the developer
		/// to check the value of IsCredithourNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32? Credithour
		{
			get
			{
				return this._credithour; 
			}
			set
			{
				if (_credithour == value && Credithour != null )
					return;
					
				this._credithour = value;
				this._isDirty = true;
				
				OnPropertyChanged("Credithour");
			}
		}
		
		/// <summary>
		/// 	Gets or Sets the DegreeStatus property. 
		///		
		/// </summary>
		/// <value>This type is int</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return (int)0. It is up to the developer
		/// to check the value of IsDegreeStatusNull() and perform business logic appropriately.
		/// </remarks>
		[DescriptionAttribute(""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		public virtual System.Int32? DegreeStatus
		{
			get
			{
				return this._degreeStatus; 
			}
			set
			{
				if (_degreeStatus == value && DegreeStatus != null )
					return;
					
				this._degreeStatus = value;
				this._isDirty = true;
				
				OnPropertyChanged("DegreeStatus");
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
			get { return "VW_InstituteDegrees"; }
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
		///  Returns a Typed VwInstituteDegreesBase Entity 
		///</summary>
		public virtual VwInstituteDegreesBase Copy()
		{
			//shallow copy entity
			VwInstituteDegrees copy = new VwInstituteDegrees();
				copy.InstituteId = this.InstituteId;
				copy.InstituteName = this.InstituteName;
				copy.Description = this.Description;
				copy.InstituteDean = this.InstituteDean;
				copy.InstituteStatus = this.InstituteStatus;
				copy.DegreeId = this.DegreeId;
				copy.DegreeName = this.DegreeName;
				copy.DegreesDescription = this.DegreesDescription;
				copy.Credithour = this.Credithour;
				copy.DegreeStatus = this.DegreeStatus;
			copy.AcceptChanges();
			return (VwInstituteDegrees)copy;
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
		///<returns>true if toObject is a <see cref="VwInstituteDegreesBase"/> and has the same value as this instance; otherwise, false.</returns>
		public virtual bool Equals(VwInstituteDegreesBase toObject)
		{
			if (toObject == null)
				return false;
			return Equals(this, toObject);
		}
		
		
		///<summary>
		/// Determines whether the specified <see cref="VwInstituteDegreesBase"/> instances are considered equal.
		///</summary>
		///<param name="Object1">The first <see cref="VwInstituteDegreesBase"/> to compare.</param>
		///<param name="Object2">The second <see cref="VwInstituteDegreesBase"/> to compare. </param>
		///<returns>true if Object1 is the same instance as Object2 or if both are null references or if objA.Equals(objB) returns true; otherwise, false.</returns>
		public static bool Equals(VwInstituteDegreesBase Object1, VwInstituteDegreesBase Object2)
		{
			// both are null
			if (Object1 == null && Object2 == null)
				return true;

			// one or the other is null, but not both
			if (Object1 == null ^ Object2 == null)
				return false;

			bool equal = true;
			if (Object1.InstituteId != Object2.InstituteId)
				equal = false;
			if (Object1.InstituteName != null && Object2.InstituteName != null )
			{
				if (Object1.InstituteName != Object2.InstituteName)
					equal = false;
			}
			else if (Object1.InstituteName == null ^ Object1.InstituteName == null )
			{
				equal = false;
			}
			if (Object1.Description != null && Object2.Description != null )
			{
				if (Object1.Description != Object2.Description)
					equal = false;
			}
			else if (Object1.Description == null ^ Object1.Description == null )
			{
				equal = false;
			}
			if (Object1.InstituteDean != null && Object2.InstituteDean != null )
			{
				if (Object1.InstituteDean != Object2.InstituteDean)
					equal = false;
			}
			else if (Object1.InstituteDean == null ^ Object1.InstituteDean == null )
			{
				equal = false;
			}
			if (Object1.InstituteStatus != Object2.InstituteStatus)
				equal = false;
			if (Object1.DegreeId != Object2.DegreeId)
				equal = false;
			if (Object1.DegreeName != null && Object2.DegreeName != null )
			{
				if (Object1.DegreeName != Object2.DegreeName)
					equal = false;
			}
			else if (Object1.DegreeName == null ^ Object1.DegreeName == null )
			{
				equal = false;
			}
			if (Object1.DegreesDescription != null && Object2.DegreesDescription != null )
			{
				if (Object1.DegreesDescription != Object2.DegreesDescription)
					equal = false;
			}
			else if (Object1.DegreesDescription == null ^ Object1.DegreesDescription == null )
			{
				equal = false;
			}
			if (Object1.Credithour != null && Object2.Credithour != null )
			{
				if (Object1.Credithour != Object2.Credithour)
					equal = false;
			}
			else if (Object1.Credithour == null ^ Object1.Credithour == null )
			{
				equal = false;
			}
			if (Object1.DegreeStatus != null && Object2.DegreeStatus != null )
			{
				if (Object1.DegreeStatus != Object2.DegreeStatus)
					equal = false;
			}
			else if (Object1.DegreeStatus == null ^ Object1.DegreeStatus == null )
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
		public static object GetPropertyValueByName(VwInstituteDegrees entity, string propertyName)
		{
			switch (propertyName)
			{
				case "InstituteId":
					return entity.InstituteId;
				case "InstituteName":
					return entity.InstituteName;
				case "Description":
					return entity.Description;
				case "InstituteDean":
					return entity.InstituteDean;
				case "InstituteStatus":
					return entity.InstituteStatus;
				case "DegreeId":
					return entity.DegreeId;
				case "DegreeName":
					return entity.DegreeName;
				case "DegreesDescription":
					return entity.DegreesDescription;
				case "Credithour":
					return entity.Credithour;
				case "DegreeStatus":
					return entity.DegreeStatus;
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
			return GetPropertyValueByName(this as VwInstituteDegrees, propertyName);
		}
		
		///<summary>
		/// Returns a String that represents the current object.
		///</summary>
		public override string ToString()
		{
			return string.Format(System.Globalization.CultureInfo.InvariantCulture,
				"{11}{10}- InstituteId: {0}{10}- InstituteName: {1}{10}- Description: {2}{10}- InstituteDean: {3}{10}- InstituteStatus: {4}{10}- DegreeId: {5}{10}- DegreeName: {6}{10}- DegreesDescription: {7}{10}- Credithour: {8}{10}- DegreeStatus: {9}{10}", 
				this.InstituteId,
				(this.InstituteName == null) ? string.Empty : this.InstituteName.ToString(),
			     
				(this.Description == null) ? string.Empty : this.Description.ToString(),
			     
				(this.InstituteDean == null) ? string.Empty : this.InstituteDean.ToString(),
			     
				this.InstituteStatus,
				this.DegreeId,
				(this.DegreeName == null) ? string.Empty : this.DegreeName.ToString(),
			     
				(this.DegreesDescription == null) ? string.Empty : this.DegreesDescription.ToString(),
			     
				(this.Credithour == null) ? string.Empty : this.Credithour.ToString(),
			     
				(this.DegreeStatus == null) ? string.Empty : this.DegreeStatus.ToString(),
			     
				System.Environment.NewLine, 
				this.GetType());
		}
	
	}//End Class
	
	
	/// <summary>
	/// Enumerate the VwInstituteDegrees columns.
	/// </summary>
	[Serializable]
	public enum VwInstituteDegreesColumn
	{
		/// <summary>
		/// InstituteID : 
		/// </summary>
		[EnumTextValue("InstituteID")]
		[ColumnEnum("InstituteID", typeof(System.String), System.Data.DbType.AnsiString, false, false, false, 20)]
		InstituteId,
		/// <summary>
		/// InstituteName : 
		/// </summary>
		[EnumTextValue("InstituteName")]
		[ColumnEnum("InstituteName", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 150)]
		InstituteName,
		/// <summary>
		/// Description : 
		/// </summary>
		[EnumTextValue("Description")]
		[ColumnEnum("Description", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 500)]
		Description,
		/// <summary>
		/// InstituteDean : 
		/// </summary>
		[EnumTextValue("InstituteDean")]
		[ColumnEnum("InstituteDean", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 20)]
		InstituteDean,
		/// <summary>
		/// InstituteStatus : 
		/// </summary>
		[EnumTextValue("InstituteStatus")]
		[ColumnEnum("InstituteStatus", typeof(System.Int32), System.Data.DbType.Int32, false, false, false)]
		InstituteStatus,
		/// <summary>
		/// DegreeId : 
		/// </summary>
		[EnumTextValue("DegreeId")]
		[ColumnEnum("DegreeId", typeof(System.Int32), System.Data.DbType.Int32, false, false, false)]
		DegreeId,
		/// <summary>
		/// DegreeName : 
		/// </summary>
		[EnumTextValue("DegreeName")]
		[ColumnEnum("DegreeName", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 150)]
		DegreeName,
		/// <summary>
		/// DegreesDescription : 
		/// </summary>
		[EnumTextValue("DegreesDescription")]
		[ColumnEnum("DegreesDescription", typeof(System.String), System.Data.DbType.AnsiString, false, false, true, 500)]
		DegreesDescription,
		/// <summary>
		/// Credithour : 
		/// </summary>
		[EnumTextValue("Credithour")]
		[ColumnEnum("Credithour", typeof(System.Int32), System.Data.DbType.Int32, false, false, true)]
		Credithour,
		/// <summary>
		/// DegreeStatus : 
		/// </summary>
		[EnumTextValue("DegreeStatus")]
		[ColumnEnum("DegreeStatus", typeof(System.Int32), System.Data.DbType.Int32, false, false, true)]
		DegreeStatus
	}//End enum

} // end namespace

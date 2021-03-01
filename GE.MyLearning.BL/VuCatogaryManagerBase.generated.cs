﻿
/*
	File generated by NetTiers templates [www.nettiers.com]
	Important: Do not modify this file. Edit the file VuCatogaryManager.cs instead.
*/

#region using directives
using System;
using System.ComponentModel;
using System.Collections;
using System.Xml.Serialization;
using System.Runtime.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Validation.Validators;
using Microsoft.Practices.EnterpriseLibrary.Validation;

using GE.MyLearning.BL.Validation;
#endregion

namespace GE.MyLearning.BL
{
	///<summary>
	/// An object representation of the 'VU_Catogary_Manager' table. [No description found the database]	
	///</summary>
	[Serializable]
	[DataObject, CLSCompliant(true)]
	public abstract partial class VuCatogaryManagerBase : EntityBase, IVuCatogaryManager, IEntityId<VuCatogaryManagerKey>, System.IComparable, System.ICloneable, ICloneableEx, IEditableObject, IComponent, INotifyPropertyChanged
	{		
		#region Variable Declarations
		
		/// <summary>
		///  Hold the inner data of the entity.
		/// </summary>
		private VuCatogaryManagerEntityData entityData;
		
		/// <summary>
		/// 	Hold the original data of the entity, as loaded from the repository.
		/// </summary>
		private VuCatogaryManagerEntityData _originalData;
		
		/// <summary>
		/// 	Hold a backup of the inner data of the entity.
		/// </summary>
		private VuCatogaryManagerEntityData backupData; 
		
		/// <summary>
		/// 	Key used if Tracking is Enabled for the <see cref="EntityLocator" />.
		/// </summary>
		private string entityTrackingKey;
		
		/// <summary>
		/// 	Hold the parent TList&lt;entity&gt; in which this entity maybe contained.
		/// </summary>
		/// <remark>Mostly used for databinding</remark>
		[NonSerialized]
		private TList<VuCatogaryManager> parentCollection;
		
		private bool inTxn = false;
		
		/// <summary>
		/// Occurs when a value is being changed for the specified column.
		/// </summary>
		[field:NonSerialized]
		public event VuCatogaryManagerEventHandler ColumnChanging;		
		
		/// <summary>
		/// Occurs after a value has been changed for the specified column.
		/// </summary>
		[field:NonSerialized]
		public event VuCatogaryManagerEventHandler ColumnChanged;
		
		#endregion Variable Declarations
		
		#region Constructors
		///<summary>
		/// Creates a new <see cref="VuCatogaryManagerBase"/> instance.
		///</summary>
		public VuCatogaryManagerBase()
		{
			this.entityData = new VuCatogaryManagerEntityData();
			this.backupData = null;
		}		
		
		///<summary>
		/// Creates a new <see cref="VuCatogaryManagerBase"/> instance.
		///</summary>
		///<param name="_catogaryId"></param>
		///<param name="_owner"></param>
		public VuCatogaryManagerBase(System.Int32? _catogaryId, System.String _owner)
		{
			this.entityData = new VuCatogaryManagerEntityData();
			this.backupData = null;

			this.CatogaryId = _catogaryId;
			this.Owner = _owner;
		}
		
		///<summary>
		/// A simple factory method to create a new <see cref="VuCatogaryManager"/> instance.
		///</summary>
		///<param name="_catogaryId"></param>
		///<param name="_owner"></param>
		public static VuCatogaryManager CreateVuCatogaryManager(System.Int32? _catogaryId, System.String _owner)
		{
			VuCatogaryManager newVuCatogaryManager = new VuCatogaryManager();
			newVuCatogaryManager.CatogaryId = _catogaryId;
			newVuCatogaryManager.Owner = _owner;
			return newVuCatogaryManager;
		}
				
		#endregion Constructors
			
		#region Properties	
		
		#region Data Properties		
		/// <summary>
		/// 	Gets or sets the Id property. 
		///		
		/// </summary>
		/// <value>This type is int.</value>
		/// <remarks>
		/// This property can not be set to null. 
		/// </remarks>




		[ReadOnlyAttribute(false)/*, XmlIgnoreAttribute()*/, DescriptionAttribute(@""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		[DataObjectField(true, true, false)]
		public virtual System.Int32 Id
		{
			get
			{
				return this.entityData.Id; 
			}
			
			set
			{
				if (this.entityData.Id == value)
					return;
					
				OnColumnChanging(VuCatogaryManagerColumn.Id, this.entityData.Id);
				this.entityData.Id = value;
				this.EntityId.Id = value;
				if (this.EntityState == EntityState.Unchanged)
					this.EntityState = EntityState.Changed;
				OnColumnChanged(VuCatogaryManagerColumn.Id, this.entityData.Id);
				OnPropertyChanged("Id");
			}
		}
		
		/// <summary>
		/// 	Gets or sets the CatogaryId property. 
		///		
		/// </summary>
		/// <value>This type is int.</value>
		/// <remarks>
		/// This property can be set to null. 
		/// If this column is null, this property will return (int)0. It is up to the developer
		/// to check the value of IsCatogaryIdNull() and perform business logic appropriately.
		/// </remarks>




		[DescriptionAttribute(@""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		[DataObjectField(false, false, true)]
		public virtual System.Int32? CatogaryId
		{
			get
			{
				return this.entityData.CatogaryId; 
			}
			
			set
			{
				if (this.entityData.CatogaryId == value)
					return;
					
				OnColumnChanging(VuCatogaryManagerColumn.CatogaryId, this.entityData.CatogaryId);
				this.entityData.CatogaryId = value;
				if (this.EntityState == EntityState.Unchanged)
					this.EntityState = EntityState.Changed;
				OnColumnChanged(VuCatogaryManagerColumn.CatogaryId, this.entityData.CatogaryId);
				OnPropertyChanged("CatogaryId");
			}
		}
		
		/// <summary>
		/// 	Gets or sets the Owner property. 
		///		
		/// </summary>
		/// <value>This type is char.</value>
		/// <remarks>
		/// This property can be set to null. 
		/// </remarks>


		[NotNullValidator(Negated=true, Tag="Owner")]
		[ValidatorComposition(CompositionType.Or, Tag="Owner")]
		[StringLengthValidator(10, MessageTemplate="Maximum length has been exceeded.", Tag="Owner")]
		[DescriptionAttribute(@""), System.ComponentModel.Bindable( System.ComponentModel.BindableSupport.Yes)]
		[DataObjectField(false, false, true, 10)]
		public virtual System.String Owner
		{
			get
			{
				return this.entityData.Owner; 
			}
			
			set
			{
				if (this.entityData.Owner == value)
					return;
					
				OnColumnChanging(VuCatogaryManagerColumn.Owner, this.entityData.Owner);
				this.entityData.Owner = value;
				if (this.EntityState == EntityState.Unchanged)
					this.EntityState = EntityState.Changed;
				OnColumnChanged(VuCatogaryManagerColumn.Owner, this.entityData.Owner);
				OnPropertyChanged("Owner");
			}
		}
		
		#endregion Data Properties		

		#region Source Foreign Key Property
				
		#endregion
		
		#region Children Collections
		#endregion Children Collections
		
		#endregion
		
		#region Table Meta Data
		/// <summary>
		///		The name of the underlying database table.
		/// </summary>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public override string TableName
		{
			get { return "VU_Catogary_Manager"; }
		}
		
		/// <summary>
		///		The name of the underlying database table's columns.
		/// </summary>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public override string[] TableColumns
		{
			get
			{
				return new string[] {"ID", "CatogaryID", "Owner"};
			}
		}
		#endregion 
		
		#region IEditableObject
		
		#region  CancelAddNew Event
		/// <summary>
        /// The delegate for the CancelAddNew event.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
		public delegate void CancelAddNewEventHandler(object sender, EventArgs e);
    
    	/// <summary>
		/// The CancelAddNew event.
		/// </summary>
		[field:NonSerialized]
		public event CancelAddNewEventHandler CancelAddNew ;

		/// <summary>
        /// Called when [cancel add new].
        /// </summary>
        public void OnCancelAddNew()
        {    
			if (!SuppressEntityEvents)
			{
	            CancelAddNewEventHandler handler = CancelAddNew ;
            	if (handler != null)
	            {    
    	            handler(this, EventArgs.Empty) ;
        	    }
	        }
        }
		#endregion 
		
		/// <summary>
		/// Begins an edit on an object.
		/// </summary>
		void IEditableObject.BeginEdit() 
	    {
	        //Console.WriteLine("Start BeginEdit");
	        if (!inTxn) 
	        {
	            this.backupData = this.entityData.Clone() as VuCatogaryManagerEntityData;
	            inTxn = true;
	            //Console.WriteLine("BeginEdit");
	        }
	        //Console.WriteLine("End BeginEdit");
	    }
	
		/// <summary>
		/// Discards changes since the last <c>BeginEdit</c> call.
		/// </summary>
	    void IEditableObject.CancelEdit() 
	    {
	        //Console.WriteLine("Start CancelEdit");
	        if (this.inTxn) 
	        {
	            this.entityData = this.backupData;
	            this.backupData = null;
				this.inTxn = false;

				if (this.bindingIsNew)
	        	//if (this.EntityState == EntityState.Added)
	        	{
					if (this.parentCollection != null)
						this.parentCollection.Remove( (VuCatogaryManager) this ) ;
				}	            
	        }
	        //Console.WriteLine("End CancelEdit");
	    }
	
		/// <summary>
		/// Pushes changes since the last <c>BeginEdit</c> or <c>IBindingList.AddNew</c> call into the underlying object.
		/// </summary>
	    void IEditableObject.EndEdit() 
	    {
	        //Console.WriteLine("Start EndEdit" + this.custData.id + this.custData.lastName);
	        if (this.inTxn) 
	        {
	            this.backupData = null;
				if (this.IsDirty) 
				{
					if (this.bindingIsNew) {
						this.EntityState = EntityState.Added;
						this.bindingIsNew = false ;
					}
					else
						if (this.EntityState == EntityState.Unchanged) 
							this.EntityState = EntityState.Changed ;
				}

				this.bindingIsNew = false ;
	            this.inTxn = false;	            
	        }
	        //Console.WriteLine("End EndEdit");
	    }
	    
	    /// <summary>
        /// Gets or sets the parent collection of this current entity, if available.
        /// </summary>
        /// <value>The parent collection.</value>
	    [XmlIgnore]
		[Browsable(false)]
	    public override object ParentCollection
	    {
	        get 
	        {
	            return this.parentCollection;
	        }
	        set 
	        {
	            this.parentCollection = value as TList<VuCatogaryManager>;
	        }
	    }
	    
	    /// <summary>
        /// Called when the entity is changed.
        /// </summary>
	    private void OnEntityChanged() 
	    {
	        if (!SuppressEntityEvents && !inTxn && this.parentCollection != null) 
	        {
	            this.parentCollection.EntityChanged(this as VuCatogaryManager);
	        }
	    }


		#endregion
		
		#region ICloneable Members
		///<summary>
		///  Returns a Typed VuCatogaryManager Entity 
		///</summary>
		protected virtual VuCatogaryManager Copy(IDictionary existingCopies)
		{
			if (existingCopies == null)
			{
				// This is the root of the tree to be copied!
				existingCopies = new Hashtable();
			}

			//shallow copy entity
			VuCatogaryManager copy = new VuCatogaryManager();
			existingCopies.Add(this, copy);
			copy.SuppressEntityEvents = true;
				copy.Id = this.Id;
				copy.CatogaryId = this.CatogaryId;
				copy.Owner = this.Owner;
			
		
			copy.EntityState = this.EntityState;
			copy.SuppressEntityEvents = false;
			return copy;
		}		
		
		
		
		///<summary>
		///  Returns a Typed VuCatogaryManager Entity 
		///</summary>
		public virtual VuCatogaryManager Copy()
		{
			return this.Copy(null);	
		}
		
		///<summary>
		/// ICloneable.Clone() Member, returns the Shallow Copy of this entity.
		///</summary>
		public object Clone()
		{
			return this.Copy(null);
		}
		
		///<summary>
		/// ICloneableEx.Clone() Member, returns the Shallow Copy of this entity.
		///</summary>
		public object Clone(IDictionary existingCopies)
		{
			return this.Copy(existingCopies);
		}
		
		///<summary>
		/// Returns a deep copy of the child collection object passed in.
		///</summary>
		public static object MakeCopyOf(object x)
		{
			if (x == null)
				return null;
				
			if (x is ICloneable)
			{
				// Return a deep copy of the object
				return ((ICloneable)x).Clone();
			}
			else
				throw new System.NotSupportedException("Object Does Not Implement the ICloneable Interface.");
		}
		
		///<summary>
		/// Returns a deep copy of the child collection object passed in.
		///</summary>
		public static object MakeCopyOf(object x, IDictionary existingCopies)
		{
			if (x == null)
				return null;
			
			if (x is ICloneableEx)
			{
				// Return a deep copy of the object
				return ((ICloneableEx)x).Clone(existingCopies);
			}
			else if (x is ICloneable)
			{
				// Return a deep copy of the object
				return ((ICloneable)x).Clone();
			}
			else
				throw new System.NotSupportedException("Object Does Not Implement the ICloneable or IClonableEx Interface.");
		}
		
		
		///<summary>
		///  Returns a Typed VuCatogaryManager Entity which is a deep copy of the current entity.
		///</summary>
		public virtual VuCatogaryManager DeepCopy()
		{
			return EntityHelper.Clone<VuCatogaryManager>(this as VuCatogaryManager);	
		}
		#endregion
		
		#region Methods	
			
		///<summary>
		/// Revert all changes and restore original values.
		///</summary>
		public override void CancelChanges()
		{
			IEditableObject obj = (IEditableObject) this;
			obj.CancelEdit();

			this.entityData = null;
			if (this._originalData != null)
			{
				this.entityData = this._originalData.Clone() as VuCatogaryManagerEntityData;
			}
			else
			{
				//Since this had no _originalData, then just reset the entityData with a new one.  entityData cannot be null.
				this.entityData = new VuCatogaryManagerEntityData();
			}
		}	
		
		/// <summary>
		/// Accepts the changes made to this object.
		/// </summary>
		/// <remarks>
		/// After calling this method, properties: IsDirty, IsNew are false. IsDeleted flag remains unchanged as it is handled by the parent List.
		/// </remarks>
		public override void AcceptChanges()
		{
			base.AcceptChanges();

			// we keep of the original version of the data
			this._originalData = null;
			this._originalData = this.entityData.Clone() as VuCatogaryManagerEntityData;
		}
		
		#region Comparision with original data
		
		/// <summary>
		/// Determines whether the property value has changed from the original data.
		/// </summary>
		/// <param name="column">The column.</param>
		/// <returns>
		/// 	<c>true</c> if the property value has changed; otherwise, <c>false</c>.
		/// </returns>
		public bool IsPropertyChanged(VuCatogaryManagerColumn column)
		{
			switch(column)
			{
					case VuCatogaryManagerColumn.Id:
					return entityData.Id != _originalData.Id;
					case VuCatogaryManagerColumn.CatogaryId:
					return entityData.CatogaryId != _originalData.CatogaryId;
					case VuCatogaryManagerColumn.Owner:
					return entityData.Owner != _originalData.Owner;
			
				default:
					return false;
			}
		}
		
		/// <summary>
		/// Determines whether the property value has changed from the original data.
		/// </summary>
		/// <param name="columnName">The column name.</param>
		/// <returns>
		/// 	<c>true</c> if the property value has changed; otherwise, <c>false</c>.
		/// </returns>
		public override bool IsPropertyChanged(string columnName)
		{
			return 	IsPropertyChanged(EntityHelper.GetEnumValue< VuCatogaryManagerColumn >(columnName));
		}
		
		/// <summary>
		/// Determines whether the data has changed from original.
		/// </summary>
		/// <returns>
		/// 	<c>true</c> if data has changed; otherwise, <c>false</c>.
		/// </returns>
		public bool HasDataChanged()
		{
			bool result = false;
			result = result || entityData.Id != _originalData.Id;
			result = result || entityData.CatogaryId != _originalData.CatogaryId;
			result = result || entityData.Owner != _originalData.Owner;
			return result;
		}	
		
		///<summary>
		///  Returns a VuCatogaryManager Entity with the original data.
		///</summary>
		public VuCatogaryManager GetOriginalEntity()
		{
			if (_originalData != null)
				return CreateVuCatogaryManager(
				_originalData.CatogaryId,
				_originalData.Owner
				);
				
			return (VuCatogaryManager)this.Clone();
		}
		#endregion
	
	#region Value Semantics Instance Equality
        ///<summary>
        /// Returns a value indicating whether this instance is equal to a specified object using value semantics.
        ///</summary>
        ///<param name="Object1">An object to compare to this instance.</param>
        ///<returns>true if Object1 is a <see cref="VuCatogaryManagerBase"/> and has the same value as this instance; otherwise, false.</returns>
        public override bool Equals(object Object1)
        {
			// Cast exception if Object1 is null or DbNull
			if (Object1 != null && Object1 != DBNull.Value && Object1 is VuCatogaryManagerBase)
				return ValueEquals(this, (VuCatogaryManagerBase)Object1);
			else
				return false;
        }

        /// <summary>
		/// Serves as a hash function for a particular type, suitable for use in hashing algorithms and data structures like a hash table.
        /// Provides a hash function that is appropriate for <see cref="VuCatogaryManagerBase"/> class 
        /// and that ensures a better distribution in the hash table
        /// </summary>
        /// <returns>number (hash code) that corresponds to the value of an object</returns>
        public override int GetHashCode()
        {
			return this.Id.GetHashCode() ^ 
					((this.CatogaryId == null) ? string.Empty : this.CatogaryId.ToString()).GetHashCode() ^ 
					((this.Owner == null) ? string.Empty : this.Owner.ToString()).GetHashCode();
        }
		
		///<summary>
		/// Returns a value indicating whether this instance is equal to a specified object using value semantics.
		///</summary>
		///<param name="toObject">An object to compare to this instance.</param>
		///<returns>true if toObject is a <see cref="VuCatogaryManagerBase"/> and has the same value as this instance; otherwise, false.</returns>
		public virtual bool Equals(VuCatogaryManagerBase toObject)
		{
			if (toObject == null)
				return false;
			return ValueEquals(this, toObject);
		}
		#endregion
		
		///<summary>
		/// Determines whether the specified <see cref="VuCatogaryManagerBase"/> instances are considered equal using value semantics.
		///</summary>
		///<param name="Object1">The first <see cref="VuCatogaryManagerBase"/> to compare.</param>
		///<param name="Object2">The second <see cref="VuCatogaryManagerBase"/> to compare. </param>
		///<returns>true if Object1 is the same instance as Object2 or if both are null references or if objA.Equals(objB) returns true; otherwise, false.</returns>
		public static bool ValueEquals(VuCatogaryManagerBase Object1, VuCatogaryManagerBase Object2)
		{
			// both are null
			if (Object1 == null && Object2 == null)
				return true;

			// one or the other is null, but not both
			if (Object1 == null ^ Object2 == null)
				return false;
				
			bool equal = true;
			if (Object1.Id != Object2.Id)
				equal = false;
			if ( Object1.CatogaryId != null && Object2.CatogaryId != null )
			{
				if (Object1.CatogaryId != Object2.CatogaryId)
					equal = false;
			}
			else if (Object1.CatogaryId == null ^ Object2.CatogaryId == null )
			{
				equal = false;
			}
			if ( Object1.Owner != null && Object2.Owner != null )
			{
				if (Object1.Owner != Object2.Owner)
					equal = false;
			}
			else if (Object1.Owner == null ^ Object2.Owner == null )
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
			//return this. GetPropertyName(SourceTable.PrimaryKey.MemberColumns[0]) .CompareTo(((VuCatogaryManagerBase)obj).GetPropertyName(SourceTable.PrimaryKey.MemberColumns[0]));
		}
		
		/*
		// static method to get a Comparer object
        public static VuCatogaryManagerComparer GetComparer()
        {
            return new VuCatogaryManagerComparer();
        }
        */

        // Comparer delegates back to VuCatogaryManager
        // Employee uses the integer's default
        // CompareTo method
        /*
        public int CompareTo(Item rhs)
        {
            return this.Id.CompareTo(rhs.Id);
        }
        */

/*
        // Special implementation to be called by custom comparer
        public int CompareTo(VuCatogaryManager rhs, VuCatogaryManagerColumn which)
        {
            switch (which)
            {
            	
            	
            	case VuCatogaryManagerColumn.Id:
            		return this.Id.CompareTo(rhs.Id);
            		
            		                 
            	
            	
            	case VuCatogaryManagerColumn.CatogaryId:
            		return this.CatogaryId.Value.CompareTo(rhs.CatogaryId.Value);
            		
            		                 
            	
            	
            	case VuCatogaryManagerColumn.Owner:
            		return this.Owner.CompareTo(rhs.Owner);
            		
            		                 
            }
            return 0;
        }
        */
	
		#endregion
		
		#region IComponent Members
		
		private ISite _site = null;

		/// <summary>
		/// Gets or Sets the site where this data is located.
		/// </summary>
		[XmlIgnore]
		[SoapIgnore]
		[Browsable(false)]
		public ISite Site
		{
			get{ return this._site; }
			set{ this._site = value; }
		}

		#endregion

		#region IDisposable Members
		
		/// <summary>
		/// Notify those that care when we dispose.
		/// </summary>
		[field:NonSerialized]
		public event System.EventHandler Disposed;

		/// <summary>
		/// Clean up. Nothing here though.
		/// </summary>
		public virtual void Dispose()
		{
			this.parentCollection = null;
			this.Dispose(true);
			GC.SuppressFinalize(this);
		}
		
		/// <summary>
		/// Clean up.
		/// </summary>
		protected virtual void Dispose(bool disposing)
		{
			if (disposing)
			{
				EventHandler handler = Disposed;
				if (handler != null)
					handler(this, EventArgs.Empty);
			}
		}
		
		#endregion
				
		#region IEntityKey<VuCatogaryManagerKey> Members
		
		// member variable for the EntityId property
		private VuCatogaryManagerKey _entityId;

		/// <summary>
		/// Gets or sets the EntityId property.
		/// </summary>
		[XmlIgnore]
		public virtual VuCatogaryManagerKey EntityId
		{
			get
			{
				if ( _entityId == null )
				{
					_entityId = new VuCatogaryManagerKey(this);
				}

				return _entityId;
			}
			set
			{
				if ( value != null )
				{
					value.Entity = this;
				}
				
				_entityId = value;
			}
		}
		
		#endregion
		
		#region EntityState
		/// <summary>
		///		Indicates state of object
		/// </summary>
		/// <remarks>0=Unchanged, 1=Added, 2=Changed</remarks>
		[BrowsableAttribute(false) , XmlIgnoreAttribute()]
		public override EntityState EntityState 
		{ 
			get{ return entityData.EntityState;	 } 
			set{ entityData.EntityState = value; } 
		}
		#endregion 
		
		#region EntityTrackingKey
		///<summary>
		/// Provides the tracking key for the <see cref="EntityLocator"/>
		///</summary>
		[XmlIgnore]
		public override string EntityTrackingKey
		{
			get
			{
				if(entityTrackingKey == null)
					entityTrackingKey = new System.Text.StringBuilder("VuCatogaryManager")
					.Append("|").Append( this.Id.ToString()).ToString();
				return entityTrackingKey;
			}
			set
		    {
		        if (value != null)
                    entityTrackingKey = value;
		    }
		}
		#endregion 
		
		#region ToString Method
		
		///<summary>
		/// Returns a String that represents the current object.
		///</summary>
		public override string ToString()
		{
			return string.Format(System.Globalization.CultureInfo.InvariantCulture,
				"{4}{3}- Id: {0}{3}- CatogaryId: {1}{3}- Owner: {2}{3}{5}", 
				this.Id,
				(this.CatogaryId == null) ? string.Empty : this.CatogaryId.ToString(),
				(this.Owner == null) ? string.Empty : this.Owner.ToString(),
				System.Environment.NewLine, 
				this.GetType(),
				this.Error.Length == 0 ? string.Empty : string.Format("- Error: {0}\n",this.Error));
		}
		
		#endregion ToString Method
		
		#region Inner data class
		
	/// <summary>
	///		The data structure representation of the 'VU_Catogary_Manager' table.
	/// </summary>
	/// <remarks>
	/// 	This struct is generated by a tool and should never be modified.
	/// </remarks>
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Serializable]
	internal protected class VuCatogaryManagerEntityData : ICloneable, ICloneableEx
	{
		#region Variable Declarations
		private EntityState currentEntityState = EntityState.Added;
		
		#region Primary key(s)
		/// <summary>			
		/// ID : 
		/// </summary>
		/// <remarks>Member of the primary key of the underlying table "VU_Catogary_Manager"</remarks>
		public System.Int32 Id;
			
		#endregion
		
		#region Non Primary key(s)
		
		
		/// <summary>
		/// CatogaryID : 
		/// </summary>
		public System.Int32?		  CatogaryId = null;
		
		/// <summary>
		/// Owner : 
		/// </summary>
		public System.String		  Owner = null;
		#endregion
			
		#region Source Foreign Key Property
				
		#endregion
		#endregion Variable Declarations
	
		#region Data Properties

		#endregion Data Properties
		
		#region Clone Method

		/// <summary>
		/// Creates a new object that is a copy of the current instance.
		/// </summary>
		/// <returns>A new object that is a copy of this instance.</returns>
		public Object Clone()
		{
			VuCatogaryManagerEntityData _tmp = new VuCatogaryManagerEntityData();
						
			_tmp.Id = this.Id;
			
			_tmp.CatogaryId = this.CatogaryId;
			_tmp.Owner = this.Owner;
			
			#region Source Parent Composite Entities
			#endregion
		
			#region Child Collections
			#endregion Child Collections
			
			//EntityState
			_tmp.EntityState = this.EntityState;
			
			return _tmp;
		}
		
		/// <summary>
		/// Creates a new object that is a copy of the current instance.
		/// </summary>
		/// <returns>A new object that is a copy of this instance.</returns>
		public object Clone(IDictionary existingCopies)
		{
			if (existingCopies == null)
				existingCopies = new Hashtable();
				
			VuCatogaryManagerEntityData _tmp = new VuCatogaryManagerEntityData();
						
			_tmp.Id = this.Id;
			
			_tmp.CatogaryId = this.CatogaryId;
			_tmp.Owner = this.Owner;
			
			#region Source Parent Composite Entities
			#endregion
		
			#region Child Collections
			#endregion Child Collections
			
			//EntityState
			_tmp.EntityState = this.EntityState;
			
			return _tmp;
		}
		
		#endregion Clone Method
		
		/// <summary>
		///		Indicates state of object
		/// </summary>
		/// <remarks>0=Unchanged, 1=Added, 2=Changed</remarks>
		[BrowsableAttribute(false), XmlIgnoreAttribute()]
		public EntityState	EntityState
		{
			get { return currentEntityState;  }
			set { currentEntityState = value; }
		}
	
	}//End struct











		#endregion
		
				
		
		#region Events trigger
		/// <summary>
		/// Raises the <see cref="ColumnChanging" /> event.
		/// </summary>
		/// <param name="column">The <see cref="VuCatogaryManagerColumn"/> which has raised the event.</param>
		public virtual void OnColumnChanging(VuCatogaryManagerColumn column)
		{
			OnColumnChanging(column, null);
			return;
		}
		
		/// <summary>
		/// Raises the <see cref="ColumnChanged" /> event.
		/// </summary>
		/// <param name="column">The <see cref="VuCatogaryManagerColumn"/> which has raised the event.</param>
		public virtual void OnColumnChanged(VuCatogaryManagerColumn column)
		{
			OnColumnChanged(column, null);
			return;
		} 
		
		
		/// <summary>
		/// Raises the <see cref="ColumnChanging" /> event.
		/// </summary>
		/// <param name="column">The <see cref="VuCatogaryManagerColumn"/> which has raised the event.</param>
		/// <param name="value">The changed value.</param>
		public virtual void OnColumnChanging(VuCatogaryManagerColumn column, object value)
		{
			if(IsEntityTracked && EntityState != EntityState.Added && !EntityManager.TrackChangedEntities)
				EntityManager.StopTracking(entityTrackingKey);
				
			if (!SuppressEntityEvents)
			{
				VuCatogaryManagerEventHandler handler = ColumnChanging;
				if(handler != null)
				{
					handler(this, new VuCatogaryManagerEventArgs(column, value));
				}
			}
		}
		
		/// <summary>
		/// Raises the <see cref="ColumnChanged" /> event.
		/// </summary>
		/// <param name="column">The <see cref="VuCatogaryManagerColumn"/> which has raised the event.</param>
		/// <param name="value">The changed value.</param>
		public virtual void OnColumnChanged(VuCatogaryManagerColumn column, object value)
		{
			if (!SuppressEntityEvents)
			{
				VuCatogaryManagerEventHandler handler = ColumnChanged;
				if(handler != null)
				{
					handler(this, new VuCatogaryManagerEventArgs(column, value));
				}
			
				// warn the parent list that i have changed
				OnEntityChanged();
			}
		} 
		#endregion
			
	} // End Class
	
	
	#region VuCatogaryManagerEventArgs class
	/// <summary>
	/// Provides data for the ColumnChanging and ColumnChanged events.
	/// </summary>
	/// <remarks>
	/// The ColumnChanging and ColumnChanged events occur when a change is made to the value 
	/// of a property of a <see cref="VuCatogaryManager"/> object.
	/// </remarks>
	public class VuCatogaryManagerEventArgs : System.EventArgs
	{
		private VuCatogaryManagerColumn column;
		private object value;
		
		///<summary>
		/// Initalizes a new Instance of the VuCatogaryManagerEventArgs class.
		///</summary>
		public VuCatogaryManagerEventArgs(VuCatogaryManagerColumn column)
		{
			this.column = column;
		}
		
		///<summary>
		/// Initalizes a new Instance of the VuCatogaryManagerEventArgs class.
		///</summary>
		public VuCatogaryManagerEventArgs(VuCatogaryManagerColumn column, object value)
		{
			this.column = column;
			this.value = value;
		}
		
		///<summary>
		/// The VuCatogaryManagerColumn that was modified, which has raised the event.
		///</summary>
		///<value cref="VuCatogaryManagerColumn" />
		public VuCatogaryManagerColumn Column { get { return this.column; } }
		
		/// <summary>
        /// Gets the current value of the column.
        /// </summary>
        /// <value>The current value of the column.</value>
		public object Value{ get { return this.value; } }

	}
	#endregion
	
	///<summary>
	/// Define a delegate for all VuCatogaryManager related events.
	///</summary>
	public delegate void VuCatogaryManagerEventHandler(object sender, VuCatogaryManagerEventArgs e);
	
	#region VuCatogaryManagerComparer
		
	/// <summary>
	///	Strongly Typed IComparer
	/// </summary>
	public class VuCatogaryManagerComparer : System.Collections.Generic.IComparer<VuCatogaryManager>
	{
		VuCatogaryManagerColumn whichComparison;
		
		/// <summary>
        /// Initializes a new instance of the <see cref="T:VuCatogaryManagerComparer"/> class.
        /// </summary>
		public VuCatogaryManagerComparer()
        {            
        }               
        
        /// <summary>
        /// Initializes a new instance of the <see cref="T:VuCatogaryManagerComparer"/> class.
        /// </summary>
        /// <param name="column">The column to sort on.</param>
        public VuCatogaryManagerComparer(VuCatogaryManagerColumn column)
        {
            this.whichComparison = column;
        }

		/// <summary>
        /// Determines whether the specified <c cref="VuCatogaryManager"/> instances are considered equal.
        /// </summary>
        /// <param name="a">The first <c cref="VuCatogaryManager"/> to compare.</param>
        /// <param name="b">The second <c>VuCatogaryManager</c> to compare.</param>
        /// <returns>true if objA is the same instance as objB or if both are null references or if objA.Equals(objB) returns true; otherwise, false.</returns>
        public bool Equals(VuCatogaryManager a, VuCatogaryManager b)
        {
            return this.Compare(a, b) == 0;
        }

		/// <summary>
        /// Gets the hash code of the specified entity.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns></returns>
        public int GetHashCode(VuCatogaryManager entity)
        {
            return entity.GetHashCode();
        }

        /// <summary>
        /// Performs a case-insensitive comparison of two objects of the same type and returns a value indicating whether one is less than, equal to, or greater than the other.
        /// </summary>
        /// <param name="a">The first object to compare.</param>
        /// <param name="b">The second object to compare.</param>
        /// <returns></returns>
        public int Compare(VuCatogaryManager a, VuCatogaryManager b)
        {
        	EntityPropertyComparer entityPropertyComparer = new EntityPropertyComparer(this.whichComparison.ToString());
        	return entityPropertyComparer.Compare(a, b);
        }

		/// <summary>
        /// Gets or sets the column that will be used for comparison.
        /// </summary>
        /// <value>The comparison column.</value>
        public VuCatogaryManagerColumn WhichComparison
        {
            get { return this.whichComparison; }
            set { this.whichComparison = value; }
        }
	}
	
	#endregion
	
	#region VuCatogaryManagerKey Class

	/// <summary>
	/// Wraps the unique identifier values for the <see cref="VuCatogaryManager"/> object.
	/// </summary>
	[Serializable]
	[CLSCompliant(true)]
	public class VuCatogaryManagerKey : EntityKeyBase
	{
		#region Constructors
		
		/// <summary>
		/// Initializes a new instance of the VuCatogaryManagerKey class.
		/// </summary>
		public VuCatogaryManagerKey()
		{
		}
		
		/// <summary>
		/// Initializes a new instance of the VuCatogaryManagerKey class.
		/// </summary>
		public VuCatogaryManagerKey(VuCatogaryManagerBase entity)
		{
			this.Entity = entity;

			#region Init Properties

			if ( entity != null )
			{
				this.Id = entity.Id;
			}

			#endregion
		}
		
		/// <summary>
		/// Initializes a new instance of the VuCatogaryManagerKey class.
		/// </summary>
		public VuCatogaryManagerKey(System.Int32 _id)
		{
			#region Init Properties

			this.Id = _id;

			#endregion
		}
		
		#endregion Constructors

		#region Properties
		
		// member variable for the Entity property
		private VuCatogaryManagerBase _entity;
		
		/// <summary>
		/// Gets or sets the Entity property.
		/// </summary>
		public VuCatogaryManagerBase Entity
		{
			get { return _entity; }
			set { _entity = value; }
		}
		
		// member variable for the Id property
		private System.Int32 _id;
		
		/// <summary>
		/// Gets or sets the Id property.
		/// </summary>
		public System.Int32 Id
		{
			get { return _id; }
			set
			{
				if ( this.Entity != null )
					this.Entity.Id = value;
				
				_id = value;
			}
		}
		
		#endregion

		#region Methods
		
		/// <summary>
		/// Reads values from the supplied <see cref="IDictionary"/> object into
		/// properties of the current object.
		/// </summary>
		/// <param name="values">An <see cref="IDictionary"/> instance that contains
		/// the key/value pairs to be used as property values.</param>
		public override void Load(IDictionary values)
		{
			#region Init Properties

			if ( values != null )
			{
				Id = ( values["Id"] != null ) ? (System.Int32) EntityUtil.ChangeType(values["Id"], typeof(System.Int32)) : (int)0;
			}

			#endregion
		}

		/// <summary>
		/// Creates a new <see cref="IDictionary"/> object and populates it
		/// with the property values of the current object.
		/// </summary>
		/// <returns>A collection of name/value pairs.</returns>
		public override IDictionary ToDictionary()
		{
			IDictionary values = new Hashtable();

			#region Init Dictionary

			values.Add("Id", Id);

			#endregion Init Dictionary

			return values;
		}
		
		///<summary>
		/// Returns a String that represents the current object.
		///</summary>
		public override string ToString()
		{
			return String.Format("Id: {0}{1}",
								Id,
								System.Environment.NewLine);
		}

		#endregion Methods
	}
	
	#endregion	

	#region VuCatogaryManagerColumn Enum
	
	/// <summary>
	/// Enumerate the VuCatogaryManager columns.
	/// </summary>
	[Serializable]
	public enum VuCatogaryManagerColumn : int
	{
		/// <summary>
		/// Id : 
		/// </summary>
		[EnumTextValue("ID")]
		[ColumnEnum("ID", typeof(System.Int32), System.Data.DbType.Int32, true, true, false)]
		Id = 1,
		/// <summary>
		/// CatogaryId : 
		/// </summary>
		[EnumTextValue("CatogaryID")]
		[ColumnEnum("CatogaryID", typeof(System.Int32), System.Data.DbType.Int32, false, false, true)]
		CatogaryId = 2,
		/// <summary>
		/// Owner : 
		/// </summary>
		[EnumTextValue("Owner")]
		[ColumnEnum("Owner", typeof(System.String), System.Data.DbType.AnsiStringFixedLength, false, false, true, 10)]
		Owner = 3
	}//End enum

	#endregion VuCatogaryManagerColumn Enum

} // end namespace
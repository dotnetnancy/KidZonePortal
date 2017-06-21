//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3623
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestSprocGenerator.Data.SingleTable.Dto
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using CommonLibrary;
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Person_Address")]
    public class Person_Address
    {
        
        private System.Guid _person_AddressID;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _personID;
        
        private System.Guid _addressID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Person_Address()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Person_AddressID")]
        public virtual System.Guid Person_AddressID
        {
            get
            {
                return this._person_AddressID;
            }
            set
            {
                this._person_AddressID = value;
                this.SetIsModified("Person_AddressID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Deleted")]
        public virtual bool Deleted
        {
            get
            {
                return this._deleted;
            }
            set
            {
                this._deleted = value;
                this.SetIsModified("Deleted");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("InsertedDateTime")]
        public virtual System.DateTime InsertedDateTime
        {
            get
            {
                return this._insertedDateTime;
            }
            set
            {
                this._insertedDateTime = value;
                this.SetIsModified("InsertedDateTime");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ModifiedDateTime")]
        public virtual System.DateTime ModifiedDateTime
        {
            get
            {
                return this._modifiedDateTime;
            }
            set
            {
                this._modifiedDateTime = value;
                this.SetIsModified("ModifiedDateTime");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PersonID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid PersonID
        {
            get
            {
                return this._personID;
            }
            set
            {
                this._personID = value;
                this.SetIsModified("PersonID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("AddressID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid AddressID
        {
            get
            {
                return this._addressID;
            }
            set
            {
                this._addressID = value;
                this.SetIsModified("AddressID");
            }
        }
        
        public virtual Dictionary<string, bool> IsModifiedDictionary
        {
            get
            {
                return this._isModifiedDictionary;
            }
            set
            {
                this._isModifiedDictionary = value;
            }
        }
        
        private void InitializeIsModifiedDictionary()
        {
            this.IsModifiedDictionary.Add("Person_AddressID", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("PersonID", false);
            this.IsModifiedDictionary.Add("AddressID", false);
        }
        
        private void SetIsModified(string columnName)
        {
            if ((this.IsModifiedDictionary.ContainsKey(columnName) == true))
            {
                IsModifiedDictionary[columnName] = true;
            }
        }
    }
}

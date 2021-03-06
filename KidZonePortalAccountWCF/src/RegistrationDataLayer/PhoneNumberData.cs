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
    using System.Runtime.Serialization;
    
    [DataContract]
    [CommonLibrary.CustomAttributes.TableNameAttribute("PhoneNumber")]
    public class PhoneNumber
    {
        
        private System.Guid _phoneNumberTypeID;
        
        private string _phoneNumber;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _phoneNumberID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public PhoneNumber()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PhoneNumberTypeID")]
        public virtual System.Guid PhoneNumberTypeID
        {
            get
            {
                return this._phoneNumberTypeID;
            }
            set
            {
                this._phoneNumberTypeID = value;
                this.SetIsModified("PhoneNumberTypeID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PhoneNumber")]
        public virtual string PhoneNumber_Property
        {
            get
            {
                return this._phoneNumber;
            }
            set
            {
                this._phoneNumber = value;
                this.SetIsModified("PhoneNumber");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PhoneNumberID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid PhoneNumberID
        {
            get
            {
                return this._phoneNumberID;
            }
            set
            {
                this._phoneNumberID = value;
                this.SetIsModified("PhoneNumberID");
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
            this.IsModifiedDictionary.Add("PhoneNumberTypeID", false);
            this.IsModifiedDictionary.Add("PhoneNumber", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("PhoneNumberID", false);
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

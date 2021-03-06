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
    [CommonLibrary.CustomAttributes.TableNameAttribute("Person")]
    public class Person
    {
        
        private string _personFirstName;
        
        private string _personLastName;
        
        private string _personMiddleInitials;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _personID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Person()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PersonFirstName")]
        public virtual string PersonFirstName
        {
            get
            {
                return this._personFirstName;
            }
            set
            {
                this._personFirstName = value;
                this.SetIsModified("PersonFirstName");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PersonLastName")]
        public virtual string PersonLastName
        {
            get
            {
                return this._personLastName;
            }
            set
            {
                this._personLastName = value;
                this.SetIsModified("PersonLastName");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PersonMiddleInitials")]
        public virtual string PersonMiddleInitials
        {
            get
            {
                return this._personMiddleInitials;
            }
            set
            {
                this._personMiddleInitials = value;
                this.SetIsModified("PersonMiddleInitials");
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
            this.IsModifiedDictionary.Add("PersonFirstName", false);
            this.IsModifiedDictionary.Add("PersonLastName", false);
            this.IsModifiedDictionary.Add("PersonMiddleInitials", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("PersonID", false);
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

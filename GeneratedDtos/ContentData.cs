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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Content")]
    public class Content
    {
        
        private System.Guid _contentTypeID;
        
        private byte[] _contentPayload;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _contentID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Content()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ContentTypeID")]
        public virtual System.Guid ContentTypeID
        {
            get
            {
                return this._contentTypeID;
            }
            set
            {
                this._contentTypeID = value;
                this.SetIsModified("ContentTypeID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ContentPayload")]
        public virtual byte[] ContentPayload
        {
            get
            {
                return this._contentPayload;
            }
            set
            {
                this._contentPayload = value;
                this.SetIsModified("ContentPayload");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ContentID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid ContentID
        {
            get
            {
                return this._contentID;
            }
            set
            {
                this._contentID = value;
                this.SetIsModified("ContentID");
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
            this.IsModifiedDictionary.Add("ContentTypeID", false);
            this.IsModifiedDictionary.Add("ContentPayload", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("ContentID", false);
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

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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Library_Content")]
    public class Library_Content
    {
        
        private System.Guid _library_ContentID;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _libraryID;
        
        private System.Guid _contentID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Library_Content()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Library_ContentID")]
        public virtual System.Guid Library_ContentID
        {
            get
            {
                return this._library_ContentID;
            }
            set
            {
                this._library_ContentID = value;
                this.SetIsModified("Library_ContentID");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("LibraryID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid LibraryID
        {
            get
            {
                return this._libraryID;
            }
            set
            {
                this._libraryID = value;
                this.SetIsModified("LibraryID");
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
            this.IsModifiedDictionary.Add("Library_ContentID", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("LibraryID", false);
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

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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("WebsiteLink")]
    public class WebsiteLink
    {
        
        private string _websiteLinkURL;
        
        private bool _deleted;
        
        private System.DateTime _insertedDateTime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _websiteLinkID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public WebsiteLink()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("WebsiteLinkURL")]
        public virtual string WebsiteLinkURL
        {
            get
            {
                return this._websiteLinkURL;
            }
            set
            {
                this._websiteLinkURL = value;
                this.SetIsModified("WebsiteLinkURL");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("WebsiteLinkID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid WebsiteLinkID
        {
            get
            {
                return this._websiteLinkID;
            }
            set
            {
                this._websiteLinkID = value;
                this.SetIsModified("WebsiteLinkID");
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
            this.IsModifiedDictionary.Add("WebsiteLinkURL", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDateTime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("WebsiteLinkID", false);
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

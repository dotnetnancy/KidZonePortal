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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Notification")]
    public class Notification
    {
        
        private System.Guid _profileIDFrom;
        
        private System.Guid _profileIDTo;
        
        private string _message;
        
        private bool _deleted;
        
        private System.DateTime _insertedDatetime;
        
        private System.DateTime _modifiedDateTime;
        
        private System.Guid _notificationID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Notification()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ProfileIDFrom")]
        public virtual System.Guid ProfileIDFrom
        {
            get
            {
                return this._profileIDFrom;
            }
            set
            {
                this._profileIDFrom = value;
                this.SetIsModified("ProfileIDFrom");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ProfileIDTo")]
        public virtual System.Guid ProfileIDTo
        {
            get
            {
                return this._profileIDTo;
            }
            set
            {
                this._profileIDTo = value;
                this.SetIsModified("ProfileIDTo");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Message")]
        public virtual string Message
        {
            get
            {
                return this._message;
            }
            set
            {
                this._message = value;
                this.SetIsModified("Message");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("InsertedDatetime")]
        public virtual System.DateTime InsertedDatetime
        {
            get
            {
                return this._insertedDatetime;
            }
            set
            {
                this._insertedDatetime = value;
                this.SetIsModified("InsertedDatetime");
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("NotificationID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid NotificationID
        {
            get
            {
                return this._notificationID;
            }
            set
            {
                this._notificationID = value;
                this.SetIsModified("NotificationID");
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
            this.IsModifiedDictionary.Add("ProfileIDFrom", false);
            this.IsModifiedDictionary.Add("ProfileIDTo", false);
            this.IsModifiedDictionary.Add("Message", false);
            this.IsModifiedDictionary.Add("Deleted", false);
            this.IsModifiedDictionary.Add("InsertedDatetime", false);
            this.IsModifiedDictionary.Add("ModifiedDateTime", false);
            this.IsModifiedDictionary.Add("NotificationID", false);
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
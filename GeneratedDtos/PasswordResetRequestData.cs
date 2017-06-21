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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("PasswordResetRequest")]
    public class PasswordResetRequest
    {
        
        private System.Guid _passwordResetRequestID;
        
        private string _passwordResetCode;
        
        private System.Guid _accountID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public PasswordResetRequest()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PasswordResetRequestID")]
        public virtual System.Guid PasswordResetRequestID
        {
            get
            {
                return this._passwordResetRequestID;
            }
            set
            {
                this._passwordResetRequestID = value;
                this.SetIsModified("PasswordResetRequestID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PasswordResetCode")]
        public virtual string PasswordResetCode
        {
            get
            {
                return this._passwordResetCode;
            }
            set
            {
                this._passwordResetCode = value;
                this.SetIsModified("PasswordResetCode");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("AccountID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual System.Guid AccountID
        {
            get
            {
                return this._accountID;
            }
            set
            {
                this._accountID = value;
                this.SetIsModified("AccountID");
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
            this.IsModifiedDictionary.Add("PasswordResetRequestID", false);
            this.IsModifiedDictionary.Add("PasswordResetCode", false);
            this.IsModifiedDictionary.Add("AccountID", false);
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
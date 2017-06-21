//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3053
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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("CustomerDemographics")]
    public class CustomerDemographics
    {
        
        private string _customerDesc;
        
        private string _customerTypeID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public CustomerDemographics()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CustomerDesc")]
        public virtual string CustomerDesc
        {
            get
            {
                return this._customerDesc;
            }
            set
            {
                this._customerDesc = value;
                this.SetIsModified("CustomerDesc");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CustomerTypeID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual string CustomerTypeID
        {
            get
            {
                return this._customerTypeID;
            }
            set
            {
                this._customerTypeID = value;
                this.SetIsModified("CustomerTypeID");
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
            this.IsModifiedDictionary.Add("CustomerDesc", false);
            this.IsModifiedDictionary.Add("CustomerTypeID", false);
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
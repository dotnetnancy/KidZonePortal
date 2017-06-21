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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Country")]
    public class Country
    {
        
        private string _abbreviation;
        
        private string _name;
        
        private char[] _twoCharISOCode;
        
        private string _threeCharISOCode;
        
        private System.Guid _createdBy;
        
        private System.Nullable<System.DateTime> _createdDate;
        
        private System.Guid _updatedBy;
        
        private System.Nullable<System.DateTime> _updatedDate;
        
        private string _subcode;
        
        private short _countryID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Country()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Abbreviation")]
        public virtual string Abbreviation
        {
            get
            {
                return this._abbreviation;
            }
            set
            {
                this._abbreviation = value;
                this.SetIsModified("Abbreviation");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Name")]
        public virtual string Name
        {
            get
            {
                return this._name;
            }
            set
            {
                this._name = value;
                this.SetIsModified("Name");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("TwoCharISOCode")]
        public virtual char[] TwoCharISOCode
        {
            get
            {
                return this._twoCharISOCode;
            }
            set
            {
                this._twoCharISOCode = value;
                this.SetIsModified("TwoCharISOCode");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ThreeCharISOCode")]
        public virtual string ThreeCharISOCode
        {
            get
            {
                return this._threeCharISOCode;
            }
            set
            {
                this._threeCharISOCode = value;
                this.SetIsModified("ThreeCharISOCode");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CreatedBy")]
        public virtual System.Guid CreatedBy
        {
            get
            {
                return this._createdBy;
            }
            set
            {
                this._createdBy = value;
                this.SetIsModified("CreatedBy");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CreatedDate")]
        public virtual System.Nullable<System.DateTime> CreatedDate
        {
            get
            {
                return this._createdDate;
            }
            set
            {
                this._createdDate = value;
                this.SetIsModified("CreatedDate");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UpdatedBy")]
        public virtual System.Guid UpdatedBy
        {
            get
            {
                return this._updatedBy;
            }
            set
            {
                this._updatedBy = value;
                this.SetIsModified("UpdatedBy");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UpdatedDate")]
        public virtual System.Nullable<System.DateTime> UpdatedDate
        {
            get
            {
                return this._updatedDate;
            }
            set
            {
                this._updatedDate = value;
                this.SetIsModified("UpdatedDate");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("subcode")]
        public virtual string Subcode
        {
            get
            {
                return this._subcode;
            }
            set
            {
                this._subcode = value;
                this.SetIsModified("subcode");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CountryID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual short CountryID
        {
            get
            {
                return this._countryID;
            }
            set
            {
                this._countryID = value;
                this.SetIsModified("CountryID");
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
            this.IsModifiedDictionary.Add("Abbreviation", false);
            this.IsModifiedDictionary.Add("Name", false);
            this.IsModifiedDictionary.Add("TwoCharISOCode", false);
            this.IsModifiedDictionary.Add("ThreeCharISOCode", false);
            this.IsModifiedDictionary.Add("CreatedBy", false);
            this.IsModifiedDictionary.Add("CreatedDate", false);
            this.IsModifiedDictionary.Add("UpdatedBy", false);
            this.IsModifiedDictionary.Add("UpdatedDate", false);
            this.IsModifiedDictionary.Add("subcode", false);
            this.IsModifiedDictionary.Add("CountryID", false);
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

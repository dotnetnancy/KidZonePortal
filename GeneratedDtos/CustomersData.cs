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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Customers")]
    public class Customers
    {
        
        private string _companyName;
        
        private string _contactName;
        
        private string _contactTitle;
        
        private string _address;
        
        private string _city;
        
        private string _region;
        
        private string _postalCode;
        
        private string _country;
        
        private string _phone;
        
        private string _fax;
        
        private string _customerID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Customers()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CompanyName")]
        public virtual string CompanyName
        {
            get
            {
                return this._companyName;
            }
            set
            {
                this._companyName = value;
                this.SetIsModified("CompanyName");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ContactName")]
        public virtual string ContactName
        {
            get
            {
                return this._contactName;
            }
            set
            {
                this._contactName = value;
                this.SetIsModified("ContactName");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ContactTitle")]
        public virtual string ContactTitle
        {
            get
            {
                return this._contactTitle;
            }
            set
            {
                this._contactTitle = value;
                this.SetIsModified("ContactTitle");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Address")]
        public virtual string Address
        {
            get
            {
                return this._address;
            }
            set
            {
                this._address = value;
                this.SetIsModified("Address");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("City")]
        public virtual string City
        {
            get
            {
                return this._city;
            }
            set
            {
                this._city = value;
                this.SetIsModified("City");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Region")]
        public virtual string Region
        {
            get
            {
                return this._region;
            }
            set
            {
                this._region = value;
                this.SetIsModified("Region");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("PostalCode")]
        public virtual string PostalCode
        {
            get
            {
                return this._postalCode;
            }
            set
            {
                this._postalCode = value;
                this.SetIsModified("PostalCode");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Country")]
        public virtual string Country
        {
            get
            {
                return this._country;
            }
            set
            {
                this._country = value;
                this.SetIsModified("Country");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Phone")]
        public virtual string Phone
        {
            get
            {
                return this._phone;
            }
            set
            {
                this._phone = value;
                this.SetIsModified("Phone");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Fax")]
        public virtual string Fax
        {
            get
            {
                return this._fax;
            }
            set
            {
                this._fax = value;
                this.SetIsModified("Fax");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CustomerID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual string CustomerID
        {
            get
            {
                return this._customerID;
            }
            set
            {
                this._customerID = value;
                this.SetIsModified("CustomerID");
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
            this.IsModifiedDictionary.Add("CompanyName", false);
            this.IsModifiedDictionary.Add("ContactName", false);
            this.IsModifiedDictionary.Add("ContactTitle", false);
            this.IsModifiedDictionary.Add("Address", false);
            this.IsModifiedDictionary.Add("City", false);
            this.IsModifiedDictionary.Add("Region", false);
            this.IsModifiedDictionary.Add("PostalCode", false);
            this.IsModifiedDictionary.Add("Country", false);
            this.IsModifiedDictionary.Add("Phone", false);
            this.IsModifiedDictionary.Add("Fax", false);
            this.IsModifiedDictionary.Add("CustomerID", false);
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

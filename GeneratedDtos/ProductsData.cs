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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Products")]
    public class Products
    {
        
        private string _productName;
        
        private System.Nullable<int> _supplierID;
        
        private System.Nullable<int> _categoryID;
        
        private string _quantityPerUnit;
        
        private System.Nullable<decimal> _unitPrice;
        
        private System.Nullable<short> _unitsInStock;
        
        private System.Nullable<short> _unitsOnOrder;
        
        private System.Nullable<short> _reorderLevel;
        
        private bool _discontinued;
        
        private int _productID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public Products()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ProductName")]
        public virtual string ProductName
        {
            get
            {
                return this._productName;
            }
            set
            {
                this._productName = value;
                this.SetIsModified("ProductName");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("SupplierID")]
        public virtual System.Nullable<int> SupplierID
        {
            get
            {
                return this._supplierID;
            }
            set
            {
                this._supplierID = value;
                this.SetIsModified("SupplierID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("CategoryID")]
        public virtual System.Nullable<int> CategoryID
        {
            get
            {
                return this._categoryID;
            }
            set
            {
                this._categoryID = value;
                this.SetIsModified("CategoryID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("QuantityPerUnit")]
        public virtual string QuantityPerUnit
        {
            get
            {
                return this._quantityPerUnit;
            }
            set
            {
                this._quantityPerUnit = value;
                this.SetIsModified("QuantityPerUnit");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UnitPrice")]
        public virtual System.Nullable<decimal> UnitPrice
        {
            get
            {
                return this._unitPrice;
            }
            set
            {
                this._unitPrice = value;
                this.SetIsModified("UnitPrice");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UnitsInStock")]
        public virtual System.Nullable<short> UnitsInStock
        {
            get
            {
                return this._unitsInStock;
            }
            set
            {
                this._unitsInStock = value;
                this.SetIsModified("UnitsInStock");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UnitsOnOrder")]
        public virtual System.Nullable<short> UnitsOnOrder
        {
            get
            {
                return this._unitsOnOrder;
            }
            set
            {
                this._unitsOnOrder = value;
                this.SetIsModified("UnitsOnOrder");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ReorderLevel")]
        public virtual System.Nullable<short> ReorderLevel
        {
            get
            {
                return this._reorderLevel;
            }
            set
            {
                this._reorderLevel = value;
                this.SetIsModified("ReorderLevel");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Discontinued")]
        public virtual bool Discontinued
        {
            get
            {
                return this._discontinued;
            }
            set
            {
                this._discontinued = value;
                this.SetIsModified("Discontinued");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("ProductID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual int ProductID
        {
            get
            {
                return this._productID;
            }
            set
            {
                this._productID = value;
                this.SetIsModified("ProductID");
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
            this.IsModifiedDictionary.Add("ProductName", false);
            this.IsModifiedDictionary.Add("SupplierID", false);
            this.IsModifiedDictionary.Add("CategoryID", false);
            this.IsModifiedDictionary.Add("QuantityPerUnit", false);
            this.IsModifiedDictionary.Add("UnitPrice", false);
            this.IsModifiedDictionary.Add("UnitsInStock", false);
            this.IsModifiedDictionary.Add("UnitsOnOrder", false);
            this.IsModifiedDictionary.Add("ReorderLevel", false);
            this.IsModifiedDictionary.Add("Discontinued", false);
            this.IsModifiedDictionary.Add("ProductID", false);
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

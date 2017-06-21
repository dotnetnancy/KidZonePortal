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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Order Details")]
    public class OrderDetails
    {
        
        private decimal _unitPrice;
        
        private short _quantity;
        
        private float _discount;
        
        private int _orderID;
        
        private int _productID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public OrderDetails()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("UnitPrice")]
        public virtual decimal UnitPrice
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
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Quantity")]
        public virtual short Quantity
        {
            get
            {
                return this._quantity;
            }
            set
            {
                this._quantity = value;
                this.SetIsModified("Quantity");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("Discount")]
        public virtual float Discount
        {
            get
            {
                return this._discount;
            }
            set
            {
                this._discount = value;
                this.SetIsModified("Discount");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("OrderID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual int OrderID
        {
            get
            {
                return this._orderID;
            }
            set
            {
                this._orderID = value;
                this.SetIsModified("OrderID");
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
            this.IsModifiedDictionary.Add("UnitPrice", false);
            this.IsModifiedDictionary.Add("Quantity", false);
            this.IsModifiedDictionary.Add("Discount", false);
            this.IsModifiedDictionary.Add("OrderID", false);
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

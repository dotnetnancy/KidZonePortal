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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("EmployeeTerritories")]
    public class EmployeeTerritories
    {
        
        private int _employeeID;
        
        private string _territoryID;
        
        private Dictionary<string, bool> _isModifiedDictionary = new Dictionary<string, bool>();
        
        public EmployeeTerritories()
        {
            this.InitializeIsModifiedDictionary();
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("EmployeeID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual int EmployeeID
        {
            get
            {
                return this._employeeID;
            }
            set
            {
                this._employeeID = value;
                this.SetIsModified("EmployeeID");
            }
        }
        
        [CommonLibrary.CustomAttributes.DatabaseColumnAttribute("TerritoryID")]
        [CommonLibrary.CustomAttributes.PrimaryKey()]
        public virtual string TerritoryID
        {
            get
            {
                return this._territoryID;
            }
            set
            {
                this._territoryID = value;
                this.SetIsModified("TerritoryID");
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
            this.IsModifiedDictionary.Add("EmployeeID", false);
            this.IsModifiedDictionary.Add("TerritoryID", false);
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

//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3053
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestSprocGenerator.SingleTable.List
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Text;
    using CommonLibrary.Base.Database;
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Suppliers")]
    public class Suppliers : List<TestSprocGenerator.Data.SingleTable.Dto.Suppliers>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public Suppliers(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public Suppliers()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.Suppliers dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.Suppliers();
                    dto.CompanyName = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("CompanyName"), reader);
                    dto.ContactName = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("ContactName"), reader);
                    dto.ContactTitle = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("ContactTitle"), reader);
                    dto.Address = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Address"), reader);
                    dto.City = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("City"), reader);
                    dto.Region = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Region"), reader);
                    dto.PostalCode = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("PostalCode"), reader);
                    dto.Country = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Country"), reader);
                    dto.Phone = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Phone"), reader);
                    dto.Fax = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Fax"), reader);
                    dto.HomePage = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("HomePage"), reader);
                    dto.SupplierID = 
                    _baseDatabase.resolveNullInt32(reader.GetOrdinal("SupplierID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}
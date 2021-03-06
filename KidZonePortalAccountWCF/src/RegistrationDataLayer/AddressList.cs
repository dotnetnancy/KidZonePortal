//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3623
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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Address")]
    public class Address : List<TestSprocGenerator.Data.SingleTable.Dto.Address>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public Address(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public Address()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.Address dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.Address();
                    dto.AddressTypeID = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("AddressTypeID"), reader);
                    dto.AddressStreet = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("AddressStreet"), reader);
                    dto.AddressCity = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("AddressCity"), reader);
                    dto.AddressZipCode = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("AddressZipCode"), reader);
                    dto.AddressCountry = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("AddressCountry"), reader);
                    dto.Deleted = 
                    _baseDatabase.resolveNullBoolean(reader.GetOrdinal("Deleted"), reader);
                    dto.InsertedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("InsertedDateTime"), reader);
                    dto.ModifiedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("ModifiedDateTime"), reader);
                    dto.AddressID = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("AddressID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

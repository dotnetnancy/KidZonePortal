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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("PhoneNumber")]
    public class PhoneNumber : List<TestSprocGenerator.Data.SingleTable.Dto.PhoneNumber>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public PhoneNumber(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public PhoneNumber()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.PhoneNumber dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.PhoneNumber();
                    dto.PhoneNumberTypeID = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("PhoneNumberTypeID"), reader);
                    dto.Deleted = 
                    _baseDatabase.resolveNullBoolean(reader.GetOrdinal("Deleted"), reader);
                    dto.InsertedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("InsertedDateTime"), reader);
                    dto.ModifiedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("ModifiedDateTime"), reader);
                    dto.PhoneNumberID = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("PhoneNumberID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

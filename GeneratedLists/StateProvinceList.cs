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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("StateProvince")]
    public class StateProvince : List<TestSprocGenerator.Data.SingleTable.Dto.StateProvince>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public StateProvince(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public StateProvince()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.StateProvince dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.StateProvince();
                    dto.CountryID = 
                    _baseDatabase.resolveNullSmallInt(reader.GetOrdinal("CountryID"), reader);
                    dto.Abbreviation = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Abbreviation"), reader);
                    dto.Name = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Name"), reader);
                    dto.CreatedBy = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("CreatedBy"), reader);
                    dto.CreatedDate = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("CreatedDate"), reader);
                    dto.UpdatedBy = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("UpdatedBy"), reader);
                    dto.UpdatedDate = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("UpdatedDate"), reader);
                    dto.StateProvinceID = 
                    _baseDatabase.resolveNullInt32(reader.GetOrdinal("StateProvinceID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

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
    using CountryCityProvinceDataLayer;
    
    [DataContract]
    [CommonLibrary.CustomAttributes.TableNameAttribute("City")]
    public class City : List<TestSprocGenerator.Data.SingleTable.Dto.City>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public City(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public City()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.City dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.City();
                    dto.Name = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Name"), reader);
                    dto.StateProvinceID = 
                    _baseDatabase.resolveNullInt32(reader.GetOrdinal("StateProvinceID"), reader);
                    dto.CreatedDate = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("CreatedDate"), reader);
                    dto.CreatedBy = 
                    _baseDatabase.retrieveNullableGuidFromDataReader(reader.GetOrdinal("CreatedBy"), reader);
                    dto.UpdatedDate = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("UpdatedDate"), reader);
                    dto.UpdatedBy =
                    _baseDatabase.retrieveNullableGuidFromDataReader(reader.GetOrdinal("UpdatedBy"), reader);
                    dto.CityCode = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("CityCode"), reader);
                    dto.CountryID = 
                    _baseDatabase.resolveNullSmallInt(reader.GetOrdinal("CountryID"), reader);
                  
                    dto.CityID = 
                    _baseDatabase.resolveNullInt32(reader.GetOrdinal("CityID"), reader);

                    
                    this.Add(dto);
                   
                }

                }

        }
    }
}

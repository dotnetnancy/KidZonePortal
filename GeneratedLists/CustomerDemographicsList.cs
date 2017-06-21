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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("CustomerDemographics")]
    public class CustomerDemographics : List<TestSprocGenerator.Data.SingleTable.Dto.CustomerDemographics>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public CustomerDemographics(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public CustomerDemographics()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.CustomerDemographics dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.CustomerDemographics();
                    dto.CustomerDesc = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("CustomerDesc"), reader);
                    dto.CustomerTypeID = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("CustomerTypeID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

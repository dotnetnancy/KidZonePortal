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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("Categories")]
    public class Categories : List<TestSprocGenerator.Data.SingleTable.Dto.Categories>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public Categories(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public Categories()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.Categories dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.Categories();
                    dto.CategoryName = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("CategoryName"), reader);
                    dto.Description = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("Description"), reader);
                    dto.Picture = 
                    _baseDatabase.retrieveNullableImageFromDataReader(reader.GetOrdinal("Picture"), reader);
                    dto.CategoryID = 
                    _baseDatabase.resolveNullInt32(reader.GetOrdinal("CategoryID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

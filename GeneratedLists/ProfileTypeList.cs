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
    
    
    [CommonLibrary.CustomAttributes.TableNameAttribute("ProfileType")]
    public class ProfileType : List<TestSprocGenerator.Data.SingleTable.Dto.ProfileType>
    {
        
        private CommonLibrary.Base.Database.BaseDatabase _baseDatabase = new CommonLibrary.Base.Database.BaseDatabase();
        
        public ProfileType(System.Data.SqlClient.SqlDataReader reader)
        {
            this.AddItemsToListBySqlDataReader(reader);
        }
        
        public ProfileType()
        {
        }
        
        public virtual void AddItemsToListBySqlDataReader(System.Data.SqlClient.SqlDataReader reader)
        {
        
            TestSprocGenerator.Data.SingleTable.Dto.ProfileType dto;
                using(reader)
                {

                while(reader.Read())
                {
            dto = new TestSprocGenerator.Data.SingleTable.Dto.ProfileType();
                    dto.ProfileName = 
                    _baseDatabase.resolveNullString(reader.GetOrdinal("ProfileName"), reader);
                    dto.Deleted = 
                    _baseDatabase.resolveNullBoolean(reader.GetOrdinal("Deleted"), reader);
                    dto.InsertedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("InsertedDateTime"), reader);
                    dto.ModifiedDateTime = 
                    _baseDatabase.resolveNullDateTime(reader.GetOrdinal("ModifiedDateTime"), reader);
                    dto.ProfileTypeID = 
                    _baseDatabase.retrieveGuidFromDataReader(reader.GetOrdinal("ProfileTypeID"), reader);
                    this.Add(dto);
                }

                }

        }
    }
}

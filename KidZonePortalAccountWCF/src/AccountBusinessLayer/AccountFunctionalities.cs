using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;

namespace AccountBusinessLayer
{
    public class AccountFunctionalities
    {
       static  CommonLibrary.DatabaseSmoObjectsAndSettings _databaseSettings = null;

       static AccountFunctionalities()
       {
           ConnectionStringSettingsCollection connections = ConfigurationManager.ConnectionStrings;

           // Get the collection elements.
           foreach (ConnectionStringSettings connection in connections)
           {
               if (connection.Name == "KidZonePortalDatabase")
               {
                   SqlConnectionStringBuilder sb = new SqlConnectionStringBuilder(connection.ConnectionString);
                   _databaseSettings = new CommonLibrary.DatabaseSmoObjectsAndSettings(
                       sb.InitialCatalog, sb.DataSource, sb.InitialCatalog,
                       sb.UserID, sb.Password, sb.IntegratedSecurity);
                   break;
               }
           }
       }
           
        public bool DoesUsernameExist(string username)
        {
            return doesUsernameExist(username);
        }

        private bool doesUsernameExist(string username)
        {
            if (_databaseSettings != null)
            {
                TestSprocGenerator.Business.SingleTable.Bo.List.Account accounts =
                    new TestSprocGenerator.Business.SingleTable.Bo.List.Account(_databaseSettings);

                TestSprocGenerator.Business.SingleTable.Bo.Account bo =
                    new TestSprocGenerator.Business.SingleTable.Bo.Account(_databaseSettings);

                bo.AccountUsername = username;
                accounts.FillByCriteriaExact(bo);

                if (accounts.Count > 0)
                {
                    return true;
                }
                return false;
            }
            else
            {
                throw new ApplicationException("Connection String was not Provided in Configuration File");
            }
        }
    }
}

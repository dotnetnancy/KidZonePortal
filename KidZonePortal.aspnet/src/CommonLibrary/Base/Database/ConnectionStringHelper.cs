using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace CommonLibrary.Base.Database
{
    public static class ConnectionStringHelper
    {
        // Protect the connectionStrings section.
        public static void ProtectConfiguration()
        {
            //we need to do this check as a web config will not be opened using what's in the else
            try
            {
                System.Configuration.Configuration config = null;
                ConfigurationSection section = null;
                try
                {
                    if (System.Web.HttpContext.Current != null && !System.Web.HttpContext.Current.Request.PhysicalPath.Equals(string.Empty))
                        config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
                    else
                        config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                }
                catch (Exception)
                {
                    section = ConfigurationManager.GetSection("connectionStrings") as ConfigurationSection;
                }


                // Define the Dpapi provider name.
                string provider =
                    "DataProtectionConfigurationProvider";

                ConfigurationSection connStrings = null;
                if (config != null)
                {

                    // Get the section to protect.
                    connStrings =
                    config.ConnectionStrings;
                }
                else
                {
                    connStrings = section;
                }

                if (connStrings != null)
                {
                    if (!connStrings.SectionInformation.IsProtected)
                    {

                        // Protect the section.
                        connStrings.SectionInformation.ProtectSection(provider);

                        connStrings.SectionInformation.ForceSave = true;
                        config.Save(ConfigurationSaveMode.Full);
                    }
                    //do nothing we are already protected i think this is default behavior in 4.0 framework
                }
                else
                    throw new ApplicationException(String.Format("Can't get the section {0}", connStrings.SectionInformation.Name));
            }
            catch (Exception)
            {
                //we probably do not have permission to call protect on the file since we are not running in .exe
            }
        }

        // Unprotect the connectionStrings section.
        private static void UnProtectConfiguration()
        {
            try
            {
                System.Configuration.Configuration config = null;
                ConfigurationSection section = null;
                try
                {
                    if (System.Web.HttpContext.Current != null && !System.Web.HttpContext.Current.Request.PhysicalPath.Equals(string.Empty))
                        config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
                    else
                        config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                }
                catch (Exception ex)
                {
                    section = ConfigurationManager.GetSection("connectionStrings") as ConfigurationSection;
                }


                // Get the section to unprotect.
                ConfigurationSection connStrings = null;

                if (config != null)
                {

                    // Get the section to protect.
                    connStrings =
                    config.ConnectionStrings;
                }
                else
                {
                    connStrings = section;
                }
                if (connStrings.SectionInformation.IsProtected)
                {

                    // Unprotect the section.
                    connStrings.SectionInformation.UnprotectSection();

                    connStrings.SectionInformation.ForceSave = true;
                    config.Save(ConfigurationSaveMode.Full);
                }
            }
            catch (Exception ex)
            {
                //we probably do not have permission to call protect on the file since we are not running in .exe

            }
        }
           

        public static ConnectionStringsSection GetConnectionStrings()
        {
            System.Configuration.Configuration config = null;
            ConnectionStringsSection section = null;
            try
            {
                if (System.Web.HttpContext.Current != null && !System.Web.HttpContext.Current.Request.PhysicalPath.Equals(string.Empty))
                    config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");
                else
                    config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            }
            catch (Exception ex)
            {
                section = ConfigurationManager.GetSection("connectionStrings") as ConnectionStringsSection;
            }

            ConnectionStringsSection connStrings = null;

            if (config != null)
            {                
                connStrings =
                config.ConnectionStrings;
            }
            else
            {
                connStrings = section;
            }

            return connStrings;

        }
    }
}
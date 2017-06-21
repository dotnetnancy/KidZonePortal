using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using TestSprocGenerator.Business.SingleTable.Bo;
using ProfileBusinessLayer;
using log4net;
using System.Reflection;
using System.ServiceModel.Activation;


namespace ProfileService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    [ServiceBehavior(Namespace = "http://KidZonePortal.com/services/ProfileServices",
        InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Multiple)]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ProfileService : IProfileService
    {
        ProfileManager _profileManager = null;

        public ProfileManager ProfileManager_Property
        {
            get { return _profileManager; }
            set { _profileManager = value; }
        }

        static ILog _log = null;

        static ProfileService()
        {
            _log = _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
            //CommonLibrary.Base.Database.ConnectionStringHelper.ProtectConfiguration();            

        }

        public ProfileService()
        {
            if (_profileManager == null)
                _profileManager = new ProfileManager();
        }

        public List<ProfileType> RetrieveProfileTypes()
        {         

            if (_profileManager == null)
                _profileManager = new ProfileManager();

            return _profileManager.RetrieveProfileTypesForInternetUsers();
        }

     
    }
}

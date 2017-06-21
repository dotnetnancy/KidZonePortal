using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using log4net;
using System.Reflection;
using System.Web.Security;
using System.ServiceModel;
using CommonLibrary;
using TestSprocGenerator.Business.SingleTable.Bo;

namespace KidZonePortal.aspnet.ProfileManagement
{
    public class ProfilePresenter
    {

        static ILog _log = null;
        IProfileView _view = null;

        static ProfilePresenter()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public ProfilePresenter(IProfileView view)
        {
            _view = view;
        }

        public bool LoadProfileTypes()
        {            
            ProfileServiceClient client = null;
            bool result = false;

            try
            {
                client = new ProfileServiceClient();
                ProfileType [] profileTypes = client.RetrieveProfileTypes();
                CommonLibrary.Utilty.Sort.GenericList<ProfileType> genericList = new CommonLibrary.Utilty.Sort.GenericList<ProfileType>();
                genericList.AddRange(profileTypes);
                genericList.Sort("ProfileName", CommonLibrary.Utilty.Sort.CollectionSortDirection.Ascending);

                if (genericList != null && genericList.Count > 0)
                {
                    _view.ProfileTypes = genericList;
                    result = true;
                }
            }
            catch (TimeoutException te)
            {
                _log.Fatal(te);

            }
            catch (FaultException fe)
            {
                _log.Fatal(fe);

            }
            catch (CommunicationException ce)
            {

                _log.Fatal(ce);
            }

            catch (Exception ex)
            {

                _log.Fatal(ex);
            }

            finally
            {
                if (client != null)
                {
                    client.CloseProxy();
                }

            }

            return result;
        }

    }
}
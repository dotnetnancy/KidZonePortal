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

namespace KidZonePortal.aspnet.CountryCityProvinceManagement
{
    public class CountryCityProvincePresenter
    {

        static ILog _log = null;
        ICountryCityProvinceView _view = null;

        static CountryCityProvincePresenter()
        {
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(Assembly.GetExecutingAssembly().GetType());
        }

        public CountryCityProvincePresenter(ICountryCityProvinceView view)
        {
            _view = view;
        }

        public bool LoadCountries()
        {

            //custom authentication
            CountryCityProvinceServiceClient client = null;
            bool result = false;

            try
            {

                client = new CountryCityProvinceServiceClient();
                Country [] countries = client.GetCountries();
                CommonLibrary.Utilty.Sort.GenericList<Country> genericList = new CommonLibrary.Utilty.Sort.GenericList<Country>();
                genericList.AddRange(countries);
                genericList.Sort("Name", CommonLibrary.Utilty.Sort.CollectionSortDirection.Ascending);

                if (genericList != null && genericList.Count > 0)
                {
                    _view.Countries = genericList;
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

        public bool LoadCities(int? countryID)
        {

            //custom authentication
            CountryCityProvinceServiceClient client = null;
            bool result = false;

            try
            {

                client = new CountryCityProvinceServiceClient();
                City [] cities = client.GetCities(countryID);

                CommonLibrary.Utilty.Sort.GenericList<City> genericList = new CommonLibrary.Utilty.Sort.GenericList<City>();
                genericList.AddRange(cities);
                genericList.Sort("Name", CommonLibrary.Utilty.Sort.CollectionSortDirection.Ascending);

                if (genericList != null && genericList.Count > 0)
                {
                    _view.Cities = genericList;
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
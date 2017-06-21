using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TestSprocGenerator.Business.SingleTable.Bo;

namespace KidZonePortal.aspnet.ProfileManagement
{
    public interface IProfileView
    {
        List<ProfileType> ProfileTypes {get; set;}            
    }
}

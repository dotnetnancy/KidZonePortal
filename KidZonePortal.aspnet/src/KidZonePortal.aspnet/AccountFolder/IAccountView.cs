using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TestSprocGenerator.Business.SingleTable.Bo;

namespace KidZonePortal.aspnet.AccountManagement
{
    public interface IAccountView
    {
        List<Account> Accounts {get; set;}
        string TitleForDisplay { get; set; }        
    }
}

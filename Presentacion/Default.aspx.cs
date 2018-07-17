using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentacion
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            Session["Usuario"] = null;
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            try
            {

            }
            catch (Exception ex) {  }
        }

    }
}
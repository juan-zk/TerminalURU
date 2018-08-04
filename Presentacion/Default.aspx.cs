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
                string usuario = Login1.UserName.Trim();
                string pass = Login1.Password;
                EntidadesCompartidas.Empleado emp = Logica.FabricaLogica.GetLogicaEmpleado().Logueo(usuario, pass);

                if (emp == null)
                {
                    throw new Exception("Error al iniciar sesion, compruebe los datos");
                }
                else
                {
                    Session["Usuario"] = emp;
                    Response.Redirect("~/ABMempleado.aspx");
                }
            }
            catch (Exception ex) { Login1.FailureText = ex.Message; }
        }

    }
}
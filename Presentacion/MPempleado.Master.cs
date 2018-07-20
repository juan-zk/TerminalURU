using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

namespace Presentacion
{
    public partial class MPempleado : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    if ((Empleado)Session["Usuario"] == null)
                        Response.Redirect("~/Default.aspx");
                        
                    lblUsuario.Text = ((Empleado)Session["Usuario"])._NombreCompleto;
                }
            }
            catch (Exception ex) { }
        }
                              
    }
}
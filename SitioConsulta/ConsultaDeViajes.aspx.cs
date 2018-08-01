using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica;
using EntidadesCompartidas;

public partial class ConsultaDeViajes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsj.Text = "";
        if (!IsPostBack)
        {
            try
            {
                List<Viaje> viajes = new List<Viaje>();
                viajes.AddRange(FabricaLogica.GetLogicaViajes().Listar());
                viajes.AddRange(FabricaLogica.GetLogicaViajes().ListarViaje());

                Session["ListaDeViajes"] = viajes;

                rptrViajes.DataSource = viajes;
                rptrViajes.DataBind();
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
        }
        

    }
    protected void rptrViajes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        
        if (e.CommandName == "VerViaje") 
        {
            try
            {
                int codViaje = Convert.ToInt32(((TextBox)e.Item.Controls[1]).Text);

                Viaje v = FabricaLogica.GetLogicaViajes().Buscar(codViaje);
                if (v == null)
                {
                    v = FabricaLogica.GetLogicaViajes().BuscarViaje(codViaje);
                }

                Session["ConsultaViaje"] = v;
                Response.Redirect("~/DetalleDeViaje.aspx");
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
        }
    }
}
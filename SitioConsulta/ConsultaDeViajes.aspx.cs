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
    protected void btnAplicar_Click(object sender, EventArgs e)
    {
        List<Viaje> FiltroViajes =  (List<Viaje>)Session["ListaDeViajes"];
        try 
        {
            //filtro por destino
             if (ddlDestino.SelectedValue != null)
             {
                List<Viaje> _Resultado = (from UnDes in FiltroViajes
                                          where UnDes._Ter._Ciudad == ddlDestino.SelectedValue
                                          select UnDes).ToList<Viaje>();
                rptrViajes.DataSource = _Resultado;
                rptrViajes.DataBind();
             }
            //filtro por destino y compañia
             else if (ddlCompañia.SelectedValue != null && ddlDestino.SelectedValue != null )
             {
                 List<Viaje> _Resultado = (from UnDes in FiltroViajes
                                           where ((UnDes._Ter._Ciudad == ddlDestino.SelectedValue) && (UnDes._Com._Nombre == ddlCompañia.SelectedValue))
                                           select UnDes).ToList<Viaje>();
                 rptrViajes.DataSource = _Resultado;
                 rptrViajes.DataBind();
             }
             //filtro por destino y rango de fechas

             else if (calPartida.SelectedDate != null && calLLegada.SelectedDate != null)
             {
                   List<Viaje> _Resultado = (from UnDes in FiltroViajes
                                          where (UnDes._Ter._Ciudad == ddlDestino.SelectedValue) && (UnDes._FechaPartida == calPartida.SelectedDate) && (UnDes._FechaArribo == calLLegada.SelectedDate) 
                                          select UnDes).ToList<Viaje>();
                rptrViajes.DataSource = _Resultado;
                rptrViajes.DataBind();
             
             }
        }
        catch (Exception ex) { lblMsj.Text = ex.Message; }
    }
    protected void btnQuitar_Click(object sender, EventArgs e)
    {
        List<Viaje> viajes = new List<Viaje>();
        viajes.AddRange(FabricaLogica.GetLogicaViajes().Listar());
        viajes.AddRange(FabricaLogica.GetLogicaViajes().ListarViaje());

        Session["ListaDeViajes"] = viajes;

        rptrViajes.DataSource = viajes;
        rptrViajes.DataBind();
    }
}

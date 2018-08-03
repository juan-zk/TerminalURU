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
    void LlenarDDL()
    {
        List<Terminal> terminales = FabricaLogica.GetLogicaTerminales().Listar();
        ddlDestino.Items.Clear();
        ddlDestino.Items.Add("Todos");
        foreach (Terminal ter in terminales)
        {
            ListItem l = new ListItem(string.Format(ter._Codigo + " " + ter._Ciudad), ter._Codigo);
            ddlDestino.Items.Add(l);
        }

        List<Compania> companias = FabricaLogica.GetLogicaCompania().Listar();
        ddlCompania.Items.Clear();
        ddlCompania.Items.Add("Todas");
        foreach (Compania c in companias)
        {
            ListItem l = new ListItem(c._Nombre, c._Nombre);
            ddlCompania.Items.Add(l);
        }
    }

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

                LlenarDDL();

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
             else if (ddlCompania.SelectedValue != null && ddlDestino.SelectedValue != null )
             {
                 List<Viaje> _Resultado = (from UnDes in FiltroViajes
                                           where ((UnDes._Ter._Ciudad == ddlDestino.SelectedValue) && (UnDes._Com._Nombre == ddlCompania.SelectedValue))
                                           select UnDes).ToList<Viaje>();
                 rptrViajes.DataSource = _Resultado;
                 rptrViajes.DataBind();
             }
             //filtro por destino y rango de fechas

             else if (calPartida.SelectedDate != null && calLLegada.SelectedDate != null && ddlDestino.SelectedValue != null)
             {
                   List<Viaje> _Resultado = (from UnDes in FiltroViajes
                                          where (UnDes._Ter._Ciudad == ddlDestino.SelectedValue) && (UnDes._FechaPartida == calPartida.SelectedDate) && (UnDes._FechaArribo == calLLegada.SelectedDate) 
                                          select UnDes).ToList<Viaje>();
                rptrViajes.DataSource = _Resultado;
                rptrViajes.DataBind();
             
             }
             else if (ddlDestino.SelectedValue == null)
             { lblMsj.Text = "No selecciono destino. Si desea filtrar por destino u otro filtro, Porfavor seleccione el destino y los demas filtros que desea"; }
            
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

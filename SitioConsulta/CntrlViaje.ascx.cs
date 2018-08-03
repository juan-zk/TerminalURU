using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

public partial class CntrlViaje : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtNumero.Text = ((Viaje)Session["ConsultaViaje"])._NumViaje.ToString();
            txtCompania.Text = ((Viaje)Session["ConsultaViaje"])._Com._Nombre;
            txtTerminal.Text = ((Viaje)Session["ConsultaViaje"])._Ter._Codigo;
            txtFechaPartida.Text = ((Viaje)Session["ConsultaViaje"])._FechaPartida.ToString();
            txtFechaArribo.Text = ((Viaje)Session["ConsultaViaje"])._FechaArribo.ToString();
            txtAsientos.Text = ((Viaje)Session["ConsultaViaje"])._CantidadAsientos.ToString();
            txtEmpleado.Text = ((Viaje)Session["ConsultaViaje"])._Emp._Cedula;
            if (Session["ConsultaViaje"] as ViajesInternacionales != null)
            {
                lblServicio.Visible = true;
                chkServicio.Visible = true;
                chkServicio.Enabled = ((ViajesInternacionales)Session["ConsultaViaje"])._ServicioBordo;
                lblDocumentacion.Visible = true;
                txtDocumentacion.Visible = true;
                txtDocumentacion.Text = ((ViajesInternacionales)Session["ConsultaViaje"])._Documentacion;
            }
            else
            {
                lblParadas.Visible = true;
                txtParadas.Visible = true;
                txtParadas.Text = ((ViajesNacionales)Session["ConsultaViaje"])._ParadasIntermedias.ToString();
            }
            txtNombre.Text = ((Viaje)Session["ConsultaViaje"])._Com._Nombre;
            txtDireccion.Text = ((Viaje)Session["ConsultaViaje"])._Com._Direccion;
            txtTelefono.Text = ((Viaje)Session["ConsultaViaje"])._Com._Telefono;

            txtPais.Text = ((Viaje)Session["ConsultaViaje"])._Ter._Pais;
            txtCiudad.Text = ((Viaje)Session["ConsultaViaje"])._Ter._Ciudad;
            txtCodigo.Text = ((Viaje)Session["ConsultaViaje"])._Ter._Codigo;
            lstFacilidades.DataSource = ((Viaje)Session["ConsultaViaje"])._Ter._Facilidades;
            lstFacilidades.DataBind();
        }
        catch (Exception ex)
        { lblMsj.Text = ex.Message; }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/ConsultaDeViajes.aspx");
        }
        catch (Exception ex)
        { lblMsj.Text = ex.Message; }
    }
}
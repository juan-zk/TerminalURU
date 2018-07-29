using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

namespace Presentacion
{
    public partial class ViajesInter : System.Web.UI.Page
    {
        void Limpiar()
        {
            txtCompania.Text = "";
            txtEmpleado.Text = "";
            txtFechaPartida.Text = "";
            txtFechaArribo.Text = "";
            txtDocumentacion.Text = "";
            txtTerminal.Text = "";
            txtCantidadAsientos.Text = "";
            chkServicioBordo.Checked = false;
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsj.Text = "";
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtNum.Text))
                        throw new Exception("Debe completar el campo de busqueda");
                    Session["viajeInter"] = Logica.FabricaLogica.GetLogicaViajes().Buscar(Convert.ToInt32(txtNum.Text.Trim()));

                if ((ViajesInternacionales)Session["viajeInter"] != null)
                {
                    txtCompania.Text = ((ViajesInternacionales)Session["viajeInter"])._Com._Nombre;
                    txtTerminal.Text = ((ViajesInternacionales)Session["viajeInter"])._Ter._Codigo;
                    txtFechaPartida.Text = ((ViajesInternacionales)Session["viajeInter"])._FechaPartida.ToString();
                    txtFechaArribo.Text = ((ViajesInternacionales)Session["viajeInter"])._FechaArribo.ToString();
                    txtCantidadAsientos.Text = ((ViajesInternacionales)Session["viajeInter"])._CantidadAsientos.ToString();
                    txtEmpleado.Text = ((ViajesInternacionales)Session["viajeInter"])._Emp._Cedula;
                    txtDocumentacion.Text = ((ViajesInternacionales)Session["viajeInter"])._Documentacion;
                    if (((ViajesInternacionales)Session["viajeInter"])._ServicioBordo == true)
                    { chkServicioBordo.Checked = true; }
                    else { chkServicioBordo.Checked = false; }
                    btnEliminar.Enabled = true;
                    btnModificar.Enabled = true;
                }
                else
                {
                    btnAgregar.Enabled = true;
                    lblMsj.Text = "No existe el viaje internacional, si desea puede agregarlo.";
                }
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                ((ViajesInternacionales)Session["viajeInter"])._Com = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtCompania.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Emp = Logica.FabricaLogica.GetLogicaEmpleado().Buscar(txtEmpleado.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Ter = Logica.FabricaLogica.GetLogicaTerminales().Buscar(txtTerminal.Text);
                ((ViajesInternacionales)Session["viajeInter"])._ServicioBordo = chkServicioBordo.Checked;
                ((ViajesInternacionales)Session["viajeInter"])._FechaPartida = Convert.ToDateTime(txtFechaPartida.Text);
                ((ViajesInternacionales)Session["viajeInter"])._FechaArribo = Convert.ToDateTime(txtFechaArribo.Text);
                ((ViajesInternacionales)Session["viajeInter"])._CantidadAsientos = Convert.ToInt32(txtCantidadAsientos.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Documentacion = txtDocumentacion.Text;
                Limpiar();
                Logica.FabricaLogica.GetLogicaViajes().Modificar((ViajesInternacionales)Session["viajeInter"]);
                
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                Limpiar();
                Logica.FabricaLogica.GetLogicaViajes().Eliminar((ViajesInternacionales)Session["viajeInter"]);

            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                //arreglar xq no existe numViaje en viajesinter
                ((ViajesInternacionales)Session["viajeInter"])._NumViaje = Convert.ToInt32(txtNum.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Com = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtCompania.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Emp = Logica.FabricaLogica.GetLogicaEmpleado().Buscar(txtEmpleado.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Ter = Logica.FabricaLogica.GetLogicaTerminales().Buscar(txtTerminal.Text);
                ((ViajesInternacionales)Session["viajeInter"])._ServicioBordo = chkServicioBordo.Checked;
                ((ViajesInternacionales)Session["viajeInter"])._FechaPartida = Convert.ToDateTime(txtFechaPartida.Text);
                ((ViajesInternacionales)Session["viajeInter"])._FechaArribo = Convert.ToDateTime(txtFechaArribo.Text);
                ((ViajesInternacionales)Session["viajeInter"])._CantidadAsientos = Convert.ToInt32(txtCantidadAsientos.Text);
                ((ViajesInternacionales)Session["viajeInter"])._Documentacion = txtDocumentacion.Text;
                Limpiar();
                Logica.FabricaLogica.GetLogicaViajes().Agregar((ViajesInternacionales)Session["viajeInter"]);

            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }
    }
}
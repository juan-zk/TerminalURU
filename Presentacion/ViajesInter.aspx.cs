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
    }
}
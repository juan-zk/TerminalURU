using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

namespace Presentacion
{
    public partial class ABMCompanias : System.Web.UI.Page
    {
        void Limpiar() 
        {
            txtDir.Text = "";
            txtTel.Text = "";
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblMsj.Text = "";
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void tnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                Limpiar();
                if (String.IsNullOrEmpty(txtNombre.Text))
                    throw new Exception("Debe completar el campo de busqueda");
                Session["compania"] = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtNombre.Text.Trim());

                if ((Compañia)Session["compania"] != null)
                {
                    txtDir.Text = ((Compañia)Session["compania"])._Nombre;
                    txtTel.Text = ((Compañia)Session["compania"])._Telefono.ToString();
                    btnEliminar.Enabled = true;
                    btnModificar.Enabled = true;
                }
                else
                {
                    btnAgregar.Enabled = true;
                    lblMsj.Text = "No existe la compañia, si desea puede agregarla.";
                }
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                Compañia comp = new Compañia(txtNombre.Text, txtDir.Text, Convert.ToInt32(txtTel.Text.Trim()));
                Logica.FabricaLogica.GetLogicaCompania().Agregar(comp);
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }
    }
}
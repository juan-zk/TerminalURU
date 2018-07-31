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
                if (String.IsNullOrEmpty(txtNombre.Text))
                    throw new Exception("Debe completar el campo de busqueda");
                Session["compania"] = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtNombre.Text.Trim());

                if ((Compania)Session["compania"] != null)
                {
                    txtDir.Text = ((Compania)Session["compania"])._Direccion;
                    txtTel.Text = ((Compania)Session["compania"])._Telefono.ToString();
                    btnEliminar.Enabled = true;
                    btnModificar.Enabled = true;
                }
                else
                {
                    Limpiar();
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
                Compania comp = new Compania(txtNombre.Text, txtDir.Text, txtTel.Text.Trim());
                Logica.FabricaLogica.GetLogicaCompania().Agregar(comp);
                Limpiar();
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {   
                ((Compania)Session["compania"])._Nombre = txtNombre.Text;
                ((Compania)Session["compania"])._Direccion = txtDir.Text;
                ((Compania)Session["compania"])._Telefono = txtTel.Text.Trim();
                Logica.FabricaLogica.GetLogicaCompania().Modificar((Compania)Session["compania"]);
            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                Limpiar();
                Logica.FabricaLogica.GetLogicaCompania().Eliminar((Compania)Session["compania"]);

            }
            catch (Exception ex)
            { lblMsj.Text = ex.Message; }
        }
    }
}
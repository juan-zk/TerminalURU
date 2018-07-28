using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentacion
{
    public partial class ABMterminales : System.Web.UI.Page
    {
        void LimpiarCampos() {
            txtCodigo.Text = "";
            txtCodigo.Enabled = true;
            ddlPais.Enabled = false;
            txtCiudad.Text = "";
            txtCiudad.Enabled = false;
            lstFacilidad.Items.Clear();
            lstFacilidad.Enabled = false;
            txtFacilidad.Text = "";
            txtFacilidad.Enabled = false;
            btnEliminar.Enabled = false;
            btnModificar.Enabled = false;
            btnAgregar.Enabled = false;
        }
        void CamposAgregar() {
            txtCodigo.Enabled = false;
            ddlPais.Enabled = true;
            txtCiudad.Enabled = true;
            lstFacilidad.Enabled = true;
            txtFacilidad.Enabled = true;
            btnEliminar.Enabled = false;
            btnModificar.Enabled = false;
            btnAgregar.Enabled = true;
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnBorraFacilidad_Click(object sender, EventArgs e)
        {
            lstFacilidad.Items.Remove(lstFacilidad.SelectedItem);
        }

        protected void btnAgregaFacilidad_Click(object sender, EventArgs e)
        {
            if (txtFacilidad.Text != "")
                lstFacilidad.Items.Add(txtFacilidad.Text);
            txtFacilidad.Text = "";
        }

    }
}
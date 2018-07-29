using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;
using Logica;

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
            btnBuscar.Enabled = true;
            Session["TerminalBuscada"] = null;
        }
        void CamposAgregar() {
            txtCodigo.Enabled = false;
            ddlPais.Enabled = true;
            lstFacilidad.Items.Clear();
            txtCiudad.Enabled = true;
            lstFacilidad.Enabled = true;
            txtFacilidad.Enabled = true;
            btnEliminar.Enabled = false;
            btnModificar.Enabled = false;
            btnAgregar.Enabled = true;
            btnBuscar.Enabled = false;
        }
        void CamposBajaModi() {
            txtCodigo.Enabled = false;
            ddlPais.Enabled = true;
            lstFacilidad.Items.Clear();
            txtCiudad.Enabled = true;
            lstFacilidad.Enabled = true;
            txtFacilidad.Enabled = true;
            btnEliminar.Enabled = true;
            btnModificar.Enabled = true;
            btnAgregar.Enabled = false;
            btnBuscar.Enabled = false;
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsj.Text = "";
            if (!IsPostBack)
            {
                LimpiarCampos();
            }
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                string cod = txtCodigo.Text;
                Terminal t = FabricaLogica.GetLogicaTerminales().Buscar(cod);

                if (t == null)
                {
                    CamposAgregar();
                    lblMsj.Text = "No existe terminal con ese codigo, ingrese los datos para agregar una";
                }
                else
                {
                    CamposBajaModi();
                    Session["TerminalBuscada"] = t;
                    txtCiudad.Text = t._Ciudad;
                    ddlPais.SelectedValue = t._Pais;
                    for (int i = 0; i < t._Facilidades.Count; i++)
                    {
                        lstFacilidad.Items.Add(t._Facilidades[i]);
                    }

                }
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
             
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        { 
            LimpiarCampos();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                List<string> listaT = new List<string>();
                for (int i = 0; i < lstFacilidad.Items.Count; i++)
                {
                    listaT.Add(lstFacilidad.Items[i].ToString());
                }
                Terminal t = new Terminal(txtCodigo.Text, txtCiudad.Text, ddlPais.Text, listaT);
                FabricaLogica.GetLogicaTerminales().Agregar(t);
                lblMsj.Text = "Terminal agregada correctamente";
                LimpiarCampos();
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                FabricaLogica.GetLogicaTerminales().Eliminar((Terminal)Session["TerminalBuscada"]);
                lblMsj.Text = "Terminal eliminada correctamente";
                LimpiarCampos();
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                Terminal ter = (Terminal)Session["TerminalBuscada"];

                ter._Ciudad = txtCiudad.Text;
                ter._Pais = ddlPais.SelectedValue;

                List<string> facilidades = new List<string>();
                for (int i = 0; i < lstFacilidad.Items.Count; i++)
                {
                    facilidades.Add(lstFacilidad.Items[i].ToString());
                }

                ter._Facilidades = facilidades;

                FabricaLogica.GetLogicaTerminales().Modificar(ter);
                lblMsj.Text = "Terminal modificada correctamente";
                LimpiarCampos();
            }
            catch (Exception ex) { lblMsj.Text = ex.Message; }
        }

    }
}
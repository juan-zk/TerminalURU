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
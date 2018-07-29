using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

namespace Presentacion
{
    public partial class ABMempleado : System.Web.UI.Page
    {
        void Limpiar()
        {
            txtCedula.Text = "";
            txtContraseña.Text = "";
            txtNombreCompleto.Text = "";
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }
       
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblMensaje.Text = "";
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void tnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
               
                if (string.IsNullOrEmpty(txtCedula.Text))
                 throw new Exception("Ingrese un numero de cedula para comenzar a buscar");
                Session["Empleado"] = Logica.FabricaLogica.GetLogicaEmpleado().Buscar(txtCedula.Text.Trim());
                

               
              
               if ((Empleado)Session["Empleado"] != null)
                {
                    txtContraseña.Text = ((Empleado)Session["Empleado"])._Contraseña;
                    txtNombreCompleto.Text = ((Empleado)Session["Empleado"])._NombreCompleto;
                    btnEliminar.Enabled = true;
                    btnModificar.Enabled = true;

                }
                else
                {
                    btnAgregar.Enabled = true;
                    lblMensaje.Text = "No existe empleado con ese numero de cedula. Si desea puede agregarlo.";
                }
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCedula.Text))
                    throw new Exception("Ingrese un numero de cedula.");
                Logica.FabricaLogica.GetLogicaEmpleado().Borrar(txtCedula.Text);

                lblMensaje.Text = "El empleado fue elimiando correctamente.";
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                Empleado emp = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text, false);
                
                Logica.FabricaLogica.GetLogicaEmpleado().Modificar(emp);
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
               
             
               
                    Empleado emp2 = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text, false);

                    Logica.FabricaLogica.GetLogicaEmpleado().Agregar(emp2);
                    txtCedula.Text = "";
                    txtContraseña.Text = "";
                    txtNombreCompleto.Text = "";
                
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        protected void btnBaja_Click(object sender, EventArgs e)
        {
            try
            {
                Empleado emp = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text, false);

                Logica.FabricaLogica.GetLogicaEmpleado().Baja(emp);
                lblMensaje.Text = "Empleado dado de baja correctamente";
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }
    }
}
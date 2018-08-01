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
            btnLimpiar.Enabled  = false;
            btnBaja.Enabled = false;
            btnBuscar.Enabled = true;
            txtCedula.Enabled = true;
            txtContraseña.Enabled = false;
            txtNombreCompleto.Enabled = false;
        }
        void Agregar()
        {
            txtCedula.Enabled = false;
            txtContraseña.Enabled = true;
            txtNombreCompleto.Enabled = true;
            btnAgregar.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            btnBuscar.Enabled = false;
        }
        void BajaCampos()
        {
            txtCedula.Enabled = false;
            txtContraseña.Enabled = true;
            txtNombreCompleto.Enabled = true;
            btnAgregar.Enabled = false;
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnBuscar.Enabled = false;
            btnBaja.Enabled = true;
        }
       
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblMensaje.Text = "";
                if (!IsPostBack)
                {
                    Limpiar();
                }
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
                    BajaCampos();
                   txtContraseña.Text = ((Empleado)Session["Empleado"])._Contraseña;
                    txtNombreCompleto.Text = ((Empleado)Session["Empleado"])._NombreCompleto;
                    

                }
                else
                {
                    Agregar();
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
                Limpiar();
                lblMensaje.Text = "El empleado fue elimiando correctamente.";
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {

                Empleado emp = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text);

                Limpiar();
                Logica.FabricaLogica.GetLogicaEmpleado().Modificar(emp);
               
                lblMensaje.Text = "El empleado fue modificado correctamente";
                
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
               
             
               
                    Empleado emp2 = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text);

                    Logica.FabricaLogica.GetLogicaEmpleado().Agregar(emp2);

                    Limpiar();
                    lblMensaje.Text = "Empleado agregado correctamente";
                
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
                Empleado emp = new Empleado(txtCedula.Text, txtContraseña.Text, txtNombreCompleto.Text);

                Logica.FabricaLogica.GetLogicaEmpleado().Baja(emp);
                Limpiar();
                lblMensaje.Text = "Empleado dado de baja correctamente";
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }
    }
}
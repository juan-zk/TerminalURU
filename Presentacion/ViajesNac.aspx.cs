﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using EntidadesCompartidas;
using Logica;


namespace Presentacion
{
    public partial class ViajesNac : System.Web.UI.Page
    {
        void Limpiar()
        {
            txtNum.Text = "";
            txtCompania.Text = "";
            txtEmpleado.Text = "";
            txtFechaPartida.Text = "";
            txtFechaArribo.Text = "";
            txtTerminal.Text = "";
            txtCantidadAsientos.Text = "";
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtNum.Text))
                    throw new Exception("Debe completar el campo de busqueda");
                Session["ViajesNacionales"] = FabricaLogica.GetLogicaViajes().BuscarViaje(Convert.ToInt32(txtNum.Text.Trim()));


                if ((ViajesNac)Session["ViajesNacionales"] != null)
                {
                    
                    txtCompania.Text = ((ViajesNacionales)Session["ViajesNacional"])._Com._Nombre;
                     txtTerminal.Text = ((ViajesNacionales)Session["ViajesNacional"])._Ter._Codigo;
                     txtFechaPartida.Text = ((ViajesNacionales)Session["ViajesNacional"])._FechaPartida.ToString();
                     txtFechaArribo.Text = ((ViajesNacionales)Session["ViajesNacional"])._FechaArribo.ToString();
                     txtCantidadAsientos.Text = ((ViajesNacionales)Session["ViajesNacional"])._CantidadAsientos.ToString();
                     txtEmpleado.Text = ((ViajesNacionales)Session["ViajesNacional"])._Emp._Cedula;
                     //Falta paradas intermedias
                    
                }
                else
                {
                    btnAgregar.Enabled = true;
                    lblMensaje.Text = "No existe el viaje internacional, si desea puede agregarlo.";
                }
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {

                ((ViajesNacionales)Session["ViajesNacionales"])._NumViaje = Convert.ToInt32(txtNum.Text);
                 ((ViajesNacionales)Session["ViajesNacionales"])._Com = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtCompania.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._Emp = Logica.FabricaLogica.GetLogicaEmpleado().Buscar(txtEmpleado.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._Ter = Logica.FabricaLogica.GetLogicaTerminales().Buscar(txtTerminal.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._FechaPartida = Convert.ToDateTime(txtFechaPartida.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._FechaArribo = Convert.ToDateTime(txtFechaArribo.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._CantidadAsientos = Convert.ToInt32(txtCantidadAsientos.Text);
                  ((ViajesNacionales)Session["ViajesNacionales"])._ParadasIntermedias = Convert.ToInt32(ddParadas.SelectedValue);
                  Logica.FabricaLogica.GetLogicaViajes().Agregar((ViajesNacionales)Session["ViajesNacionales"]);



            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                ((ViajesNacionales)Session["ViajesNacionales"])._Com = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtCompania.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._Emp = Logica.FabricaLogica.GetLogicaEmpleado().Buscar(txtEmpleado.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._Ter = Logica.FabricaLogica.GetLogicaTerminales().Buscar(txtTerminal.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._FechaPartida = Convert.ToDateTime(txtFechaPartida.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._FechaArribo = Convert.ToDateTime(txtFechaArribo.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._CantidadAsientos = Convert.ToInt32(txtCantidadAsientos.Text);
                ((ViajesNacionales)Session["ViajesNacionales"])._ParadasIntermedias = Convert.ToInt32(ddParadas.SelectedValue);

                Logica.FabricaLogica.GetLogicaViajes().Modificar((ViajesNacionales)Session["ViajesNacionales"]);
                
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                ViajesNacionales viaje = (ViajesNacionales)Session["ViajesNacionales"];
                FabricaLogica.GetLogicaViajes().Eliminar(viaje);


            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }
    }
}
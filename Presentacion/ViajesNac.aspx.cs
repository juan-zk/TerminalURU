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
            txtCompania.Text = "";            
            txtFechaPartida.Text = "";
            txtFechaArribo.Text = "";
            txtTerminal.Text = "";
            txtCantidadAsientos.Text = "";
            ddParadas.SelectedValue = Convert.ToString(0);
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }
        void LimpiarTodo()
        {
            txtNum.Text = "";
            txtCompania.Text = "";
            txtFechaPartida.Text = "";
            txtFechaArribo.Text = "";
            txtTerminal.Text = "";
            txtCantidadAsientos.Text = "";
            ddParadas.SelectedValue = Convert.ToString(0);
            btnAgregar.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
        }
        bool ControlVacio()
        {
            bool vacio = false;
            if (String.IsNullOrEmpty(txtCompania.Text) || String.IsNullOrEmpty(txtFechaPartida.Text) || String.IsNullOrEmpty(txtFechaArribo.Text) || String.IsNullOrEmpty(ddParadas.SelectedValue) || String.IsNullOrEmpty(txtTerminal.Text) || String.IsNullOrEmpty(txtCantidadAsientos.Text))
                vacio = true;
            return vacio;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            if (!IsPostBack)
            {
                Limpiar();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtNum.Text))
                    throw new Exception("Debe completar el campo de busqueda");
                Session["ViajeNacBuscado"] = FabricaLogica.GetLogicaViajes().BuscarViaje(Convert.ToInt32(txtNum.Text.Trim()));


                if ((ViajesNacionales)Session["ViajeNacBuscado"] != null)
                {
                    btnAgregar.Enabled = false;
                    txtCompania.Text = ((ViajesNacionales)Session["ViajeNacBuscado"])._Com._Nombre;
                    txtTerminal.Text = ((ViajesNacionales)Session["ViajeNacBuscado"])._Ter._Codigo;
                    txtFechaPartida.Text = ((ViajesNacionales)Session["ViajeNacBuscado"])._FechaPartida.ToString();
                    txtFechaArribo.Text = ((ViajesNacionales)Session["ViajeNacBuscado"])._FechaArribo.ToString();
                    txtCantidadAsientos.Text = ((ViajesNacionales)Session["ViajeNacBuscado"])._CantidadAsientos.ToString();                    
                    ddParadas.Text = Convert.ToString(((ViajesNacionales)Session["ViajeNacBuscado"])._ParadasIntermedias);
                     btnEliminar.Enabled = true;
                     btnModificar.Enabled = true;
                }
                else
                {
                    Limpiar();
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
                if (ControlVacio())
                    throw new Exception("Debe completar todos los campos");
                Compania compania = Logica.FabricaLogica.GetLogicaCompania().Buscar(txtCompania.Text);
                if (compania == null)
                    throw new Exception("La compañia ingresada no se encuentra registrada");
                Terminal terminal = Logica.FabricaLogica.GetLogicaTerminales().Buscar(txtTerminal.Text);
                if (terminal == null)
                    throw new Exception("La terminal ingresada no se encuentra registrada");
                ViajesNacionales ViajeNac = new ViajesNacionales(Convert.ToInt32(txtNum.Text), compania, terminal, Convert.ToDateTime(txtFechaPartida.Text), Convert.ToDateTime(txtFechaArribo.Text), Convert.ToInt32(txtCantidadAsientos.Text), (Empleado)Session["Usuario"], Convert.ToInt32(ddParadas.SelectedValue));
                LimpiarTodo();
                
                Logica.FabricaLogica.GetLogicaViajes().Agregar(ViajeNac);
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ControlVacio())
                    throw new Exception("Debe completar todos los campos");
                ((ViajesNacionales)Session["ViajeNacBuscado"])._Com = Logica.FabricaLogica.GetLogicaCompania().BuscarParaViaje(txtCompania.Text);
                ((ViajesNacionales)Session["ViajeNacBuscado"])._Emp = (Empleado)Session["Usuario"];
                ((ViajesNacionales)Session["ViajeNacBuscado"])._Ter = Logica.FabricaLogica.GetLogicaTerminales().BuscarParaViaje(txtTerminal.Text);
                ((ViajesNacionales)Session["ViajeNacBuscado"])._FechaPartida = Convert.ToDateTime(txtFechaPartida.Text);
                ((ViajesNacionales)Session["ViajeNacBuscado"])._FechaArribo = Convert.ToDateTime(txtFechaArribo.Text);
                ((ViajesNacionales)Session["ViajeNacBuscado"])._CantidadAsientos = Convert.ToInt32(txtCantidadAsientos.Text);
                ((ViajesNacionales)Session["ViajeNacBuscado"])._ParadasIntermedias = Convert.ToInt32(ddParadas.SelectedValue);
                LimpiarTodo();
                Logica.FabricaLogica.GetLogicaViajes().Modificar((ViajesNacionales)Session["ViajeNacBuscado"]);
                
            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                LimpiarTodo();
                FabricaLogica.GetLogicaViajes().Eliminar((ViajesNacionales)Session["ViajeNacBuscado"]);


            }
            catch (Exception ex)
            { lblMensaje.Text = ex.Message; }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarTodo();
        }
    }
}
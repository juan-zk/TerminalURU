<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ABMempleado.aspx.cs" Inherits="Presentacion.ABMempleado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        .style9
        {
            height: 23px;
            text-align: center;
        }
        .style18
        {
            height: 23px;
            text-align: center;
        }
        .style22
        {
            height: 23px;
            width: 299px;
            text-align: right;
        }
        .style25
        {
            height: 23px;
            width: 329px;
            text-align: left;
        }
        .style26
        {
            height: 23px;
            width: 300px;
            text-align: left;
        }
        .style16
        {
            height: 23px;
            width: 300px;
            text-align: center;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table align="center" width="100%">
    <tr>
        <td class="style9" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18" colspan="3">
            <asp:Label ID="lblTitle" runat="server" CssClass="title" 
                style="text-align: left" Text="Mantenimiento de Empleado"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style18" colspan="3">
            <asp:Label ID="lblMensaje" runat="server" style="text-align: center"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style22" width="33%">
            &nbsp;</td>
        <td class="style25" align="center" width="33%">
            </td>
        <td class="style25" align="left" width="33%">
            </td>
    </tr>
    <tr>
        <td class="style22" width="33%">
            <asp:Label ID="Label1" runat="server" Text="Cedula:"></asp:Label>
        </td>
        <td class="style26" align="center" width="33%">
            <asp:TextBox ID="txtCedula" runat="server" style="text-align: left" 
                CssClass="txt"></asp:TextBox>
        </td>
        <td class="style26" align="left" width="33%">
            <asp:Button ID="btnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                onclick="tnBuscar_Click" />
        </td>
    </tr>
    <tr>
        <td class="style22" width="33%">
            &nbsp;</td>
        <td class="style25" align="center" width="33%">
            &nbsp;</td>
        <td class="style25" align="left" width="33%">
                <asp:Button ID="btnLimpiar" runat="server" CssClass="btns" Text="Limpiar" 
                onclick="btnLimpiar_Click" />
            </td>
    </tr>
    <tr>
        <td class="style9" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            </td>
        <td class="style25" align="center" width="33%">
            &nbsp;</td>
        <td class="style25" align="left" width="33%">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            <asp:Label ID="lblTel" runat="server" Text="Contraseña:"></asp:Label>
        </td>
        <td class="style25" align="center" width="33%">
            <asp:TextBox ID="txtContraseña" runat="server" style="text-align: left" 
                CssClass="txt"></asp:TextBox>
        </td>
        <td class="style25" align="left" width="33%">
            <asp:Button ID="btnBaja" runat="server" onclick="btnBaja_Click" Text="Baja" 
                CssClass="btns" />
        </td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            &nbsp;</td>
        <td class="style25" align="center" width="33%">
            &nbsp;</td>
        <td class="style25" align="left" width="33%">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            <asp:Label ID="lblDir" runat="server" Text="Nombre Completo:"></asp:Label>
        </td>
        <td class="style25" align="center" width="33%">
            <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="txt"></asp:TextBox>
        </td>
        <td class="style25" align="left" width="33%">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            &nbsp;</td>
        <td class="style25" align="center" width="33%">
            &nbsp;</td>
        <td class="style25" align="left" width="33%">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            &nbsp;</td>
        <td class="style16" align="center" width="33%">
            &nbsp;</td>
        <td class="style16" align="left" width="33%">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                Enabled="False" onclick="btnEliminar_Click" />
        </td>
        <td class="style16" align="center" width="33%">
            <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                Enabled="False" onclick="btnModificar_Click" />
        </td>
        <td class="style16" align="left" width="33%">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                Enabled="False" onclick="btnAgregar_Click" />
        </td>
    </tr>
    <tr>
        <td class="style22" align="right" width="33%">
            &nbsp;</td>
        <td class="style16" align="center" width="33%">
            &nbsp;</td>
        <td class="style16" align="left" width="33%">
            &nbsp;</td>
    </tr>
</table>
</asp:Content>

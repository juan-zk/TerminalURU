<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ViajesInter.aspx.cs" Inherits="Presentacion.ViajesInter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 731px;
            margin: 0 auto;
        }
        .style4
        {
            text-align: center;
        }
        .style6
        {
            width: 243px;
            text-align: left;
            height: 25px;
        }
        .style10
        {
            text-align: center;
            height: 25px;
        }
        .style11
        {
            text-align: center;
        }
        .style12
        {
            width: 243px;
            text-align: left;
        }
        .style17
        {
            text-align: center;
        }
        .style22
        {
            text-align: center;
            width: 243px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        &nbsp;</p>
    <table class="style1" width="100%">
        <tr>
            <td colspan="3" style="text-align: center">
                <asp:Label ID="lblTitle" runat="server" CssClass="title" 
                    Text="Viajes Internacionales"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center">
                <asp:Label ID="lblMsj" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style22">
                &nbsp;</td>
            <td class="style22">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style22">
                <asp:Label ID="lblNum" runat="server" Text="Número"></asp:Label>
            </td>
            <td class="style22">
                <asp:TextBox ID="txtNum" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12">
                <asp:Button ID="btnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                    onclick="btnBuscar_Click" />
            </td>
        </tr>
        <tr>
            <td class="style22">
                &nbsp;</td>
            <td class="style22">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="3">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="style17" colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblCom" runat="server" Text="Compañia"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtCompania" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="2">
            </td>
            <td class="style6">
            </td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblDestino" runat="server" Text="Destino"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtTerminal" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17" colspan="2">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblFPart" runat="server" style="text-align: left" 
                    Text="Fecha de Partida"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtFechaPartida" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17" colspan="2">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblFarribo" runat="server" Text="Fecha de Arribo"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtFechaArribo" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17" colspan="2">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblCAsientos" runat="server" Text="Cantidad de Asientos"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtCantidadAsientos" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17" colspan="2">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblUltEmpleado" runat="server" Text="Último Empleado"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtEmpleado" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="2">
            </td>
            <td class="style6">
            </td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblDoc" runat="server" Text="Documentación"></asp:Label>
            </td>
            <td class="style12">
                <asp:TextBox ID="txtDocumentacion" runat="server" CssClass="txt"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style11" colspan="2">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblSB" runat="server" Text="Servicio a Bordo"></asp:Label>
            </td>
            <td class="style12">
                <asp:CheckBox ID="chkServicioBordo" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="3">
            </td>
        </tr>
        <tr>
            <td class="style22">
                <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                    Width="100%" onclick="btnEliminar_Click" />
            </td>
            <td class="style22">
                <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                    Width="100%" onclick="btnModificar_Click" />
            </td>
            <td class="style12">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                    Width="100%" onclick="btnAgregar_Click" />
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

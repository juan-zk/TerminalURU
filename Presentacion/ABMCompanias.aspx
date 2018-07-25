<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ABMCompanias.aspx.cs" Inherits="Presentacion.ABMCompanias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .style1
    {
        width: 901px;
        height: 69px;
    }
        .style9
        {
            height: 23px;
            text-align: center;
        }
        .style16
        {
            height: 23px;
            width: 300px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="style1">
    <tr>
        <td class="style9" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18" colspan="3">
            <asp:Label ID="lblTitle" runat="server" CssClass="title" 
                style="text-align: left" Text="Mantenimiento de Compañias"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style18" colspan="3">
            <asp:Label ID="lblMsj" runat="server" style="text-align: center"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            </td>
    </tr>
    <tr>
        <td class="style22">
            <asp:Label ID="Label1" runat="server" Text="Nombre"></asp:Label>
        </td>
        <td class="style26">
            <asp:TextBox ID="txtNombre" runat="server" style="text-align: left"></asp:TextBox>
        </td>
        <td class="style26">
            <asp:Button ID="tnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                onclick="tnBuscar_Click" />
        </td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style9" colspan="3">
            <hr />
        </td>
    </tr>
    <tr>
        <td class="style22">
            </td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22">
            <asp:Label ID="lblTel" runat="server" Text="Teléfono"></asp:Label>
        </td>
        <td class="style25" colspan="2">
            <asp:TextBox ID="txtTel" runat="server" style="text-align: left"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22">
            <asp:Label ID="lblDir" runat="server" Text="Dirección"></asp:Label>
        </td>
        <td class="style25" colspan="2">
            <asp:TextBox ID="txtDir" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22">
            &nbsp;</td>
        <td class="style25" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22">
            <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                Width="100%" Enabled="False" />
        </td>
        <td class="style16">
            <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                Width="100%" Enabled="False" onclick="btnModificar_Click" />
        </td>
        <td class="style16">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                Width="100%" Enabled="False" onclick="btnAgregar_Click" />
        </td>
    </tr>
</table>
</asp:Content>

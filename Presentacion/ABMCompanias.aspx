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
    <table align="center" width="100%">
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
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style25" colspan="2" align="center">
            </td>
    </tr>
    <tr>
        <td class="style22" align="right">
            <asp:Label ID="Label1" runat="server" Text="Nombre"></asp:Label>
        </td>
        <td class="style26" align="center">
            <asp:TextBox ID="txtNombre" runat="server" style="text-align: left" 
                CssClass="txt"></asp:TextBox>
        </td>
        <td class="style26">
            <asp:Button ID="tnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                onclick="tnBuscar_Click" />
        </td>
    </tr>
    <tr>
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style25" colspan="2" align="center">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style9" colspan="3" align="center">
            <hr />
        </td>
    </tr>
    <tr>
        <td class="style22" align="right">
            </td>
        <td class="style25" align="center">
            &nbsp;</td>
        <td class="style25" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            <asp:Label ID="lblTel" runat="server" Text="Teléfono"></asp:Label>
        </td>
        <td class="style25" align="center">
            <asp:TextBox ID="txtTel" runat="server" style="text-align: left" CssClass="txt"></asp:TextBox>
        </td>
        <td class="style25" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style25" align="center">
            &nbsp;</td>
        <td class="style25" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            <asp:Label ID="lblDir" runat="server" Text="Dirección"></asp:Label>
        </td>
        <td class="style25" align="center">
            <asp:TextBox ID="txtDir" runat="server" CssClass="txt"></asp:TextBox>
        </td>
        <td class="style25" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style25" align="center">
            &nbsp;</td>
        <td class="style25" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style16" align="center">
            &nbsp;</td>
        <td class="style16" align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style22" align="right">
            <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                Enabled="False" onclick="btnEliminar_Click" />
        </td>
        <td class="style16" align="center">
            <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                Enabled="False" onclick="btnModificar_Click" />
        </td>
        <td align="left">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                Enabled="False" onclick="btnAgregar_Click" />
        </td>
    </tr>
    <tr>
        <td class="style22" align="right">
            &nbsp;</td>
        <td class="style16" align="center">
            &nbsp;</td>
        <td align="left">
            &nbsp;</td>
    </tr>
</table>
</asp:Content>

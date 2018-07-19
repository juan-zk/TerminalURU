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
            text-align: left;
        }
        .style18
        {
            height: 23px;
            width: 299px;
            text-align: center;
        }
        .style19
        {
            height: 23px;
            width: 372px;
            text-align: left;
        }
        .style20
        {
            height: 23px;
            width: 372px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="style1">
    <tr>
        <td class="style9" colspan="3">
            <asp:Label ID="lblMsj" runat="server" style="text-align: center"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style18">
            <asp:Label ID="lblTitle" runat="server" CssClass="title" 
                style="text-align: left" Text="Mantenimiento de Compañias"></asp:Label>
        </td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            </td>
        <td class="style20" colspan="2">
            </td>
    </tr>
    <tr>
        <td class="style18">
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </td>
        <td class="style20" colspan="2">
            <asp:Button ID="tnBuscar" runat="server" CssClass="btns" Text="Buscar" />
        </td>
    </tr>
    <tr>
        <td class="style18">
            &nbsp;</td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style9" colspan="3">
            <hr />
        </td>
    </tr>
    <tr>
        <td class="style18">
            </td>
        <td class="style20" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            <asp:Label ID="lblTel" runat="server" Text="Teléfono"></asp:Label>
        </td>
        <td class="style19" colspan="2">
            <asp:TextBox ID="txtTel" runat="server" style="text-align: left"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style18">
            &nbsp;</td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            <asp:Label ID="lblDir" runat="server" Text="Dirección"></asp:Label>
        </td>
        <td class="style19" colspan="2">
            <asp:TextBox ID="txtDir" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style18">
            &nbsp;</td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            &nbsp;</td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            &nbsp;</td>
        <td class="style19" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style18">
            <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" />
        </td>
        <td class="style16">
            <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" />
        </td>
        <td class="style16">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" />
        </td>
    </tr>
</table>
</asp:Content>

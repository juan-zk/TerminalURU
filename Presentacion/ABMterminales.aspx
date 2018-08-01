<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ABMterminales.aspx.cs" Inherits="Presentacion.ABMterminales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            height: 32px;
        }
        .style2
        {
            width: 33%;
        }
        .btnQ
        {}
        .btnA
        {}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%;" align="center">
        <tr>
            <td>
                &nbsp;
            </td>
            <td class="style2">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                <asp:Label ID="Label1" runat="server" Text="Mantenimiento de Terminales" 
                    CssClass="title"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" class="style1" colspan="3">
                <asp:Label ID="lblMsj" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td class="style2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="33%">
                <asp:Label ID="Label2" runat="server" Text="Codigo:"></asp:Label>
            </td>
            <td align="center" class="style2">
                <asp:TextBox ID="txtCodigo" runat="server" CssClass="txt" Width="100%" ></asp:TextBox>
            </td>
            <td width="33%">
                <asp:Button ID="btnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                    onclick="btnBuscar_Click" />
            </td>
        </tr>
        <tr>
            <td align="right" width="33%">
                &nbsp;</td>
            <td align="center" class="style2">
                &nbsp;</td>
            <td width="33%">
                <asp:Button ID="btnLimpiar" runat="server" CssClass="btns" Text="Limpiar" 
                    onclick="btnLimpiar_Click" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3" style="width: 66%">
            <hr />
            </td>
        </tr>
        <tr>
            <td align="right" width="33%">
                <asp:Label ID="Label3" runat="server" Text="Pais:"></asp:Label>
            </td>
            <td align="center" class="style2">
                <asp:DropDownList ID="ddlPais" runat="server" CssClass="txt" Width="100%" 
                    Enabled="False">
                    <asp:ListItem>Uruguay</asp:ListItem>
                    <asp:ListItem>Argentina</asp:ListItem>
                    <asp:ListItem>Brasil</asp:ListItem>
                    <asp:ListItem>Paraguay</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="33%">
                <asp:Label ID="Label4" runat="server" Text="Ciudad:"></asp:Label>
            </td>
            <td align="center" class="style2">
                <asp:TextBox ID="txtCiudad" runat="server" CssClass="txt" Width="100%" 
                    Enabled="False" ></asp:TextBox>
            </td>
            <td width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="33%" rowspan="2" valign="top">
                <asp:Label ID="Label5" runat="server" Text="Facilidades de la Terminal:"></asp:Label>
            </td>
            <td align="center" class="style2" rowspan="2">
                <asp:ListBox ID="lstFacilidad" runat="server" Width="100%" CssClass="txt" 
                    Font-Names="Segoe UI" Height="100px" Enabled="False">
                </asp:ListBox>
                <br />
                <asp:TextBox ID="txtFacilidad" runat="server" CssClass="txt" Width="100%" 
                    placeholder="Servicio" Enabled="False"></asp:TextBox>
            </td>
            <td width="33%" height="100px">
                <asp:Button ID="btnBorraFacilidad" runat="server" CssClass="btnQ" Height="100%" Text="x" 
                    Width="15%" onclick="btnBorraFacilidad_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td width="33%">
                <asp:Button ID="btnAgregaFacilidad" runat="server" CssClass="btnA" 
                    Height="100%" Text="+" 
                    Width="15%" onclick="btnAgregaFacilidad_Click" />
            </td>
        </tr>
        <tr>
            <td align="right" width="33%">
                &nbsp;</td>
            <td align="center" class="style2">
                &nbsp;</td>
            <td width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="33%">
                <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                    Enabled="False" onclick="btnEliminar_Click" />
            </td>
            <td align="center" class="style2">
                <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                    Enabled="False" onclick="btnModificar_Click" />
            </td>
            <td width="33%">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                    Enabled="False" onclick="btnAgregar_Click" />
            </td>
        </tr>
        <tr>
            <td align="right" width="33%">
                &nbsp;</td>
            <td align="center" class="style2">
                &nbsp;</td>
            <td width="33%">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

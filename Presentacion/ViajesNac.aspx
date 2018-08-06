<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ViajesNac.aspx.cs" Inherits="Presentacion.ViajesNac" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="style1" width="100%">
        <tr>
            <td colspan="3" style="text-align: center">
                <asp:Label ID="lblTitle" runat="server" CssClass="title" 
                    Text="Viajes Nacionales"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center">
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style22" width="33%" align="center">
                &nbsp;</td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style22" align="right" width="33%">
                <asp:Label ID="lblNum" runat="server" Text="Número"></asp:Label>
            </td>
            <td class="style22" width="33%" align="center">
                <asp:TextBox ID="txtNum" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                <asp:Button ID="btnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                    onclick="btnBuscar_Click" />
            </td>
        </tr>
        <tr>
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style22" width="33%" align="center">
                &nbsp;</td>
            <td class="style12" width="33%">
                <asp:Button ID="btnLimpiar" runat="server" CssClass="btns" 
                    onclick="btnLimpiar_Click" Text="Limpiar" />
            </td>
        </tr>
        <tr>
            <td class="style4" colspan="3" align="center">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblCom" runat="server" Text="Compañia"></asp:Label>
            </td>
            <td class="style4" width="33%" align="center">
                <asp:TextBox ID="txtCompania" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" align="right" width="33%">
                <asp:Label ID="lblDestino" runat="server" Text="Destino"></asp:Label>
            </td>
            <td class="style2" width="33%" align="center">
                <asp:TextBox ID="txtTerminal" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style2" width="33%">
            </td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblFPart" runat="server" style="text-align: left" 
                    Text="Fecha de Partida"></asp:Label>
            </td>
            <td class="style4" width="33%" align="center">
                <asp:TextBox ID="txtFechaPartida" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblFarribo" runat="server" Text="Fecha de Arribo"></asp:Label>
            </td>
            <td class="style4" width="33%" align="center">
                <asp:TextBox ID="txtFechaArribo" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblCAsientos" runat="server" Text="Cantidad de Asientos"></asp:Label>
            </td>
            <td class="style4" width="33%" align="center">
                <asp:TextBox ID="txtCantidadAsientos" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblDoc" runat="server" Text="Paradas Intermedias"></asp:Label>
            </td>
            <td class="style4" width="33%" align="center">
                <asp:DropDownList ID="ddParadas" runat="server" Height="40px" Width="100%" 
                    CssClass="txt">
                    <asp:ListItem Value="0"></asp:ListItem>
                    <asp:ListItem Value="1"></asp:ListItem>
                    <asp:ListItem Value="2"></asp:ListItem>
                    <asp:ListItem Value="3"></asp:ListItem>
                    <asp:ListItem Value="4"></asp:ListItem>
                    <asp:ListItem Value="5"></asp:ListItem>
                    <asp:ListItem Value="6"></asp:ListItem>
                    <asp:ListItem Value="7"></asp:ListItem>
                    <asp:ListItem Value="8"></asp:ListItem>
                    <asp:ListItem Value="9"></asp:ListItem>
                    <asp:ListItem Value="10"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                &nbsp;</td>
            <td class="style4" width="33%" align="center">
                &nbsp;</td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style10" colspan="3" align="center">
            </td>
        </tr>
        <tr>
            <td class="style22" align="right">
                <asp:Button ID="btnEliminar" runat="server" CssClass="btns" Text="Eliminar" 
                    onclick="btnEliminar_Click" />
            </td>
            <td class="style22" align="center">
                <asp:Button ID="btnModificar" runat="server" CssClass="btns" Text="Modificar" 
                    onclick="btnModificar_Click" />
            </td>
            <td class="style12">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btns" Text="Agregar" 
                    onclick="btnAgregar_Click" />
            </td>
        </tr>
        <tr>
            <td class="style22" align="right">
                &nbsp;</td>
            <td class="style22" align="center">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .style1
        {
            height: 32px;
        }
        .style2
        {
            height: 47px;
        }
    </style>
</asp:Content>


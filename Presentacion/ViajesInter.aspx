<%@ Page Title="" Language="C#" MasterPageFile="~/MPempleado.Master" AutoEventWireup="true" CodeBehind="ViajesInter.aspx.cs" Inherits="Presentacion.ViajesInter" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style12" align="left" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style22" align="right" width="33%">
                <asp:Label ID="lblNum" runat="server" Text="Número"></asp:Label>
            </td>
            <td class="style22" align="right" width="33%">
                <asp:TextBox ID="txtNum" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" align="left" width="33%">
                <asp:Button ID="btnBuscar" runat="server" CssClass="btns" Text="Buscar" 
                    onclick="btnBuscar_Click" />
            </td>
        </tr>
        <tr>
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style22" align="right" width="33%">
                &nbsp;</td>
            <td class="style12" align="left" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" colspan="3">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblCom" runat="server" Text="Compañia"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtCompania" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblDestino" runat="server" Text="Destino"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtTerminal" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblFPart" runat="server" style="text-align: left" 
                    Text="Fecha de Partida dd/mm/aaaa hh:mm(24hrs)"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtFechaPartida" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblFarribo" runat="server" 
                    Text="Fecha de Arribo dd/mm/aaaa hh:mm(24hrs)"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtFechaArribo" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblCAsientos" runat="server" Text="Cantidad de Asientos"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtCantidadAsientos" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblUltEmpleado" runat="server" Text="Último Empleado"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtEmpleado" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblDoc" runat="server" Text="Documentación"></asp:Label>
            </td>
            <td class="style4" align="center" width="33%">
                <asp:TextBox ID="txtDocumentacion" runat="server" CssClass="txt"></asp:TextBox>
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                <asp:Label ID="lblSB" runat="server" Text="Servicio a Bordo"></asp:Label>
            </td>
            <td class="style4" align="left" width="33%">
                <asp:CheckBox ID="chkServicioBordo" runat="server" />
            </td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" align="right" width="33%">
                &nbsp;</td>
            <td class="style4" align="left" width="33%">
                &nbsp;</td>
            <td class="style12" width="33%">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style10" colspan="3">
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
    </table>
</asp:Content>

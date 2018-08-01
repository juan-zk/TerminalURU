<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsultaDeViajes.aspx.cs" Inherits="ConsultaDeViajes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/estilos.css" type="text/css" rel="Stylesheet" />
    <title>Consulta de Viajes</title>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        <asp:Panel ID="Panel1" runat="server" CssClass="navegacion">
            aca hay que poner algo</asp:Panel>
        <table class="tablaForm">
            <tr>
                <td align="center" colspan="5">
                    <asp:Label ID="lblMsj" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="5">
                    <asp:Repeater ID="rptrViajes" runat="server" 
                        onitemcommand="rptrViajes_ItemCommand">
                     <ItemTemplate>
                        <table width="100%">
                            <tr bgcolor="#e2e2e2" class="item">
                                <td> Número:<asp:TextBox ID="txtNumero" runat="server" CssClass="txt" Text = '<%# Bind("_NumViaje") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Compañia:<asp:TextBox ID="txtCompania" runat="server" CssClass="txt" Text = '<%# Bind("_Com._Nombre") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Partida:<asp:TextBox ID="txtPartida" runat="server" CssClass="txt" Text = '<%# Bind("_FechaPartida") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Llegada:<asp:TextBox ID="txtLlegada" runat="server" CssClass="txt" Text = '<%# Bind("_FechaArribo") %>' Enabled="False"></asp:TextBox> </td>
                                <td> <asp:Button ID="btnVerViaje" runat="server" CommandName="VerViaje" Text="Ver Viaje" CssClass="btns" Width="100px" /> </td>
                              </tr>
                        </table>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <table width="100%">
                            <tr bgcolor="#fff" class="item">
                                <td> Número:<asp:TextBox ID="txtNumero" runat="server" CssClass="txt" Text = '<%# Bind("_NumViaje") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Compañia:<asp:TextBox ID="txtCompania" runat="server" CssClass="txt" Text = '<%# Bind("_Com._Nombre") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Partida:<asp:TextBox ID="txtPartida" runat="server" CssClass="txt" Text = '<%# Bind("_FechaPartida") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Llegada:<asp:TextBox ID="txtLlegada" runat="server" CssClass="txt" Text = '<%# Bind("_FechaArribo") %>' Enabled="False"></asp:TextBox> </td>
                                <td> <asp:Button ID="btnVerViaje" runat="server" CommandName="VerViaje" Text="Ver Viaje" CssClass="btns" Width="100px" /> </td>
                           </tr>
                        </table>
                    </AlternatingItemTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            </table>
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsultaDeViajes.aspx.cs" Inherits="ConsultaDeViajes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/estilos.css" type="text/css" rel="Stylesheet" />
    <title>Consulta de Viajes</title>
    <style type="text/css">
        .style1
        {
            height: 32px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        <asp:Panel ID="Panel1" runat="server" CssClass="navegacion" Height="40px">
        <table>
            <tr>
                <td align="center" height="40px" valign="middle" width="100%">
                    <asp:Label ID="Label4" runat="server" Font-Size="Large" 
                        Text="Consulta de Viajes" Font-Bold="True"></asp:Label>
                </td>
            </tr>
        </table>
        
        </asp:Panel>
        <table class="tablaForm">
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lblMsj" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="50%">
                    <asp:Label ID="Label1" runat="server" Text="Filtrar por:"></asp:Label>
                </td>
                <td align="center" colspan="2">
                    <asp:Label ID="Label5" runat="server" Text="Filtrar por rango de fechas:"></asp:Label>
                    <asp:CheckBox ID="chkPorFecha" runat="server" AutoPostBack="True" 
                        oncheckedchanged="chkPorFecha_CheckedChanged" />
                </td>
            </tr>
            <tr>
                <td width="50%">
                    &nbsp;</td>
                <td align="center">
                    Partida:</td>
                <td align="center">
                    LLegada:</td>
            </tr>
            <tr>
                <td class="style1" width="50%">
                    <asp:Label ID="Label2" runat="server" Text="Destino:"></asp:Label>
                    <asp:DropDownList ID="ddlDestino" runat="server" CssClass="txt">
                        <asp:ListItem>Seleccione uno</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td rowspan="6" align="center">
                    <asp:Calendar ID="calPartida" runat="server" Height="200px" Width="200px" 
                        Enabled="False">
                    </asp:Calendar>
                </td>
                <td rowspan="6" align="center">
                    <asp:Calendar ID="calLLegada" runat="server" Height="200px" Width="200px" 
                        Enabled="False">
                    </asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="style1" width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style1" width="50%">
                    <asp:Label ID="Label3" runat="server" Text="Compañia:"></asp:Label>
                    <asp:DropDownList ID="ddlCompania" runat="server" CssClass="txt">
                        <asp:ListItem>Seleccione una</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1" width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="50%">
                    <asp:Button ID="btnAplicar" runat="server" CssClass="btns" 
                        Text="Aplicar Filtro" onclick="btnAplicar_Click" />
&nbsp;<asp:Button ID="btnQuitar" runat="server" CssClass="btns" Text="Quitar todos los filtros" 
                        onclick="btnQuitar_Click" />
                </td>
            </tr>
            <tr>
                <td width="50%">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Repeater ID="rptrViajes" runat="server" 
                        onitemcommand="rptrViajes_ItemCommand">
                     <ItemTemplate>
                        <table width="100%">
                            <tr bgcolor="#e2e2e2" class="item">
                                <td> Número:<asp:TextBox ID="txtNumero" Width="50px" runat="server" CssClass="txt" Text = '<%# Bind("_NumViaje") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Compañia:<asp:TextBox ID="txtCompania" runat="server" CssClass="txt" Text = '<%# Bind("_Com._Nombre") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Partida:<asp:TextBox ID="txtPartida" runat="server" CssClass="txt" Text = '<%# Bind("_FechaPartida") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Llegada:<asp:TextBox ID="txtLlegada" runat="server" CssClass="txt" Text = '<%# Bind("_FechaArribo") %>' Enabled="False"></asp:TextBox> </td>                                
                                <td> Destino:<asp:TextBox ID="TextBox1" runat="server" CssClass="txt" Text = '<%# Bind("_Ter._Destino") %>' Enabled="False"></asp:TextBox> </td>
                                <td> <asp:Button ID="btnVerViaje" runat="server" CommandName="VerViaje" Text="Ver Viaje" CssClass="btns" Width="100px" /> </td>
                              </tr>
                        </table>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <table width="100%">
                            <tr bgcolor="#fff" class="item">
                                <td> Número:<asp:TextBox ID="txtNumero" Width="50px" runat="server" CssClass="txt" Text = '<%# Bind("_NumViaje") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Compañia:<asp:TextBox ID="txtCompania" runat="server" CssClass="txt" Text = '<%# Bind("_Com._Nombre") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Partida:<asp:TextBox ID="txtPartida" runat="server" CssClass="txt" Text = '<%# Bind("_FechaPartida") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Llegada:<asp:TextBox ID="txtLlegada" runat="server" CssClass="txt" Text = '<%# Bind("_FechaArribo") %>' Enabled="False"></asp:TextBox> </td>
                                <td> Destino:<asp:TextBox ID="TextBox1" runat="server" CssClass="txt" Text = '<%# Bind("_Ter._Destino") %>' Enabled="False"></asp:TextBox> </td>
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

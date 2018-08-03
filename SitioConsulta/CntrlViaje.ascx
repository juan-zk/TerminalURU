<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CntrlViaje.ascx.cs" Inherits="CntrlViaje" %>
<style type="text/css">
    .style2
    {
        margin: -30px auto;
        padding: 0;
        width: 718px;
        background: #fff;
    }
    .style8
    {
        text-align: left;
    }
.title
{
    font-size: 20px;
    font-family: Arial;
    color: #415C71;
}
.btns
{
    color: White;
    background: #4ebaab;
    width: 230px;
    height: 40px;
    font-weight:bold;
    font-size: 15px;
    border: 0;
    border-radius: 4px;
}
    .style11
    {
        width: 712px;
    }
.subtitle
{
    color: #4ebaab;
    font-weight: bold;
    font-size: 17px;
    font-family: Arial;
    padding: 7px;
}
    .style17
    {
        text-align: justify;
    }
.txt {
    border:2px solid #deebf2;
    border-radius:4px;
    margin: 2px 0;
    outline: none;
    padding: 8px;
    box-sizing: border-box;
    transition: .3s;
    width: 200px;
}
</style>
        <table class="style2">
            <tr>
                <td class="style8">
                    &nbsp;</td>
            </tr>
            <tr>
                <td bgcolor="#415C71" class="style8" height="35px">
                    &nbsp;
                    &nbsp;
                    <asp:Label ID="lblTitle" runat="server" CssClass="title" ForeColor="White" 
                        Text="Consulta Individual de Viaje"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style8">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style8">
                    <asp:Label ID="lblMsj" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style8">
                    <asp:Button ID="btnVolver" runat="server" CssClass="btns" 
                        onclick="Button1_Click" Text="Volver" />
                    &nbsp;
                    &nbsp;
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style8">
                    <table class="style11">
                        <tr>
                            <td bgcolor="#415C71" colspan="6" height="35px" style="text-align: left">
                                <asp:Label ID="lblViaje" runat="server" CssClass="subtitle" Font-Bold="True" 
                                    Text="Datos Viaje"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17" colspan="6">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblNumero" runat="server" Text="Número"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtNumero" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblTerminal" runat="server" Text="Terminal"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtTerminal" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblArribo" runat="server" Text="Fecha de Arribo"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtFechaArribo" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblCompania" runat="server" Text="Compañia"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtCompania" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblPartida" runat="server" Text="Fecha de Partida"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtFechaPartida" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblAsientos" runat="server" Text="Asientos"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtAsientos" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblEmpleado" runat="server" Text="Empleado"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtEmpleado" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblServicio" runat="server" Text="Servicio a Bordo" 
                                    Visible="False"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:CheckBox ID="chkServicio" runat="server" Visible="False" />
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblDocumentacion" runat="server" Text="Documentación" 
                                    Visible="False"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtDocumentacion" runat="server" CssClass="txt" 
                                    Visible="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblParadas" runat="server" Text="Paradas Intermedias" 
                                    Visible="False"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtParadas" runat="server" CssClass="txt" Visible="False"></asp:TextBox>
                            </td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td bgcolor="#415C71" class="style17" colspan="6" height="35px">
                                <asp:Label ID="Label10" runat="server" CssClass="subtitle" 
                                    Text="Datos Compañia"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblDir" runat="server" Text="Dirección"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtDireccion" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblTel" runat="server" Text="Teléfono"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td bgcolor="#415C71" class="style17" colspan="6" height="35px">
                                <asp:Label ID="Label14" runat="server" CssClass="subtitle" 
                                    Text="Datos Terminal"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblCodigo" runat="server" Text="Código"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtCodigo" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblCiudad" runat="server" Text="Ciudad"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtCiudad" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                            <td class="style17">
                                <asp:Label ID="lblPais" runat="server" Text="País"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:TextBox ID="txtPais" runat="server" CssClass="txt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style17">
                                <asp:Label ID="lblFacilidades" runat="server" Text="Facilidades"></asp:Label>
                            </td>
                            <td class="style17">
                                <asp:ListBox ID="lstFacilidades" runat="server" CssClass="txt"></asp:ListBox>
                            </td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                            <td class="style17">
                                &nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    

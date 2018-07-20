<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Presentacion.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/estilos.css" type="text/css" rel="Stylesheet" />
    <title>Terminal URU</title>
    <style type="text/css">
        .style1
        {
            height: 70px;
        }
        .style2
        {
            height: 69px;
        }
        .style3
        {
            height: 75px;
        }
    </style>
</head>
<body bgcolor="#f7f7f7">
    <form id="form1" runat="server">
    <div align="center">
    
        <br />
        <br />
        <br />
        <asp:Login ID="Login1" runat="server" BackColor="#FFFFFF" BorderColor="Silver" 
            BorderPadding="0" BorderStyle="Solid" BorderWidth="0px" 
            CreateUserText="Registrarse" Font-Names="Century Gothic" Font-Size="Small" 
            ForeColor="#003366" Height="500px" LoginButtonText="Login" 
            RememberMeText="Recordar usuario" TitleText="TerminalURU Login" 
            UserNameLabelText="Usuario:" Width="350px" 
            onauthenticate="Login1_Authenticate">
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <LayoutTemplate>
                <table cellpadding="0" cellspacing="0" 
                    style="border-collapse:collapse; width: 411px; height: 500px;">
                    <tr>
                        <td>
                            <table cellpadding="0" style="height:501px; width:452px;">
                                <tr>
                                    <td align="center" 
                                        
                                        
                                        style="color:White;background-color:#415C71;font-size:Medium;font-weight:bold;" 
                                        class="style3">
                                        TerminalURU Login</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:TextBox ID="UserName" runat="server" Font-Size="Small" Width="90%" placeholder="Usuario" 
                                            CssClass="txt"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:TextBox ID="Password" runat="server" Font-Size="Small" TextMode="Password" 
                                            Width="90%" placeholder="Contraseña" CssClass="txt"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Recordar usuario" 
                                            Font-Bold="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="color:Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="style1">
                                        <asp:Button ID="LoginButton" runat="server" 
                                            CommandName="Login" Text="Login" ValidationGroup="Login1"  
                                            CssClass="btnLogueo" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:HyperLink ID="CreateUserLink" runat="server" Font-Bold="False">Registrarse</asp:HyperLink>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" 
                BorderWidth="1px" Font-Bold="True" Font-Names="Century Gothic" 
                Font-Size="Medium" ForeColor="#284E98" Width="100%" />
            <TextBoxStyle Font-Size="0.8em" />
            <TitleTextStyle BackColor="#415C71" Font-Bold="True" Font-Size="Medium" 
                ForeColor="White" HorizontalAlign="Center" Wrap="True" />
        </asp:Login>
        <br />
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>

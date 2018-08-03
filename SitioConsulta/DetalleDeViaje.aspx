<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetalleDeViaje.aspx.cs" Inherits="DetalleDeViaje" %>

<%@ Register src="CntrlViaje.ascx" tagname="CntrlViaje" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <link href="css/estilos.css" type="text/css" rel="Stylesheet" />
    <title>Detalle de viaje</title>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        <uc1:CntrlViaje ID="CntrlViaje1" runat="server" />
    </div>
    </form>
</body>
</html>


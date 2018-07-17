using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaEmpleado
    {
        Empleado Logueo(string pUsuario, string pPass);
    }
}

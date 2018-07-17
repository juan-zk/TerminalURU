using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaEmpleado : ILogicaEmpleado
    {
         //singleton
        private static LogicaEmpleado _instancia = null;
        private LogicaEmpleado() { }
        public static LogicaEmpleado GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaEmpleado();
            return _instancia;
        }

        public Empleado Logueo(string pUsuario, string pPass) {
            return FabricaPersistencia.GetPersistenciaEmpleado().Logueo(pUsuario,pPass);
        }
    }
}

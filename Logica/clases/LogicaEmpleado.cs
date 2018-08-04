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

        public Empleado Buscar(string pCedula)
        { return FabricaPersistencia.GetPersistenciaEmpleado().Buscar(pCedula); }

        public Empleado BuscarParaViaje(string pCedula)
        { return FabricaPersistencia.GetPersistenciaEmpleado().BuscarParaViaje(pCedula); }

        public void Agregar(Empleado pEmp)
        {
            FabricaPersistencia.GetPersistenciaEmpleado().Agregar(pEmp);
        }

        public void Modificar(Empleado pEmp)
        {
            FabricaPersistencia.GetPersistenciaEmpleado().Modificar(pEmp);
        }
        
        public void Borrar(string pCedula)
        {
            FabricaPersistencia.GetPersistenciaEmpleado().Borrar(pCedula);
        }
    }
}

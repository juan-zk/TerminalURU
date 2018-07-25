using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica 
{
    internal class LogicaCompania: ILogicaCompania
    {
         //singleton
        private static LogicaCompania _instancia = null;
        private LogicaCompania() { }
        public static LogicaCompania GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaCompania();
            return _instancia;
        }

        public Compañia Buscar(string pNombre) {
            return FabricaPersistencia.GetPersistenciaCompania().Buscar(pNombre);
        }
        public void Agregar(Compañia pComp)
        {
            FabricaPersistencia.GetPersistenciaCompania().Agregar(pComp);
        }
        public void Modificar(Compañia pComp)
        {
            FabricaPersistencia.GetPersistenciaCompania().Modificar(pComp);
        }
    }
}

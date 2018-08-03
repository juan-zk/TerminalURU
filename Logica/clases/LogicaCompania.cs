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

        public Compania Buscar(string pNombre) {
            return FabricaPersistencia.GetPersistenciaCompania().Buscar(pNombre);
        }
        public void Agregar(Compania pComp)
        {
            FabricaPersistencia.GetPersistenciaCompania().Agregar(pComp);
        }
        public void Modificar(Compania pComp)
        {
            FabricaPersistencia.GetPersistenciaCompania().Modificar(pComp);
        }
        public void Eliminar(Compania pComp)
        {
            FabricaPersistencia.GetPersistenciaCompania().Eliminar(pComp);
        }
        public List<Compania> Listar()
        {
            return FabricaPersistencia.GetPersistenciaCompania().Listar();
        }
    }
}

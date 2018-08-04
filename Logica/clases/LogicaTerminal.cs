using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaTerminal:ILogicaTerminal
    {
        //singleton
        public static LogicaTerminal _instancia = null;
        public LogicaTerminal() { }
        public static LogicaTerminal GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaTerminal();
            return _instancia;
        }

        public void Agregar(Terminal t) 
        {
            FabricaPersistencia.GetPersistenciaTerminal().Agregar(t);
        }
        public void Modificar(Terminal t)
        {
            FabricaPersistencia.GetPersistenciaTerminal().Modificar(t);
        }
        public void Eliminar(Terminal t)
        {
            FabricaPersistencia.GetPersistenciaTerminal().Eliminar(t);
        }
        public Terminal Buscar(string pCodigo)
        {
            return FabricaPersistencia.GetPersistenciaTerminal().Buscar(pCodigo);
        }

        public Terminal BuscarParaViaje(string pCodigo)
        {
            return FabricaPersistencia.GetPersistenciaTerminal().BuscarParaViaje(pCodigo);
        }

        public List<Terminal> Listar()
        {
            return FabricaPersistencia.GetPersistenciaTerminal().Listar();
        }

    }
}

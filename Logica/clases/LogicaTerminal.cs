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
            
        }

    }
}

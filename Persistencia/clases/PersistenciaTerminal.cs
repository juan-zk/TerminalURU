using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistencia
{
    internal class PersistenciaTerminal
    {
        //singleton
        public static PersistenciaTerminal _instancia = null;
        public PersistenciaTerminal() { }
        public static PersistenciaTerminal GetInsancia() 
        {
            if (_instancia == null)
                _instancia = new PersistenciaTerminal();
            return _instancia;
        }


    }
}

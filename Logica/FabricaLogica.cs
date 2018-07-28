using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Logica
{
    public class FabricaLogica
    {
        public static ILogicaEmpleado GetLogicaEmpleado() {
            return (LogicaEmpleado.GetInstancia());
        }

        public static ILogicaCompania GetLogicaCompania()
        {
            return (LogicaCompania.GetInstancia());
        }

        public static ILogicaViaje GetLogicaViajes()
        {
            return (LogicaViaje.GetInstancia());
        }

        public static ILogicaTerminal GetLogicaTerminales()
        {
            return (LogicaTerminal.GetInstancia());
        }
        
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistencia
{
    public class FabricaPersistencia
    {
        public static IPersistenciaEmpleado GetPersistenciaEmpleado() {
            return (PersistenciaEmpleado.GetInstancia());
        }
        public static IPersistenciaCompania GetPersistenciaCompania()
        {
            return (PersistenciaCompania.GetInstancia());
        }
        public static IPersistenciaViajeInternacional GetPersistenciaViajeInternacional()
        {
            return (PersistenciaViajeInternacional.GetInstancia());
        }
      
        public static IPersistenciaViajeNacional GetPersistenciaViajeNacional()
        { 
            return (PersistenciaViajeNacional.GetInstancia()); 
        }
        
        public static IPersistenciaTerminal GetPersistenciaTerminal()
        {
            return (PersistenciaTerminal.GetInstancia());
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Persistencia;

namespace Logica
{
    internal class LogicaViaje: ILogicaViaje
    {
        //singleton
        private static LogicaViaje _instancia = null;
        private LogicaViaje() { }
        public static LogicaViaje GetInstancia()
        {
            if (_instancia == null)
                _instancia = new LogicaViaje();
            return _instancia;
        }

        public ViajesInternacionales Buscar(int pNumero) {
            return FabricaPersistencia.GetPersistenciaViajeInternacional().Buscar(pNumero);
        }

        public void Modificar(ViajesInternacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeInternacional().Modificar(pViaje);
        }

        public void Eliminar(ViajesInternacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeInternacional().Eliminar(pViaje);
        }

        public void Agregar(ViajesInternacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeInternacional().Agregar(pViaje);
        }
    }
}

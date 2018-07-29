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

       // VIAJES NACIONALES
        
        public ViajesNacionales BuscarViaje(int pNumero)
        { 
            return FabricaPersistencia.GetPersistenciaViajeNacional().BuscarViaje(pNumero); 
        }

        public void AgregarViaje(ViajesNacionales pViaje)
        { 
            FabricaPersistencia.GetPersistenciaViajeNacional().AgregarViaje(pViaje); 
        }

        public void ModificarViaje(ViajesNacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeNacional().ModificarViaje(pViaje);
        }

        public void EliminarViaje(ViajesNacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeNacional().EliminarViaje(pViaje);
        }
    }
}

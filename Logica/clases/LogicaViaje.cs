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

        public List<ViajesInternacionales> Listar()
        {
            return FabricaPersistencia.GetPersistenciaViajeInternacional().Listar();
        }

        public void Modificar(ViajesInternacionales pViaje)
        {
            var list = Listar();
            TimeSpan dif;

            if(pViaje._FechaArribo<=pViaje._FechaPartida)
            {
                throw new Exception("La fecha de arribo debe ser posterior a la fecha de partida");
            }
            foreach (ViajesInternacionales vi in list)
            {
                if (vi._NumViaje != pViaje._NumViaje && vi._Ter._Codigo == pViaje._Ter._Codigo && vi._FechaPartida.Date == pViaje._FechaPartida.Date)
                {
                    dif = vi._FechaPartida.TimeOfDay.Subtract(pViaje._FechaPartida.TimeOfDay);
                    if (dif.TotalHours < 2 && dif.TotalHours > -2)
                        throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia.");
                }
            }
            FabricaPersistencia.GetPersistenciaViajeInternacional().Modificar(pViaje);
        }

        public void Eliminar(ViajesInternacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeInternacional().Eliminar(pViaje);
        }

        public void Agregar(ViajesInternacionales pViaje)
        {
            var list = Listar();
            TimeSpan dif;
            if (pViaje._FechaArribo < DateTime.Now || pViaje._FechaPartida < DateTime.Now)
            {
                throw new Exception("La fecha de arribo y de partida deben ser posteriores a la fecha actual");
            }
            if(pViaje._FechaArribo<=pViaje._FechaPartida)
            {
                throw new Exception("La fecha de arribo debe ser posterior a la fecha de partida");
            }
            foreach (ViajesInternacionales vi in list)
            {
                if (vi._Ter._Codigo == pViaje._Ter._Codigo && vi._FechaPartida.Date == pViaje._FechaPartida.Date)
                {
                    dif = vi._FechaPartida.TimeOfDay.Subtract(pViaje._FechaPartida.TimeOfDay);
                    if(dif.TotalHours<2 && dif.TotalHours>-2)
                    throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia.");
                }
            }

            FabricaPersistencia.GetPersistenciaViajeInternacional().Agregar(pViaje);
        }

       // VIAJES NACIONALES
        
        public ViajesNacionales BuscarViaje(int pNumero)
        { 
            return FabricaPersistencia.GetPersistenciaViajeNacional().BuscarViaje(pNumero); 
        }
        
        public void Agregar(ViajesNacionales pViaje)
        {
            var list = ListarViaje();
            TimeSpan dif;
            if (pViaje._FechaArribo < DateTime.Now || pViaje._FechaPartida < DateTime.Now)
            {
                throw new Exception("La fecha de arribo y de partida deben ser posteriores a la fecha actual");
            }
            if(pViaje._FechaArribo<=pViaje._FechaPartida)
            {
                throw new Exception("La fecha de arribo debe ser posterior a la fecha de partida");
            }
            foreach (ViajesNacionales vi in list)
            {
                if (vi._Ter._Codigo == pViaje._Ter._Codigo && vi._FechaPartida.Date == pViaje._FechaPartida.Date)
                {
                    dif = vi._FechaPartida.TimeOfDay.Subtract(pViaje._FechaPartida.TimeOfDay);
                    if (dif.TotalHours < 2 && dif.TotalHours > -2)
                        throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia.");
                }
            }

            FabricaPersistencia.GetPersistenciaViajeNacional().AgregarViaje(pViaje); 
        }

        public void Modificar(ViajesNacionales pViaje)
        {
            var list = ListarViaje();
            TimeSpan dif;

            if(pViaje._FechaArribo<=pViaje._FechaPartida)
            {
                throw new Exception("La fecha de arribo debe ser posterior a la fecha de partida");
            }
       
            foreach (ViajesNacionales vi in list)
            {
                if (vi._NumViaje!=pViaje._NumViaje && vi._Ter._Codigo == pViaje._Ter._Codigo && vi._FechaPartida.Date == pViaje._FechaPartida.Date)
                {
                    dif = vi._FechaPartida.TimeOfDay.Subtract(pViaje._FechaPartida.TimeOfDay);
                    if (dif.TotalHours < 2 && dif.TotalHours > -2)
                        throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia.");
                }
            }
            FabricaPersistencia.GetPersistenciaViajeNacional().ModificarViaje(pViaje);
        }

        public void Eliminar(ViajesNacionales pViaje)
        {
            FabricaPersistencia.GetPersistenciaViajeNacional().EliminarViaje(pViaje);
        }


        public List<ViajesNacionales> ListarViaje()
        {
            return FabricaPersistencia.GetPersistenciaViajeNacional().ListarViaje();
        }

    }
}

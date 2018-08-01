using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
   public interface IPersistenciaViajeNacional
    {
       ViajesNacionales BuscarViaje(int pNumero);

       void ModificarViaje(ViajesNacionales pViaje);

       void EliminarViaje(ViajesNacionales pViaje);

       void AgregarViaje(ViajesNacionales pViaje);

       List<ViajesNacionales> ListarViaje();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILogicaViaje
    {
        ViajesInternacionales Buscar(int pNumero);

        List<ViajesInternacionales> Listar();

        void Modificar(ViajesInternacionales pViaje);

        void Eliminar(ViajesInternacionales pViaje);

        void Agregar(ViajesInternacionales pViaje);

        //  VIAJES NACIONALES

        ViajesNacionales BuscarViaje(int pNumero);
        
        void Modificar(ViajesNacionales pViaje);
        
        void Agregar(ViajesNacionales pViaje);         

        void Eliminar(ViajesNacionales pViaje);
    }
}

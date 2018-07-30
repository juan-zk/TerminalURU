﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaViajeInternacional
    {
        ViajesInternacionales Buscar(int pNumero);

        void Modificar(ViajesInternacionales pViaje);

        void Eliminar(ViajesInternacionales pViaje);

        void Agregar(ViajesInternacionales pViaje);

        List<ViajesInternacionales> Listar();


    }
}

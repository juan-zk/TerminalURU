using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaCompania
    {
        Compañia Buscar(string pNombre);

        void Agregar(Compañia pComp);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILogicaCompania
    {
        Compañia Buscar(string pNombre);

        void Agregar(Compañia pComp);
    }
}

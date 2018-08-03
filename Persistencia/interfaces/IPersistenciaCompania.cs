using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaCompania
    {
        Compania Buscar(string pNombre);

        void Agregar(Compania pComp);

        void Modificar(Compania pComp);

        void Eliminar(Compania pComp);

        List<Compania> Listar();
    }
}

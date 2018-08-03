using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaTerminal
    {
        void Agregar(Terminal t);
        void Eliminar(Terminal t);
        void Modificar(Terminal t);
        Terminal Buscar(string cod);
        List<Terminal> Listar();

    }
}

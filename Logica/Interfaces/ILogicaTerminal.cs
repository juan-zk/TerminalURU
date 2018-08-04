using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Logica
{
    public interface ILogicaTerminal
    {
        Terminal Buscar(string pCodigo);

        Terminal BuscarParaViaje(string pCodigo);

        void Agregar(Terminal pTerminal);

        void Eliminar(Terminal pTerminal);

        void Modificar(Terminal pTerminal);

        List<Terminal> Listar();
    }
}

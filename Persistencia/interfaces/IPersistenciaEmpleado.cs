using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    public interface IPersistenciaEmpleado
    {
        Empleado Logueo(string pUsuario, string pPass);

        Empleado Buscar(string pCedula);

        Empleado BuscarParaViaje(string pCedula);

        void Agregar(Empleado pEmp);

        void Modificar(Empleado pEmp);

        void Borrar(string pCedula);
    }
}

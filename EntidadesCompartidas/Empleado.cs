using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class Empleado
    {
       // Atributos
       private string Cedula;
       private string Contraseña;
       private string NombreCompleto;
       
      
       // Propiedades
       public string _Cedula
       {
           get { return Cedula; }
           set
           {
               long parse;
               if ((value.Length == 8) && (Int64.TryParse(value, out parse) == true))
                   Cedula = value;
               else
                   throw new Exception("La cedula debe incluir digito verificador y debe tener formato numerico. ");
           }
       }

       public string _Contraseña
       {
           get { return Contraseña; }
           set 
           {
               if (value.Length > 6)
                    Contraseña = value;
               else
                   throw new Exception("La contraseña debe tener al menos 6 caracteres");
           }
       }

       public string _NombreCompleto
       {
           get { return NombreCompleto; }
           set 
           {
               if (value.Length > 0)
                    NombreCompleto = value;
               else
                   throw new Exception("El nombre completo del empleado no puede ser vacio.");
           }
       }

       // Constructor
       public Empleado(string pCedula, string pContraseña, string pNombreCompleto)
       {
           _Cedula = pCedula;
           _Contraseña = pContraseña;
           _NombreCompleto = pNombreCompleto;
       }
    }
}

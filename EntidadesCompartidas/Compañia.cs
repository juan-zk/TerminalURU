using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class Compañia
    {
       // Atributos 
       private string Nombre;
       private string Direccion;
       private string Telefono;

       // Propiedades
       public string _Nombre
       {
           get { return Nombre; }
           set
           {
               if (value.Length > 0)
                    Nombre = value;
               else
                   throw new Exception("El nombre no puede ser vacio.");
           }
       }

       public string _Direccion
       {
           get { return Direccion; }
           set
           {
               if (value.Length > 0)
                    Direccion = value;
               else
                   throw new Exception("La direccion no puede ser vacia.");
           }
       }

       public string _Telefono
       {
           get { return Telefono; }
           set
           {
               if (value.Length > 0)
                   Telefono = value;
               else
                   throw new Exception("El telefono no puede ser vacio.");
           }
       }

       // Constructor
       public Compañia(string pNombre, string pDireccion, string pTelefono)
       {
           _Nombre = pNombre;
           _Direccion = pDireccion;
           _Telefono = pTelefono;
       }
    }
}

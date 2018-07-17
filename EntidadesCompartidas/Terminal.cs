using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class Terminal
    {
       //Atributos 
       private string Codigo;
       private string Ciudad;
       private string Pais;
       private List<string> Facilidades;
       private int parse;

       // Propiedades 
       public string _Codigo
       {
           get { return Codigo; }
           set
           {
               if ((value.Length == 3) && (Int32.TryParse(value, out parse) == false))
                   Codigo = value;
               else
                   throw new Exception("El codigo debe estar compuesto solo por 3 letras.");
           }
       }

       public string _Ciudad
       {
           get { return Ciudad; }
           set
           {
               if (value.Length > 0)
                   Ciudad = value;
               else
                   throw new Exception("La ciudad no puede estar vacia.");
           }
       }

       public string _Pais
       {
           get { return Pais; }
           set
           {
               if ((value == "Uruguay") || (value == "Argentina") || (value == "Brasil") || (value == "Paraguay"))
                    Pais = value;
               else
                   throw new Exception(" El pais no pertenece al MercoSur.");
           }
       }

       public List<string> _Facilidades
       {
           get { return Facilidades; }
           set
           {
               if (value.Count > 0)
                    Facilidades = value;
               else
                   throw new Exception("Debe seleccionar al menos una facilidad");
           }
       }

       // Constructor
       public Terminal(string pCodigo, string pCiudad, string pPais, List<string> pFacilidades)
       {
           _Codigo = pCodigo;
           _Ciudad = pCiudad;
           _Pais = pPais;
           _Facilidades = pFacilidades;
       }
    }
}

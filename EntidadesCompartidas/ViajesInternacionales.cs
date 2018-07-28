using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class ViajesInternacionales:Viaje
    {
       // Atributo
       private bool ServicioBordo;
       private string Documentacion;

       // Propiedades
       public bool _ServicioBordo
       {
           get { return ServicioBordo; }
           set { ServicioBordo = value; }
       }

       public string _Documentacion
       {
           get { return Documentacion; }
           set 
           {
               if (value.Length != 0)
                   Documentacion = value;
               else throw new Exception("Documentacion no puede ser vacia.");
           }
       }

       //Constructor 
       public ViajesInternacionales(int pNumViaje, Compañia pCom, Terminal pTer, DateTime pFechaPartida, DateTime pFechaArribo, int pCantidadAsientos, Empleado pEmp, bool pServicioBordo, string pDocumentacion)
           : base(pNumViaje, pCom, pTer, pFechaPartida, pFechaArribo, pCantidadAsientos, pEmp)
       {
           _ServicioBordo = pServicioBordo;
           _Documentacion = pDocumentacion;
       }
    }
}

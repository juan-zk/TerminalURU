using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class ViajesInternacionales:Viaje
    {
       // Atributo
       private int ServicioBordo;
       private string Documentacion;

       // Propiedades
       public int _ServicioBordo
       {
           get { return ServicioBordo; }
           set
           {
               if (value == 1)
                   ServicioBordo = 1;
               else if (value == 2)
                   ServicioBordo = 2;
               else
                   throw new Exception("Debe seleccionar una de las opciones");
           }
       }

       public string _Documentacion
       {
           get { return Documentacion; }
           set { Documentacion = value; }
       }

       //Constructor 
       public ViajesInternacionales(int pNumViaje, Compañia pCom, Terminal pTer, DateTime pFechaPartida, DateTime pFechaArribo, int pCantidadAsientos, Empleado pEmp, int pServicioBordo, string pDocumentacion)
           : base(pNumViaje, pCom, pTer, pFechaPartida, pFechaArribo, pCantidadAsientos, pEmp)
       {
           _ServicioBordo = pServicioBordo;
           _Documentacion = pDocumentacion;
       }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public abstract class Viaje
    {
       // Atributos
       private int NumViaje;
       private Compania Com;
       private Terminal Ter;
       private DateTime FechaPartida;
       private DateTime FechaArribo;
       private int CantidadAsientos;
       private Empleado Emp;

       // Propiedades 
       public int _NumViaje
       {
           get { return NumViaje; }
           set 
           {
               if (value > 0)
                    NumViaje = value;
               else
                   throw new Exception("El numero de viaje debe ser mayor a 0 y no puede estar vacio.");
           }
       }

       public Compania _Com
       {
           get { return Com; }
           set
           {
               if (value != null)

                   Com = value;
               else
                   throw new Exception("Error en la Compañia");
           }
       }

       public Terminal _Ter
       {
           get { return Ter; }
           set
           {
               if (value != null)

                   Ter = value;
               else
                   throw new Exception("Error en la Terminal");
           }
       }

       public DateTime _FechaPartida
       {
           get { return FechaPartida; }
           set { FechaPartida = value; }
       }
     
       public DateTime _FechaArribo
       {
           get { return FechaArribo; }
           set { FechaArribo = value; }
       }

       public int _CantidadAsientos
       {
           get { return CantidadAsientos; }
           set
           {
               if (value > 0)
                   CantidadAsientos = value;
               else
                   throw new Exception("La cantidad deasiento no puede ser menor a 0 y no puede qeudar vacia.");
           }
       }

       public Empleado _Emp
       {
           get { return Emp; }
           set
           {
               if (value != null)
                   Emp = value;
               else
                   throw new Exception("Error en el Empleado");
           }
       }

       // Constructor
       public Viaje(int pNumViaje, Compania pCom, Terminal pTer, DateTime pFechaPartida, DateTime pFechaArribo, int pCantidadAsientos, Empleado pEmp)
       {
           _NumViaje = pNumViaje;
           _Com = pCom;
           _Ter = pTer;
           _FechaPartida = FechaPartida;
           _FechaArribo = pFechaArribo;
           _CantidadAsientos = pCantidadAsientos;
           _Emp = pEmp;
           
       }

    }
}

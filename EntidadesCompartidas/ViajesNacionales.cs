﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
   public class ViajesNacionales:Viaje
    {
       // Atributos 
       private int ParadasIntermedias;

       // Propiedades

       public int _ParadasIntermedias
       {
           get { return ParadasIntermedias; }
           set 
           {
               if (value >= 0)
                   ParadasIntermedias = value;
               else throw new Exception("Paradas intermedias debe ser mayor o igual a 0");
           }
       }

       //Constructor 
       public ViajesNacionales(int pNumViaje, Compania pCom, Terminal pTer, DateTime pFechaPartida, DateTime pFechaArribo, int pCantidadAsientos, Empleado pEmp, int pParadasIntermedias)
           : base(pNumViaje, pCom, pTer, pFechaPartida, pFechaArribo, pCantidadAsientos, pEmp)
       {
           _ParadasIntermedias = pParadasIntermedias;
       }
       
   }
}

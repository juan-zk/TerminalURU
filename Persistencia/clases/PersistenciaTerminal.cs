using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    internal class PersistenciaTerminal
    {
        //singleton
        public static PersistenciaTerminal _instancia = null;
        public PersistenciaTerminal() { }
        public static PersistenciaTerminal GetInsancia() 
        {
            if (_instancia == null)
                _instancia = new PersistenciaTerminal();
            return _instancia;
        }
//------------------ALTA------------------------------------------------------------------------------------------
        public void Agregar(Terminal t) 
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("AgregarTerminal",cnn);
            cmd.Parameters.AddWithValue("@codigo", t._Codigo);
            cmd.Parameters.AddWithValue("@ciudad", t._Ciudad);
            cmd.Parameters.AddWithValue("@pais", t._Pais);

            SqlParameter retorno = new SqlParameter();
            retorno.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(retorno);

            SqlTransaction tran = null;

            //voy a crear un bool auxiliar por si se realizo un levante de baja de una terminal ya existente
            bool levantado=false;
            try
            {
                cnn.Open();
                tran = cnn.BeginTransaction();
                cmd.Transaction = tran;
                cmd.ExecuteNonQuery();

                int ret = Convert.ToInt32(retorno.Value);
                if (ret == -1)
                    throw new Exception("Ese codigo de terminal ya existe");
                else if (ret == -2)
                    throw new Exception("No se pudo agregar la terminal (error SQL)");
                else if (ret == 2)
                    levantado = true;

                foreach (string fac in t._Facilidades)
                {
                    PersistenciaFacilidadTerminal.Agregar(fac, t._Codigo, tran);
                }

                //si llego aca sin romper es porque salio todo ok, entonces...
                tran.Commit();
                throw new Exception("Existio antes una terminal con ese codigo, se creo con sus antiguos datos pero con los nuevos servicios que se agregaron");
            }
            catch (Exception ex) 
            {
                if (!levantado) //si el error no fue porque se habia levantado la baja
                    tran.Rollback(); //si rompio en algun lado va a venir aca a hacer rollback 
                    //SOLO HACE EL ROLLBACK SI EL ERROR FUE POR ALGO DISTINTO A QUE YA EXISTIA

                throw ex; 
            }
            finally { cnn.Close(); }
        }
//------------------BAJA--------------------------------------------------------------------
        public void Eliminar(Terminal t) 
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("EliminarTerminal", cnn);
            cmd.Parameters.AddWithValue("@codigo", t._Codigo);
            SqlParameter retorno = new SqlParameter();
            retorno.Direction=ParameterDirection.ReturnValue;
            cmd.Parameters.Add(retorno);

            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();

                int ret = Convert.ToInt32(retorno.Value);
                if (ret == -1)
                    throw new Exception("No existe una terminal con ese codigo");
                else if (ret == -2)
                    throw new Exception("No se elimino. Error de SQL");
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }
        }


    }
}

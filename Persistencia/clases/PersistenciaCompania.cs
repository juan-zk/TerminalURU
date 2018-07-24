using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    internal class PersistenciaCompania: IPersistenciaCompania
    {
        //singleton
        private static PersistenciaCompania _instancia = null;
        private PersistenciaCompania() { }
        public static PersistenciaCompania GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PersistenciaCompania();
            return _instancia;
        }

        /*BUSCAR*/
        public Compañia Buscar(string nombre)
        {
            Compañia compania = null;

            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("buscarCompania", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nombre", nombre);
            try
            {
                cnn.Open();
                SqlDataReader lector = cmd.ExecuteReader();

                while (lector.Read())
                {
                    compania = new Compañia((string)lector["nombre"],
                                        (string)lector["direccion"],
                                        (int)lector["telefono"]);
                }
                lector.Close();
            }
            catch (Exception ex)
            { throw ex; }
            finally { cnn.Close(); }
            return compania;
        }

        /*AGREGAR*/
        public void Agregar(Compañia compania)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("agregarCompania", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nombre", compania._Nombre);
            cmd.Parameters.AddWithValue("@direccion", compania._Direccion);
            cmd.Parameters.AddWithValue("@tel", compania._Telefono);


            SqlParameter resSQL = new SqlParameter();
            resSQL.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(resSQL);
            int respuesta;

            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                respuesta = (int)resSQL.Value;

                if (respuesta == -1)
                    throw new Exception("Nombre de compañia ya existe");
                if (respuesta == -2)
                    throw new Exception("ERROR SQL");
                if (respuesta == 0)
                    throw new Exception("Compañia agregada correctamente.");

            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }
    }
}

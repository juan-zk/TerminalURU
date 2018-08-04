using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    internal class PersistenciaCompania : IPersistenciaCompania
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
        public Compania Buscar(string nombre)
        {
            Compania compania = null;

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
                    compania = new Compania((string)lector["nombre"],
                                        (string)lector["direccion"],
                                        (string)lector["telefono"]);
                }
                lector.Close();
            }
            catch (Exception ex)
            { throw ex; }
            finally { cnn.Close(); }
            return compania;
        }

        /*BUSCAR PARA ARMAR VIAJE*/
        public Compania BuscarParaViaje(string nombre)
        {
            Compania compania = null;

            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("buscarCompaniaParaViaje", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nombre", nombre);

            try
            {
                cnn.Open();
                SqlDataReader lector = cmd.ExecuteReader();

                while (lector.Read())
                {
                    compania = new Compania((string)lector["nombre"],
                                        (string)lector["direccion"],
                                        (string)lector["telefono"]);
                }
                lector.Close();
            }
            catch (Exception ex)
            { throw ex; }
            finally { cnn.Close(); }
            return compania;
        }

        /*AGREGAR*/
        public void Agregar(Compania compania)
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
                if (respuesta == -2 || respuesta == -3)
                    throw new Exception("ERROR SQL");
                if (respuesta == -4)
                    throw new Exception("El teléfono debe ser único, el ingresado ya se encuentra registrado");
                if (respuesta == 1 || respuesta == 2)
                    throw new Exception("Compañia agregada correctamente.");

            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

        /*MODIFICAR*/
        public void Modificar(Compania pComp)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("modificarCompania", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nombre", pComp._Nombre);
            cmd.Parameters.AddWithValue("@direccion", pComp._Direccion);
            cmd.Parameters.AddWithValue("@tel", pComp._Telefono);


            SqlParameter resSQL = new SqlParameter();
            resSQL.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(resSQL);
            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int respuesta = (int)resSQL.Value;
                if (respuesta == -1)
                    throw new Exception("ERROR SQL, no se pudo completar su petición");
                if (respuesta == -3)
                    throw new Exception("El teléfono debe ser único, el ingresado ya se encuentra registrado");
                if (respuesta == 0)
                    throw new Exception("Compañia modificada correctamente.");
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

        /*ELIMINAR*/
        public void Eliminar(Compania pComp)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("eliminarCompania", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nombre", pComp._Nombre);

            SqlParameter resSQL = new SqlParameter();
            resSQL.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(resSQL);

            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();

                int res = (int)resSQL.Value;
                if (res == -3)
                    throw new Exception("Error al eliminar.");
                if (res == 1)
                    throw new Exception("Compañia eliminada correctamente");
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

        //--------LISTAR---------------------
        public List<Compania> Listar()
        {
            List<Compania> resp = null;
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("ListarCompanias", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            try
            {
                cnn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    Compania c = null;
                    resp = new List<Compania>();
                    while (dr.Read())
                    {
                        string nombre = (string)dr[0];
                        string direccion = (string)dr[1];
                        string telefono = (string)dr[2];

                        c = new Compania(nombre, direccion, telefono);
                        resp.Add(c);
                    }
                }
                dr.Close();
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }

            return resp;
        }

    }
}

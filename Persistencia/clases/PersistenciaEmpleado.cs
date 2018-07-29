using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;


namespace Persistencia
{
    internal class PersistenciaEmpleado : IPersistenciaEmpleado
    {
         //singleton
        private static PersistenciaEmpleado _instancia = null;
        private PersistenciaEmpleado() { }
        public static PersistenciaEmpleado GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PersistenciaEmpleado();
            return _instancia;
        }

        public Empleado Logueo(string pUsuario, string pPass) 
        {
            Empleado e=null;
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("Logueo",cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cedula", pUsuario);
            cmd.Parameters.AddWithValue("@pass", pPass);

            try
            {
                cnn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    e = new Empleado((string)dr[0], (string)dr[1], (string)dr[2],false);
                }
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }

            return e;
        }

        public Empleado Buscar(string pCedula)
        {
            Empleado resp = null;
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("BuscarEmpleado", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Cedula", pCedula);
            try
            {
                cnn.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                if(lector.Read())
                {
                    string cedula = (string )lector[0];
                    string NombreCompleto = (string)lector[1];
                    string Contraseña = (string)lector[2];
                    
                    bool baja = (bool)lector[3];
                    resp = new Empleado(cedula, Contraseña, NombreCompleto, baja);
                }
                lector.Close();
            }
            catch (Exception ex)
            { throw ex; }
            finally { cnn.Close(); }
            return resp;
        }

        public  void Agregar(Empleado emp)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("AgregarEmpleado", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Cedula", emp._Cedula);
            cmd.Parameters.AddWithValue("@Contraseña", emp._Contraseña);
            cmd.Parameters.AddWithValue("@NombreCompleto", emp._NombreCompleto);
            cmd.Parameters.AddWithValue("@Baja", emp._Baja);
            SqlParameter ret = new SqlParameter();
            ret.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(ret);
            try 
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int resultado = (int)ret.Value;
                if (resultado == -1)
                {
                    throw new Exception(" la cedula del empleado ya existe");
                }
                if (resultado == -2)
                {
                    throw new Exception("Error sql.");
                }
                if (resultado == 0)
                {
                    throw new Exception("Empleado Agregado correctamente.");
                }
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }

        }

        public  void Modificar (Empleado emp)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("ModificarEmpleado", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            
            cmd.Parameters.AddWithValue("@Cedula", emp._Cedula);
            cmd.Parameters.AddWithValue("@Contraseña", emp._Contraseña);
            cmd.Parameters.AddWithValue("@NombreCompleto", emp._NombreCompleto);

            SqlParameter ret = new SqlParameter();
            ret.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(ret);
            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int resultado = (int)ret.Value;
                if (resultado == -1)
                {
                    throw new Exception("erro sql.");
                }
                if (resultado == 0)
                {
                    throw new Exception("Empleado modificado correctamente.");
                }
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }

        }

        public void Baja(Empleado emp)
        {

            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("BajaEmpleado", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Cedula", emp._Cedula);
            cmd.Parameters.AddWithValue("@Contraseña", emp._Contraseña);
            cmd.Parameters.AddWithValue("@NombreCompleto", emp._NombreCompleto);

            SqlParameter ret = new SqlParameter();
            ret.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(ret);
            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int resultado = (int)ret.Value;
                if (resultado == -1)
                {
                    throw new Exception("erro sql.");
                }
               
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

      
        public void Borrar(string pCedula)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("BorrarEmpleado", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Cedula", pCedula);
            SqlParameter Retorno = new SqlParameter();
            Retorno.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(Retorno);

            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int ret = (int)Retorno.Value;
                if (ret == -1)
                    throw new Exception("No existe empleado ingresado con esa ceudla.");
                if (ret == -2)
                    throw new Exception("El empleado que desea borrar tinen viajes realizados o modificados. Si desea puede darlo de baja. ");
                if (ret == -3)
                    throw new Exception("Error SQL.");
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

    }
}

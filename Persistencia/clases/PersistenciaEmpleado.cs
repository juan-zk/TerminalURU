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
                    e = new Empleado((string)dr[0], (string)dr[1], (string)dr[2]);
                }
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }

            return e;
        }
    }
}

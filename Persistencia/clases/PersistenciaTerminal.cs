using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    internal class PersistenciaTerminal : IPersistenciaTerminal
    {
        //singleton
        public static PersistenciaTerminal _instancia = null;
        public PersistenciaTerminal() { }
        public static PersistenciaTerminal GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PersistenciaTerminal();
            return _instancia;
        }
        //------------------ALTA------------------------------------------------------------------------------------------
        public void Agregar(Terminal t)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("AgregarTerminal", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@codigo", t._Codigo);
            cmd.Parameters.AddWithValue("@ciudad", t._Ciudad);
            cmd.Parameters.AddWithValue("@pais", t._Pais);

            SqlParameter retorno = new SqlParameter();
            retorno.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(retorno);

            SqlTransaction tran = null;
            
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
                
                foreach (string fac in t._Facilidades)
                {
                    PersistenciaFacilidadTerminal.Agregar(fac, t._Codigo, tran);
                }

                //si llego aca sin romper es porque salio todo ok, entonces...
                tran.Commit();
                
            }
            catch (Exception ex)
            {

                tran.Rollback();

                throw ex;
            }
            finally { cnn.Close(); }
        }
        //------------------BAJA--------------------------------------------------------------------
        public void Eliminar(Terminal t)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("EliminarTerminal", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@codigo", t._Codigo);
            SqlParameter retorno = new SqlParameter();
            retorno.Direction = ParameterDirection.ReturnValue;
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

        //------------MODIFICACION---------------------------------------------------------
        public void Modificar(Terminal t)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("ModificarTerminal", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@codigo", t._Codigo);
            cmd.Parameters.AddWithValue("@ciudad", t._Ciudad);
            cmd.Parameters.AddWithValue("@pais", t._Pais);
            SqlParameter retorno = new SqlParameter();
            retorno.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(retorno);

            SqlTransaction tran = null;
            try
            {
                cnn.Open();
                tran = cnn.BeginTransaction();
                cmd.Transaction = tran;
                cmd.ExecuteNonQuery();

                int ret = Convert.ToInt32(retorno.Value);
                if (ret == -1)
                    throw new Exception("Ese codigo de terminal no existe");
                else if (ret == -2)
                    throw new Exception("No se pudo eliminar la terminal (error SQL)");

                PersistenciaFacilidadTerminal.Modificar(t, tran);

                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }
            finally { cnn.Close(); }
        }

        //--------BUSCAR--------------------------------------------------------------
        public Terminal Buscar(string cod)
        {
            
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("BuscarTerminal", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@codigo", cod);

            Terminal terminal = null;

            try
            {
                cnn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string codigo = (string)dr[0];
                    string ciudad = (string)dr[1];
                    string pais = (string)dr[2];
                    List<string> facilidades = PersistenciaFacilidadTerminal.CargarFacilidades((string)dr[0]);

                    terminal = new Terminal(codigo, ciudad, pais, facilidades);
                }
                dr.Close();
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }

            return terminal;
        }

        //------listar----------------------------------
        public List<Terminal> Listar()
        {
            List<Terminal> resp = null;
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("ListarTerminales", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            
            try
            {
                cnn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    resp = new List<Terminal>();
                    Terminal ter = null;
                    while (dr.Read())
                    {
                        string codigo = (string)dr[0];
                        string ciudad = (string)dr[1];
                        string pais = (string)dr[2];
                        List<string> facilidades = PersistenciaFacilidadTerminal.CargarFacilidades((string)dr[0]);

                        ter = new Terminal(codigo, ciudad, pais, facilidades);
                        resp.Add(ter);
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

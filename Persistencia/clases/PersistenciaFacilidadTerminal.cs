using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EntidadesCompartidas;
using System.Data;
using System.Data.SqlClient;

namespace Persistencia
{
    internal class PersistenciaFacilidadTerminal
    {
        internal static void Agregar(string fac, string cod, SqlTransaction tran)
        {
            SqlCommand cmd = new SqlCommand("AgregarFacilidad", tran.Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@codigo", cod);
            cmd.Parameters.AddWithValue("@servicio", fac);

            SqlParameter retorno = new SqlParameter();
            retorno.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(retorno);

            try
            {
                cmd.Transaction = tran;
                cmd.ExecuteNonQuery();

                int ret = Convert.ToInt32(retorno.Value);
                if (ret == -1)
                    throw new Exception("No pudo agregarse facilidad. Terminal inexistente");
                else if (ret == -2)
                    throw new Exception("No pudo agregarse facilidad. Error de SQL");


            }
            catch (Exception ex) { throw ex; }
        }
    }
}

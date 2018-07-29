using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using EntidadesCompartidas;

namespace Persistencia
{
    internal class PersistenciaViajeInternacional: IPersistenciaViajeInternacional
    {
        //singleton
        private static PersistenciaViajeInternacional _instancia = null;
        private PersistenciaViajeInternacional() { }
        public static PersistenciaViajeInternacional GetInstancia()
        {
            if (_instancia == null)
                _instancia = new PersistenciaViajeInternacional();
            return _instancia;
        }

        /*BUSCAR*/
        public ViajesInternacionales Buscar(int pNumero)
        {
            ViajesInternacionales viajeInter = null;

            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("buscarViajeInter", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@numero", pNumero);
            try
            {
                cnn.Open();
                SqlDataReader lector = cmd.ExecuteReader();

                while (lector.Read())
                {
                    Compania compania = FabricaPersistencia.GetPersistenciaCompania().Buscar((string)lector["nomCompania"]);
                    Terminal terminal = FabricaPersistencia.GetPersistenciaTerminal().Buscar((string)lector["codTerminal"]);
                    Empleado empleado = FabricaPersistencia.GetPersistenciaEmpleado().Buscar((string)lector["cedulaEmpleado"]);
                   
                    viajeInter = new ViajesInternacionales((int)lector["numViaje"],
                                        compania,
                                        terminal,
                                        (DateTime)lector["fechaHoraPartida"],
                                        (DateTime)lector["fechaHoraArribo"],
                                        (int)lector["cantidadAsientos"],
                                        empleado,
                                        (bool)lector["servicioAbordo"],
                                        (string)lector["documentacion"]);
                }
                lector.Close();
            }
            catch (Exception ex)
            { throw ex; }
            finally { cnn.Close(); }
            return viajeInter;
        }
    }
}

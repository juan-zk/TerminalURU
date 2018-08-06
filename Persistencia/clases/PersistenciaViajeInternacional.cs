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

        public List<ViajesInternacionales> Listar()
        {

            List<ViajesInternacionales> resp = new List<ViajesInternacionales>();
            ViajesInternacionales viajeInter;
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("ListarViajesInter", cnn); 
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cnn.Open();
                SqlDataReader lector = cmd.ExecuteReader(); 
                while (lector.Read()) 
                {
                    Compania compania = FabricaPersistencia.GetPersistenciaCompania().BuscarParaViaje((string)lector["nomCompania"]);
                    Terminal terminal = FabricaPersistencia.GetPersistenciaTerminal().BuscarParaViaje((string)lector["codTerminal"]);
                    Empleado empleado = FabricaPersistencia.GetPersistenciaEmpleado().BuscarParaViaje((string)lector["cedulaEmpleado"]);

                    viajeInter = new ViajesInternacionales((int)lector["numViaje"],
                                        compania,
                                        terminal,
                                        (DateTime)lector["fechaHoraPartida"],
                                        (DateTime)lector["fechaHoraArribo"],
                                        (int)lector["cantidadAsientos"],
                                        empleado,
                                        (bool)lector["servicioAbordo"],
                                        (string)lector["documentacion"]);
                    resp.Add(viajeInter);

                }
                lector.Close();
            }
            catch (Exception ex) { throw ex; }
            finally { cnn.Close(); }
            return resp;
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
                    Compania compania = FabricaPersistencia.GetPersistenciaCompania().BuscarParaViaje((string)lector["nomCompania"]);
                    Terminal terminal = FabricaPersistencia.GetPersistenciaTerminal().BuscarParaViaje((string)lector["codTerminal"]);
                    Empleado empleado = FabricaPersistencia.GetPersistenciaEmpleado().BuscarParaViaje((string)lector["cedulaEmpleado"]);
                   
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

        /*MODIFICAR*/
        public void Modificar(ViajesInternacionales pViaje)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("modificarViajeInter", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@numero", pViaje._NumViaje);
            cmd.Parameters.AddWithValue("@nombreCompania", pViaje._Com._Nombre);
            cmd.Parameters.AddWithValue("@codTerminal", pViaje._Ter._Codigo);
            cmd.Parameters.AddWithValue("@fechaHoraPartida", pViaje._FechaPartida);
            cmd.Parameters.AddWithValue("@fechaHoraArribo", pViaje._FechaArribo);
            cmd.Parameters.AddWithValue("@cantidadAsientos", pViaje._CantidadAsientos);
            cmd.Parameters.AddWithValue("@cedulaEmpleado", pViaje._Emp._Cedula);
            cmd.Parameters.AddWithValue("@servicioAbordo", pViaje._ServicioBordo);
            cmd.Parameters.AddWithValue("@documentacion", pViaje._Documentacion);


            SqlParameter resSQL = new SqlParameter();
            resSQL.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(resSQL);
            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();
                int respuesta = (int)resSQL.Value;
                if (respuesta == -1)
                    throw new Exception("No existe el viaje");
                if (respuesta == -2)
                    throw new Exception("No existe la compañia ingresada");
                if (respuesta == -3)
                    throw new Exception("No existe la terminal ingresada");
                if (respuesta == -4)
                    throw new Exception("No existe el empleado ingresado");
                if (respuesta == -5)
                    throw new Exception("ERROR al modificar el viaje");
                if (respuesta == -6)
                    throw new Exception("ERROR al modificar el viaje internacional");
                if (respuesta == -7)
                    throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia..");
                if (respuesta == -8)
                    throw new Exception("La compañia ingresada ya se encuentra baja, intente con otra porfavor.");
                if (respuesta == -9)
                    throw new Exception("El empleado ingresado ya se encuentra dado de baja, intente con otro porfavor.");
                if (respuesta == -10)
                    throw new Exception("La terminal ingresada ya se encuentra baja, intente con otra porfavor.");
                if (respuesta == -11)
                    throw new Exception("La fecha de arribo debe ser posterior a la fecha de partida.");
                if (respuesta == 1)
                    throw new Exception("Viaje modificado correctamente.");
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

        /*ELIMINAR*/
        public void Eliminar(ViajesInternacionales pViaje)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);
            SqlCommand cmd = new SqlCommand("eliminarViajeInter", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@numero", pViaje._NumViaje);

            SqlParameter resSQL = new SqlParameter();
            resSQL.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(resSQL);

            try
            {
                cnn.Open();
                cmd.ExecuteNonQuery();

                int res = (int)resSQL.Value;
                if (res == -1)
                    throw new Exception("No existe el viaje");
                if (res == -2)
                    throw new Exception("ERROR al eliminar el viaje");
                if (res == -3)
                    throw new Exception("ERROR al eliminar viaje internacional");
                if (res == 1)
                    throw new Exception("Viaje eliminado correctamente");
            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }

        /*AGREGAR*/
        public void Agregar(ViajesInternacionales pViaje)
        {
            SqlConnection cnn = new SqlConnection(Conexion.CONEXION);

            SqlCommand cmd = new SqlCommand("agregarViajeInter", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@numero", pViaje._NumViaje);
            cmd.Parameters.AddWithValue("@nombreCompania", pViaje._Com._Nombre);
            cmd.Parameters.AddWithValue("@codTerminal", pViaje._Ter._Codigo);
            cmd.Parameters.AddWithValue("@fechaHoraPartida", pViaje._FechaPartida);
            cmd.Parameters.AddWithValue("@fechaHoraArribo", pViaje._FechaArribo);
            cmd.Parameters.AddWithValue("@cantidadAsientos", pViaje._CantidadAsientos);
            cmd.Parameters.AddWithValue("@cedulaEmpleado", pViaje._Emp._Cedula);
            cmd.Parameters.AddWithValue("@servicioAbordo", pViaje._ServicioBordo);
            cmd.Parameters.AddWithValue("@documentacion", pViaje._Documentacion);


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
                    throw new Exception("Ya existe el viaje ingresado");
                if (respuesta == -2)
                    throw new Exception("No existe la compañia ingresada");
                if (respuesta == -3)
                    throw new Exception("No existe la terminal ingresada");
                if (respuesta == -4)
                    throw new Exception("No existe el empleado ingresado");
                if (respuesta == -5)
                    throw new Exception("ERROR al agregar el viaje");
                if (respuesta == -6)
                    throw new Exception("ERROR al agregar el viaje internacional");
                if (respuesta == -7)
                    throw new Exception("No puede haber un viaje al mismo destino con la misma hora de salida, al menos 2 hrs de diferencia..");
                if (respuesta == -8)
                    throw new Exception("Las fechas deben ser posteriores a la actual");
                if (respuesta == -9)
                    throw new Exception("La fecha de arribo debe ser posterior a la de partida..");
                if (respuesta == 1)
                    throw new Exception("Viaje agregado correctamente.");

            }
            catch (Exception ex)
            { throw ex; }
            finally
            { cnn.Close(); }
        }
    }
}

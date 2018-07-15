--si la base de datos existe la borro------------------------------------------------------
use master
go

if exists(Select * FROM SysDataBases WHERE name='TerminalURU')
BEGIN
	DROP DATABASE TerminalURU
END
go


--creo la base de datos---------------------------------------------------------------------
CREATE DATABASE TerminalURU
ON(
	NAME=TerminalURU,
	FILENAME='C:\TerminalURU.mdf'
)
go


--pone en uso la bd-------------------------------------------------------------------------
USE TerminalURU
go


--creo las tablas --------------------------------------------------------------------------

Create Table Companias
(
	nombre varchar(200) Not Null Primary Key,
	direccion varchar(200),
	telefono int unique,
)
go

Create Table Empleados
(
	cedula int Not Null Primary key,
	nombreCompleto varchar(10), --hay que usar unique
	contraseña varchar(30) CHECK (len(contraseña) = 6),
	
)
go
Create Table Viajes
(
	numViaje int not null Primary Key,
	nomCompania  varchar(200) not null Foreign Key References Companias(nombre),
	codTerminal varchar(3) not null Foreign Key References Terminales(codigo),
	fechaHoraPartida Date,
	fechaHoraArribo Date,
	cantidadAsientos int,
	cedulaEmpleado int Foreign Key References Empleados(cedula) ---no se desea mantener historico!!
)
go
Create Table ViajesInternacionales
(
	numViaje int Not Null primary key Foreign Key References Viajes(numViaje),
	servicioAbordo bit default 0,--hay que usar default
	documentacion varchar(300)
)
go

Create Table ViajesNacionales
(
	numViaje int Not Null Primary Key Foreign Key References Viajes(numViaje),
	paradasIntermedias int,
	
)
go
Create Table Terminales
(
	codigo int Not Null Primary Key constraint CHK_codigo check (codigo like '[Aa-Zz][Aa-Zz][Aa-Zz]'),--buscar 
	ciudad varchar(100),
	pais varchar(100),
	Facilidades varchar(100) --???? -- esto va a ser otra tabla, porque es multivaluado
)
go

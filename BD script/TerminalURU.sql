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
	cedula varchar(8) Not Null Primary key,
	nombreCompleto varchar(30), --hay que usar unique
	pass varchar(30) CHECK (len(pass) = 6),
	
)
go

Create Table Terminales
(
	codigo int Not Null Primary Key constraint CHK_codigo check (codigo like '[Aa-Zz][Aa-Zz][Aa-Zz]'),--buscar 
	ciudad varchar(100),
	pais varchar(100),
)
go

create table FacilidadTerminales
(
	codigoTerminal int not null,
	servicio varchar(100) not null,
	primary key(codigoTerminal, servicio),
	foreign key (codigoTerminal) references Terminales(codigo)
)
go

Create Table Viajes
(
	numViaje int not null Primary Key,
	nomCompania  varchar(200) not null Foreign Key References Companias(nombre),
	codTerminal int not null Foreign Key References Terminales(codigo),
	fechaHoraPartida Date,
	fechaHoraArribo Date,
	cantidadAsientos int,
	cedulaEmpleado varchar(8) Foreign Key References Empleados(cedula) ---no se desea mantener historico!!
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

----------------------SP--------------------------------
--EMPLEADO
create proc Logueo
@cedula varchar(8),
@pass varchar(30)
as
begin
	select cedula,pass,nombreCompleto from Empleados where cedula=@cedula and pass=@pass
end
go


/***********************
	SP DE COMPAÑIAS
***********************/

-- RETORNA UNA COMPAÑIA
create proc buscarCompania
@nombre varchar(200)
as
begin
	select * from Companias where nombre = @nombre;
end
go

-- INSERTA UNA COMPAÑIA
create proc agregarCompania
@nombre varchar(200),
@tel int,
@direccion varchar(200)
as
begin

	if exists(select nombre from Companias where nombre = @nombre)
		return -1 /* sale cuando ya existe la compañia */

	insert into Companias
	values(@nombre, @direccion, @tel)
end
go

-- MODIFICA UNA COMPAÑIA
create proc modificarCompania
@nombre varchar(200),
@tel int,
@direccion varchar(200)
as
begin 
	declare @respuesta int
	update Companias 
	set nombre = @nombre,
		direccion = @direccion,
		telefono = @tel
	where nombre = @nombre
	set @respuesta = @@ERROR
	if @respuesta <> 0
		return -1 /*ERROR SQL*/
end 
go

-- ELIMINA UNA COMPAÑIA
create proc eliminarCompania
@nombre varchar(200)
as
begin 
	declare @respuesta int
	delete from Companias where nombre = @nombre
	set @respuesta = @@ERROR
	if @respuesta <> 0
		return -1 /*ERROR SQL*/
	else return 0
end 
go


insert into Empleados values ('49850767','Juan Acosta','123456')
select * from Empleados
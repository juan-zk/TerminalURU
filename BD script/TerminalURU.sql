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
	pass varchar(30) CHECK (len(pass) >= 6),
	
)
go

Create Table Terminales
(
	codigo int Not Null Primary Key constraint CHK_codigo check (codigo like '[Aa-Zz][Aa-Zz][Aa-Zz]'),--buscar 
	ciudad varchar(100),
	pais varchar(100),
	baja bit default 0
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

---MANEJO DE TERMINALES-----------------------------------

create proc AgregarTerminal
@codigo int,
@ciudad varchar(100),
@pais varchar(100)
as
begin
	if exists (select * from Terminales where codigo=@codigo and baja=0)
		return -1 -- ya existe esa terminal
	if not exists (select * from Terminales where codigo=@codigo and baja=1) -- si no existe ni bajado logicamente
		insert into Terminales (codigo,ciudad,pais) values(@codigo,@ciudad,@pais) -- lo agregamos nomas 
	if (@@ERROR <> 0) -- si eso salio bien
		return 1 --retornar 1 es que se agrego una nueva terminal
	if exists (select * from Terminales where codigo=@codigo and baja=1) -- si llegue tengo que ver al que esta agregado pero bajado
		update Terminales set baja=0 where codigo=@codigo -- y simplemente subirle la baja logica 
		if (@@ERROR <> 0) -- si eso salio bien
		return 2 -- retornar 2 va a querer decir que solo se subio el existente con sus antiguos datos
end
go

create proc ModificarTerminal
@codigo int,
@ciudad varchar(100),
@pais varchar(100)
as
begin
	if not exists (select * from Terminales where codigo=@codigo and baja=1)
		return -1 --no existe la terminal
		
	update Terminales set ciudad=@ciudad, pais=@pais where codigo=@codigo
	if (@@ERROR <> 0)
		return 1
	else
		return -2
end
go

create proc EliminarTerminal
@codigo int
as
begin
	if not exists (select * from terminales where codigo=@codigo)
		return -1 --no existe terminal
	if exists (select * from terminales where codigo=@codigo and baja=1)
		return -1-- existe pero bajado, es lo mismo que no existiera
			
	begin tran
		delete from FacilidadTerminales where codigoTerminal=@codigo
		if (@@ERROR <> 0)
			rollback
			return -2 -- no se puede borrar lista de facilidades
		
		if exists (select * from Viajes where codTerminal=@codigo)
			begin
				update Terminales set baja=1
				if (@@ERROR<>0)
					rollback
					return -3					
			end
		else
			begin
				delete from Terminales where codigo=@codigo
				if (@@ERROR <> 0)
					rollback
					return -3
			end
		commit tran -- si llego aca fue todo ok
		return 1 -- se elimino
end
go


----------------------------------------------------------

insert into Empleados values ('49850767','Juan Acosta','123456')
insert into Empleados values ('12345678','Jose Gervasio Artigas','123456')
--select * from Empleados
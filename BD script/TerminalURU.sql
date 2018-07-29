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
	telefono varchar(20) unique,
)
go

Create Table Empleados
(
	cedula varchar(8) Not Null Primary key,
	nombreCompleto varchar(30), --hay que usar unique
	pass varchar(30) CHECK (len(pass) >= 6),
	baja bit
)
go

Create Table Terminales
(
	codigo varchar(3) Not Null Primary Key constraint CHK_codigo check (codigo like '[Aa-Zz][Aa-Zz][Aa-Zz]'),--buscar 
	ciudad varchar(100),
	pais varchar(100),
	baja bit default 0
)
go

create table FacilidadTerminales
(
	codigoTerminal varchar(3) not null,
	servicio varchar(100) not null,
	primary key(codigoTerminal, servicio),
	foreign key (codigoTerminal) references Terminales(codigo)
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

Create Proc BuscarEmpleado @Cedula varchar(200) as
begin
	select * from Empleados where cedula = @Cedula
end
go

Create Proc AgregarEmpleado  @Cedula varchar(200),@Contraseña varchar(200),@NombreCompleto varchar(200), @Baja bit as
declare @aux int
if exists(select cedula from Empleados where cedula = @Cedula)
return -1

insert into Empleados values(@Cedula,@NombreCompleto,@Contraseña,@Baja)
set @aux=@@ERROR
	if @aux=0 
	return 0;
	else return -2
go

Create Proc ModificarEmpleado @Cedula varchar(200), @Contraseña varchar(200), @NombreCompleto varchar(200) as
begin
declare @respuesta int
update Empleados set nombreCompleto = @NombreCompleto, pass = @Contraseña where cedula = @Cedula
set @respuesta = @@ERROR
	if @respuesta = 0
		return 0;
	else return -1

end
go
Create Proc BajaEmpleado @Cedula varchar(200), @Contraseña varchar(200), @NombreCompleto varchar(200) as
begin 
	declare @respuesta int
update Empleados set baja = 1 where cedula = @cedula
set @respuesta = @@ERROR
	if @respuesta = 0
		return 0;
	else return -1

end
go
Create Proc BorrarEmpleado @Cedula varchar (200) as
begin
	declare @Error int
	declare @Ced int
	select @Ced = vi.cedulaEmpleado from Viajes vi where vi.cedulaEmpleado = @Cedula 
	if @Ced is not null
	return -2
	set @Ced = null
	select @Ced = cedula from Empleados where cedula = @Cedula
	if @Ced is null
	return -1
	
	delete Empleados where cedula = @Cedula
	set @Error = @@ERROR
	if @Error <> 0
	return -3
	return 0 
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
@tel varchar(20),
@direccion varchar(200)
as
begin
	declare @aux int
	if exists(select nombre from Companias where nombre = @nombre)
		return -1 /* sale cuando ya existe la compañia */

	insert into Companias
	values(@nombre, @direccion, @tel)
	set @aux=@@ERROR
	if @aux=0 
	return 0;
	else return -2
end
go

-- MODIFICA UNA COMPAÑIA
create proc modificarCompania
@nombre varchar(200),
@tel varchar(20),
@direccion varchar(200)
as
begin 
	declare @respuesta int
	update Companias 
	set direccion = @direccion,
		telefono = @tel
	where nombre = @nombre
	set @respuesta = @@ERROR
	if @respuesta = 0
		return 0;
	else return -1 /*ERROR SQL*/
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
@codigo varchar(3),
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
		update Terminales set pais=@pais, ciudad=@ciudad, baja=0 where codigo=@codigo -- y simplemente subirle la baja logica 
		if (@@ERROR <> 0) -- si eso salio bien
		return 2 -- retornar 2 va a querer decir que solo se subio el existente 
end
go

create proc ModificarTerminal
@codigo varchar(3),
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
@codigo varchar(3)
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

create proc BuscarTerminal
@codigo varchar(3)
as
begin
	select codigo,ciudad,pais from Terminales where codigo=@codigo
end
go

create proc AgregarFacilidad
@codigo varchar(3),
@servicio varchar(100)
as
begin
	insert into FacilidadTerminales (codigoTerminal,servicio) values (@codigo,@servicio)
	if (@@ERROR <> 0)
		return -1
	else
		return 1
end
go

create proc EliminarFacilidades
@codigo varchar(3)
as
begin
	delete from FacilidadTerminales where codigoTerminal=@codigo
	if (@@ERROR <> 0)
		return -1
	else
		return 1
end
go

create proc ListarFacilidades
@codigo varchar(3)
as
begin
	select servicio from FacilidadTerminales where codigoTerminal=@codigo
end
go


--------MANEJO VIAJES INTERNACIONALES-------------------

-- RETORNA UN VIAJE INTER
create proc buscarViajeInter
@numero int
as
begin
	select	v.numViaje,
			v.nomCompania,
			v.codTerminal,
			v.fechaHoraPartida,
			v.fechaHoraArribo,
			v.cantidadAsientos,
			v.cedulaEmpleado,
			vi.servicioAbordo,
			vi.documentacion
	from viajes v join viajesInternacionales vi
	on (v.numViaje = vi.numViaje) and vi.numViaje=@numero
end
go

-- INSERTA UN VIAJE INTER
create proc agregarViajeInter
@numero int,
@nombreCompania varchar(200),
@codTerminal varchar(3),
@fechaHoraPartida date,
@fechaHoraArribo date,
@cantidadAsientos int,
@cedulaEmpleado varchar(8),
@servicioAbordo bit,
@documentacion varchar(300)
as
begin
	declare @resultado int

	if exists (select * from Viajes where numViaje=@numero)
		return -1 -- error ya existe viaje
		
	if not exists (select * from Companias where nombre=@nombreCompania)
		return -2 -- error no existe compañia
		
	if not exists (select * from Terminales where codigo=@codTerminal)
		return -3 -- error no existe terminal
		
	if not exists (select * from Empleados where cedula=@cedulaEmpleado)
		return -4 -- error no existe empleado
		
	begin tran
		insert into Viajes values (@numero, @nombreCompania, @codTerminal, @fechaHoraPartida, @fechaHoraArribo, @cantidadAsientos, @cedulaEmpleado)
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -5 /*error al insertar viaje*/
		end
		insert into viajesInternacionales values(@numero, @servicioAbordo, @documentacion)
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -6 /*error al insertar viaje internacional*/
		end
		else
		begin
			commit tran
			return 1
		end
end
go

-- MODIFICA UN VIAJE INTER
create proc modificarViajeInter
@numero int,
@nombreCompania varchar(200),
@codTerminal varchar(3),
@fechaHoraPartida date,
@fechaHoraArribo date,
@cantidadAsientos int,
@cedulaEmpleado varchar(8),
@servicioAbordo bit,
@documentacion varchar(300)
as
begin
	
	declare @resultado int
		
	if not exists (select * from Viajes where numViaje=@numero)
	return -1--no existe el viaje
	
	if not exists (select * from Companias where nombre=@nombreCompania)and not exists(select * from Viajes where nomCompania=@nombreCompania)
		return -2 -- error no existe compañia
		
	if not exists (select * from Terminales where codigo=@codTerminal)
		return -3 -- error no existe terminal
		
	if not exists (select * from Empleados where cedula=@cedulaEmpleado)
		return -4 -- error no existe empleado

	begin tran
		update Viajes set nomCompania=@nombreCompania,
						  codTerminal = @codTerminal,
						  fechaHoraPartida=@fechaHoraPartida,
						  fechaHoraArribo=@fechaHoraArribo,
						  cantidadAsientos=@cantidadAsientos,
						  cedulaEmpleado=@cedulaEmpleado
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -5 /*error al modificar viaje*/
		end
		update viajesInternacionales set servicioAbordo=@servicioAbordo, documentacion=@documentacion where numViaje = @numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -6 /*error al modificar viaje inter*/
		end
		else
		begin
			commit tran
			return 1 --todo ok
		end
end

go

-- ELIMINA UN VIAJE INTER
create proc eliminarViajeInter
--alter proc eliminarViajeInter
@numero int
as
begin
	
	declare @resultado int
	
	if not exists (select * from Viajes where numViaje=@numero)
	return -1 --no existe viaje
		
	begin tran
		delete from ViajesInternacionales where numViaje = @numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -2 /*error al eliminar un viaje inter*/
		end
		else
		delete from Viajes where numViaje = @numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -3 /*error al eliminar un viaje*/
		end
		else
		begin
			commit tran
			return 1 --todo ok
		end
end
go
----------------------------------------------------------

insert into Empleados values ('49850767','Juan Acosta','123456',0)
insert into Empleados values ('12345678','Jose Gervasio Artigas','123456',0)
insert into Empleados values ('12336678','Enrique Perez','123456',0)
insert into Empleados values ('52345678','Laura Perez','123456',0)
insert into Empleados values ('49345678','Cinthia Acosta','123456',0)
insert into Companias values ('CompañiaX','Atenea 1526',22003659)
insert into Companias values ('CompañiaA','Asencio 1523',22006659)
insert into Companias values ('CompañiaB','Agraciada 1526',22009659)
insert into Companias values ('CompañiaC','Uruguay 1526',23003659)
insert into Companias values ('CompañiaD','Gimenez 3526',22003759)
insert into Terminales values ('ABC','Montevideo','Uruguay', 0)
insert into Terminales values ('ABD','Montevideo','Uruguay', 0)
insert into Terminales values ('ABJ','Montevideo','Uruguay', 0)
insert into Terminales values ('AHJ','Montevideo','Uruguay', 0)
insert into Terminales values ('Abf','Montevideo','Uruguay', 0)
insert into Terminales values ('ACT','Montevideo','Uruguay', 0)
insert into FacilidadTerminales values ('ACT','emails')
insert into FacilidadTerminales values ('ABJ','emails')
insert into FacilidadTerminales values ('ABD','emails')
insert into Viajes values (1,'CompañiaA','ABD', '2018/09/15', '2018/09/25', 46, '12336678')
insert into Viajes values (2,'CompañiaX','ABC', '2018/09/15', '2018/09/25', 26, '49850767')
insert into Viajes values (3,'CompañiaC','ACT', '2018/09/15', '2018/09/25', 56, '52345678')
insert into Viajes values (4,'CompañiaD','ABC', '2018/09/15', '2018/09/25', 56, '49345678')
insert into ViajesInternacionales values (4, 1, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (3, 1, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (2, 0, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (1, 0, 'Viaje Internacional chequeado')

--select * from Empleados
--select * from Companias
go


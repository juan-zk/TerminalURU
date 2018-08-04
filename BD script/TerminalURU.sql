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
	baja bit default 0
)
go

Create Table Empleados
(
	cedula varchar(8) Not Null Primary key,
	nombreCompleto varchar(30), 
	pass varchar(30) CHECK (len(pass) >= 6),
	baja bit default 0
)
go

Create Table Terminales
(
	codigo varchar(3) Not Null Primary Key constraint CHK_codigo check (codigo like '[Aa-Zz][Aa-Zz][Aa-Zz]'),--buscar 
	ciudad varchar(100),
	pais varchar(100)constraint Chk_pais check (pais = 'Uruguay' or pais='Argentina' or pais='Brasil' or pais='Paraguay'),
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
	fechaHoraPartida smalldatetime,
	fechaHoraArribo smalldatetime,
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
	select cedula,pass,nombreCompleto from Empleados where cedula=@cedula and pass=@pass and baja =0
end
go
Create Proc BuscarEmpleado @cedula varchar(200) as
begin
	select * from Empleados where cedula = @Cedula and baja =0
end
go
--buscar empleado para armar viaje
create proc buscarEmpleadoParaViaje
@Cedula varchar(8)
as
begin
	select * from Empleados where cedula = @Cedula
end
go
Create Proc AgregarEmpleado  @Cedula varchar(200),@Contraseña varchar(200),@NombreCompleto varchar(200) as
begin

if exists(select * from Empleados where cedula = @Cedula and baja = 0)
return -1 --ya existe el empleado

if not exists (select * from Empleados where cedula = @Cedula and baja = 1)

insert into Empleados(cedula,nombreCompleto,pass) values(@Cedula,@NombreCompleto,@Contraseña)--agrego
if (@@ERROR <> 0) -- si eso salio bien
		return 1 --retornar 1 es que se agrego un empelado
		
if exists(select * from Empleados where cedula = @Cedula and baja =1)
update Empleados set cedula= @Cedula, nombreCompleto = @NombreCompleto, pass= @Contraseña, baja = 0 where cedula = @Cedula
if (@@ERROR <> 0)
return 2
end
go

Create Proc ModificarEmpleado @Cedula varchar(200), @Contraseña varchar(200), @NombreCompleto varchar(200) as
begin
declare @respuesta int
if not exists (select * from Empleados where cedula=@Cedula and baja=0)
		return -1 --no existe la terminal
update Empleados set nombreCompleto = @NombreCompleto, pass = @Contraseña where cedula = @Cedula
set @respuesta = @@ERROR
	if @respuesta = 0
		return 0;
	else return -1

end
go


Create Proc BorrarEmpleado @Cedula varchar (200) as
begin
	if not exists (select * from Empleados where cedula=@Cedula)
		return -1 --no existe empleado
	if exists (select * from Empleados where cedula=@Cedula and baja=1)
		return -1-- existe pero bajado, es lo mismo que no existiera
		
	begin tran		
		if exists (select * from Viajes where cedulaEmpleado=@Cedula)
			begin
				update Empleados set baja=1 where cedula=@Cedula
				if (@@ERROR <> 0)
					begin
					rollback
					return -2 --error al borrar logicamente
					end
			end
			
		if not exists (select * from Viajes where cedulaEmpleado=@Cedula)
			begin
			delete from Empleados where cedula=@Cedula
			if (@@ERROR <> 0)
					begin
					rollback
					return -3 --error al borrar logicamente
					end
			end
			
			commit
			return 1 --borrado correctamente
	
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
	select * from Companias where nombre = @nombre and baja=0;
end
go
--buscar compañia para armar viaje
create proc buscarCompaniaParaViaje
@nombre varchar(200)
as
begin
	select * from Companias where nombre = @nombre;
	/*select	c.nombre,
			c.direccion,
			c.telefono
	from companias c join viajes v
	on (v.nomCompania = c.nombre) and v.numViaje=@num*/
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
	if exists (select telefono from Companias where telefono=@tel and baja=0)
		return -4 --telefono unico
	if exists(select nombre from Companias where nombre = @nombre and baja=0)
		return -1 /*ya existe la compañia */
	if not exists(select * from Companias where nombre = @nombre and baja=1)
	begin
		insert into Companias(nombre, direccion, telefono) values(@nombre, @direccion, @tel)/* no existe la compañia baja, agrego registro*/
		set @aux=@@ERROR
		if (@aux<>0 )
		return -3
		else return 2
	end
	if exists(select * from Companias where nombre = @nombre and baja=1)  
	begin
		update Companias set nombre=@nombre, telefono=@tel, direccion=@direccion, baja=0 where nombre=@nombre /* ya existe la compañia pero baja, modifico registro*/
		set @aux=@@ERROR
		if (@aux<> 0) 
		return -2
		else return 1
	end
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
	if not exists (select * from Companias where nombre=@nombre and baja=0)
		return -2 --no existe la compania
	if exists (select telefono from Companias where telefono=@tel and baja=0)
		return -3 --telefono unico
	update Companias 
	set direccion = @direccion,
		telefono = @tel
	where nombre = @nombre and baja=0
	set @respuesta = @@ERROR
	if @respuesta = 0
		return 0;
	else return -1 /*ERROR SQL*/
end 
go

-- ELIMINA UNA COMPAÑIA
create proc EliminarCompania
@nombre varchar(200)
as
begin
	if not exists (select * from companias where nombre=@nombre)
		return -1 --no existe compania
	if exists (select * from companias where nombre=@nombre and baja=1)
		return -1-- existe pero bajado, es lo mismo que no existiera
		
	begin tran
		
		if exists (select * from Viajes where nomCompania=@nombre)
			begin
				update companias set baja=1 where nombre=@nombre
				if (@@ERROR <> 0)
					begin
					rollback
					return -3 --error al borrar logicamente
					end
			end
			
		if not exists (select * from Viajes where nomCompania=@nombre)
			begin
			delete from companias where nombre=@nombre
			if (@@ERROR <> 0)
					begin
					rollback
					return -3 --error al borrar logicamente
					end
			end
			
			commit
			return 1 --borrado correctamente
end
go

---listar compañias---------------------------------------------

create proc ListarCompanias
as
begin
	select nombre, direccion, telefono from Companias where baja=0
end
go

----------------------------------------------------------------
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
	if not exists (select * from Terminales where codigo=@codigo and baja=0)
		return -1 --no existe la terminal
		
	update Terminales set ciudad=@ciudad, pais=@pais where codigo=@codigo
	if (@@ERROR <> 0)
		return -2
	else
		return 1
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
		if (@@error<>0)
			begin
			rollback
			return -2 --no se puede borrar lista de facilidades
			end
		
		if exists (select * from Viajes where codTerminal=@codigo)
			begin
				update Terminales set baja=1 where codigo=@codigo
				if (@@ERROR <> 0)
					begin
					rollback
					return -3 --error al borrar logicamente
					end
			end
			
		if not exists (select * from Viajes where codTerminal=@codigo)
			begin
			delete from Terminales where codigo=@codigo
			if (@@ERROR <> 0)
					begin
					rollback
					return -3 --error al borrar logicamente
					end
			end
			
			commit
			return 1 --borrado correctamente
end
go

create proc BuscarTerminal
@codigo varchar(3)
as
begin
	select codigo,ciudad,pais from Terminales where codigo=@codigo and baja=0
end
go
--buscar terminal para armar viaje
create proc buscarTerminalParaViaje
@codigo varchar(3)
as
begin
	select * from Terminales where codigo = @codigo;
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

create proc ListarTerminales
as
begin
	select codigo, ciudad, pais from Terminales where baja=0
end
go

--------MANEJO VIAJES INTERNACIONALES-------------------

create proc ListarViajesInter
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
	on (v.numViaje = vi.numViaje)
end
go
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
@fechaHoraPartida smalldatetime,
@fechaHoraArribo smalldatetime,
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
		
	if(GETDATE()>@fechaHoraPartida or GETDATE()>@fechaHoraArribo)
		return -8
		
	if(@fechaHoraPartida>@fechaHoraArribo)
		return -9

		
	if exists (select NumViaje from Viajes where cast(fechaHoraPartida as date)=cast(@fechaHoraPartida as date) and codTerminal=@codTerminal and DATEDIFF(hh,@fechaHoraPartida,fechaHoraPartida)<2)
		return -7
		
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
/*
declare @resp int
exec @resp=agregarViajeInter 22, 'CompañiaA', 'ABC', '13-10-2018 13:30', '13-10-2018 14:30', 20, '49850767', 0, 'test'
IF @resp=-7
     PRINT 'Existe otro viaje que no cumple con las 2 hrs.'
IF @resp=-8
     PRINT 'Las fechas deben ser posteriores a la actual.'
IF @resp=-9
     PRINT 'Fecha de arribo debe ser mayor a la fecha de partida.'
go*/
--select*from viajes
-- MODIFICA UN VIAJE INTER
create proc modificarViajeInter
@numero int,
@nombreCompania varchar(200),
@codTerminal varchar(3),
@fechaHoraPartida smalldatetime,
@fechaHoraArribo smalldatetime,
@cantidadAsientos int,
@cedulaEmpleado varchar(8),
@servicioAbordo bit,
@documentacion varchar(300)
as
begin
	
	declare @resultado int
	declare @nomCompActual varchar(200)
	declare @ciEmpActual varchar(8)
	declare @codTerminalActual varchar(3)
	select @nomCompActual=nomCompania from viajes where @numero=numViaje
	select @ciEmpActual=cedulaEmpleado from viajes where @numero=numViaje
	select @codTerminalActual=codTerminal from viajes where @numero=numViaje
	
	if exists (select * from companias where nombre=@nombreCompania and baja=1 and nombre<>@nomCompActual)
	return -8 --controlo que si la compañia ingresada esta baja sea igual al nombre actual sino no permito modificar ya que se esta intentando modificar con una compañia que ya se bajo
	
	if exists (select * from empleados where cedula=@cedulaEmpleado and baja=1 and cedula<>@ciEmpActual)
	return -9
	
	if exists (select * from terminales where codigo=@codTerminal and baja=1 and codigo<>@codTerminalActual)
	return -10
		
	if not exists (select * from Viajes where numViaje=@numero)
	return -1--no existe el viaje
	
	if not exists (select * from Companias where nombre=@nombreCompania)
		return -2 -- error no existe compañia
		
	if not exists (select * from Terminales where codigo=@codTerminal)
		return -3 -- error no existe terminal
		
	if not exists (select * from Empleados where cedula=@cedulaEmpleado)
		return -4 -- error no existe empleado
		
	if exists (select NumViaje from Viajes where cast(fechaHoraPartida as date)=cast(@fechaHoraPartida as date) and codTerminal=@codTerminal and DATEDIFF(hh,@fechaHoraPartida,fechaHoraPartida)<2 and NumViaje <> @numero)
		return -7

	begin tran
		update Viajes set nomCompania=@nombreCompania,
						  codTerminal = @codTerminal,
						  fechaHoraPartida=@fechaHoraPartida,
						  fechaHoraArribo=@fechaHoraArribo,
						  cantidadAsientos=@cantidadAsientos,
						  cedulaEmpleado=@cedulaEmpleado
						  where numViaje=@numero
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
-----------MANEJO VIAJES NACIONALES-----------
create proc ListarViajesNacionales
as
begin
	select	v.numViaje,
			v.nomCompania,
			v.codTerminal,
			v.fechaHoraPartida,
			v.fechaHoraArribo,
			v.cantidadAsientos,
			v.cedulaEmpleado,
			vn.paradasIntermedias
	from viajes v join viajesNacionales vn
	on (v.numViaje = vn.numViaje)
end
go
-----SP VIAJES NACIONALES
Create Proc BuscarViajeNacional @numero int as
begin
	select	v.numViaje,
			v.nomCompania,
			v.codTerminal,
			v.fechaHoraPartida,
			v.fechaHoraArribo,
			v.cantidadAsientos,
			v.cedulaEmpleado,
			vn.paradasIntermedias
			
		from viajes v join ViajesNacionales vn
	on (v.numViaje = vn.numViaje) and vn.numViaje=@numero
end
go

Create Proc AgregarViajeNacional 
@numero int,
@nombreCompania varchar(200),
@codTerminal varchar(3),
@fechaHoraPartida smalldatetime,
@fechaHoraArribo smalldatetime,
@cantidadAsientos int,
@cedulaEmpleado varchar(8),
@ParadasIntermedias int
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
		
	if(GETDATE()>@fechaHoraPartida or GETDATE()>@fechaHoraArribo)
		return -8
		
	if(@fechaHoraPartida>@fechaHoraArribo)
		return -9
		
	if exists (select NumViaje from Viajes where cast(fechaHoraPartida as date)=cast(@fechaHoraPartida as date) and codTerminal=@codTerminal and DATEDIFF(hh,@fechaHoraPartida,fechaHoraPartida)<2)
		return -7
		
	begin tran
		insert into Viajes values (@numero, @nombreCompania, @codTerminal, @fechaHoraPartida, @fechaHoraArribo, @cantidadAsientos, @cedulaEmpleado)
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -5 /*error al insertar viaje*/
		end
		insert into ViajesNacionales values(@numero, @ParadasIntermedias)
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -6 /*error al insertar viaje Nacional*/
		end
		else
		begin
			commit tran
			return 1
		end
end
go

Create Proc ModificarViajeNacional
@numero int,
@nombreCompania varchar(200),
@codTerminal varchar(3),
@fechaHoraPartida smalldatetime,
@fechaHoraArribo smalldatetime,
@cantidadAsientos int,
@cedulaEmpleado varchar(8),
@ParadasIntermedias int
as
begin
	
	declare @resultado int
	declare @nomCompActual varchar(200)
	declare @ciEmpActual varchar(8)
	declare @codTerminalActual varchar(3)
	select @nomCompActual=nomCompania from viajes where @numero=numViaje
	select @ciEmpActual=cedulaEmpleado from viajes where @numero=numViaje
	select @codTerminalActual=codTerminal from viajes where @numero=numViaje
	
	if exists (select * from companias where nombre=@nombreCompania and baja=1 and nombre<>@nomCompActual)
	return -8 --controlo que si la compañia ingresada esta baja sea igual al nombre actual sino no permito modificar ya que se esta intentando modificar con una compañia que ya se bajo
	
	if exists (select * from empleados where cedula=@cedulaEmpleado and baja=1 and cedula<>@ciEmpActual)
	return -9
	
	if exists (select * from terminales where codigo=@codTerminal and baja=1 and codigo<>@codTerminalActual)
	return -10
		
	if not exists (select * from Viajes where numViaje=@numero)
	return -1--no existe el viaje
	
	if not exists (select * from Companias where nombre=@nombreCompania)
		return -2 -- error no existe compañia
		
	if not exists (select * from Terminales where codigo=@codTerminal)
		return -3 -- error no existe terminal
		
	if not exists (select * from Empleados where cedula=@cedulaEmpleado)
		return -4 -- error no existe empleado
		
	if exists (select NumViaje from Viajes where cast(fechaHoraPartida as date)=cast(@fechaHoraPartida as date) and codTerminal=@codTerminal and DATEDIFF(hh,@fechaHoraPartida,fechaHoraPartida)<2 and NumViaje <> @numero)
		return -7

	begin tran
		update Viajes set nomCompania=@nombreCompania,
						  codTerminal = @codTerminal,
						  fechaHoraPartida=@fechaHoraPartida,
						  fechaHoraArribo=@fechaHoraArribo,
						  cantidadAsientos=@cantidadAsientos,
						  cedulaEmpleado=@cedulaEmpleado
						  where numViaje=@numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -5 /*error al modificar viaje*/
		end
		update ViajesNacionales set paradasIntermedias = @ParadasIntermedias  where numViaje = @numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -6 /*error al modificar viaje Nacional*/
		end
		else
		begin
			commit tran
			return 1 --todo ok
		end
	end
go


Create Proc EliminarViajeNacional 
@numero int
as
begin
	
	declare @resultado int
	
	if not exists (select * from Viajes where numViaje=@numero)
	return -1 --no existe viaje
		
	begin tran
		delete from ViajesNacionales where numViaje = @numero
		set @resultado = @@ERROR
		if @resultado <> 0
		begin
			rollback
			return -2 /*error al eliminar un viaje Nacional*/
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



-- RETORNA UN VIAJE INTER
----------------------------------------------------------

insert into Empleados values ('49850767','Juan Acosta','123456', 0)
insert into Empleados values ('12345678','Jose Gervasio Artigas','123456', 0)
insert into Empleados values ('12336678','Enrique Perez','123456', 0)
insert into Empleados values ('22222222','Laura Perez','123456', 0)
insert into Empleados values ('11111111','Cinthia Acosta','123456', 0)
insert into Companias values ('CompañiaX','Atenea 1526',22003659, 0)
insert into Companias values ('CompañiaA','Asencio 1523',22006659, 0)
insert into Companias values ('CompañiaB','Agraciada 1526',22009659, 0)
insert into Companias values ('CompañiaC','Uruguay 1526',23003659, 0)
insert into Companias values ('CompañiaD','Gimenez 3526',22003759, 0)
insert into Terminales values ('ABC','Montevideo','Uruguay', 0)
insert into Terminales values ('ABD','Montevideo','Uruguay', 0)
insert into Terminales values ('ABJ','Montevideo','Uruguay', 0)
insert into Terminales values ('Abf','Montevideo','Uruguay', 0)
insert into Terminales values ('ACT','Montevideo','Uruguay', 0)
insert into FacilidadTerminales values ('ABC','servicio random')
insert into FacilidadTerminales values ('ABC','otro servicio')
insert into FacilidadTerminales values ('ACT','emails')
insert into FacilidadTerminales values ('ABJ','emails')
insert into FacilidadTerminales values ('ABD','emails')
insert into FacilidadTerminales values ('Abf','emails')
insert into Viajes values (1,'CompañiaA','ABD', '15-09-2018 13:00', '25-09-2018 14:00', 46, '12336678')
insert into Viajes values (2,'CompañiaX','ABC', '30-09-2018 16:00:00', '25-10-2018 17:00:00', 26, '49850767')
insert into Viajes values (3,'CompañiaC','ACT', '20-12-2018 19:00:00', '25-12-2018 20:00:00', 56, '11111111')
insert into Viajes values (4,'CompañiaD','ABC', '05-10-2018 13:00:00', '07-10-2018 12:00:00', 56, '22222222')
insert into Viajes values (5,'CompañiaD','ABC', '12-10-2018 17:30:00', '15-10-2018 16:30:00', 56, '11111111')
insert into Viajes values (6,'CompañiaD','ABC', '03-08-2018 17:30:00', '02-08-2018 16:30:00', 56, '22222222')
insert into Viajes values (7,'CompañiaD','ABC', '20-10-2018 17:30:00', '21-10-2018 16:30:00', 56, '11111111')
insert into Viajes values (8,'CompañiaD','ABC', '21-10-2018 17:30:00', '22-10-2018 16:30:00', 56, '22222222')

insert into ViajesInternacionales values (6, 1, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (4, 1, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (3, 1, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (2, 0, 'Viaje Internacional chequeado')
insert into ViajesInternacionales values (1, 0, 'Viaje Internacional chequeado')
insert into ViajesNacionales values(5,2)
insert into ViajesNacionales values(7,3)
insert into ViajesNacionales values(8,3)

--select * from Empleados
--select * from Companias
--select * from Terminales
--select *from Viajes
go


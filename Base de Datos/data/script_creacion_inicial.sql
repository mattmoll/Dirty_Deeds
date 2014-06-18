USE GD1C2014;
GO
CREATE SCHEMA DIRTYDEEDS AUTHORIZATION gd

create table Usuario
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Usuario char(20) not null unique,
	Contrasenia varchar(256) not null DEFAULT 'Password',
	IntentosFallidos int not null DEFAULT 0,
	IdReferencia int not null,
	Discriminante char not null,
	Deleted bit not null DEFAULT 0
)

create table Rol
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Nombre varchar(30) not null,
	Deleted bit not null DEFAULT 0
)

create table Rol_Funcionalidad
(
	IdRol int foreign key references Rol(Id),
	IdFuncionalidad int not null,
	primary key (IdRol, IdFuncionalidad)
)

create table Usuario_Rol
(
	IdUsuario int foreign key references Usuario(Id),
	IdRol int foreign key references Rol(Id)
	primary key (IdUsuario, IdRol)
)

create table Calificacion
(
	Codigo int primary key,
	CodigoPublicacion int foreign key references Publicacion(Codigo),
	IdCalificador int foreign key references Usuario(Id),
	IdCalificado int foreign key references Usuario(Id),
	Descripcion nvarchar(255) not null,
	CantidadEstrellas int not null,
	IdCompra int foreign key references OfertaCompra(Id)
)

create table Localidad
(
	Id int not null IDENTITY(1,1) primary key,
	Nombre nvarchar(255) unique,
	Deleted bit not null DEFAULT 0
)
create table Direccion
(
	Id int not null IDENTITY(1,1) primary key,
	Domicilio nvarchar(255) not null,
	NumeroCalle int not null,
	Piso int not null,
	Depto nvarchar(50) not null,
	CodPostal int NOT NULL,
	IdLocalidad int foreign key references Localidad(Id),
	Deleted bit not null DEFAULT 0
)

create table Cliente
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Apellido nvarchar(150) not null,
	Nombre nvarchar(150) not null,
	TipoDocumento char(4) not null,
	Documento int not null,
	FechaNacimiento datetime not null,
	Telefono nvarchar(40) not null DEFAULT '', 
	Mail nvarchar(150) not null,
	IdDireccion int foreign key references Direccion(Id),
	Deleted bit not null DEFAULT 0
)

create table Empresa
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	RazonSocial nvarchar(255) not null unique,
	Cuit nvarchar(50) not null unique,
	FechaIngreso datetime not null,
	Mail nvarchar(50) not null,
	Ciudad nvarchar(60) not null,
	NombreContacto varchar(60) not null,
	IdDireccion int foreign key references Direccion(Id),
	Deleted bit not null DEFAULT 0
)

create table FormaPago
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Descripcion nvarchar(255) not null
)

create table Factura
(
	Numero int primary key,
	Fecha datetime not null,
	Total numeric(18, 2) not null,
	IdFormaPago int not null foreign key references FormaPago(Id)
)

create table Item
(
	NumFactura int foreign key references Factura(Numero),
	NumItem int not null,
	Descripcion varchar(255) not null,
	Monto numeric(18, 2) not null,
	Cantidad int not null,
	primary key (NumFactura,NumItem)
)

create table Visibilidad
(
	Id int not null IDENTITY(1,1) primary key,
	Codigo varchar(20) not null,
	Descripcion nvarchar(255) not null,
	Precio numeric(18, 2) not null,
	Porcentaje numeric(18, 2) not null,
	DiasActiva int not null DEFAULT 30,
	Deleted bit not null DEFAULT 0
)

create table Rubro
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Descripcion nvarchar(255) not null,
	Deleted bit not null DEFAULT 0
)

create table Publicacion
(
	Codigo int primary key,
	Presentacion nvarchar(255) not null,
	Stock int not null,
	Fecha datetime not null,
	FechaVto datetime not null,
	Precio numeric(18, 2) not null,
	Tipo char(1) not null,
	AceptaPreguntas bit not null DEFAULT 1,
	IdEstado int foreign key references Estado(Id),
	IdVisibilidad int foreign key references Visibilidad(Id),
	IdUsuario int foreign key references Usuario(Id) not null
)

create table Publicacion_Rubro
(
	CodPublicacion int foreign key references Publicacion(Codigo),
	IdRubro int foreign key references Rubro(Id) not null
)

create table Estado
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	Descripcion varchar(50) not null
)

create table Publicacion_Pregunta
(
	CodPublicacion int foreign key references Publicacion(Codigo),
	NumPregunta int,
	Pregunta nvarchar(255) not null default '',
	Respuesta nvarchar(255)not null default '',
	primary key (CodPublicacion, NumPregunta)
)

create table OfertaCompra
(
	Id int NOT NULL IDENTITY(1,1) primary key,
	IdUsuario int foreign key references Usuario(Id),
	CodPublicacion int foreign key references Publicacion(Codigo),
	Fecha datetime not null,
	Monto numeric(18, 2) not null,
	Cantidad int not null ,
	Discriminante char(1) not null 
)

-- VISTAS
CREATE VIEW DIRTYDEEDS.Vendedores(IdUsuario,Vendedor)
AS
SELECT DISTINCT usuarios.Id as IdUsuario, CAST(clientes.Documento as varchar(20)) as Vendedor FROM DIRTYDEEDS.Cliente as clientes, DIRTYDEEDS.Usuario as usuarios, DIRTYDEEDS.Publicacion as publicaciones
WHERE publicaciones.IdUsuario = usuarios.Id
AND usuarios.IdReferencia = clientes.Id
AND usuarios.Discriminante = 'C'
UNION
SELECT DISTINCT usuarios.Id,empresas.Cuit FROM DIRTYDEEDS.Empresa as empresas, DIRTYDEEDS.Usuario as usuarios, DIRTYDEEDS.Publicacion as publicaciones
WHERE usuarios.IdReferencia = empresas.Id
AND usuarios.Id = publicaciones.IdUsuario
AND usuarios.Discriminante = 'E'
GO

-- Vendedores con calificacion Promedio
CREATE VIEW DIRTYDEEDS.Calificacion_Vendedores(IdUsuario,Vendedor,CalificacionPromedio)
AS
SELECT IdCalificado, vendedores.vendedor, SUM(CantidadEstrellas) / COUNT(IdCalificado) as promedio FROM DIRTYDEEDS.Calificacion, DIRTYDEEDS.Vendedores as vendedores
WHERE IdCalificado = vendedores.IdUsuario
GROUP BY IdCalificado, vendedores.vendedor
GO


-- Funciones
create function DIRTYDEEDS.GetSiguienteCodigoPublicacion()
returns int
as
begin
	declare @ret int
	select @ret = MAX(DIRTYDEEDS.Publicacion.Codigo) from DIRTYDEEDS.Publicacion
	return @ret + 1
end
go

create function DIRTYDEEDS.GetSiguienteCodigoFactura()
returns int
as
begin
	declare @ret int
	select @ret = MAX(DIRTYDEEDS.Factura.Numero) from DIRTYDEEDS.Factura
	return @ret + 1
end
go

-- Stored Procedures
-- Preguntas a ser respndidas dado un usuario
create procedure DIRTYDEEDS.Preguntas(@IdUsuarioLoggeado int)
as
begin  
	select CodPublicacion as Codigo_Publicacion, NumPregunta as Numero_Pregunta, Pregunta, 
			Respuesta, Presentacion as Descripcion_Publicacion, Stock, Fecha, Precio 
	from DIRTYDEEDS.Publicacion_Pregunta 
		join DIRTYDEEDS.Publicacion on Publicacion.Codigo = Publicacion_Pregunta.CodPublicacion
		join DIRTYDEEDS.Usuario on Usuario.Id = Publicacion.IdUsuario
	where IdUsuario = @IdUsuarioLoggeado 
end
go

CREATE Procedure DIRTYDEEDS.OfertasGanadoras
AS
BEGIN
	IF EXISTS(SELECT * FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#OfertasMaximas')) BEGIN DROP TABLE #OfertasMaximas END
	
	SELECT CodPublicacion, MAX(Fecha) as FechaMaxima, MAX(Monto) as MontoMaximo INTO #OfertasMaximas
	FROM DIRTYDEEDS.OfertaCompra 
	WHERE Monto != 0 
	GROUP By CodPublicacion
	
	SELECT oferta.Id,oferta.IdUsuario,oferta.CodPublicacion,oferta.Fecha,oferta.Monto,oferta.Cantidad FROM DIRTYDEEDS.OfertaCompra as oferta, #OfertasMaximas as maximas
	WHERE oferta.Monto != 0
	AND oferta.CodPublicacion = maximas.CodPublicacion
	AND Fecha = maximas.FechaMaxima
	AND Monto = maximas.MontoMaximo
	ORDER BY oferta.CodPublicacion,oferta.Monto DESC
END
GO

CREATE Procedure DIRTYDEEDS.ComprasYOfertasGanadas
AS 
BEGIN
	IF EXISTS(SELECT * FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#ComprasYOfertasGanadas')) BEGIN DROP TABLE #ComprasYOfertasGanadas END
	SELECT CodPublicacion, MAX(Fecha) as FechaMaxima, MAX(Monto) as MontoMaximo INTO #ComprasYOfertasGanadas
	FROM DIRTYDEEDS.OfertaCompra 
	WHERE Monto != 0 
	GROUP By CodPublicacion
	
	SELECT oferta.Id,oferta.IdUsuario,oferta.CodPublicacion,oferta.Fecha,oferta.Monto,oferta.Cantidad FROM DIRTYDEEDS.OfertaCompra as oferta, #ComprasYOfertasGanadas as maximas
	WHERE oferta.Monto != 0
	AND oferta.CodPublicacion = maximas.CodPublicacion
	AND Fecha = maximas.FechaMaxima
	AND Monto = maximas.MontoMaximo
	UNION
	SELECT Id,IdUsuario,CodPublicacion,Fecha,Monto,Cantidad FROM DIRTYDEEDS.OfertaCompra WHERE Monto = 0
	ORDER BY oferta.CodPublicacion,oferta.Monto DESC
END
GO





-- Historial de Calificaciones otorgadas y recibidas
create procedure DIRTYDEEDS.Calificaciones(@IdUsuarioLoggeado int)
as
begin  
	select CASE WHEN Calificacion.IdCalificado = @IdUsuarioLoggeado THEN 'Fuiste Calificado' 
									else 'Calificaste' end as Tipo , 
	Calificacion.CantidadEstrellas as Cantidad_Estrellas, Calificacion.Descripcion as Comentario_Calificacion, 
	Calificacion.CodigoPublicacion as Codigo_Publicacion, Publicacion.Presentacion
	from DIRTYDEEDS.Calificacion
	join DIRTYDEEDS.Publicacion on Publicacion.Codigo = Calificacion.CodigoPublicacion
	where IdCalificado = @IdUsuarioLoggeado or IdCalificador = @IdUsuarioLoggeado
	order by CodigoPublicacion desc 
end
go

-- Compras y Ofertas ganadoras con calificacion pendiente
create procedure DIRTYDEEDS.ComprasYOfertasConCalificacionPendiente(@IdUsuarioLoggeado int)
as
begin

	IF EXISTS(SELECT * FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#OfertasMaximas')) BEGIN DROP TABLE #OfertasMaximas END

	-- Obtenemos las ofertas maximas de todas las subastas
	SELECT CodPublicacion, MAX(Fecha) as FechaMaxima, MAX(Monto) as MontoMaximo INTO #OfertasMaximas
	FROM DIRTYDEEDS.OfertaCompra 
	WHERE Monto != 0 
	GROUP By CodPublicacion

	-- Obtenemos las Ofertas ganadoras de las subastas que aun no tengan Calificaciones.
	SELECT publicacion.Presentacion, publicacion.Precio, OfertaCompra.Fecha, OfertaCompra.Cantidad, 'Subasta' as Tipo,
			OfertaCompra.CodPublicacion as Codigo_Publicacion, publicacion.IdUsuario as Id_Vendedor, 
			OfertaCompra.Id as Id_Compra
		FROM DIRTYDEEDS.OfertaCompra
		join  #OfertasMaximas on OfertaCompra.CodPublicacion = #OfertasMaximas.CodPublicacion
								AND OfertaCompra.Fecha = #OfertasMaximas.FechaMaxima
								AND OfertaCompra.Monto = #OfertasMaximas.MontoMaximo
		join DIRTYDEEDS.Publicacion on 	Publicacion.Codigo = OfertaCompra.CodPublicacion
		left outer join DIRTYDEEDS.Calificacion on OfertaCompra.Id = Calificacion.IdCompra
		WHERE OfertaCompra.Monto != 0 and publicacion.IdEstado = 4 
		and Calificacion.Codigo is null 
		and OfertaCompra.IdUsuario = @IdUsuarioLoggeado

		
	union

	-- Y lo unimos con las compras que aun no tengan calificaciones
	select Publicacion.Presentacion, Publicacion.Precio,OfertaCompra.Fecha, OfertaCompra.Cantidad, 'Compra' as Tipo, 
	OfertaCompra.CodPublicacion as Codigo_Publicacion, Publicacion.IdUsuario as Id_Vendedor, OfertaCompra.Id as Id_Compra
	 from DIRTYDEEDS.OfertaCompra 
		left outer join DIRTYDEEDS.Calificacion on OfertaCompra.Id = Calificacion.IdCompra
		join DIRTYDEEDS.Publicacion on Publicacion.Codigo = OfertaCompra.CodPublicacion
	where OfertaCompra.Discriminante = 'C' 
		and Calificacion.Codigo is null
		and OfertaCompra.IdUsuario = @IdUsuarioLoggeado
end
go


-- Indices
CREATE INDEX IdVisibilidad
ON DIRTYDEEDS.Publicacion (IdVisibilidad)
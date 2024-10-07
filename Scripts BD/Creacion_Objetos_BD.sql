-- BORRADO DE BASE DE DATOS
USE master;
GO
DROP DATABASE RegistroEstudiantes;
GO

-- CREACIÓN DE BASE DE DATOS
CREATE DATABASE RegistroEstudiantes;
GO
USE RegistroEstudiantes;
GO


--CREACION DE TABLAS
CREATE TABLE RE_MATERIA(
	Id int primary key,
	Nombre nvarchar(50),
	Descripcion nvarchar(500),
	FechaReg datetime default Getdate()
	);

CREATE TABLE RE_TIPODOCUMENTO(
	TipoDoc nvarchar(5) primary key,
	Descripcion nvarchar(30),
	FechaReg datetime default Getdate()
	);

CREATE TABLE RE_PROFESOR(
	TipoDoc nvarchar(5),
	NumDocumento nvarchar(15) primary key,
	PrimerNombre nvarchar(200) not null,
	SegundoNombre nvarchar(200) not null,
	PrimerApellido nvarchar(200) not null,
	SegundoApellido nvarchar(200) not null,
	FechaReg datetime default Getdate(),
	CONSTRAINT fk_Do_TipoDoc FOREIGN KEY (TipoDoc) REFERENCES RE_TIPODOCUMENTO (TipoDoc),
	);

CREATE TABLE RE_ESTUDIANTE(
	TipoDoc nvarchar(5),
	NumeroDocumento nvarchar(15) primary key,
	FechaNacimiento date,
	PrimerNombre nvarchar(200) not null,
	SegundoNombre nvarchar(200) not null,
	PrimerApellido nvarchar(200) not null,
	SegundoApellido nvarchar(200) not null,
	Direccion nvarchar(300),
	NumeroCelular nvarchar(13),
	Email nvarchar(200),
	FechaReg datetime default Getdate(),
	CONSTRAINT fk_Es_TipoDoc FOREIGN KEY (TipoDoc) REFERENCES RE_TIPODOCUMENTO (TipoDoc)
	);

CREATE TABLE RE_ESTUDIANTE_MATERIA(
	NumeroDocumento nvarchar(15),
	Id_Materia int,
	FechaReg datetime default Getdate(),
    CONSTRAINT fk_IdMateriaEst FOREIGN KEY (Id_Materia) REFERENCES RE_MATERIA (Id),
	CONSTRAINT fk_DocEstudiante FOREIGN KEY (NumeroDocumento) REFERENCES RE_ESTUDIANTE (NumeroDocumento),
	primary key(NumeroDocumento,Id_Materia)
	);

CREATE TABLE RE_PROFESOR_MATERIA(
	Id int primary key,
	NumDocumento nvarchar(15),
	Id_Materia int,
	Descripcion nvarchar(30),
	FechaReg datetime default Getdate(),
    CONSTRAINT fk_IdMateriaProf FOREIGN KEY (Id_Materia) REFERENCES RE_MATERIA (Id),
	CONSTRAINT fk_DocProfesor FOREIGN KEY (NumDocumento) REFERENCES RE_PROFESOR (NumDocumento)
	);
GO

--CREACIÓN PROCEDIMIENTOS ALMACENADOS
CREATE PROCEDURE SP_GET_TIPODOC
AS
   SELECT TipoDoc, Descripcion
   FROM RE_TIPODOCUMENTO;
GO

CREATE PROCEDURE SP_GET_MATERIAS

AS
   SELECT MAT.Id,
          MAT.Nombre,
          MAT.Descripcion,
		  CONCAT (PRO.PrimerNombre,' ', PRO.SegundoNombre, ' ', PRO.PrimerApellido, ' ', PRO.SegundoApellido) AS Docente,
          MAT.FechaReg
   FROM RE_MATERIA MAT,
		RE_PROFESOR PRO,
		RE_PROFESOR_MATERIA PROMAT
   WHERE MAT.Id = PROMAT.Id_Materia
   AND PROMAT.NumDocumento = PRO.NumDocumento;

GO

CREATE PROCEDURE SP_GET_MATXEST
    @NumDoc nvarchar(50)
AS
   SELECT MAT.Id, 
          MAT.Nombre,
		  MAT.Descripcion,
		  CONCAT (PRO.PrimerNombre,' ', PRO.SegundoNombre, ' ', PRO.PrimerApellido, ' ', PRO.SegundoApellido) AS Docente,
		  MAT.FechaReg
   FROM RE_ESTUDIANTE_MATERIA ESMA,
		RE_MATERIA MAT,
		RE_PROFESOR PRO,
		RE_PROFESOR_MATERIA PROMAT
   WHERE ESMA.Id_Materia = MAT.Id
   AND PROMAT.NumDocumento = PRO.NumDocumento
   AND PROMAT.Id_Materia = ESMA.Id_Materia
   AND ESMA.NumeroDocumento = @NumDoc;

GO
--Procedimiento que agrega una una materia a un determinado estudiante
CREATE PROCEDURE SP_INSERT_MATXEST
    @NumDoc nvarchar(50),
	@IdMateria nvarchar(50)
AS

   INSERT INTO RE_ESTUDIANTE_MATERIA (NumeroDocumento, Id_Materia)
    VALUES(@NumDoc, @IdMateria);
GO
--Procedimiento que elimina una determinada materia que tiene asociada un estudiante
CREATE PROCEDURE SP_DELETE_MATXEST
    @Id int,
	@numDoc nvarchar(50)
AS
   DELETE RE_ESTUDIANTE_MATERIA
   WHERE Id_Materia = @Id
   AND NumeroDocumento = @numDoc;
GO
--Procedimiento que consulta el listado de todos los estudiante que se encuentran registrados
CREATE PROCEDURE SP_GET_ESTUDIANTES
AS
   SELECT TipoDoc,	
           NumeroDocumento,
           FechaNacimiento, 
           PrimerNombre, 	
           SegundoNombre, 	
           PrimerApellido, 	
           SegundoApellido,	
           Direccion,		
           NumeroCelular,	
           Email,
		   FechaReg
   FROM RE_ESTUDIANTE EST;
GO
--Procedimiento que registra un estudiante con sus respectivos datos
CREATE PROCEDURE SP_INSERT_ESTUDIANTE
	@TipoDoc nvarchar(50),
    @NumDoc nvarchar(50),
	@FechaNacimiento date,
	@PrimerNombre nvarchar(50),
	@SegundoNombre nvarchar(50),
	@PrimerApellido nvarchar(50),
	@SegundoApellido nvarchar(50),
	@Direccion nVarchar(100),
	@NumeroCelular nVarchar(15),
	@Email nVarchar(100)
AS
   INSERT INTO RE_ESTUDIANTE (TipoDoc, NumeroDocumento, FechaNacimiento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Direccion, NumeroCelular, Email)
    VALUES(@TipoDoc, @NumDoc, @FechaNacimiento, @PrimerNombre, @SegundoNombre, @PrimerApellido, @SegundoApellido, @Direccion, @NumeroCelular, @Email);

GO
--Procedimiento que actualiza los datos de un estudiante por documento
CREATE PROCEDURE SP_UPDATE_ESTUDIANTE
	@TipoDoc nvarchar(50),
    @NumDoc nvarchar(50),
    @FechaNacimiento date,
	@PrimerNombre nvarchar(200),
	@SegundoNombre nvarchar(200),
	@PrimerApellido nvarchar(200),
	@SegundoApellido nvarchar(200),
	@Direccion nvarchar(300),
	@NumeroCelular nvarchar(13),
	@Email nvarchar(200)
AS
   UPDATE RE_ESTUDIANTE
   SET FechaNacimiento = @FechaNacimiento,
	   PrimerNombre = @PrimerNombre, 	
	   SegundoNombre = @SegundoNombre, 	
	   PrimerApellido = @PrimerApellido, 
	   SegundoApellido = @SegundoApellido,
	   Direccion = @Direccion,		
	   NumeroCelular = @NumeroCelular,	
	   Email = @Email
   WHERE TipoDoc = @TipoDoc
   AND NumeroDocumento = @NumDoc;

GO
--Procedimiento que elimina un estudiante por documento
CREATE PROCEDURE SP_DELETE_ESTUDIANTE
	@TipoDoc nvarchar(50),
    @NumDoc nvarchar(50)
AS
   DELETE RE_ESTUDIANTE
   WHERE TipoDoc= @TipoDoc
   AND NumeroDocumento = @NumDoc;
GO
--Procedimiento que consulta los datos de un estudiante por documento
CREATE PROCEDURE SP_GET_ESTUDIANTEXDOC
    @NumDoc nvarchar(50)
AS
   SELECT TipoDoc,	
           NumeroDocumento,
           FechaNacimiento, 
           PrimerNombre, 	
           SegundoNombre, 	
           PrimerApellido, 	
           SegundoApellido,	
           Direccion,		
           NumeroCelular,	
           Email,
		   FechaReg
   FROM RE_ESTUDIANTE EST
   WHERE EST.NumeroDocumento = @NumDoc;
GO

--Procedimiento que consulta los datos de un estudiante por documento
CREATE PROCEDURE SP_GET_MATERIASPROF
    @NumDoc nvarchar(50)
AS
   SELECT TipoDoc,	
           NumeroDocumento,
           FechaNacimiento, 
           PrimerNombre, 	
           SegundoNombre, 	
           PrimerApellido, 	
           SegundoApellido,	
           Direccion,		
           NumeroCelular,	
           Email,
		   FechaReg
   FROM RE_ESTUDIANTE EST
   WHERE EST.NumeroDocumento = @NumDoc;
GO

--Procedimiento que consulta el listado de todos los estudiante que se encuentran registrados
--en una deter
CREATE PROCEDURE SP_GET_ESTUDIANTESXMAT
@IdMateria int
AS
   SELECT  CONCAT (EST.PrimerNombre,' ', EST.SegundoNombre, ' ', EST.PrimerApellido, ' ', EST.SegundoApellido) AS nombreCompleto
   FROM RE_ESTUDIANTE EST,
        RE_ESTUDIANTE_MATERIA ESTMA
   WHERE EST.NumeroDocumento = ESTMA.NumeroDocumento
   AND ESTMA.Id_Materia = @IdMateria
   ORDER BY EST.PrimerApellido, EST.SegundoApellido;
GO

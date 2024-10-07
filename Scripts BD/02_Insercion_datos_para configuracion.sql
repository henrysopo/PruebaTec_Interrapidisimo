--INSERCI�N DE DATOS

--TIPOS DE DOCUMENTOS
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('CC', 'C�dula de ciudadania');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('TI', 'Tarjeta de identidad');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('RC', 'Registro civil');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('CE', 'Cedula de extranjer�a');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('PA', 'Pasaporte');
GO
--MATERIAS A SER ASIGNADAS POR LOS ESTUDIANTES (10)
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (1, 'Quimica General', 'Constituci�n de la materia. Elementos qu�micos');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (2, 'Matem�tica I', 'Conjuntos num�ricos. Intervalos reales. Funciones Reales. Funci�n inversa. Funciones polin�micas, racionales, exponenciales, logar�tmicas');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (3, 'Introducci�n a la ingenieria', 'Conseptos b�sicos de ingenieria');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (4, 'Fundamentos de econom�a', 'Conceptos de: Microeconom�a. Reglas de mercado');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (5, 'F�sica I', 'Mediciones. Errores. Vectores. Operaciones b�sicas con vectores');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (6, 'Programaci�n I', 'La materia introduce a los alumnos en los conceptos de programaci�n encarando Problemas y Algoritmos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (7, 'Bases de datos', 'La asignatura introduce a los alumnos en el concepto de dise�o y gesti�n de Datos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (8, 'Sistemas operativos', 'El curso aborda los conceptos de los mecanismos de Sistemas Operativos sus procesos, memoria y manejo de archivos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (9, 'Probabilidad y estad�stica', 'Tabulaci�n y representaci�n gr�fica de datos. Medidas descriptivas. Teor�a de probabilidades, reglas de c�lculo.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (10, 'Introducci�n a las comunicaciones', 'Objetivos de las redes de datos. Redes y Comunicaciones. Evoluci�n y desarrollo de las redes de transmisi�n de datos.');
GO

	--INFORMACI�N DE LOS PROFESORES (5)
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10985432654', 'Jose', 'Ernesto', 'Lopez', 'Mu�oz');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10432156432', 'Juan', 'Felipe', 'Arbelaez', 'Sarmiento');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10367843568', 'Maria', 'Paola', 'Bernal', 'Vanegas');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10543265432', 'Martha', 'Lucia', 'C�rdenas', 'Suarez');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10354267890', 'Berenice', 'Consuelo', 'Romero', 'Ramirez');

GO
    --SE ASOCIAN LOS PROFESORES CON CADA UNA DE LAS DIFERENTES MATERIAS QUE SE TIENEN EN EL SISTEMA
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (1, '10985432654', 1, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (2, '10432156432', 2, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (3, '10367843568', 3, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (4, '10543265432', 4, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (5, '10354267890', 5, 'Descripci�n');
    INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (6, '10985432654', 6, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (7, '10432156432', 7, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (8, '10367843568', 8, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (9, '10543265432', 9, 'Descripci�n');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (10, '10354267890', 10, 'Descripci�n');

GO
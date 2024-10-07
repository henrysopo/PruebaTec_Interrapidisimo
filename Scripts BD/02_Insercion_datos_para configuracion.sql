--INSERCIÓN DE DATOS

--TIPOS DE DOCUMENTOS
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('CC', 'Cédula de ciudadania');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('TI', 'Tarjeta de identidad');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('RC', 'Registro civil');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('CE', 'Cedula de extranjería');
	INSERT INTO RE_TIPODOCUMENTO (TipoDoc, Descripcion)
    VALUES ('PA', 'Pasaporte');
GO
--MATERIAS A SER ASIGNADAS POR LOS ESTUDIANTES (10)
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (1, 'Quimica General', 'Constitución de la materia. Elementos químicos');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (2, 'Matemática I', 'Conjuntos numéricos. Intervalos reales. Funciones Reales. Función inversa. Funciones polinómicas, racionales, exponenciales, logarítmicas');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (3, 'Introducción a la ingenieria', 'Conseptos básicos de ingenieria');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (4, 'Fundamentos de economía', 'Conceptos de: Microeconomía. Reglas de mercado');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (5, 'Física I', 'Mediciones. Errores. Vectores. Operaciones básicas con vectores');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (6, 'Programación I', 'La materia introduce a los alumnos en los conceptos de programación encarando Problemas y Algoritmos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (7, 'Bases de datos', 'La asignatura introduce a los alumnos en el concepto de diseño y gestión de Datos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (8, 'Sistemas operativos', 'El curso aborda los conceptos de los mecanismos de Sistemas Operativos sus procesos, memoria y manejo de archivos.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (9, 'Probabilidad y estadística', 'Tabulación y representación gráfica de datos. Medidas descriptivas. Teoría de probabilidades, reglas de cálculo.');
	INSERT INTO RE_MATERIA (Id, Nombre, Descripcion)
    VALUES (10, 'Introducción a las comunicaciones', 'Objetivos de las redes de datos. Redes y Comunicaciones. Evolución y desarrollo de las redes de transmisión de datos.');
GO

	--INFORMACIÓN DE LOS PROFESORES (5)
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10985432654', 'Jose', 'Ernesto', 'Lopez', 'Muñoz');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10432156432', 'Juan', 'Felipe', 'Arbelaez', 'Sarmiento');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10367843568', 'Maria', 'Paola', 'Bernal', 'Vanegas');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10543265432', 'Martha', 'Lucia', 'Cárdenas', 'Suarez');
	INSERT INTO RE_PROFESOR (TipoDoc, NumDocumento, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido)
    VALUES ('CC', '10354267890', 'Berenice', 'Consuelo', 'Romero', 'Ramirez');

GO
    --SE ASOCIAN LOS PROFESORES CON CADA UNA DE LAS DIFERENTES MATERIAS QUE SE TIENEN EN EL SISTEMA
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (1, '10985432654', 1, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (2, '10432156432', 2, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (3, '10367843568', 3, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (4, '10543265432', 4, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (5, '10354267890', 5, 'Descripción');
    INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (6, '10985432654', 6, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (7, '10432156432', 7, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (8, '10367843568', 8, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (9, '10543265432', 9, 'Descripción');
	INSERT INTO RE_PROFESOR_MATERIA(Id, NumDocumento, Id_Materia, Descripcion)
    VALUES (10, '10354267890', 10, 'Descripción');

GO
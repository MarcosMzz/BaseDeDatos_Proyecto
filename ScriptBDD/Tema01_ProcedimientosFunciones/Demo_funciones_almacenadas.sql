USE gestAcad
GO

-- EJECUTAR Funciones_Almacenadas.sql ANTES QUE ESTA CONSULTA

-- Creacion de datos de prueba
INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
VALUES ('Pedro', 'Sanchez', '2003-05-12', '40123456', 'pedroS@email.com', '12345');

DECLARE @id_alumno INT;
SELECT @id_alumno = id_alumno 
FROM alumnos AS a
WHERE a.dni = '40123456';

INSERT INTO carrera (nombre_carrera)
VALUES ('Ingeniería en Sistemas');

DECLARE @id_carrera INT;
SELECT @id_carrera = id_carrera
FROM Carrera AS c
WHERE c.nombre_carrera = 'Ingeniería en Sistemas';

INSERT INTO cuatrimestre(cuatrimestre)
VALUES (1);

DECLARE @id_cuatrimestre INT;
SELECT @id_cuatrimestre = id_cuatri
FROM cuatrimestre AS c
WHERE c.cuatrimestre = 1

INSERT INTO materia (nombre_materia, id_cuatri, anio_cursada)
VALUES ('Base de Datos', @id_cuatrimestre, 2021);

DECLARE @id_materia INT;
SELECT @id_materia = id_materia
FROM Materia AS m
WHERE m.nombre_materia = 'Base de Datos';

INSERT INTO materia_carrera (id_materia, id_carrera)
VALUES (@id_materia, @id_carrera);

INSERT INTO estados (descripcion)
VALUES ('Activo');

DECLARE @id_estado INT;
SELECT @id_estado = id_estado 
FROM estados AS e
WHERE e.descripcion = 'Activo';

INSERT INTO inscripcion_carrera (fecha_ins_carrera, id_estado, id_alumno, id_carrera)
VALUES (GETDATE(), @id_estado, @id_alumno, @id_carrera);

INSERT INTO examen (fecha, id_materia)
VALUES 
('2025-03-15', @id_materia),
('2025-07-20', @id_materia),
('2025-11-30', @id_materia);

DECLARE @id_examen1 INT;
SELECT @id_examen1 = id_examen
FROM Examen AS ex
WHERE ex.fecha = '2025-03-15' AND ex.id_materia = @id_materia;

INSERT INTO inscripcion_examen (fecha_ins_examen, id_estado, id_alumno, id_examen, calificacion)
VALUES
(GETDATE(), @id_estado, @id_alumno, @id_examen1, 7),
(GETDATE(), @id_estado, @id_alumno, @id_examen1+1, 6),
(GETDATE(), @id_estado, @id_alumno, @id_examen1+2, 5);

-- Demostracion de funciones
SELECT dbo.fn_NombreYApellidoAlumno ('40123456') AS nombre_completo_alumno;
SELECT dbo.fn_PromedioNotas ('40123456') AS promedio_notas;
SELECT dbo.fn_EstadoInscripcionCarrera ('40123456', @id_carrera) AS estado_en_carrera;

-- Borrado de datos de prueba
DELETE FROM inscripcion_carrera WHERE id_estado = @id_estado AND id_alumno = @id_alumno AND id_carrera = @id_carrera;
DELETE FROM inscripcion_examen WHERE id_estado = @id_estado AND id_alumno = @id_alumno AND id_examen = @id_examen1;
DELETE FROM inscripcion_examen WHERE id_estado = @id_estado AND id_alumno = @id_alumno AND id_examen = @id_examen1+1;
DELETE FROM inscripcion_examen WHERE id_estado = @id_estado AND id_alumno = @id_alumno AND id_examen = @id_examen1+2;
DELETE FROM materia_carrera WHERE id_materia = @id_materia AND id_carrera = @id_carrera;
DELETE FROM Examen WHERE id_examen = @id_examen1;
DELETE FROM Examen WHERE id_examen = @id_examen1+1;
DELETE FROM Examen WHERE id_examen = @id_examen1+2;
DELETE FROM estados WHERE id_estado = @id_estado;
DELETE FROM Materia WHERE id_materia = @id_materia;
DELETE FROM cuatrimestre WHERE id_cuatri = @id_cuatrimestre;
DELETE FROM Carrera WHERE id_carrera = @id_carrera;
DELETE FROM alumnos WHERE id_alumno = @id_alumno;

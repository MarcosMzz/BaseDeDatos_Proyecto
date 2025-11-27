use GestAcad;
go;

-- Tarea 1: Implementación de una Transacción Consistente
-- El siguiente código T-SQL define una transacción explícita (BEGIN TRANSACTION) que realiza tres operaciones en las tablas 
-- del esquema gestAcad:
-- una inserción en alumnos, otra inserción en estados, y una actualización en Carrera.
-- Utilizamos la estructura BEGIN TRY...END CATCH para asegurar que si ocurre un error en cualquier punto, 
-- toda la operación se revierte (ROLLBACK), garantizando la atomicidad.
-- Para este ejemplo, asumiremos que ya existe la base de datos gestAcad
-- y que hay un registro en la tabla Carrera para actualizar.


-- CHEQUEOS ANTES DE INICIAR LA TRANSACCION
SELECT * FROM carrera WHERE nombre_carrera = 'Ingeniería en Sistemas'; -- Tiene que devolver un registro
SELECT * FROM carrera WHERE nombre_carrera = 'Licenciatura en Sistemas'; -- No debe devolver nada
SELECT nombre, apellido, dni FROM alumnos WHERE dni = 12345000; -- No debe devolver nada
SELECT * FROM estados WHERE descripcion = 'ESTADO DE PRUEBA DE TRANSACCION'; -- No debe devolver nada


-- INICIO DE LA TRANSACCIÓN CONSISTENTE

BEGIN TRANSACTION TransaccionDeInscripcion;
BEGIN TRY
    -- 1. Insertar un registro en la tabla 'alumnos' 
    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
    VALUES ('Alfredo', 'Gómez', '2001-05-15', 12345000, 'alfredo@gmail.com', 'pwd123');

    -- 2. Insertar otro registro en la tabla 'estados' 
    INSERT INTO estados (descripcion)
    VALUES ('ESTADO DE PRUEBA DE TRANSACCION');

    -- 3. Actualizar un registro en la tabla 'Carrera' 
    UPDATE Carrera
    SET nombre_carrera = 'Licenciatura en Sistemas'
    WHERE nombre_carrera = 'Ingeniería en Sistemas';

    -- Si todas las operaciones se completan sin error, se confirma la transacción.
    PRINT 'Transacción completada exitosamente. Datos confirmados.';
    COMMIT TRANSACTION TransaccionDeInscripcion;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION TransaccionDeInscripcion;
        PRINT 'Error detectado. Se ha realizado ROLLBACK. Ningún dato modificado.';
    END
    
END CATCH

GO
-- Verificación después de la ejecución exitosa
SELECT nombre, apellido, dni FROM alumnos WHERE dni = 12345000; -- Debe devolver el alumno insertado
SELECT * FROM estados WHERE descripcion = 'ESTADO DE PRUEBA DE TRANSACCION'; -- Debe devolver el estado insertado
SELECT nombre_carrera FROM Carrera WHERE nombre_carrera = 'Licenciatura en Sistemas'; -- Debe devolver la carrera modificada

-- Limpieza de datos
DELETE FROM alumnos WHERE dni = 12345000;
DELETE FROM estados WHERE descripcion = 'ESTADO DE PRUEBA DE TRANSACCION';
UPDATE Carrera
    SET nombre_carrera = 'Ingeniería en Sistemas'
WHERE nombre_carrera = 'Licenciatura en Sistemas';


-- Tarea 2
-- INICIO DE LA TRANSACCIÓN CON ERROR
BEGIN TRANSACTION TransaccionDeInscripcion;
BEGIN TRY
    -- 1. Insertar un registro en la tabla 'alumnos' 
    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
    VALUES ('Alfredo', 'Gómez', '2001-05-15', 12345000, 'alfredo@gmail.com', 'pwd123');

    -- 2. Insertar otro registro en la tabla 'estados' 
    INSERT INTO estados (descripcion)
    VALUES ('Completado Temporal');
    
    SAVE TRANSACTION AntesDelError;
    -- ERROR INTENCIONAL 
    -- 2.5. Insertar un registro duplicado en 'alumnos' (Falla al violar la restricción UNIQUE de dni)
    BEGIN TRY
	    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
	    VALUES ('DNI Duplicado', 'Prueba', '2000-01-01', 12345000, 'duplicado@error.com', 'error');
	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION AntesDelError;
	END CATCH
    -- 3. Actualizar un registro en la tabla 'Carrera' 
    UPDATE Carrera
    	SET nombre_carrera = 'Fallo de transaccion'
    WHERE nombre_carrera = 'Ingeniería en Sistemas';

    -- Si todas las operaciones se completan sin error, se confirma la transacción.
    COMMIT TRANSACTION TransaccionDeInscripcion;
    PRINT 'Transacción completada exitosamente. Datos confirmados.';

END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION TransaccionDeInscripcion;
        PRINT 'Error detectado. Se ha realizado ROLLBACK. Ningún dato modificado.';
    END
END CATCH

GO
-- Verificación después de la ejecución exitosa
SELECT nombre, apellido, dni FROM alumnos WHERE dni = 12345000; -- No deberia haber ni un registro
SELECT * FROM estados WHERE descripcion = 'Completado Temporal'; -- No deberia haber ni un registro
SELECT nombre_carrera FROM Carrera WHERE nombre_carrera = 'Fallo de transaccion'; -- No deberia haber ni un registro
SELECT nombre_carrera FROM Carrera WHERE nombre_carrera = 'Ingeniería en Sistemas'; -- Deberia haber un registro







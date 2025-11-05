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

-- *************************************************************
-- PASO DE PREPARACIÓN (Ejecutar solo una vez para crear datos iniciales)
-- Insertar un estado y una carrera base para que las operaciones 
-- de la transacción puedan ser probadas.
BEGIN TRY
    INSERT INTO estados (descripcion) VALUES ('En Proceso de Inscripcion');
    INSERT INTO Carrera (nombre_carrera) VALUES ('Carrera de prueba');
END TRY
BEGIN CATCH
    -- Ignorar si ya existen por restricciones UNIQUE
END CATCH
-- *************************************************************

-- INICIO DE LA TRANSACCIÓN CONSISTENTE
BEGIN TRANSACTION TransaccionDeInscripcion;

BEGIN TRY
    -- 1. Insertar un registro en la tabla 'alumnos' 
    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
    VALUES ('Alfredo', 'Gómez', '2001-05-15', 12345000, 'alfredo@gmail.com', 'pwd123');

    -- 2. Insertar otro registro en la tabla 'estados' 
    INSERT INTO estados (descripcion)
    VALUES ('Completado Temporal');

    -- 3. Actualizar un registro en la tabla 'Carrera' 
    UPDATE Carrera
    SET nombre_carrera = 'Licenciatura en Sistemas'
    WHERE nombre_carrera = 'Carrera de prueba';

    -- Si todas las operaciones se completan sin error, se confirma la transacción.
    COMMIT TRANSACTION TransaccionDeInscripcion;
    PRINT 'Transacción completada exitosamente. Datos confirmados.';

END TRY
BEGIN CATCH
    -- Si ocurre un error, se verifica @@TRANCOUNT y se revierte la transacción.
    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION TransaccionDeInscripcion;
        PRINT 'Error detectado. Se ha realizado ROLLBACK. Ningún dato modificado.';
    END
END CATCH

GO
-- Verificación después de la ejecución exitosa
SELECT nombre, apellido, dni FROM alumnos WHERE dni = 12345000;
SELECT * FROM estados WHERE descripcion = 'Completado Temporal';
SELECT nombre_carrera FROM Carrera WHERE nombre_carrera = 'Licenciatura en Sistemas';

DELETE FROM alumnos WHERE dni = 12345000;
DELETE FROM estados WHERE descripcion = 'Completado Temporal';


-- Tarea 2
-- INICIO DE LA TRANSACCIÓN CON ERROR
BEGIN TRANSACTION TransaccionDeInscripcion;

BEGIN TRY
    -- 1. Insertar un registro en la tabla 'alumnos' 
    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
    VALUES ('Alfredo', 'Gómez', '2001-05-15', 12346000, 'alfredo@gmail.com', 'pwd123');

    -- 2. Insertar otro registro en la tabla 'estados' 
    INSERT INTO estados (descripcion)
    VALUES ('Completado Temporal');
    
    -- ERROR INTENCIONAL 
    -- 2.5. Insertar un registro duplicado en 'alumnos' (Falla al violar la restricción UNIQUE de dni)
    INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
    VALUES ('DNI Duplicado', 'Prueba', '2000-01-01', 12345000, 'duplicado@error.com', 'error');

    -- 3. Actualizar un registro en la tabla 'Carrera' 
    UPDATE Carrera
    SET nombre_carrera = 'Fallo de transaccion'
    WHERE nombre_carrera = 'Licenciatura en Sistemas';

    -- Si todas las operaciones se completan sin error, se confirma la transacción.
    COMMIT TRANSACTION TransaccionDeInscripcion;
    PRINT 'Transacción completada exitosamente. Datos confirmados.';

END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE();

    IF XACT_STATE() <> 0
    BEGIN
        ROLLBACK TRANSACTION TransaccionDeInscripcion;
        PRINT 'Error detectado. Se ha realizado ROLLBACK. Ningún dato modificado.';
    END
END CATCH

GO
-- Verificación después de la ejecución exitosa
SELECT nombre, apellido, dni FROM alumnos WHERE dni = 12345000;
SELECT * FROM estados WHERE descripcion = 'Completado Temporal';
SELECT nombre_carrera FROM Carrera WHERE nombre_carrera = 'Fallo de transaccion';







USE gestAcad
GO

-- Devuelve el nombre completo del alumno
CREATE FUNCTION fn_NombreYApellidoAlumno (@dni INT)
    RETURNS VARCHAR(400)
    AS
    BEGIN
        DECLARE @nombreYApellido VARCHAR(400);

        SELECT @nombreYApellido = nombre + ' ' + apellido
        FROM alumnos
        WHERE dni = @dni;

        RETURN @nombreYApellido;
END;
GO

-- Devuelve el estado del alumno en la carrera
CREATE FUNCTION fn_EstadoInscripcionCarrera (@dni INT, @id_carrera INT)
    RETURNS VARCHAR(100)
    AS
    BEGIN
        DECLARE @estado VARCHAR(100);
        DECLARE @id_alumno INT;

        SELECT @id_alumno = id_alumno
        FROM alumnos
        WHERE dni = @dni

        SELECT @estado = e.descripcion
        FROM inscripcion_carrera AS ic
        INNER JOIN estados AS e ON ic.id_estado = e.id_estado
        WHERE ic.id_alumno = @id_alumno AND ic.id_carrera = @id_carrera;

        RETURN @estado;
END;
GO
 
-- Devuelve el promedio de notas del alumno
CREATE FUNCTION fn_PromedioNotas (@dni INT)
    RETURNS FLOAT
    AS
    BEGIN
        DECLARE @promedio FLOAT;
        DECLARE @id_alumno INT;

        SELECT @id_alumno = id_alumno
        FROM alumnos
        WHERE dni = @dni

        SELECT @promedio = AVG(calificacion)
        FROM inscripcion_examen
        WHERE id_alumno = @id_alumno AND calificacion IS NOT NULL;

        RETURN @promedio;
END;
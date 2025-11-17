USE gestAcad;
GO
-------RECOMENDABLE LIMPIAR LA TABLA alumnos ANTES Y DESPUES DE EJECUTAR, A PODER SER
-------EN UNA CONSULTA DIFERENTE PARA NO AFECTAR RESULTADOS COMPARATIVOS DE RENDIMIENTO

--     DELETE FROM dbo.alumnos;

--INSERCIÓN DIRECTA
DECLARE @i INT = 1;
BEGIN
    WHILE @i <= 10000
    BEGIN
        INSERT INTO dbo.alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
        VALUES (
            CONCAT('Nombre', @i),
            CONCAT('Apellido', @i),
            DATEADD(DAY, -(@i % 10000), '2000-01-01'),
            40000000 + @i,
            CONCAT('alumno', @i, '@mail.com'),
            'pass123'
        );
        SET @i += 1;
    END;
END;

--INSERCIÓN POR PROCEDIMIENTO
DECLARE @j INT = 10001;
DECLARE @nombre VARCHAR(200);
DECLARE @apellido VARCHAR(200);
DECLARE @fecha_nacimiento DATE;
DECLARE @dni INT;
DECLARE @Email VARCHAR(200);
DECLARE @pass VARCHAR(200);

WHILE @j <= 20000
BEGIN
    SET @nombre = 'Nombre' + CAST(@j AS VARCHAR(10));
    SET @apellido = 'Apellido' + CAST(@j AS VARCHAR(10));
    SET @fecha_nacimiento = DATEADD(DAY, -(@j % 10000), '2000-01-01');
    SET @dni = 50000000 + @j;
    SET @Email = 'alumno_proc' + CAST(@j AS VARCHAR(10)) + '@mail.com';
    SET @pass = 'pass456';

    EXEC spInsertar_Alumno
        @nombre = @nombre,
        @apellido = @apellido,
        @fecha_nacimiento = @fecha_nacimiento,
        @dni = @dni,
        @Email = @Email,
        @pass = @pass;

    SET @j = @j + 1;
END;
USE gestAcad;
GO
 DROP PROCEDURE spInsertar_Alumno;
 DROP PROCEDURE spEliminar_Alumno;
 DROP PROCEDURE spModificar_Alumno;
GO
------ PROCEDIMIENTOS ALMACENADOS -------

--INSERTAR
CREATE PROCEDURE spInsertar_Alumno
(
	@nombre VARCHAR(200),
	@apellido VARCHAR(200),
	@fecha_nacimiento DATE,
 	@dni INT,
 	@email VARCHAR(200),
 	@pass VARCHAR(200)
) 

AS

BEGIN
	IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE dni = @dni)
	BEGIN
		PRINT 'ya existe un alumno con ese dni'
	END

	ELSE
	BEGIN
		INSERT INTO dbo.alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
		VALUES (@nombre, @apellido, @fecha_nacimiento, @dni, @email, @pass)
	END
END;
GO

--ELIMINAR
CREATE PROCEDURE spEliminar_Alumno
(
	@dni INT
) 

AS

BEGIN
	IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE dni = @dni)
	BEGIN
		DELETE FROM dbo.alumnos 
		WHERE dni = @dni 
	END

	ELSE	
	BEGIN
		PRINT 'no existe alumno con ese dni'
	END
END;
GO


--MODIFICAR
CREATE PROCEDURE spModificar_Alumno
(
	@dni INT,
	@nombre VARCHAR(200) = NULL,
	@apellido VARCHAR(200) = NULL,
 	@email VARCHAR(200) = NULL,
 	@pass VARCHAR(200) = NULL
)

AS

BEGIN
	IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE dni = @dni)
	BEGIN
		UPDATE dbo.alumnos
		SET	
			nombre = CASE WHEN @nombre IS NOT NULL THEN @nombre ELSE nombre END,
			apellido = CASE WHEN @apellido IS NOT NULL THEN @apellido ELSE apellido END,
			email = CASE WHEN @email IS NOT NULL THEN @email ELSE email END,
			pass = CASE WHEN @pass IS NOT NULL THEN @pass ELSE pass END

		WHERE dni = @dni 
	END

	ELSE	
	BEGIN
		PRINT 'no existe alumno con ese dni'
	END
END
USE gestAcad;
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
	@id INT
) 

AS

BEGIN
	IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE id_alumno = @id)
	BEGIN
		DELETE FROM dbo.alumnos 
		WHERE id_alumno = @id 
	END

	ELSE	
	BEGIN
		PRINT 'no existe alumno con esa id'
	END
END;
GO


--MODIFICAR
CREATE PROCEDURE spModificar_Alumno
(
	@id INT,
	@nombre VARCHAR(200),
	@apellido VARCHAR(200),
 	@email VARCHAR(200),
 	@pass VARCHAR(200)
)

AS

BEGIN
	IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE id_alumno = @id)
	BEGIN
		UPDATE dbo.alumnos
		SET	nombre = @nombre,
			apellido = @apellido,
			email = @email,
			pass = @pass

		WHERE id_alumno = @id 
	END

	ELSE	
	BEGIN
		PRINT 'no existe alumno con esa id'
	END
END
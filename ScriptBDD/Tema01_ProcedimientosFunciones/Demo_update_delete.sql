USE gestAcad
GO
-- EJECUTAR Lotes_de_datos.sql ANTES QUE ESTA CONSULTA


-- Seleccionamos 10 alumnos
SELECT TOP 10 * FROM alumnos

-- Elimnamos 5
EXEC spEliminar_Alumno 40000001
EXEC spEliminar_Alumno 40000003
EXEC spEliminar_Alumno 40000005
EXEC spEliminar_Alumno 40000007
EXEC spEliminar_Alumno 40000009

-- Modificamos los otros 5
EXEC spModificar_Alumno 40000002, @nombre = 'Carlos'
EXEC spModificar_Alumno 40000004, @apellido = 'Rodriguez'
EXEC spModificar_Alumno 40000006, @email = 'autos_845@hotmail.com'
EXEC spModificar_Alumno 40000008, @pass = 'Contraseña0000008'
EXEC spModificar_Alumno 40000010, @nombre = 'Juan', @apellido = 'Perez', @email = 'juan_pe@hotmail.com', @pass = 'Contra10'

-- Seleccionamos los 5 que quedan para ver las modificaciones
SELECT TOP 5 * FROM alumnos

-- intentamos modificar y eliminar un alumno que ya borramos (ver en mensajes)
EXEC spEliminar_Alumno 40000001
EXEC spModificar_Alumno 40000001
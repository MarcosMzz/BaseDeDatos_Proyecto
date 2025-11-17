USE gestAcad
GO
-- EJECUTAR Lotes_de_datos.sql ANTES QUE ESTA CONSULTA


-- Seleccionamos 10 alumnos
SELECT * 
FROM alumnos
WHERE dni = 40000001 OR dni = 40000002 OR dni = 40000003 OR dni = 40000004 OR dni = 40000005 OR dni = 40000006 OR dni = 40000007 OR dni = 40000008 OR dni = 40000009 OR dni = 40000010;

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
SELECT * 
FROM alumnos
WHERE dni = 40000001 OR dni = 40000002 OR dni = 40000003 OR dni = 40000004 OR dni = 40000005 OR dni = 40000006 OR dni = 40000007 OR dni = 40000008 OR dni = 40000009 OR dni = 40000010;


-- intentamos modificar y eliminar un alumno que ya borramos (ver en mensajes)
EXEC spEliminar_Alumno 40000001
EXEC spModificar_Alumno 40000001
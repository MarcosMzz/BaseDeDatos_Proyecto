# Capítulo I: Introducción

En este capítulo se estudian dos elementos fundamentales para la lógica
de negocio dentro de SQL Server: los **Procedimientos Almacenados** 
y las **Funciones Almacenadas**.\
Ambos permiten centralizar operaciones, mejorar la seguridad, favorecer
la reutilización de código y optimizar el rendimiento.

Este trabajo tiene como objetivo aplicar dichos elementos al proyecto 
**GestAcad**

------------------------------------------------------------------------

# Capítulo II: Conceptos Fundamentales

## 2.1. Procedimiento Almacenado

Un **procedimiento almacenado** es un conjunto de instrucciones SQL
precompiladas que se ejecutan en el servidor.\
Pueden recibir parámetros, ejecutar operaciones complejas y 
retornar valores por parámetros de salida o mediante `SELECT`.

**Usos principales:** - Reglas de negocio - Validación de datos -
Operaciones CRUD estandarizadas - Optimización de rendimiento

------------------------------------------------------------------------

## 2.2. Función Almacenada

Una **función almacenada** retorna siempre un valor (escalar o tabla).\
Se utiliza dentro de consultas SELECT o en expresiones.

**Usos principales:** - Cálculos derivados - Valores compuestos -
Consultas que requieren lógica reutilizable

------------------------------------------------------------------------

## 2.3. Diferencias Entre Procedimientos y Funciones

**Retorno de valores:**
Procedimientos: pueden devolver o no un valor.

Funciones: siempre deben retornar un valor.

**Uso en consultas:**
Procedimientos: no pueden utilizarse dentro de un SELECT.

Funciones: sí pueden ser llamadas en un SELECT, WHERE u otras expresiones.

**Modificación de datos:**
Procedimientos: pueden realizar operaciones INSERT, UPDATE y DELETE.

Funciones: no pueden modificar datos; solo realizar cálculos o consultas.

**Complejidad y propósito:**
Procedimientos: se usan para tareas completas y lógicas de negocio.

Funciones: se enfocan en cálculos o valores derivados.


------------------------------------------------------------------------

# Capítulo III: Procedimientos Almacenados

Los **procedimientos almacenados** desarrollados para este trabajo son:

## 3.1. Insertar Alumnos

``` sql
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
        PRINT 'ya existe un alumno con ese dni';
    ELSE
        INSERT INTO dbo.alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass)
        VALUES (@nombre, @apellido, @fecha_nacimiento, @dni, @email, @pass);
END;
GO
```

------------------------------------------------------------------------

## 3.2. Eliminar Alumnos

``` sql
CREATE PROCEDURE spEliminar_Alumno
(
    @dni INT
) 
AS
BEGIN
    IF EXISTS (SELECT 1 FROM dbo.alumnos WHERE dni = @dni)
        DELETE FROM dbo.alumnos WHERE dni = @dni;
    ELSE
        PRINT 'no existe alumno con ese dni';
END;
GO
```

------------------------------------------------------------------------

## 3.3. Modificar Alumnos

``` sql
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
        SET nombre = COALESCE(@nombre, nombre),
            apellido = COALESCE(@apellido, apellido),
            email = COALESCE(@email, email),
            pass = COALESCE(@pass, pass)
        WHERE dni = @dni;
    END
    ELSE
        PRINT 'no existe alumno con ese dni';
END;
GO
```

------------------------------------------------------------------------

# Capítulo IV: Inserción Masiva y Pruebas CRUD

## 4.1. Inserción de Datos Directa vs Procedimientos

Se cargaron **20.000 alumnos** de los cuales:

-   10.000 registros usando **inserción directa**
-   10.000 registros usando el procedimiento **spInsertar_Alumno**

Con el objetivo de comparar la eficiencia de los diferentes metodos

Los resultados fueron:

**Inserción Directa** 

![alt text](eficiencia_insercionDirecta.png)


**Inserción Por Procedimiento**

![alt text](eficiencia_insercionProcedimiento.png)


**Conclusión:**
Al analizar los planes de ejecución, se observa que el bloque con 
inserciones directas tiene un costo relativo del 90%, mientras que 
la ejecución del procedimiento almacenado spInsertar_Alumno tiene 
un costo del 10%. 
 Esto sugiere que el procedimiento almacenado aprovecha mejor la 
 optimización del motor SQL y reutiliza planes de ejecución, 
 resultando más eficiente globalmente. 
 
------------------------------------------------------------------------

## 4.2. Pruebas de Eliminación y Modificación

Se realizaron pruebas con los procedimientos:

**spEliminar_Alumno:** se utilizo para eliminar 5 alumnos
``` sql
EXEC spEliminar_Alumno 40000001
EXEC spEliminar_Alumno 40000003
EXEC spEliminar_Alumno 40000005
EXEC spEliminar_Alumno 40000007
EXEC spEliminar_Alumno 40000009
```
**resultado:** se borraron exitosamente los registros de los alumnos

**spModificar_Alumno:** se utilizo para modificar distintos datos de 
5 alumnos

``` sql
EXEC spModificar_Alumno 40000002, @nombre = 'Carlos'
EXEC spModificar_Alumno 40000004, @apellido = 'Rodriguez'
EXEC spModificar_Alumno 40000006, @email = 'autos_845@hotmail.com'
EXEC spModificar_Alumno 40000008, @pass = 'Contraseña0000008'
EXEC spModificar_Alumno 40000010, @nombre = 'Juan', @apellido = 'Perez', @email = 'juan_pe@hotmail.com', @pass = 'Contra10'
```
**resultado:** se modificaron exitosamente solo los datos modificados para
los primeros cuatro casos y todos los campos modificables para el 
último caso

Por último se intento tanto eliminar como modificar los datos de un 
alumno que ya se habia eliminado

``` sql
EXEC spEliminar_Alumno 40000001
EXEC spModificar_Alumno 40000001
```
**resultado:** no hubo cambios en la tabla y se mostro en la pestaña
de mensajes "no existe alumno con ese dni"

------------------------------------------------------------------------

# Capítulo V: Funciones Almacenadas

Las **funciones almacenadas** desarrolladas para este trabajo son:

## 5.1. Nombre Completo del Alumno

``` sql
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
```

------------------------------------------------------------------------

## 5.2. Estado del Alumno en la Carrera

``` sql
CREATE FUNCTION fn_EstadoInscripcionCarrera (@dni INT, @id_carrera INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @estado VARCHAR(100);
    DECLARE @id_alumno INT;

    SELECT @id_alumno = id_alumno FROM alumnos WHERE dni = @dni;

    SELECT @estado = e.descripcion
    FROM inscripcion_carrera ic
    INNER JOIN estados e ON ic.id_estado = e.id_estado
    WHERE ic.id_alumno = @id_alumno AND ic.id_carrera = @id_carrera;

    RETURN @estado;
END;
GO
```

------------------------------------------------------------------------

## 5.3. Promedio de Notas

``` sql
CREATE FUNCTION fn_PromedioNotas (@dni INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @promedio FLOAT;
    DECLARE @id_alumno INT;

    SELECT @id_alumno = id_alumno FROM alumnos WHERE dni = @dni;

    SELECT @promedio = AVG(calificacion)
    FROM inscripcion_examen
    WHERE id_alumno = @id_alumno AND calificacion IS NOT NULL;

    RETURN @promedio;
END;
GO
```

------------------------------------------------------------------------

# Capítulo VI: Conclusiones

Los procedimientos y las funciones almacenadas son herramientas clave
para organizar y optimizar la lógica dentro de una base de datos. 
Permiten reutilizar código, mejorar el rendimiento y asegurar que las 
operaciones se ejecuten de manera consistente. Su uso contribuye a 
sistemas más claros, eficientes y fáciles de mantener.


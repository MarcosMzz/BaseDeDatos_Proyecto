
-- PROYECTO: GestAcad (Grupo 38)
-- TEMA TÉCNICO: Implementación de Triggers en SQL Server

-- DESCRIPCIÓN:
-- Este script implementa dos tipos de triggers DML para el proyecto GestAcad:
-- 1. Un trigger 'AFTER' para auditoría de cambios en la tabla 'alumnos'.
-- 2. Un trigger 'INSTEAD OF' para prevenir el borrado en la tabla 'materia'.
-- Incluye la creación de tablas auxiliares, los triggers y las pruebas.

 USE GestAcad; 
 GO

/*
UN POCO DE TEÓRICA


-¿QUÉ ES UN TRIGGER?
 Un trigger (disparador) es un objeto de la base de datos, similar a un 
 procedimiento almacenado, que se ejecuta AUTOMÁTICAMENTE cuando ocurre un 
 evento específico.

-¿POR QUÉ USARLOS?
 Los triggers mueven la lógica de negocio y las reglas de integridad desde
 la capa de aplicación (Java, Python, C#) a la capa de base de datos.
 Esto asegura que la regla se cumpla SIEMPRE, sin importar qué aplicación
 o usuario intente modificar los datos.

 -TIPOS DE TRIGGERS DML (Data Manipulation Language)
 Son los que reaccionan a los comandos INSERT, UPDATE o DELETE. En SQL Server
 tenemos principalmente dos tipos:

 1. TRIGGERS 'AFTER' (Después de):
    - Se ejecutan *después* de que la operación (INSERT, UPDATE, DELETE) 
      se haya completado con éxito.
    - Son ideales para AUDITORÍA y LOGGING (como en nuestra Tarea 1),
      ya que la acción ya ocurrió y solo queremos registrarla.
    - NO pueden cancelar la acción.

 2. TRIGGERS 'INSTEAD OF' (En lugar de):
    - Se ejecutan *en lugar de* la operación. Interceptan el comando
      (INSERT, UPDATE, DELETE) y evitan que se ejecute en la tabla.
    - En su lugar, se ejecuta el código que definamos dentro del trigger.
    - Son ideales para PREVENIR o VETAR acciones (como en nuestra Tarea 2)
      o para manejar inserciones en vistas complejas (vistas no actualizables).

--LAS TABLAS VIRTUALES: 'inserted' y 'deleted'
 Cuando un trigger DML se dispara, SQL Server nos da acceso a dos tablas
 temporales (en memoria) que contienen los datos afectados:

 +-------------+-------------------------+--------------------------+
 |   ACCIÓN    |   Tabla 'inserted'      |    Tabla 'deleted'       |
 +-------------+-------------------------+--------------------------+
 |   INSERT    |   Contiene los NUEVOS   |    Está VACÍA            |
 |             |   datos insertados.     |                          |
 +-------------+-------------------------+--------------------------+
 |   DELETE    |   Está VACÍA            |    Contiene los datos    |
 |             |                         |    que FUERON BORRADOS.  |
 +-------------+-------------------------+--------------------------+
 |   UPDATE    |   Contiene los datos    |    Contiene los datos    |
 |             |   NUEVOS (los valores   |    ANTIGUOS (los valores |
 |             |   después del cambio).  |    antes del cambio).    |
 +-------------+-------------------------+--------------------------+

- Usaremos estas tablas para saber qué datos registrar en la auditoría.


--------------------------------------------------------------------
TAREA 1 - TRIGGER DE AUDITORÍA (AFTER UPDATE, DELETE)
--------------------------------------------------------------------

 1: Crear la tabla auxiliar 'auditoria_alumnos'
 Esta tabla almacenará un log de todos los cambios y borrados
 que ocurran en la tabla 'alumnos'.*/

PRINT 'Creando tabla auditoria_alumnos...';
CREATE TABLE auditoria_alumnos (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY, -- ID autoincremental del log
    
    -- Datos del registro ANTES del cambio (datos "viejos")
    id_alumno INT NOT NULL,
    nombre_anterior VARCHAR(100),
    apellido_anterior VARCHAR(100),
    email_anterior VARCHAR(100),
    dni_anterior VARCHAR(20),
    
    -- Datos de control de la auditoría
    operacion CHAR(1) NOT NULL, -- 'U' para Update, 'D' para Delete
    usuario_bd VARCHAR(100) NOT NULL,
    fecha_hora DATETIME NOT NULL,

    -- Restricción para asegurar que solo se registren 'U' o 'D'
    CHECK (operacion IN ('U', 'D'))
);
GO 

-- Paso 2: Crear el Trigger 'trg_audit_alumnos'
-- Se disparará DESPUÉS (AFTER) de un UPDATE o DELETE en la tabla 'alumnos'.
PRINT 'Creando trigger trg_audit_alumnos...';
GO
CREATE TRIGGER trg_audit_alumnos
ON alumnos -- Tabla vigilada
AFTER UPDATE, DELETE -- Eventos que lo disparan
AS
BEGIN
    -- SET NOCOUNT ON evita que SQL Server devuelva mensajes
    -- de "X filas afectadas" por cada operación del trigger,
    -- lo cual mejora el rendimiento y la limpieza.
    SET NOCOUNT ON;

    -- Declaramos variables para almacenar la info de auditoría
    DECLARE @usuario_bd VARCHAR(100);
    DECLARE @fecha_hora DATETIME;
    DECLARE @tipo_operacion CHAR(1);

    -- Obtenemos el usuario y la fecha UNA SOLA VEZ
    -- SUSER_SNAME() es la función de T-SQL para obtener el usuario actual
    SET @usuario_bd = SUSER_SNAME(); 
    SET @fecha_hora = GETDATE(); -- GETDATE() obtiene la fecha/hora actual

    -- Determinamos si la operación fue un UPDATE o un DELETE.
    -- Si la tabla virtual 'INSERTED' (datos nuevos) tiene filas,
    -- significa que fue un UPDATE (porque hay datos nuevos y viejos).
    -- Si 'INSERTED' está vacía, fue un DELETE.
    IF EXISTS (SELECT 1 FROM inserted)
        SET @tipo_operacion = 'U'; -- Fue un Update
    ELSE
        SET @tipo_operacion = 'D'; -- Fue un Delete

    -- Insertamos los datos en nuestra tabla de auditoría.
    -- Obtenemos los datos ANTIGUOS o BORRADOS desde la
    -- tabla virtual 'deleted'.
    INSERT INTO auditoria_alumnos (
        id_alumno,
        nombre_anterior,
        apellido_anterior,
        email_anterior,
        dni_anterior,
        operacion,
        usuario_bd,
        fecha_hora
    )
    SELECT
        d.id_alumno,
        d.nombre,
        d.apellido,
        d.email,
        d.dni,
        @tipo_operacion,
        @usuario_bd,
        @fecha_hora
    FROM 
        deleted d; -- Usamos la tabla mágica 'deleted'
END;
GO

/*-------------------------------------------------------------------------------
TAREA 2 - TRIGGER DE VETO (INSTEAD OF DELETE)
-------------------------------------------------------------------------------

 --1: Crear el Trigger 'trg_veto_delete_materia'
-- Se disparará EN LUGAR DE (INSTEAD OF) un DELETE en la tabla 'materia'.
 Esto previene activamente que la materia sea borrada.*/
PRINT 'Creando trigger trg_veto_delete_materia...';
GO
CREATE TRIGGER trg_veto_delete_materia
ON materia -- Tabla vigilada
INSTEAD OF DELETE -- Evento interceptado
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Emitir un mensaje de error claro al usuario.
    -- RAISERROR es la forma estándar en T-SQL de devolver un error.
    -- Nivel 16 indica un error general que puede ser corregido por el usuario.
    RAISERROR (
        'OPERACIÓN NO PERMITIDA: Las materias no pueden ser eliminadas (Trigger trg_veto_delete_materia). 
         Considere marcarlas como "inactivas" en lugar de borrarlas.', 
        16, -- Nivel de severidad
        1   -- Estado
    );

    -- 2. Revertir la transacción.
    -- Aunque el 'INSTEAD OF' ya previene la acción, 
    -- ROLLBACK TRANSACTION asegura que cualquier parte de una
    -- transacción más grande que haya iniciado esto, sea deshecha.
    ROLLBACK TRANSACTION;
END;
GO

--------------------------------------------------------
--PRUEBAS DE FUNCIONALIDAD
--------------------------------------------------------

PRINT 'Iniciando pruebas de triggers...';

-- PRUEBA 1: Probar el trigger de AUDITORÍA
PRINT '--- Prueba 1: Trigger de Auditoría (trg_audit_alumnos) ---';
BEGIN TRY
    -- 1.1 Insertamos un alumno de prueba
    PRINT 'Insertando alumno de prueba...';
    -- (Asegúrate de que 'password' y 'fecha_nacimiento' acepten NULL 
    -- o ajusta los valores según tu DDL)
    INSERT INTO alumnos (nombre, apellido, email, dni, pass, fecha_nacimiento) 
    VALUES ('Alumno', 'DePrueba', 'prueba@email.com', '99999999', 'pass123', '2000-01-01')

    -- 1.2 Hacemos un UPDATE sobre el alumno
    PRINT 'Actualizando alumno de prueba...';
    UPDATE alumnos 
    SET email = 'prueba.modificado@email.com', nombre = 'AlumnoModificado' 
    WHERE dni = '99999999';

    -- 1.3 Hacemos un DELETE sobre el alumno
    PRINT 'Eliminando alumno de prueba...';
    DELETE FROM alumnos 
    WHERE dni = '99999999';

    -- 1.4 Revisamos la tabla de auditoría
    PRINT 'Resultado de la auditoría (tabla auditoria_alumnos):';
    SELECT 
        operacion, 
        id_alumno, 
        nombre_anterior, 
        email_anterior, 
        usuario_bd, 
        fecha_hora 
    FROM auditoria_alumnos 
    WHERE dni_anterior = '99999999';
    PRINT 'Prueba 1 completada. Deberías ver 2 filas: una "U" (Update) y una "D" (Delete).';
END TRY
BEGIN CATCH
    PRINT 'ERROR en Prueba 1: ' + ERROR_MESSAGE();
END CATCH


-- PRUEBA 2: Probar el trigger de VETO
PRINT '--- Prueba 2: Trigger de Veto (trg_veto_delete_materia) ---';
BEGIN TRY
    -- 2.1 Insertamos una materia de prueba
    PRINT 'Insertando materia de prueba...';
    -- (Ajusta los valores según tu DDL. Asumo id_materia autoincremental)
    INSERT INTO materia (nombre_materia)
    VALUES ('MateriaDePrueba');
    
    DECLARE @id_materia_prueba INT;
    SET @id_materia_prueba = SCOPE_IDENTITY(); -- Obtenemos el ID recién insertado

    -- 2.2 Intentamos borrar la materia
    PRINT 'Intentando borrar la materia de prueba (ID: ' + CAST(@id_materia_prueba AS VARCHAR) + ')...';
    DELETE FROM materia 
    WHERE id_materia = @id_materia_prueba;

    PRINT '...Si ves este mensaje, el trigger de veto FALLÓ.';
END TRY
BEGIN CATCH
    -- El bloque CATCH debería activarse por el RAISERROR
    PRINT 'PRUEBA EXITOSA: El trigger de veto funcionó.';
    PRINT 'Mensaje de error capturado: ' + ERROR_MESSAGE();

    -- 2.3 Verificamos que la materia NO se borró
    IF EXISTS (SELECT 1 FROM materia WHERE id_materia = @id_materia_prueba)
        PRINT 'VERIFICACIÓN: La materia (ID: ' + CAST(@id_materia_prueba AS VARCHAR) + ') sigue existiendo en la BD.';
    ELSE
        PRINT 'VERIFICACIÓN FALLIDA: La materia fue borrada.';
    
    -- Limpieza (opcional, si quieres borrar la materia de prueba)
    -- Para borrarla, primero debes deshabilitar el trigger
    PRINT 'Limpiando materia de prueba (deshabilitando trigger temporalmente)...';
    DISABLE TRIGGER trg_veto_delete_materia ON materia;
    DELETE FROM materia WHERE id_materia = @id_materia_prueba;
    ENABLE TRIGGER trg_veto_delete_materia ON materia;
    PRINT 'Limpieza completada y trigger rehabilitado.';
END CATCH
GO

select * from auditoria_alumnos
select * from Materia
/*******************************************************************************

 CONCLUSIONES DE LA INVESTIGACIÓN Y PRUEBAS:

 1. FUNCIONALIDAD:
    - Se comprobó que los triggers AFTER son una solución robusta y confiable
      para implementar auditorías a nivel de base de datos.
    - Se demostró que los triggers INSTEAD OF son una herramienta efectiva
      para implementar reglas de negocio restrictivas (veto), impidiendo
      operaciones no deseadas que las restricciones (constraints) simples
      no podrían manejar.

 2. IMPACTO EN LA INTEGRIDAD Y SEGURIDAD:
    - La auditoría (Tarea 1) incrementa masivamente la SEGURIDAD y la
      TRAZABILIDAD. Ahora es posible responder "quién, qué y cuándo"
      se modificó un dato crítico.
    - El veto (Tarea 2) garantiza la INTEGRIDAD de los datos al prevenir
      el borrado de entidades maestras (como 'materia'), evitando así
      borrados en cascada accidentales o la pérdida de datos históricos.

 3. CONSIDERACIONES (DIFICULTADES/VENTAJAS):
    - VENTAJA: La lógica está centralizada en la BD, lo que la hace
      independiente de la aplicación que se conecte.
    - DESVENTAJA (Riesgo): Los triggers pueden ser "invisibles" para los
      desarrolladores de aplicaciones, causando confusión si no están
      bien documentados (ej. "¿Por qué no puedo borrar esta materia?").
    - DESVENTAJA (Rendimiento): Un trigger se ejecuta *por cada* operación.
      Si el trigger es complejo o realiza consultas lentas, puede
      impactar severamente el rendimiento (performance) de las operaciones
      DML en esa tabla. Deben ser lo más eficientes posible.

 
*/

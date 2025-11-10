# Capítulo I: Introducción

Un **Trigger** (o disparador) es un objeto especial dentro de la base de datos, similar a un procedimiento almacenado, que se ejecuta de forma **automática** cuando ocurre un evento específico. Estos eventos son generalmente operaciones de manipulación de datos (DML) como `INSERT`, `UPDATE` o `DELETE` sobre una tabla específica.

El objetivo de este capítulo es aplicar esta tecnología en el proyecto **GestAcad** para cumplir dos objetivos críticos de negocio y auditoría:

1.  **Auditoría (Trazabilidad):** Mantener un registro histórico de todos los cambios y eliminaciones que sufran los datos sensibles en la tabla `alumnos`.
2.  **Integridad (Veto):** Prevenir activamente la eliminación de registros en tablas maestras, específicamente en la tabla `Materia`, para evitar la pérdida de integridad referencial histórica.

Este trabajo documentará los tipos de triggers disponibles en SQL Server, la implementación de los dos casos mencionados y la evaluación de su impacto en el sistema.

---

# Capítulo II: Tipos de Triggers

En SQL Server, los triggers se pueden clasificar según el evento que los dispara (DML, DDL) o el momento en que se ejecutan (AFTER, INSTEAD OF). Para este proyecto, nos centramos en los **Triggers DML**.

## 2.1. Triggers DML: AFTER (Después de)

Este es el tipo de trigger más común. Se ejecuta *después* de que la operación DML (`INSERT`, `UPDATE` o `DELETE`) se haya completado con éxito.

* **Caso de uso principal:** Auditoría y registro (logging).
* **Funcionamiento:** La acción (ej. el `DELETE`) ya ocurrió. El trigger se activa para registrar ese hecho en una tabla de bitácora. No puede cancelar la acción, solo reaccionar a ella.
* **Aplicación en GestAcad:** Se usará para implementar la **Tarea 1 (Auditoría)** en la tabla `alumnos`.

## 2.2. Triggers DML: INSTEAD OF (En lugar de)

Este trigger es más complejo y potente. Se ejecuta *en lugar de* la operación DML. Es decir, intercepta el comando (`INSERT`, `UPDATE` o `DELETE`) y **evita que se ejecute** en la tabla. En su lugar, ejecuta el código que se defina dentro del trigger.

* **Caso de uso principal:** Prevenir o vetar acciones, y permitir la actualización de vistas complejas (que no son actualizables por sí mismas).
* **Funcionamiento:** El `DELETE` original nunca se ejecuta. El trigger toma el control total.
* **Aplicación en GestAcad:** Se usará para implementar la **Tarea 2 (Veto)** en la tabla `Materia`.

## 2.3. Las Tablas Virtuales: `inserted` y `deleted`

Para que los triggers DML funcionen, SQL Server proporciona dos tablas virtuales (en memoria) que contienen las filas afectadas por la operación:

* **`inserted`**: Contiene las **filas nuevas**.
    * En un `INSERT`: Contiene los nuevos registros.
    * En un `UPDATE`: Contiene los datos *después* del cambio (valores nuevos).
* **`deleted`**: Contiene las **filas antiguas**.
    * En un `DELETE`: Contiene los registros que se acaban de borrar.
    * En un `UPDATE`: Contiene los datos *antes* del cambio (valores viejos).

Usaremos la tabla `deleted` en nuestras dos implementaciones.

---

# Capítulo III: Implementación y Pruebas

A continuación, se detalla la implementación y los resultados de las pruebas para cada trigger solicitado.

## 3.1. Tarea 1: Trigger de Auditoría en `alumnos` (AFTER)

**Objetivo:** Registrar en una tabla `auditoria_alumnos` los valores *antiguos* de un alumno cuando este sea modificado (`UPDATE`) o eliminado (`DELETE`).

### 3.1.1. Creación de la Tabla de Auditoría

Primero, se crea la tabla auxiliar:

```sql
CREATE TABLE auditoria_alumnos (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    id_alumno INT NOT NULL,
    nombre_anterior VARCHAR(200),
    apellido_anterior VARCHAR(200),
    dni_anterior INT,
    email_anterior VARCHAR(200),
    operacion CHAR(1) NOT NULL CHECK (operacion IN ('U', 'D')),
    usuario_bd VARCHAR(100) NOT NULL,
    fecha_hora DATETIME NOT NULL
);
```

### 3.1.2. Creación del Trigger AFTER

```sql
CREATE TRIGGER trg_audit_alumnos
ON alumnos -- Tabla vigilada
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @usuario_bd VARCHAR(100) = SUSER_SNAME();
    DECLARE @fecha_hora DATETIME = GETDATE();
    DECLARE @tipo_operacion CHAR(1);

    IF EXISTS (SELECT 1 FROM inserted)
        SET @tipo_operacion = 'U'; -- Fue un Update
    ELSE
        SET @tipo_operacion = 'D'; -- Fue un Delete

    -- Insertamos en la auditoría los datos VIEJOS desde la tabla 'deleted'
    INSERT INTO auditoria_alumnos (
        id_alumno,
        nombre_anterior,
        apellido_anterior,
        dni_anterior,
        email_anterior,
        operacion,
        usuario_bd,
        fecha_hora
    )
    SELECT
        d.id_alumno,
        d.nombre,
        d.apellido,
        d.dni,
        d.email,
        @tipo_operacion,
        @usuario_bd,
        @fecha_hora
    FROM 
        deleted d; -- Usamos la tabla mágica 'deleted'
END;
```

### 3.1.3. Pruebas y Resultados

Se ejecutaron las siguientes operaciones:

```sql
-- 1. Insertamos un alumno de prueba
INSERT INTO alumnos (nombre, apellido, fecha_nacimiento, dni, email, pass) 
VALUES ('Alumno', 'DePrueba', '2000-01-01', 99999999, 'prueba@email.com', 'pass123');

-- 2. Hacemos un UPDATE
UPDATE alumnos
SET email = 'prueba.modificado@email.com', nombre = 'AlumnoModificado' 
WHERE dni = 99999999;

-- 3. Hacemos un DELETE
DELETE FROM alumnos
WHERE dni = 99999999;
```

Resultado en auditoria_alumnos: Al consultar SELECT * FROM auditoria_alumnos;, la prueba es exitosa. Se observan dos registros:
<img width="880" height="77" alt="image" src="https://github.com/user-attachments/assets/233da328-2f10-46af-942d-9b7a93a3c4cd" />



## 3.2. Tarea 2: Trigger de Veto en `Materia` (INSTEAD OF)

**Objetivo:** Prevenir la eliminación (`DELETE`) de registros en la tabla Materia y notificar al usuario.

### 3.2.1 Creación del Trigger INSTEAD OF

```sql
CREATE TRIGGER trg_veto_delete_materia
ON Materia -- Tabla vigilada
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Emitir un mensaje de error claro al usuario.
    RAISERROR (
        'OPERACIÓN NO PERMITIDA: Las materias no pueden ser eliminadas (Trigger trg_veto_delete_materia).', 
        16, -- Nivel de severidad (error)
        1   -- Estado
    );

    -- 2. Revertir la transacción.
    ROLLBACK TRANSACTION;
END;
```

### 3.2.2 Pruebas y Resultados

Se ejecutaron las siguientes operaciones:

```sql
-- 1. Insertamos una materia de prueba
INSERT INTO Materia (nombre_materia) VALUES ('MateriaDePrueba');
-- (Asumamos que el ID generado es 4)

-- 2. Intentamos borrar la materia
DELETE FROM Materia WHERE id_materia = 4;
```

Resultado en la consola: La prueba es exitosa. La operación DELETE no se ejecuta y la consola de SQL Server devuelve el error que definimos:

<img width="906" height="319" alt="image" src="https://github.com/user-attachments/assets/14aec10a-ee9e-498e-8d75-6c30c1574017" />



---

# Capitulo IV: Evaluacion de Resultados

La implementación de los triggers cumple con los criterios de evaluación establecidos:

**Impacto en la Integridad:** El trigger trg_veto_delete_materia (INSTEAD OF) garantiza la integridad de los datos a un nivel que una restricción de FOREIGN KEY por sí sola no puede. Previene activamente una acción de negocio (borrar materias) que se considera peligrosa, evitando así borrados en cascada accidentales y la pérdida de datos históricos.

**Impacto en la Seguridad:** El trigger trg_audit_alumnos (AFTER) incrementa exponencialmente la seguridad del sistema al implementar la trazabilidad. Ahora es posible responder a las preguntas "quién, qué y cuándo" se modificó o borró un dato crítico de un alumno, lo cual es fundamental para cualquier sistema académico.

**Funcionalidad:** Como se demostró en el Capítulo III, las pruebas confirman que ambos triggers son 100% funcionales y responden correctamente a los eventos UPDATE, DELETE.

---

# Capitulo V: Conclusiones

Los triggers demostraron ser una herramienta extremadamente poderosa para centralizar la lógica de negocio y las reglas de auditoría directamente en el motor de la base de datos.

## 5.1 FUNCIONALIDAD:
Se comprobó que los triggers AFTER son una solución robusta y confiable para implementar auditorías a nivel de base de datos.
Se demostró que los triggers INSTEAD OF son una herramienta efectiva para implementar reglas de negocio restrictivas (veto), impidiendo
operaciones no deseadas que las restricciones (constraints) simples no podrían manejar.

## 5.2 IMPACTO EN LA INTEGRIDAD Y SEGURIDAD:
La auditoría (Tarea 1) incrementa masivamente la SEGURIDAD y la TRAZABILIDAD. Ahora es posible responder "quién, qué y cuándo" se modificó un dato crítico.
El veto (Tarea 2) garantiza la INTEGRIDAD de los datos al prevenir el borrado de entidades maestras (como 'Materia'), evitando así
borrados en cascada accidentales o la pérdida de datos históricos.

## 5.3 CONSIDERACIONES (DIFICULTADES/VENTAJAS):
-VENTAJA (Centralizacion y Robustez): Las reglas de negocio (como "no borrar materias") están en la BD, no en la aplicación. Esto asegura que la regla se cumpla sin importar quién se conecte (un desarrollador, un administrador, una app web, etc.).
La auditoría AFTER es automática y no puede ser "olvidada" por un programador de aplicaciones.

DESVENTAJA (Riesgo):Los triggers pueden ser "invisibles" para los desarrolladores. Un programador podría no entender por qué su DELETE falla o por qué la base de datos se vuelve lenta, ya que la lógica está "oculta" en el trigger. Una documentación clara es esencial.

-DESVENTAJA (Rendimiento): Un trigger se ejecuta *por cada* operación.  Si el trigger es complejo (ej. consulta muchas tablas), puede impactar severamente el rendimiento (performance) de las operaciones
DML en tablas muy concurridas. Deben ser lo más eficientes posible.

---

# Capitulo VI: Bibliografia

Triggers DML (AFTER / INSTEAD OF) (SQL Server). https://learn.microsoft.com/es-es/sql/relational-databases/triggers/dml-triggers

CREATE TRIGGER (Transact-SQL). https://learn.microsoft.com/es-es/sql/t-sql/statements/create-trigger-transact-sql

Usar las tablas inserted y deleted. https://learn.microsoft.com/es-es/sql/relational-databases/triggers/use-the-inserted-and-deleted-tables

Paginas visitadas el 03/11/25

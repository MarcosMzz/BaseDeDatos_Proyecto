/*
OBJETIVO:
Probar cómo impactan los índices agrupados (clustered) y no agrupados 
(non-clustered) en una consulta por rango de fechas sobre una tabla 
con un millón de registros.
*/

USE gestAcad;
GO

-- Si ya existe una tabla de prueba, la borramos antes de empezar
IF OBJECT_ID('dbo.Examen_Prueba', 'U') IS NOT NULL
    DROP TABLE dbo.Examen_Prueba;
GO

/*
No usamos directamente la tabla 'Examen' del proyecto porque:
1. En SQL Server, la clave primaria genera automáticamente 
   un índice agrupado (clustered index).
2. Como solo puede existir un índice agrupado por tabla, 
   no podemos crear otro índice agrupado sobre la columna 'fecha'.

-- -----------------------------------------------------------------
-- INTENTO FALLIDO: ÍNDICE AGRUPADO EN LA TABLA OFICIAL
-- -----------------------------------------------------------------
-- Este bloque es solo para demostrar lo que pasa si intentamos
-- crear un índice agrupado sobre 'fecha' en la tabla original.
-- SQL Server devuelve un error porque ya existe uno sobre 'id_examen'.
*/

CREATE CLUSTERED INDEX idx_examen_fecha_agrupado
ON Examen(fecha);
GO

/*-- Resultado esperado:
-- "Cannot create more than one clustered index on table 'Examen'."
Por eso creamos 'Examen_Prueba': sin PK.
*/

CREATE TABLE Examen_Prueba (
    fecha DATE NOT NULL,
    id_materia INT NOT NULL
);
GO

/*
Creamos una vista para hacer la carga masiva (BULK INSERT).
*/

CREATE VIEW dbo.v_examen_bulk AS
SELECT
    fecha,
    id_materia
FROM
    Examen;
GO

-- Cargamos el millon de registros
-- Cargamos el archivo CSV con las columnas (fecha, id_materia)
-- en ambas tablas: la de prueba y la oficial.
BULK INSERT dbo.Examen_Prueba
FROM 'C:\datos\examenes_prueba.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 100000
);
GO

BULK INSERT dbo.v_examen_oficial_bulk
FROM 'C:\datos\examenes_prueba.csv'
WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    BATCHSIZE = 100000
);
GO

-- Activamos estadísticas de tiempo y de E/S para medir el rendimiento
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- -----------------------------------------------------------------
-- PRUEBA 1: CONSULTA SIN ÍNDICE
-- -----------------------------------------------------------------
-- Como la tabla no tiene índices, el plan de ejecución va a mostrar 
-- un “Table Scan”, es decir, lectura completa de la tabla.
SELECT * FROM Examen_Prueba 
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

SELECT fecha,id_materia FROM Examen
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- -----------------------------------------------------------------
-- PRUEBA 2: ÍNDICE AGRUPADO EN TABLA DE PRUEBA
-- -----------------------------------------------------------------
-- Esto reordena físicamente la tabla según la columna 'fecha'.
CREATE CLUSTERED INDEX idx_pruebas_fecha_agrupado
ON Examen_Prueba(fecha);
GO

-- Repetimos la misma consulta y comparamos tiempos con la anterior.
SELECT * FROM Examen_Prueba 
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

SELECT fecha,id_materia FROM Examen
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

--Borramos el indice agrupado

DROP INDEX idx_pruebas_fecha_agrupado ON Examen_Prueba;
GO

-- -----------------------------------------------------------------
-- PRUEBA 3: ÍNDICE NO AGRUPADO (NON-CLUSTERED)
-- -----------------------------------------------------------------
-- Ahora probamos con un índice no agrupado.
-- Incluimos 'id_materia' para que sea un índice “cubierto”
-- (la consulta puede resolverse solo con el índice).

CREATE NONCLUSTERED INDEX idx_pruebas_fecha_noagrupado
ON Examen_Prueba(fecha)
INCLUDE (id_materia);
GO

-- Ejecutamos de nuevo la misma consulta

SELECT * FROM Examen
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

SELECT * FROM Examen_Prueba 
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- También creamos uno similar en la tabla original (esto no da error
-- porque ya tiene su índice agrupado por la PK).
CREATE NONCLUSTERED INDEX idx_examen_fecha_noagrupado
ON Examen(fecha);
GO

-- Ejecutamos de nuevo la misma consulta

SELECT * FROM Examen
WHERE fecha BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- Borramos la tabla de prueba para dejar todo en su estado "original"
DROP TABLE Examen_Prueba;
GO

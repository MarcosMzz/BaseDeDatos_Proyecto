import csv
import random
from datetime import date, timedelta

CANT_MATERIAS = 50

with open('materias.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['nombre_materia', 'id_cuatri', 'anio_cursada'])

    for i in range(1, CANT_MATERIAS + 1):
        nombre_materia = f"Materia {i}"
        id_cuatri = random.randint(1, 2)
        anio_cursada = random.randint(2015, 2030)

        writer.writerow([nombre_materia, id_cuatri, anio_cursada])

print("Archivo materias.csv generado.")

CANTIDAD_REGISTROS = 1_000_000
# CANT_MATERIAS = 50 Cantidad de materias generadas previamente

start_date = date.today() - timedelta(days=10 * 365)
end_date = date.today()
total_dias = (end_date - start_date).days

print(f"Generando {CANTIDAD_REGISTROS} registros de exámenes...")

with open('examenes_prueba.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['fecha', 'id_materia'])

    for i in range(CANTIDAD_REGISTROS):
        if i > 0 and i % 100000 == 0:
            print(f"{i} registros generados...")

        id_materia = random.randint(1, CANT_MATERIAS)
        random_days = random.randint(0, total_dias)
        fecha = start_date + timedelta(days=random_days)

        writer.writerow([fecha.isoformat(), id_materia])

print(f"Archivo examenes_prueba.csv generado con {CANTIDAD_REGISTROS} registros.")

# Para insertar los datos generados se recomienda utilziar una view de las tablas Materia y Examen debido
# que hace conflicto con la primaryKey + Identity
#A continuacion dejo ambos ejemplos
# View para materia
#CREATE VIEW dbo.v_materia_bulk AS
#SELECT
#   nombre_materia,
#   id_cuatri,
#   anio_cursada
#FROM
#   materia;

# View para Examen
#CREATE VIEW dbo.v_examen_bulk AS
#SELECT
#    fecha,
#    id_materia
#FROM
#   examen;

#Ademas se debe crear una carpeta en la raiz del disco C llamada datos y darle los permisos al sql.
#El nombre es opcional pero de esa forma ya se puede utilizar la prueba de indice sin cambiar nada.
#Como dar permisos 
#Carpeta que contiene los archivos cvs
# -> Propiedades
# -> Seguridad
# -> Editar
# -> Agregar
# -> NT SERVICE\MSSQL$SQLEXPRESS
# -> Comprobar nombres
# -> Aceptar
# -> Permisos: Lectura / Ejecución
# -> Aplicar
# -> OK

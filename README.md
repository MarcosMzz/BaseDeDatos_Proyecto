# **Sistema de Gestión Académica**
**GestAcad**

**Universidad Nacional del Nordeste**

**Licenciatura en sistemas e información**

**Bases de Datos 1**

**Sistema de Gestión Académica**
**GestAcad**

**Profesores**: Darío Villegas, Juan Jose Cuzziol, Walter Vallejos, Numa Badaracco.

**Grupo: 38**

**Integrantes**
- Bazzola Gabriel Esteban
- Rojas Yaccuzzi Joaquin
- Zambrano Franco
- Mazzanti Marcos Santino

# Índice

1. [Capítulo I: Introducción](#capítulo-i-introducción)  
   1.1. [Tema](#tema)  
   1.2. [Planteamiento del problema](#planteamiento-del-problema)  
   1.3. [Objetivo general](#objetivo-general)  
   1.4. [Objetivos específicos](#objetivos-específicos)  
   1.5. [Alcance](#alcance)  
2. [Capítulo II: Marco conceptual o referencial](#capítulo-ii-marco-conceptual-o-referencial)  
3. [Capítulo III: Metodología](#capítulo-iii-metodología)  
   3.1. [Descripción del proceso](#descripción-del-proceso)  
   3.2. [Herramientas utilizadas](#herramientas-utilizadas)  
4. [Capítulo IV: Desarrollo del tema / Resultados](#capítulo-iv-desarrollo-del-tema--resultados)  
   4.1. [Modelo entidad-relación](#modelo-entidad-relación)  
   4.2. [Diagrama de entidad-relación](#diagrama-de-entidad-relación)  
   4.3. [Presentación de temas](#presentación-de-temas)
6. [Capítulo V: Conclusiones](#capítulo-v-conclusiones)  
7. [Capítulo VI: Bibliografía](#capítulo-vi-bibliografía)  

 

## CAPÍTULO I: INTRODUCCIÓN
### Tema
El proyecto aborda el diseño e implementación de una base de datos académica denominada gestAcad, orientada a centralizar la información vinculada a los alumnos de una institución educativa.
El foco está en organizar y digitalizar los procesos relacionados con inscripciones a carreras, materias, comisiones y exámenes, así como el registro de calificaciones y estados académicos.
________________________________________
### Planteamiento del problema  

Actualmente, la gestión académica suele realizarse en sistemas poco integrados o incluso en registros físicos, lo que provoca:  

- Dificultades para mantener un historial confiable de inscripciones y calificaciones.  
- Errores o inconsistencias en la administración de materias, comisiones y exámenes.  
- Información dispersa y propensa a pérdidas.  
- Complejidad para obtener una visión clara del estado académico de los alumnos.  

Por lo tanto, surge la necesidad de contar con una base de datos centralizada que garantice un registro organizado, consistente y seguro de toda la trayectoria académica del estudiante.  

________________________________________
### Objetivo general  

Desarrollar e implementar un modelo de base de datos (**gestAcad**) que permita gestionar de manera integral la información académica de los alumnos, abarcando inscripciones, exámenes, comisiones y estados académicos.  

### Objetivos específicos  

- Registrar alumnos con datos personales únicos y validados.  
- Administrar carreras y vincularlas con sus materias correspondientes.  
- Gestionar inscripciones a carreras, materias, comisiones y exámenes.  
- Registrar calificaciones y estados de los exámenes.  
- Mantener el seguimiento del estado académico de cada alumno (activo, regular, aprobado, desaprobado, etc.).  
- Garantizar la trazabilidad de la trayectoria académica completa del estudiante.  

________________________________________

### Alcance
El proyecto se limita al modelado y puesta en marcha de una base de datos enfocada en los alumnos.
No incluye otros módulos administrativos ni de gestión institucional, centrándose únicamente en el núcleo académico: carreras, materias, comisiones, exámenes y estados asociados al alumno.

________________________________________

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL
Marco conceptual
Este proyecto responde a la necesidad de organizar y centralizar la información académica de los alumnos, asegurando procesos más claros y eficientes en las instituciones educativas.
La base de datos busca:
•	Mejorar la administración de inscripciones.
•	Ofrecer un registro histórico y confiable de la trayectoria del alumno.
•	Facilitar el análisis académico mediante la información normalizada.
La implementación de un sistema de este tipo contribuye a la digitalización educativa, simplificando la gestión interna y brindando mayor precisión en la información.

________________________________________

# CAPÍTULO III: METODOLOGÍA SEGUIDA

## Descripción del proceso

El desarrollo se llevó a cabo siguiendo un enfoque incremental,
aplicando principios de trabajo colaborativo. Las principales
actividades fueron:

-   Relevamiento de requerimientos\
-   Modelado inicial en ERD Plus\
-   Normalización y validación del esquema\
-   Implementación en SQL Server\
-   Pruebas CRUD, procedimientos, funciones e índices\
-   Documentación final del proceso

## Herramientas utilizadas

-   **ERD Plus:** para la elaboración del modelo entidad-relación\
-   **SQL Server Management Studio (SSMS):** para implementar y probar
    la base de datos\
-   **WhatsApp:** como herramienta principal para la comunicación del
    equipo, coordinación de tareas y resolución rápida de dudas\
-   **GitHub:** para respaldo y control de versiones del
    proyecto
________________________________________
## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS
### Modelo entidad-relación
A partir del modelado realizado, se diseñó la base de datos de gestAcad, estructurada en torno al alumno como entidad principal.
El esquema contempla las siguientes relaciones clave:
•	Inscripciones de alumnos a carreras, materias, comisiones y exámenes.
•	Administración de carreras y materias.
•	Registro de exámenes con calificaciones y estados académicos.
•	Asociación de estados a cada proceso académico (activo, regular, aprobado, desaprobado, etc.).

### Diagrama de entidad-relación
![Diagrama DER](Doc/DERGestAcadNuevo.png)
El modelo asegura la integridad referencial mediante claves primarias y foráneas, y ofrece una visión clara de
la trayectoria académica del estudiante desde su ingreso a una carrera hasta la aprobación de sus exámenes.

### Procedimientos almacenados

Se desarrollaron procedimientos para:

-   Insertar alumnos\
-   Modificar alumnos\
-   Eliminar alumnos\
-   Implementar lógica de negocio centralizada\
-   Mejorar seguridad y reutilización del código

Las pruebas CRUD demostraron diferencias claras en rendimiento entre
inserción directa y mediante SPs, mostrando mayor eficiencia al
reutilizar planes de ejecución.

## Presentación de temas

### Funciones almacenadas

Se implementaron funciones para:

-   Obtener nombre completo del alumno\
-   Obtener estado de inscripción a carrera\
-   Calcular promedio de notas

Las funciones demostraron ser útiles para lógica de consulta
reutilizable y cálculos derivados.

### Inserción masiva

Se cargaron 20.000 registros divididos en inserción directa y por
procedimientos, evidenciando:

-   90% costo relativo en inserciones directas\
-   10% costo relativo mediante SPs

### Índices

Se realizaron pruebas con:

-   Índice agrupado\
-   Índices no agrupados con INCLUDE\
-   Índices múltiples

Se observó:

-   Reducción significativa de tiempos\
-   Eliminación de Table Scans\
-   Mayor uso de Index Seek

### Triggers

Se implementaron dos tipos:

-   **Trigger AFTER** para auditoría de modificaciones y eliminaciones
    en alumnos\
-   **Trigger INSTEAD OF** para vetar la eliminación de materias

Resultados:

-   Incremento en trazabilidad\
-   Prevención de operaciones críticas\
-   Aseguramiento de integridad histórica
________________________________________
# CAPÍTULO V: CONCLUSIONES

El proyecto GestAcad permitió desarrollar una base de datos académica
robusta, normalizada y completamente funcional. A partir del trabajo
realizado se concluye que:

###  Centralización y organización

La base de datos permite almacenar y relacionar toda la información
académica de manera coherente y trazable.

###  Optimización y rendimiento

Las pruebas demostraron que el uso adecuado de:

-   Procedimientos almacenados\
-   Funciones\
-   Índices\
-   Triggers

mejora de manera notable la eficiencia del sistema, reduciendo tiempos y
evitando operaciones costosas.

### Integridad y seguridad

Los triggers implementados fortalecen la integridad referencial y
agregan auditoría interna, lo cual es esencial para un sistema
académico.

### Escalabilidad

El modelo está preparado para ampliarse a módulos administrativos o
sistemas externos sin comprometer su estructura.

### Trabajo colaborativo

El uso de herramientas como WhatsApp y Github favoreció la coordinación
del equipo y permitió resolver problemas de forma rápida.

### Conclusión final

GestAcad constituye una solución completamentemente funcional que
integra modelado, implementación y optimización avanzada de bases de
datos, demostrando la importancia de aplicar buenas prácticas de diseño
y programación en entornos académicos reales.

________________________________________
## VI: Bibliografía

- Unidad 2: Diseño de Bases de Datos y el Modelo Entidad-Relación. Aula Virtual – Base de Datos I.  
- Unidad 3: El modelo relacional. Aula Virtual – Base de Datos I.  
- Unidad 5: SQL y SQL Avanzado. Aula Virtual – Base de Datos I.  
- El Lenguaje de Definición de Datos (DDL) y su aplicación en Bases de Datos Relacionales. Aula Virtual – Base de Datos I.  
- ERDPlus. Herramienta para el modelado de bases de datos. Disponible en: [https://erdplus.com](https://erdplus.com)  

USE gestAcad;
GO

----------------------------------------------------------------------
-- INSERCIÓN DE CUATRIMESTRES 
-- Define los períodos académicos (1° y 2° cuatrimestre).
----------------------------------------------------------------------
INSERT INTO cuatrimestre (cuatrimestre) VALUES 
('1° Cuatrimestre'), -- ID 1
('2° Cuatrimestre'); -- ID 2
GO

----------------------------------------------------------------------
-- INSERCIÓN DE ESTADOS
-- Define los estados posibles para inscripciones.
----------------------------------------------------------------------
INSERT INTO estados (descripcion) VALUES
('Activo'),      -- ID 1 (Para inscripción a carrera)
('Inactivo'),    -- ID 2 (Para inscripción a carrera)
('Regular'),     -- ID 3 (Para inscripción a examen)
('Libre');       -- ID 4 (Para inscripción a examen)
GO

----------------------------------------------------------------------
-- INSERCIÓN DE CARRERAS 
-- Carga el catálogo de carreras ofrecidas por la institución.
----------------------------------------------------------------------
INSERT INTO carrera (nombre_carrera) VALUES
('Ingeniería en Sistemas'),           -- ID 1
('Tecnicatura en Programación'),    -- ID 2
('Licenciatura en Gestión Educativa'),-- ID 3
('Ingeniería Electrónica'),           -- ID 4
('Administración de Empresas'),     -- ID 5
('Contador Público'),               -- ID 6
('Psicología'),                     -- ID 7
('Diseño Gráfico'),                 -- ID 8
('Ingeniería Industrial'),          -- ID 9
('Abogacía');                       -- ID 10
GO

----------------------------------------------------------------------
-- INSERCIÓN DE MATERIAS
-- Carga el catálogo de materias, asociándolas a un cuatrimestre (id_cuatri)
-- y al año de cursada correspondiente.
----------------------------------------------------------------------
INSERT INTO materia (id_cuatri, nombre_materia, anio_cursada) VALUES
(1,'Programación I',1),             -- ID 1
(2,'Programación II',1),            -- ID 2
(1,'Matemática Discreta',1),        -- ID 3
(2,'Bases de Datos I',2),           -- ID 4
(1,'Arquitectura de Computadoras',2), -- ID 5
(2,'Redes I',2),                    -- ID 6
(1,'Sistemas Operativos',2),        -- ID 7
(2,'Ingeniería de Software I',3),   -- ID 8
(1,'Proyecto Final',3),             -- ID 9
(2,'Pedagogía I',1),                -- ID 10
(1,'Pedagogía II',2),               -- ID 11
(2,'Circuitos Electrónicos I',1),   -- ID 12
(1,'Circuitos Electrónicos II',2),  -- ID 13
(2,'Electromagnetismo',1),          -- ID 14
(1,'Microcontroladores',2),         -- ID 15
(2,'Contabilidad I',1),             -- ID 16
(1,'Contabilidad II',2),            -- ID 17
(2,'Impuestos I',2),                -- ID 18
(1,'Finanzas I',3),                 -- ID 19
(2,'Administración I',1),           -- ID 20
(1,'Macroeconomía',2),              -- ID 21
(2,'Recursos Humanos',2),           -- ID 22
(1,'Marketing I',2),                -- ID 23
(2,'Derecho Penal I',1),            -- ID 24
(1,'Derecho Penal II',2),           -- ID 25
(2,'Derecho Civil I',1),            -- ID 26
(1,'Derecho Civil II',2),           -- ID 27
(2,'Psicología General',1),         -- ID 28
(1,'Psicología Social',2),          -- ID 29
(2,'Neurociencias I',2),            -- ID 30
(1,'Diseño I',1),                   -- ID 31
(2,'Diseño II',2),                  -- ID 32
(1,'Comunicación Visual',1),        -- ID 33
(2,'Producción Multimedial',2),     -- ID 34
(1,'Cálculo I',1),                  -- ID 35
(2,'Cálculo II',2),                 -- ID 36
(1,'Física I',1),                   -- ID 37
(2,'Física II',2),                  -- ID 38
(1,'Producción Industrial',3),      -- ID 39
(2,'Organización Industrial',3),    -- ID 40
(1,'Ética Profesional',1),          -- ID 41
(2,'Metodología de la Investigación',1), -- ID 42
(1,'Estadística',2),                -- ID 43
(2,'Probabilidad',2),               -- ID 44
(1,'Sociología',1),                 -- ID 45
(2,'Filosofía',1),                  -- ID 46
(1,'Literatura',2),                 -- ID 47
(2,'Historia Moderna',2);           -- ID 48
GO

----------------------------------------------------------------------
-- INSERCIÓN DE COMISIONES 
-- Crea las comisiones (cursos específicos) para cada materia.
-- Se usa el id_materia de la sección anterior.
----------------------------------------------------------------------
INSERT INTO comision (id_materia, nro_comision) VALUES
(1,1001), -- Programación I
(2,1002), -- Programación II
(3,1003), -- Matemática Discreta
(3,2003), -- Matemática Discreta (Comisión 2)
(4,1004), -- Bases de Datos I
(5,1005), -- Arquitectura de Computadoras
(6,1006), -- Redes I
(6,2006), -- Redes I (Comisión 2)
(7,1007), -- Sistemas Operativos
(8,1008), -- Ingeniería de Software I
(9,1009), -- Proyecto Final
(9,2009), -- Proyecto Final (Comisión 2)
(10,1010), -- Pedagogía I
(11,1011), -- Pedagogía II
(12,1012), -- Circuitos Electrónicos I
(12,2012), -- Circuitos Electrónicos I (Comisión 2)
(13,1013), -- Circuitos Electrónicos II
(14,1014), -- Electromagnetismo
(15,1015), -- Microcontroladores
(15,2015), -- Microcontroladores (Comisión 2)
(16,1016), -- Contabilidad I
(17,1017), -- Contabilidad II
(18,1018), -- Impuestos I
(18,2018), -- Impuestos I (Comisión 2)
(19,1019), -- Finanzas I
(20,1020), -- Administración I
(21,1021), -- Macroeconomía
(21,2021), -- Macroeconomía (Comisión 2)
(22,1022), -- Recursos Humanos
(23,1023), -- Marketing I
(24,1024), -- Derecho Penal I
(24,2024), -- Derecho Penal I (Comisión 2)
(25,1025), -- Derecho Penal II
(26,1026), -- Derecho Civil I
(27,1027), -- Derecho Civil II
(27,2027), -- Derecho Civil II (Comisión 2)
(28,1028), -- Psicología General
(29,1029), -- Psicología Social
(30,1030), -- Neurociencias I
(30,2030), -- Neurociencias I (Comisión 2)
(31,1031), -- Diseño I
(32,1032), -- Diseño II
(33,1033), -- Comunicación Visual
(33,2033), -- Comunicación Visual (Comisión 2)
(34,1034), -- Producción Multimedial
(35,1035), -- Cálculo I
(36,1036), -- Cálculo II
(36,2036), -- Cálculo II (Comisión 2)
(37,1037), -- Física I
(38,1038), -- Física II
(39,1039), -- Producción Industrial
(39,2039), -- Producción Industrial (Comisión 2)
(40,1040), -- Organización Industrial
(41,1041), -- Ética Profesional
(42,1042), -- Metodología de la Investigación
(42,2042), -- Metodología de la Investigación (Comisión 2)
(43,1043), -- Estadística
(44,1044), -- Probabilidad
(45,1045), -- Sociología
(45,2045), -- Sociología (Comisión 2)
(46,1046), -- Filosofía
(47,1047), -- Literatura
(48,1048), -- Historia Moderna
(48,2048); -- Historia Moderna (Comisión 2)
GO

----------------------------------------------------------------------
-- INSERCIÓN DE ALUMNOS 
-- Carga el lote de 100 alumnos de prueba.
----------------------------------------------------------------------
INSERT INTO alumnos (nombre,apellido,fecha_nacimiento,dni,email,pass) VALUES
('Ana','Torres','2005-02-10',45000001,'ana.torres1@gmail.com','pass'),
('Camila','Franco','2002-03-07',45000002,'camila.franco2@gmail.com','pass'),
('Leandro','Ramírez','2000-09-27',45000003,'leandro.ramirez3@gmail.com','pass'),
('Carlos','Franco','2001-12-15',45000004,'carlos.franco4@gmail.com','pass'),
('Martín','Franco','1996-01-24',45000005,'martin.franco5@gmail.com','pass'),
('Lucía','Gómez','2004-10-01',45000006,'lucia.gomez6@gmail.com','pass'),
('Roberto','Fernández','1999-08-26',45000007,'roberto.fernandez7@gmail.com','pass'),
('Gonzalo','Rivas','2004-11-11',45000008,'gonzalo.rivas8@gmail.com','pass'),
('Florencia','Castro','1997-12-07',45000009,'florencia.castro9@gmail.com','pass'),
('Juan','Fernández','1995-11-28',45000010,'juan.fernandez10@gmail.com','pass'),
('Matías','Herrera','1996-12-23',45000011,'matias.herrera11@gmail.com','pass'),
('Agustín','Vega','2004-04-07',45000012,'agustin.vega12@gmail.com','pass'),
('Paula','Martínez','1998-05-22',45000013,'paula.martinez13@gmail.com','pass'),
('Laura','Silva','2000-08-13',45000014,'laura.silva14@gmail.com','pass'),
('Agustín','Herrera','2001-02-13',45000015,'agustin.herrera15@gmail.com','pass'),
('Camila','Cano','1998-12-17',45000016,'camila.cano16@gmail.com','pass'),
('Florencia','Sosa','1998-02-21',45000017,'florencia.sosa17@gmail.com','pass'),
('Florencia','Díaz','2005-06-15',45000018,'florencia.diaz18@gmail.com','pass'),
('Pedro','Rivas','2002-03-27',45000019,'pedro.rivas19@gmail.com','pass'),
('Florencia','Vega','2003-03-23',45000020,'florencia.vega20@gmail.com','pass'),
('Laura','Silva','2002-09-28',45000021,'laura.silva21@gmail.com','pass'),
('Matías','Franco','1996-12-08',45000022,'matias.franco22@gmail.com','pass'),
('María','Gómez','2001-02-12',45000023,'maria.gomez23@gmail.com','pass'),
('María','Gómez','2002-04-24',45000024,'maria.gomez24@gmail.com','pass'),
('Juan','López','1998-01-08',45000025,'juan.lopez25@gmail.com','pass'),
('Julieta','Molina','1995-08-17',45000026,'julieta.molina26@gmail.com','pass'),
('Leandro','Vega','1996-03-14',45000027,'leandro.vega27@gmail.com','pass'),
('Camila','Vega','2004-02-20',45000028,'camila.vega28@gmail.com','pass'),
('Leandro','Fernández','1997-03-26',45000029,'leandro.fernandez29@gmail.com','pass'),
('Martín','Molina','2002-02-16',45000030,'martin.molina30@gmail.com','pass'),
('Roberto','López','1996-11-13',45000031,'roberto.lopez31@gmail.com','pass'),
('Roberto','Díaz','1999-11-20',45000032,'roberto.diaz32@gmail.com','pass'),
('Florencia','Suárez','1996-12-16',45000033,'florencia.suarez33@gmail.com','pass'),
('Matías','Vega','2000-11-03',45000034,'matias.vega34@gmail.com','pass'),
('Pedro','Suárez','1996-12-19',45000035,'pedro.suarez35@gmail.com','pass'),
('Agustín','Molina','1998-06-21',45000036,'agustin.molina36@gmail.com','pass'),
('Agustín','Fernández','1999-05-19',45000037,'agustin.fernandez37@gmail.com','pass'),
('Julieta','Martínez','2003-09-09',45000038,'julieta.martinez38@gmail.com','pass'),
('María','Gómez','1998-01-17',45000039,'maria.gomez39@gmail.com','pass'),
('Florencia','Fernández','1998-12-11',45000040,'florencia.fernandez40@gmail.com','pass'),
('Ana','Herrera','2003-12-03',45000041,'ana.herrera41@gmail.com','pass'),
('Leandro','Molina','1997-03-27',45000042,'leandro.molina42@gmail.com','pass'),
('Sofía','Suárez','2000-04-03',45000043,'sofia.suarez43@gmail.com','pass'),
('Laura','Fernández','1995-06-23',45000044,'laura.fernandez44@gmail.com','pass'),
('Juan','Torres','1996-04-14',45000045,'juan.torres45@gmail.com','pass'),
('Ana','Aguilar','2005-09-05',45000046,'ana.aguilar46@gmail.com','pass'),
('María','López','2004-07-01',45000047,'maria.lopez47@gmail.com','pass'),
('Miguel','Vega','2002-12-23',45000048,'miguel.vega48@gmail.com','pass'),
('Ana','Vega','2002-05-08',45000049,'ana.vega49@gmail.com','pass'),
('Sofía','Suárez','1997-08-01',45000050,'sofia.suarez50@gmail.com','pass'),
('Agustín','Pérez','1997-01-06',45000051,'agustin.perez51@gmail.com','pass'),
('Julieta','Pérez','1997-03-27',45000052,'julieta.perez52@gmail.com','pass'),
('María','Romero','2004-03-12',45000053,'maria.romero53@gmail.com','pass'),
('Martín','Molina','1999-08-12',45000054,'martin.molina54@gmail.com','pass'),
('Julieta','Romero','2005-06-10',45000055,'julieta.romero55@gmail.com','pass'),
('Laura','Torres','2003-12-22',45000056,'laura.torres56@gmail.com','pass'),
('Carlos','Herrera','2005-12-26',45000057,'carlos.herrera57@gmail.com','pass'),
('Roberto','Cano','2000-04-13',45000058,'roberto.cano58@gmail.com','pass'),
('Camila','Torres','1998-08-25',45000059,'camila.torres59@gmail.com','pass'),
('Julieta','López','2005-10-20',45000060,'julieta.lopez60@gmail.com','pass'),
('Florencia','Herrera','1999-04-07',45000061,'florencia.herrera61@gmail.com','pass'),
('Julieta','López','2005-09-23',45000062,'julieta.lopez62@gmail.com','pass'),
('María','Pérez','2005-07-02',45000063,'maria.perez63@gmail.com','pass'),
('Camila','Castro','1995-03-23',45000064,'camila.castro64@gmail.com','pass'),
('Carlos','Torres','1998-11-03',45000065,'carlos.torres65@gmail.com','pass'),
('Martín','Gómez','1995-01-05',45000066,'martin.gomez66@gmail.com','pass'),
('Martín','Rivas','2004-10-25',45000067,'martin.rivas67@gmail.com','pass'),
('Julieta','Rivas','2001-12-07',45000068,'julieta.rivas68@gmail.com','pass'),
('Laura','Gómez','2002-05-25',45000069,'laura.gomez69@gmail.com','pass'),
('Sofía','Castro','1997-03-09',45000070,'sofia.castro70@gmail.com','pass'),
('María','Suárez','2002-03-10',45000071,'maria.suarez71@gmail.com','pass'),
('Rocío','Torres','2002-07-09',45000072,'rocio.torres72@gmail.com','pass'),
('Roberto','Suárez','1998-12-14',45000073,'roberto.suarez73@gmail.com','pass'),
('Ana','Torres','2001-04-26',45000074,'ana.torres74@gmail.com','pass'),
('Paula','Suárez','1996-02-07',45000075,'paula.suarez75@gmail.com','pass'),
('Miguel','Pérez','2002-07-17',45000076,'miguel.perez76@gmail.com','pass'),
('Lucía','Vega','2004-02-11',45000077,'lucia.vega77@gmail.com','pass'),
('Matías','Herrera','1995-01-03',45000078,'matias.herrera78@gmail.com','pass'),
('Juan','Romero','1997-04-25',45000079,'juan.romero79@gmail.com','pass'),
('Leandro','Molina','2001-04-21',45000080,'leandro.molina80@gmail.com','pass'),
('Camila','Fernández','1995-09-18',45000081,'camila.fernandez81@gmail.com','pass'),
('Camila','Aguilar','1998-05-18',45000082,'camila.aguilar82@gmail.com','pass'),
('Miguel','Cano','2005-08-25',45000083,'miguel.cano83@gmail.com','pass'),
('Pedro','Romero','2000-03-26',45000084,'pedro.romero84@gmail.com','pass'),
('Matías','Fernández','2003-06-27',45000085,'matias.fernandez85@gmail.com','pass'),
('Sofía','Gómez','2001-04-14',45000086,'sofia.gomez86@gmail.com','pass'),
('Lucía','Díaz','2002-10-09',45000087,'lucia.diaz87@gmail.com','pass'),
('Leandro','Sosa','1997-08-01',45000088,'leandro.sosa88@gmail.com','pass'),
('María','Gómez','1998-10-13',45000089,'maria.gomez89@gmail.com','pass'),
('María','Romero','1999-09-20',45000090,'maria.romero90@gmail.com','pass'),
('Laura','Silva','1999-07-20',45000091,'laura.silva91@gmail.com','pass'),
('Gonzalo','Rivas','1998-01-19',45000092,'gonzalo.rivas92@gmail.com','pass'),
('Gonzalo','Martínez','2003-07-24',45000093,'gonzalo.martinez93@gmail.com','pass'),
('María','Fernández','2003-11-15',45000094,'maria.fernandez94@gmail.com','pass'),
('Rocío','Cano','2005-10-25',45000095,'rocio.cano95@gmail.com','pass'),
('Leandro','Rivas','1998-12-28',45000096,'leandro.rivas96@gmail.com','pass'),
('Julieta','Herrera','2004-10-11',45000097,'julieta.herrera97@gmail.com','pass'),
('Roberto','Herrera','1999-10-01',45000098,'roberto.herrera98@gmail.com','pass'),
('Florencia','Castro','1999-09-01',45000099,'florencia.castro99@gmail.com','pass'),
('Rocío','Suárez','2002-05-11',45000100,'rocio.suarez100@gmail.com','pass');


----------------------------------------------------------------------
-- RELACIÓN MATERIA - CARRERA 
-- Asigna las materias a las carreras correspondientes.
----------------------------------------------------------------------

INSERT INTO materia_carrera (id_materia, id_carrera) VALUES
-- Ingeniería en Sistemas (ID 1)
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (41, 1), (42, 1), (43, 1), (44, 1),
-- Tecnicatura en Programación (ID 2)
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (7, 2), (41, 2), (42, 2), (43, 2),
-- Licenciatura en Gestión Educativa (ID 3)
(10, 3), (11, 3), (41, 3), (42, 3), (45, 3), (46, 3), (47, 3), (48, 3),
-- Ingeniería Electrónica (ID 4)
(12, 4), (13, 4), (14, 4), (15, 4), (35, 4), (36, 4), (37, 4), (38, 4), (41, 4), (43, 4), (44, 4),
-- Administración de Empresas (ID 5)
(20, 5), (21, 5), (22, 5), (23, 5), (16, 5), (41, 5), (42, 5), (43, 5), (44, 5), (45, 5),
-- Contador Público (ID 6)
(16, 6), (17, 6), (18, 6), (19, 6), (20, 6), (41, 6), (42, 6), (43, 6), (44, 6),
-- Psicología (ID 7)
(28, 7), (29, 7), (30, 7), (41, 7), (42, 7), (45, 7), (46, 7), (47, 7), (48, 7),
-- Diseño Gráfico (ID 8)
(31, 8), (32, 8), (33, 8), (34, 8), (41, 8), (42, 8), (47, 8), (48, 8),
-- Ingeniería Industrial (ID 9)
(35, 9), (36, 9), (37, 9), (38, 9), (39, 9), (40, 9), (41, 9), (42, 9), (43, 9), (44, 9),
-- Abogacía (ID 10)
(24, 10), (25, 10), (26, 10), (27, 10), (41, 10), (42, 10), (45, 10), (46, 10);
GO

----------------------------------------------------------------------
-- INSCRIPCIONES MASIVAS A CARRERAS 
-- Inscribe a los alumnos en las carreras.
-- id_estado 1 = Activo, 2 = Inactivo 
----------------------------------------------------------------------

INSERT INTO inscripcion_carrera (id_alumno, id_carrera, id_estado, fecha_ins_carrera) VALUES
-- Asignación de los 100 alumnos
(1, 1, 1, '2023-03-10'),
(2, 2, 1, '2022-03-11'),
(3, 1, 1, '2021-03-12'),
(4, 4, 1, '2022-03-10'),
(5, 5, 1, '2020-03-11'),
(6, 6, 1, '2023-03-12'),
(7, 7, 1, '2021-03-10'),
(8, 8, 1, '2023-03-11'),
(9, 9, 1, '2020-03-12'),
(10, 10, 1, '2019-03-10'),
(11, 1, 1, '2020-03-11'),
(12, 3, 1, '2023-03-12'),
(13, 4, 1, '2021-03-10'),
(14, 5, 1, '2022-03-11'),
(15, 6, 1, '2022-03-12'),
(16, 7, 1, '2021-03-10'),
(17, 8, 1, '2021-03-11'),
(18, 9, 1, '2023-03-12'),
(19, 10, 1, '2022-03-10'),
(20, 1, 1, '2023-03-11'),
(21, 2, 1, '2022-03-12'),
(22, 1, 1, '2020-03-10'),
(23, 3, 1, '2021-03-11'),
(24, 4, 1, '2022-03-12'),
(25, 5, 1, '2023-03-10'),
(26, 6, 1, '2019-03-11'),
(27, 7, 1, '2020-03-12'),
(28, 8, 1, '2023-03-10'),
(29, 9, 1, '2021-03-11'),
(30, 10, 1, '2022-03-12'),
(31, 1, 1, '2020-03-10'),
(32, 2, 1, '2021-03-11'),
(33, 3, 1, '2020-03-12'),
(34, 4, 1, '2022-03-10'),
(35, 5, 1, '2020-03-11'),
(36, 6, 1, '2021-03-12'),
(37, 7, 1, '2021-03-10'),
(38, 8, 1, '2023-03-11'),
(39, 9, 1, '2020-03-12'),
(40, 10, 1, '2021-03-10'),
(41, 1, 1, '2023-03-11'),
(42, 2, 1, '2021-03-12'),
(43, 3, 1, '2022-03-10'),
(44, 4, 1, '2019-03-11'),
(45, 5, 1, '2020-03-12'),
(46, 6, 1, '2023-03-10'),
(47, 7, 1, '2023-03-11'),
(48, 8, 1, '2022-03-12'),
(49, 9, 1, '2022-03-10'),
(50, 10, 1, '2021-03-11'),
(51, 1, 1, '2021-03-12'),
(52, 2, 1, '2021-03-10'),
(53, 3, 1, '2023-03-11'),
(54, 4, 1, '2021-03-12'),
(55, 5, 1, '2023-03-10'),
(56, 6, 1, '2023-03-11'),
(57, 7, 1, '2023-03-12'),
(58, 8, 1, '2022-03-10'),
(59, 9, 1, '2021-03-11'),
(60, 10, 1, '2023-03-12'),
(61, 1, 1, '2021-03-10'),
(62, 2, 1, '2023-03-11'),
(63, 3, 1, '2023-03-12'),
(64, 4, 1, '2019-03-10'),
(65, 5, 1, '2021-03-11'),
(66, 6, 1, '2019-03-12'),
(67, 7, 1, '2023-03-10'),
(68, 8, 1, '2022-03-11'),
(69, 9, 1, '2022-03-12'),
(70, 10, 1, '2021-03-10'),
(71, 1, 1, '2022-03-11'),
(72, 2, 1, '2022-03-12'),
(73, 3, 1, '2021-03-10'),
(74, 4, 1, '2022-03-11'),
(75, 5, 1, '2020-03-12'),
(76, 6, 1, '2022-03-10'),
(77, 7, 1, '2023-03-11'),
(78, 8, 1, '2019-03-12'),
(79, 9, 1, '2021-03-10'),
(80, 10, 1, '2022-03-11'),
-- Alumnos que se cambiaron (Estado 2 en la vieja, Estado 1 en la nueva)
(81, 1, 2, '2020-03-10'),
(81, 2, 1, '2021-03-10'),
(82, 3, 2, '2021-03-11'),
(82, 4, 1, '2022-03-11'),
(83, 5, 2, '2022-03-12'),
(83, 6, 1, '2023-03-12'),
(84, 7, 2, '2021-03-10'),
(84, 8, 1, '2022-03-10'),
(85, 9, 2, '2020-03-11'),
(85, 10, 1, '2021-03-11'),
-- Alumnos Inactivos (Estado 2)
(86, 1, 2, '2022-03-12'),
(87, 2, 2, '2022-03-10'),
(88, 3, 2, '2021-03-11'),
(89, 4, 2, '2020-03-12'),
(90, 5, 2, '2019-03-10'),
(91, 6, 2, '2021-03-11'),
(92, 7, 2, '2021-03-12'),
(93, 8, 2, '2023-03-10'),
(94, 9, 2, '2022-03-11'),
(95, 10, 2, '2023-03-12'),
(96, 1, 2, '2021-03-10'),
(97, 2, 2, '2023-03-11'),
(98, 3, 2, '2021-03-12'),
(99, 4, 2, '2021-03-10'),
(100, 5, 2, '2022-03-11');
GO

----------------------------------------------------------------------
-- INSCRIPCIONES MASIVAS A COMISIONES 
-- Inscribe alumnos a las comisiones de las materias
-- (Se asume que el alumno está activo en la carrera)
----------------------------------------------------------------------

INSERT INTO inscripcion_comision (id_alumno, id_comision, fecha_ins_comision) VALUES
-- Alumno 1 (Sistemas)
(1, 1, '2024-03-15'), -- Prog I
(1, 3, '2024-03-15'), -- Mat Discreta
(1, 5, '2024-03-15'), -- BD I
(1, 7, '2024-03-15'), -- Redes I
-- Alumno 2 (Programación)
(2, 1, '2024-03-15'), -- Prog I
(2, 2, '2024-03-15'), -- Prog II
(2, 4, '2024-03-15'), -- Mat Discreta
-- Alumno 3 (Sistemas)
(3, 1, '2024-03-16'), -- Prog I
(3, 3, '2024-03-16'), -- Mat Discreta
(3, 6, '2024-03-16'), -- Arq Comp
(3, 8, '2024-03-16'), -- Redes I
(3, 9, '2024-03-16'), -- SO
-- Alumno 4 (Electrónica)
(4, 15, '2024-03-17'), -- Circuitos I
(4, 18, '2024-03-17'), -- Electro
(4, 19, '2024-03-17'), -- Micro
-- Alumno 5 (Admin)
(5, 26, '2024-03-17'), -- Admin I
(5, 27, '2024-03-17'), -- Macro
(5, 29, '2024-03-17'), -- RRHH
(5, 30, '2024-03-17'), -- Mkt I
-- Alumno 6 (Contador)
(6, 21, '2024-03-18'), -- Conta I
(6, 22, '2024-03-18'), -- Conta II
(6, 23, '2024-03-18'), -- Impuestos I
-- Alumno 7 (Psicología)
(7, 36, '2024-03-18'), -- Psico General
(7, 37, '2024-03-18'), -- Psico Social
(7, 38, '2024-03-18'), -- Neuro I
-- Alumno 8 (Diseño)
(8, 40, '2024-03-18'), -- Diseño I
(8, 42, '2024-03-18'), -- Com Visual
-- Alumno 9 (Industrial)
(9, 43, '2024-03-19'), -- Cálculo I
(9, 45, '2024-03-19'), -- Física I
(9, 47, '2024-03-19'), -- Prod Ind
-- Alumno 10 (Abogacía)
(10, 31, '2024-03-19'), -- Penal I
(10, 33, '2024-03-19'), -- Civil I
(10, 49, '2024-03-19'), -- Ética
-- Más inscripciones variadas
(11, 1, '2024-03-19'), -- (Sistemas) Prog I
(12, 13, '2024-03-19'), -- (Gestión) Peda I
(12, 14, '2024-03-19'), -- (Gestión) Peda II
(13, 16, '2024-03-20'), -- (Electrónica) Circuitos I
(13, 17, '2024-03-20'), -- (Electrónica) Circuitos II
(14, 26, '2024-03-20'), -- (Admin) Admin I
(15, 21, '2024-03-20'), -- (Contador) Conta I
(16, 36, '2024-03-21'), -- (Psico) Psico Gral
(17, 40, '2024-03-21'), -- (Diseño) Diseño I
(18, 43, '2024-03-21'), -- (Industrial) Cálculo I
(19, 31, '2024-03-21'), -- (Abogacía) Penal I
(20, 1, '2024-03-22'), -- (Sistemas) Prog I
(20, 2, '2024-03-22'), -- (Sistemas) Prog II
(21, 1, '2024-03-22'), -- (Programación) Prog I
(22, 5, '2024-03-22'), -- (Sistemas) BD I
(23, 13, '2024-03-22'), -- (Gestión) Peda I
(24, 15, '2024-03-23'), -- (Electrónica) Circuitos I
(25, 26, '2024-03-23'), -- (Admin) Admin I
(26, 21, '2024-03-23'), -- (Contador) Conta I
(27, 36, '2024-03-23'), -- (Psico) Psico Gral
(28, 40, '2024-03-24'), -- (Diseño) Diseño I
(29, 43, '2024-03-24'), -- (Industrial) Cálculo I
(30, 31, '2024-03-24'), -- (Abogacía) Penal I
(31, 49, '2024-03-24'); -- (Sistemas) Ética
GO

----------------------------------------------------------------------
-- CREACIÓN DE MESAS DE EXAMEN 
-- Define las fechas de examen para las materias.
----------------------------------------------------------------------

INSERT INTO examen (id_materia, fecha) VALUES
(1, '2024-07-15'), (1, '2024-12-05'), -- Prog I
(2, '2024-07-16'), (2, '2024-12-06'), -- Prog II
(3, '2024-07-17'), (3, '2024-12-07'), -- Mat Discreta
(4, '2024-07-18'), (4, '2024-12-08'), -- BD I
(5, '2024-07-19'), (5, '2024-12-09'), -- Arq Comp
(6, '2024-07-20'), (6, '2024-12-10'), -- Redes I
(7, '2024-07-21'), (7, '2024-12-11'), -- SO
(8, '2024-07-22'), (8, '2024-12-12'), -- Ing Soft I
(9, '2024-07-23'), (9, '2024-12-13'), -- Proyecto
(10, '2024-07-15'), -- Peda I
(11, '2024-07-16'), -- Peda II
(12, '2024-07-17'), (12, '2024-12-05'), -- Circuitos I
(13, '2024-07-18'), -- Circuitos II
(14, '2024-07-19'), -- Electro
(15, '2024-07-20'), (15, '2024-12-06'), -- Micro
(16, '2024-07-21'), (16, '2024-12-07'), -- Conta I
(17, '2024-07-22'), -- Conta II
(18, '2024-07-23'), -- Impuestos I
(19, '2024-07-24'), -- Finanzas I
(20, '2024-07-15'), (20, '2024-12-08'), -- Admin I
(21, '2024-07-16'), -- Macro
(22, '2024-07-17'), -- RRHH
(23, '2024-07-18'), -- Mkt I
(24, '2024-07-19'), (24, '2024-12-09'), -- Penal I
(25, '2024-07-20'), -- Penal II
(26, '2024-07-21'), -- Civil I
(27, '2024-07-22'), -- Civil II
(28, '2024-07-23'), (28, '2024-12-10'), -- Psico Gral
(29, '2024-07-24'), -- Psico Social
(30, '2024-07-15'), -- Neuro I
(31, '2024-07-16'), (31, '2024-12-11'), -- Diseño I
(32, '2024-07-17'), -- Diseño II
(33, '2024-07-18'), -- Com Visual
(34, '2024-07-19'), -- Prod Multi
(35, '2024-07-20'), (35, '2024-12-12'), -- Cálculo I
(36, '2024-07-21'), -- Cálculo II
(37, '2024-07-22'), -- Física I
(38, '2024-07-23'), -- Física II
(39, '2024-07-24'), -- Prod Ind
(40, '2024-07-15'), -- Org Ind
(41, '2024-07-16'), (41, '2024-12-13'); -- Ética
GO

-- NOTA: Los ID de examen se generan automáticamente (IDENTITY).
-- Asumiremos los IDs generados en orden para el siguiente script.
-- Ej: Examen 1 = (1, '2024-07-15'), Examen 2 = (1, '2024-12-05'), Examen 3 = (2, '2024-07-16'), etc.

----------------------------------------------------------------------
-- INSCRIPCIONES A EXÁMENES Y CALIFICACIONES 
-- Inscribe a los alumnos que cursaron a los exámenes
-- id_estado 3 = Regular, 4 = Libre
-- calificacion NULL = Aún no se cargo la nota.
----------------------------------------------------------------------

INSERT INTO inscripcion_examen (id_alumno, id_examen, fecha_ins_examen, id_estado, calificacion) VALUES
-- Alumno 1 (Sistemas)
(1, 1, '2024-07-10', 3, 7), -- Prog I (Regular, Aprobado) (Examen ID 1)
(1, 5, '2024-07-12', 3, 4), -- Mat Discreta (Regular, Desaprobado) (Examen ID 5)
(1, 7, '2024-07-13', 3, 8), -- BD I (Regular, Aprobado) (Examen ID 7)
(1, 11, '2024-07-15', 3, NULL), -- Redes I (Regular, Pendiente) (Examen ID 11)

-- Alumno 2 (Programación)
(2, 1, '2024-07-10', 3, 2), -- Prog I (Regular, Desaprobado) (Examen ID 1)
(2, 2, '2024-12-01', 3, 6), -- Prog I (Regular, Aprobado) (Examen ID 2)
(2, 3, '2024-07-11', 4, 5), -- Prog II (Libre, Desaprobado) (Examen ID 3)
(2, 6, '2024-12-02', 3, NULL), -- Mat Discreta (Regular, Pendiente) (Examen ID 6)

-- Alumno 3 (Sistemas)
(3, 1, '2024-07-10', 3, 9), -- Prog I (Regular, Aprobado) (Examen ID 1)
(3, 5, '2024-07-11', 4, 10), -- Mat Discreta (Libre, Aprobado) (Examen ID 5)
(3, 9, '2024-07-12', 3, 7), -- Arq Comp (Regular, Aprobado) (Examen ID 9)

-- Alumno 4 (Electrónica)
(4, 21, '2024-07-12', 3, 6), -- Circuitos I (Regular, Aprobado) (Examen ID 21)
(4, 24, '2024-07-13', 4, 3), -- Electro (Libre, Desaprobado) (Examen ID 24)
(4, 25, '2024-07-14', 3, 8), -- Micro (Regular, Aprobado) (Examen ID 25)

-- Alumno 5 (Admin)
(5, 30, '2024-07-10', 3, 7), -- Admin I (Regular, Aprobado) (Examen ID 30)
(5, 32, '2024-07-11', 3, 5), -- Macro (Regular, Desaprobado) (Examen ID 32)
(5, 33, '2024-07-12', 3, NULL), -- RRHH (Regular, Pendiente) (Examen ID 33)

-- Alumno 6 (Contador)
(6, 27, '2024-07-15', 3, 6), -- Conta I (Regular, Aprobado) (Examen ID 27)
(6, 29, '2024-07-16', 3, 6), -- Conta II (Regular, Aprobado) (Examen ID 29)
(6, 28, '2024-12-01', 3, NULL), -- Conta I (Pendiente) (Examen ID 28)

-- Alumno 10 (Abogacía)
(10, 37, '2024-07-14', 3, 8), -- Penal I (Regular, Aprobado) (Examen ID 37)
(10, 40, '2024-07-15', 3, 7), -- Civil I (Regular, Aprobado) (Examen ID 40)
(10, 56, '2024-07-15', 3, 9), -- Ética (Regular, Aprobado) (Examen ID 56)

-- Alumno 12 (Gestión)
(12, 18, '2024-07-10', 3, 10), -- Peda I (Regular, Aprobado) (Examen ID 18)
(12, 19, '2024-07-11', 3, 9), -- Peda II (Regular, Aprobado) (Examen ID 19)

-- Alumno 20 (Sistemas)
(20, 1, '2024-07-11', 4, 4), -- Prog I (Libre, Desaprobado) (Examen ID 1)
(20, 3, '2024-07-12', 3, 7); -- Prog II (Regular, Aprobado) (Examen ID 3)
GO

CREATE TABLE alumnos
(
  id_alumno INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  apellido VARCHAR(200) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  dni INT NOT NULL,
  email VARCHAR(200) NOT NULL,
  password VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_alumno),
  UNIQUE (dni),
  UNIQUE (email)
);

CREATE TABLE estados
(
  id_estado INT NOT NULL,
  descripcion INT NOT NULL,
  PRIMARY KEY (id_estado),
  UNIQUE (descripcion)
);

CREATE TABLE Carrera
(
  id_carrera INT NOT NULL,
  nombre_carrera INT NOT NULL,
  cant_materias INT NOT NULL,
  PRIMARY KEY (id_carrera),
  UNIQUE (nombre_carrera)
);

CREATE TABLE inscripcion_carrera
(
  fecha_ins_carrera DATE NOT NULL,
  id_estado INT NOT NULL,
  id_alumno INT NOT NULL,
  id_carrera INT NOT NULL,
  PRIMARY KEY (id_alumno, id_carrera),
  FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);

CREATE TABLE Materia
(
  id_materia INT NOT NULL,
  nombre_materia VARCHAR(200) NOT NULL,
  cuatrimestre VARCHAR(200) NOT NULL,
  anio_cursada DATE NOT NULL,
  PRIMARY KEY (id_materia),
  UNIQUE (nombre_materia)
);

CREATE TABLE inscripcion_materia
(
  fecha_ins_materia DATE NOT NULL,
  id_alumno INT NOT NULL,
  id_materia INT NOT NULL,
  PRIMARY KEY (id_alumno, id_materia),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE Examen
(
  id_examen INT NOT NULL,
  calificacion INT,
  fecha INT NOT NULL,
  id_materia INT NOT NULL,
  id_estado INT NOT NULL,
  PRIMARY KEY (id_examen),
  FOREIGN KEY (id_materia) REFERENCES Materia(id_materia),
  FOREIGN KEY (id_estado) REFERENCES estados(id_estado)
);

CREATE TABLE inscripcion_examen
(
  fecha_ins_examen DATE NOT NULL,
  id_estado INT NOT NULL,
  id_alumno INT NOT NULL,
  id_examen INT NOT NULL,
  PRIMARY KEY (id_alumno, id_examen),
  FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_examen) REFERENCES Examen(id_examen)
);

CREATE TABLE Comision
(
  id_comision INT NOT NULL,
  cant_alumnos INT NOT NULL,
  nro_comision INT NOT NULL,
  id_materia INT NOT NULL,
  PRIMARY KEY (id_comision),
  FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE inscripcion_comision
(
  fecha_ins_comision DATE NOT NULL,
  id_alumno INT NOT NULL,
  id_comision INT NOT NULL,
  PRIMARY KEY (id_alumno, id_comision),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_comision) REFERENCES Comision(id_comision)
);

CREATE TABLE materia_carrera
(
  id_materia INT NOT NULL,
  id_carrera INT NOT NULL,
  PRIMARY KEY (id_materia, id_carrera),
  FOREIGN KEY (id_materia) REFERENCES Materia(id_materia),
  FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);
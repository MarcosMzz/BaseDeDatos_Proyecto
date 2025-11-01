CREATE TABLE alumnos
(
  id_alumno INT IDENTITY(1,1) NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  apellido VARCHAR(200) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  dni INT NOT NULL,
  email VARCHAR(200) NOT NULL,
  pass VARCHAR(200) NOT NULL,
  constraint pk_alumno PRIMARY KEY (id_alumno),
  constraint uq_dni UNIQUE (dni),
  constraint uq_email UNIQUE (email)
);

CREATE TABLE estados
(
  id_estado INT IDENTITY(1,1) NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  constraint pk_estados PRIMARY KEY (id_estado),
  constraint uq_descripcion UNIQUE (descripcion)
);

CREATE TABLE Carrera
(
  id_carrera INT IDENTITY(1,1) NOT NULL,
  nombre_carrera VARCHAR(200) NOT NULL,
  constraint pk_carrera PRIMARY KEY (id_carrera),
  constraint uq_nombre_carrera UNIQUE (nombre_carrera)
);

CREATE TABLE Materia
(
  id_materia INT IDENTITY(1,1) NOT NULL,
  nombre_materia VARCHAR(200) NOT NULL,
  constraint pk_materia PRIMARY KEY (id_materia),
  constraint uq_nombre_materia UNIQUE (nombre_materia)
);

CREATE TABLE Comision
(
  id_comision INT IDENTITY(1,1) NOT NULL,
  nro_comision INT NOT NULL,
  id_materia INT NOT NULL,
  anio INT NOT NULL,
  cuatrimestre VARCHAR(50) NOT NULL,
  constraint pk_comision PRIMARY KEY (id_comision),
  constraint fk_comision_materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE Examen
(
  id_examen INT IDENTITY(1,1) NOT NULL,
  fecha DATE NOT NULL,
  id_materia INT NOT NULL,
  constraint pk_examen PRIMARY KEY (id_examen),
  constraint fk_examen_materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE materia_carrera
(
  id_materia INT NOT NULL,
  id_carrera INT NOT NULL,
  constraint pk_materia_carrera PRIMARY KEY (id_materia, id_carrera),
  constraint fk_materia_carrera_materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia),
  constraint fk_materia_carrera_carrera FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);

CREATE TABLE inscripcion_carrera
(
  id_inscripcion_carrera INT IDENTITY(1,1) NOT NULL,
  fecha_ins_carrera DATE NOT NULL,
  id_estado INT NOT NULL,
  id_alumno INT NOT NULL,
  id_carrera INT NOT NULL,
  constraint pk_inscripcion_carrera PRIMARY KEY (id_inscripcion_carrera),
  constraint fk_inscripcion_carrera_estados FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
  constraint fk_inscripcion_carrera_alumnos FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  constraint fk_inscripcion_carrera_carrera FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);

CREATE TABLE inscripcion_comision
(
  fecha_ins_comision DATE NOT NULL,
  id_alumno INT NOT NULL,
  id_comision INT NOT NULL,
  constraint pk_inscripcion_comision PRIMARY KEY (id_alumno, id_comision),
  constraint fk_inscripcion_comision_alumnos FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  constraint fk_inscripcion_comision_comision FOREIGN KEY (id_comision) REFERENCES Comision(id_comision)
);

CREATE TABLE inscripcion_examen
(
  fecha_ins_examen DATE NOT NULL,
  id_estado INT NOT NULL,
  id_alumno INT NOT NULL,
  id_examen INT NOT NULL,
  calificacion INT NULL,
  constraint pk_inscripcion_examen PRIMARY KEY (id_alumno, id_examen),
  constraint fk_inscripcion_examen_estados FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
  constraint fk_inscripcion_examen_alumnos FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  constraint fk_inscripcion_examen_examen FOREIGN KEY (id_examen) REFERENCES Examen(id_examen)
);
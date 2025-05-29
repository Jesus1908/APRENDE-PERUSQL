CREATE DATABASE IF NOT EXISTS aprendeperu;
USE aprendeperu;

CREATE TABLE TIPO_EXAMEN (
    idtipo 		INT PRIMARY KEY AUTO_INCREMENT,
    tipo 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE AREA (
    idarea 	INT PRIMARY KEY AUTO_INCREMENT,
    area 	VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE ESTADOEXAMEN (
    idestado 	INT PRIMARY KEY AUTO_INCREMENT,
    estado 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE ALTERNATIVAS (
    idalternativa INT PRIMARY KEY AUTO_INCREMENT,
    alternativa VARCHAR(50) NOT NULL,
    altcorrecta BOOLEAN
)ENGINE = INNODB;

CREATE TABLE ESTUDIANTE (
    idestudiante 	INT PRIMARY KEY AUTO_INCREMENT,
    nombres 		VARCHAR(50) NOT NULL,
    apellidos 		VARCHAR(50) NOT NULL,
    dni 			VARCHAR(8) UNIQUE,
    fecha_nacimiento DATE NOT NULL
)ENGINE = INNODB;

CREATE TABLE PREGUNTAS (
    idpregunta 		INT PRIMARY KEY AUTO_INCREMENT,
    idalternativa   INT NOT NULL,
    pregunta 		TEXT,
    valor 			INT,
    FOREIGN KEY (idalternativa) REFERENCES ALTERNATIVAS(idalternativa)
);

CREATE TABLE RESPUESTA_MARCADA (
    idrespuestam 	INT PRIMARY KEY AUTO_INCREMENT,
    estado 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE EVALUACION (
    idevaluacion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    tiempo_desarrollo INT,
    idtipo INT,
    idarea INT,
    idestado INT,
    idpregunta INT,
    FOREIGN KEY (idtipo) REFERENCES TIPO(idtipo),
    FOREIGN KEY (idarea) REFERENCES AREA(idarea),
    FOREIGN KEY (idestado) REFERENCES ESTADOEXAMEN(idestado),
    FOREIGN KEY (idpregunta) REFERENCES PREGUNTAS_EVALUACION(idpregunta)
);

CREATE TABLE PREGUNTAS_EVALUACION (
    idpregunta INT PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY (idpregunta) REFERENCES PREGUNTAS(idpregunta)
);

CREATE TABLE HISTORIALASIGNACION (
    idasignacion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_asignacion DATE,
    idevaluacion INT,
    idestudiante INT,
    FOREIGN KEY (idevaluacion) REFERENCES EVALUACION(idevaluacion),
    FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(idestudiante)
);

CREATE TABLE RESPUESTAS_MARCADAS (
	idrespuestam INT PRIMARY KEY AUTO_INCREMENT,
    idresultado INT NOT NULL,
    FOREIGN KEY (idresultado) REFERENCES RESULTADO(idresultado)
);

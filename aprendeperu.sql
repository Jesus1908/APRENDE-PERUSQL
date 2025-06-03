CREATE DATABASE aprendeperu;
USE aprendeperu;

CREATE TABLE TIPO_EXAMEN (
    idtipo 		INT PRIMARY KEY AUTO_INCREMENT,
    tipo 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE AREA (
    idarea 	INT PRIMARY KEY AUTO_INCREMENT,
    area 	VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE ESTADO_EXAMEN (
    idestado 	INT PRIMARY KEY AUTO_INCREMENT,
    estado 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE ALTERNATIVAS (
    idalternativa 	INT PRIMARY KEY AUTO_INCREMENT,
    alternativa 	VARCHAR(150) NOT NULL,
    altcorrecta 	BOOLEAN NOT NULL
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
    pregunta 		VARCHAR(150) NOT NULL,
    valor 			DECIMAL(2,0) NOT NULL,
    FOREIGN KEY (idalternativa) REFERENCES ALTERNATIVAS(idalternativa)
);

CREATE TABLE PREGUNTAS_EVALUACION (
	idprgevaluacion INT PRIMARY KEY AUTO_INCREMENT,
    idpregunta 		INT NOT NULL,
    FOREIGN KEY (idpregunta) REFERENCES PREGUNTAS(idpregunta)
);

CREATE TABLE RESULTADO (
    idresultado 	INT PRIMARY KEY AUTO_INCREMENT,
    puntaje			INT NOT NULL,
    idestudiante    INT NOT NULL,
    FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(idestudiante)
)ENGINE = INNODB;

CREATE TABLE RESPUESTA_MARCADA (
    idrespuestamar	INT PRIMARY KEY AUTO_INCREMENT,
    idresultado     INT NOT NULL,
    FOREIGN KEY (idresultado) REFERENCES RESULTADO(idresultado)
)ENGINE = INNODB;

CREATE TABLE HISTORIALASIGNACION (
    idasignacion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_asignacion DATE NOT NULL,
    idevaluacion INT NOT NULL,
    idestudiante INT NOT NULL,
    FOREIGN KEY (idevaluacion) REFERENCES EVALUACION(idevaluacion),
    FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(idestudiante)
)ENGINE = INNODB;

CREATE TABLE EVALUACION (
    idevaluacion 		INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio 		DATETIME NOT NULL,
    fecha_fin 			DATETIME NOT NULL,
    tiempo_desarrollo 	INT NULL,
    idtipo 				INT NOT NULL,
    idestudiante 		INT NOT NULL,
    idarea 				INT NOT NULL,
    idestado 			INT NOT NULL,
    idprevaluacion	    INT NOT NULL,
    FOREIGN KEY (idtipo) REFERENCES TIPO(idtipo),
    FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(idestudiante),
    FOREIGN KEY (idarea) REFERENCES AREA(idarea),
    FOREIGN KEY (idestado) REFERENCES ESTADOEXAMEN(idestado),
    FOREIGN KEY (idprevaluacion) REFERENCES PREGUNTAS_EVALUACION(idprevaluacion)
)ENGINE = INNODB;



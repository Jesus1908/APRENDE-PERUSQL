CREATE DATABASE aprendeperu;
USE aprendeperu;

CREATE TABLE TIPO_EVALUACION (
    idtipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
) ENGINE=INNODB;

CREATE TABLE AREA (
    idarea INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
) ENGINE=INNODB;

CREATE TABLE ESTADO_EVALUACION (
    idestado INT PRIMARY KEY AUTO_INCREMENT,
    estado 	 VARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE ESTUDIANTE (
    idestudiante 	 INT PRIMARY KEY AUTO_INCREMENT,
    nombres 		 VARCHAR(50) NOT NULL,
    apellidos 		 VARCHAR(50) NOT NULL,
    dni 			 VARCHAR(8) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL
) ENGINE=INNODB;

CREATE TABLE EVALUACION (
    idevaluacion    INT PRIMARY KEY AUTO_INCREMENT,
    titulo 		    VARCHAR(100) NOT NULL,
    fecha_inicio 	DATETIME NOT NULL,
    fecha_fin       DATETIME NOT NULL,
    tiempo_maximo   INT NOT NULL COMMENT 'En minutos',
    idtipo		    INT NOT NULL,
    idarea          INT NOT NULL,
    idestado        INT NOT NULL,
    FOREIGN KEY (idtipo) REFERENCES TIPO_EVALUACION(idtipo),
    FOREIGN KEY (idarea) REFERENCES AREA(idarea),
    FOREIGN KEY (idestado) REFERENCES ESTADO_EVALUACION(idestado)
) ENGINE=INNODB;

CREATE TABLE ALTERNATIVA (
    idalternativa 	INT PRIMARY KEY AUTO_INCREMENT,
    texto 			VARCHAR(255) NOT NULL,
    es_correcta 	BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE PREGUNTA (
    idpregunta 				INT PRIMARY KEY AUTO_INCREMENT,
    enunciado 				TEXT NOT NULL,
    valor 					DECIMAL(5,2) NOT NULL,
    idalternativa_correcta INT NOT NULL,
    FOREIGN KEY (idalternativa_correcta) REFERENCES ALTERNATIVA(idalternativa)
) ENGINE=INNODB;

CREATE TABLE EVALUACION_PREGUNTA (
    idevaluacion 	INT NOT NULL,
    idpregunta 		INT NOT NULL,
    orden 			INT NOT NULL,
    PRIMARY KEY (idevaluacion, idpregunta),
    FOREIGN KEY (idevaluacion) REFERENCES EVALUACION(idevaluacion),
    FOREIGN KEY (idpregunta) REFERENCES PREGUNTA(idpregunta)
) ENGINE=INNODB;

-- Tablas de asignación y resultados
CREATE TABLE ASIGNACION (
    idasignacion 		INT PRIMARY KEY AUTO_INCREMENT,
    idevaluacion 		INT NOT NULL,
    idestudiante 		INT NOT NULL,
    fecha_asignacion 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completada 			BOOLEAN DEFAULT FALSE,
    UNIQUE KEY (idevaluacion, idestudiante),
    FOREIGN KEY (idevaluacion) REFERENCES EVALUACION(idevaluacion),
    FOREIGN KEY (idestudiante) REFERENCES ESTUDIANTE(idestudiante)
) ENGINE=INNODB;

CREATE TABLE INTENTO_EVALUACION (
    idintento 		INT PRIMARY KEY AUTO_INCREMENT,
    idasignacion 	INT NOT NULL,
    fecha_inicio 	DATETIME NOT NULL,
    fecha_fin 		DATETIME NOT NULL,
    puntaje 		DECIMAL(5,2),
    FOREIGN KEY (idasignacion) REFERENCES ASIGNACION(idasignacion)
) ENGINE=INNODB;

CREATE TABLE RESPUESTA_ESTUDIANTE (
    idrespuesta 	INT PRIMARY KEY AUTO_INCREMENT,
    idintento 		INT NOT NULL,
    idpregunta 		INT NOT NULL,
    idalternativa 	INT NOT NULL,
    tiempo_respuesta INT COMMENT 'En segundos',
    FOREIGN KEY (idintento) REFERENCES INTENTO_EVALUACION(idintento),
    FOREIGN KEY (idpregunta) REFERENCES PREGUNTA(idpregunta),
    FOREIGN KEY (idalternativa) REFERENCES ALTERNATIVA(idalternativa)
) ENGINE=INNODB;


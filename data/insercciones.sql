-- Tipo Evaluación, Área, Estado
INSERT INTO TIPO_EVALUACION (nombre) VALUES 
('Examen Parcial'),
('Examen Final'),
('Quiz'),
('Práctica Calificada'),
('Simulacro');

INSERT INTO AREA (nombre) VALUES 
('Matemáticas'),
('Comunicación'),
('Ciencias'),
('Historia'),
('Inglés');

INSERT INTO ESTADO_EVALUACION (estado) VALUES 
('Activa'),
('Inactiva'),
('En progreso'),
('Finalizada'),
('Pendiente');

INSERT INTO ESTUDIANTE (nombres, apellidos, dni, fecha_nacimiento) VALUES
('Juan', 'Pérez', '12345678', '2000-05-15'),
('María', 'Gómez', '23456789', '2001-03-22'),
('Carlos', 'López', '34567890', '1999-11-30'),
('Ana', 'Rodríguez', '45678901', '2002-07-10'),
('Luis', 'Martínez', '56789012', '2000-09-05'),
('Sofía', 'Hernández', '67890123', '2001-01-18'),
('Pedro', 'Díaz', '78901234', '1999-12-25'),
('Lucía', 'Fernández', '89012345', '2002-04-08'),
('Jorge', 'García', '90123456', '2000-08-12'),
('Elena', 'Sánchez', '01234567', '2001-06-20');

-- Insertar 5 evaluaciones 
INSERT INTO EVALUACION (titulo, fecha_inicio, fecha_fin, tiempo_maximo, idtipo, idarea, idestado) VALUES
('Examen Parcial Matemáticas', '2023-11-01 08:00:00', '2023-11-01 10:00:00', 120, 1, 1, 1),
('Quiz de Ciencias', '2023-11-05 10:00:00', '2023-11-05 10:30:00', 30, 3, 3, 1),
('Examen Final Comunicación', '2023-11-10 09:00:00', '2023-11-10 11:00:00', 120, 2, 2, 1),
('Práctica de Historia', '2023-11-15 14:00:00', '2023-11-15 15:30:00', 90, 4, 4, 1),
('Simulacro de Inglés', '2023-11-20 16:00:00', '2023-11-20 17:00:00', 60, 5, 5, 1);

-- 4. Insertar alternativas y preguntas para cada evaluación

-- Evaluación 1:
INSERT INTO ALTERNATIVA (texto, es_correcta) VALUES
-- Pregunta 1
('5', 0), ('10', 0), ('15', 1), ('20', 0),
-- Pregunta 2
('25', 0), ('50', 1), ('75', 0), ('100', 0),
-- Pregunta 3
('2π', 0), ('πr²', 1), ('2πr', 0), ('πd', 0),
-- Pregunta 4
('3', 0), ('6', 1), ('9', 0), ('12', 0),
-- Pregunta 5
('0', 1), ('1', 0), ('-1', 0), ('2', 0);

-- Preguntas para Evaluación 1
INSERT INTO PREGUNTA (enunciado, valor, idalternativa_correcta) VALUES
('¿Cuánto es 5 + 10?', 4.00, 3),
('¿Cuál es la mitad de 100?', 4.00, 6),
('¿Cuál es la fórmula del área de un círculo?', 4.00, 10),
('¿Cuánto es 2 × 3?', 4.00, 14),
('¿Cuál es el valor de x en x + 5 = 5?', 4.00, 17);

-- Relacionar preguntas con evaluación 1
INSERT INTO EVALUACION_PREGUNTA (idevaluacion, idpregunta, orden) VALUES
(1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4), (1, 5, 5);

-- 4 estudiantes con 3 evaluaciones cada uno
INSERT INTO ASIGNACION (idevaluacion, idestudiante) VALUES
(1, 1), (2, 1), (3, 1),  -- Estudiante 1
(2, 2), (3, 2), (4, 2),  -- Estudiante 2
(3, 3), (4, 3), (5, 3),  -- Estudiante 3
(1, 4), (4, 4), (5, 4);  -- Estudiante 4

-- 3 estudiantes con 2 evaluaciones cada uno
INSERT INTO ASIGNACION (idevaluacion, idestudiante) VALUES
(1, 5), (5, 5),  -- Estudiante 5
(2, 6), (4, 6),  -- Estudiante 6
(3, 7), (5, 7);  -- Estudiante 7

-- Estudiante 1 (Aprobado - Matemáticas)
INSERT INTO INTENTO_EVALUACION (idasignacion, fecha_inicio, fecha_fin, puntaje) VALUES
(1, '2023-11-01 08:05:00', '2023-11-01 09:30:00', 18.5);

-- Insertar respuestas del estudiante 1 (3 correctas, 2 incorrectas)
INSERT INTO RESPUESTA_ESTUDIANTE (idintento, idpregunta, idalternativa, tiempo_respuesta) VALUES
(1, 1, 3, 30),  -- Correcta
(1, 2, 6, 45),  -- Correcta
(1, 3, 9, 60),  -- Incorrecta (seleccionó 2π)
(1, 4, 14, 25), -- Correcta
(1, 5, 17, 20); -- Correcta

-- Estudiante 2 (Desaprobado - Ciencias)
INSERT INTO INTENTO_EVALUACION (idasignacion, fecha_inicio, fecha_fin, puntaje) VALUES
(4, '2023-11-05 10:05:00', '2023-11-05 10:25:00', 9.0);

-- Estudiante 3 (Aprobado - Comunicación)
INSERT INTO INTENTO_EVALUACION (idasignacion, fecha_inicio, fecha_fin, puntaje) VALUES
(7, '2023-11-10 09:10:00', '2023-11-10 10:45:00', 15.0);
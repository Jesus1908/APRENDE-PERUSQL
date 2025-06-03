-- Alumnos desaprobados en total
SELECT COUNT(DISTINCT e.idestudiante) AS total_desaprobados
FROM ESTUDIANTE e
JOIN ASIGNACION a ON e.idestudiante = a.idestudiante
JOIN INTENTO_EVALUACION ie ON a.idasignacion = ie.idasignacion
WHERE ie.puntaje < 10.5;

-- Alumnos aprobados en un determinado curso
SELECT COUNT(DISTINCT e.idestudiante) AS aprobados_curso
FROM ESTUDIANTE e
JOIN ASIGNACION a ON e.idestudiante = a.idestudiante
JOIN INTENTO_EVALUACION ie ON a.idasignacion = ie.idasignacion
JOIN EVALUACION ev ON a.idevaluacion = ev.idevaluacion
WHERE ev.titulo = 'Examen Parcial Matemáticas'  
AND ie.puntaje >= 10.5;

-- Exámenes inscritos, resueltos y pendientes por alumno
SELECT 
    e.nombres,
    e.apellidos,
    COUNT(a.idasignacion) AS total_inscritos,
    SUM(CASE WHEN a.completada = TRUE THEN 1 ELSE 0 END) AS resueltos,
    SUM(CASE WHEN a.completada = FALSE THEN 1 ELSE 0 END) AS pendientes
FROM ESTUDIANTE e
LEFT JOIN ASIGNACION a ON e.idestudiante = a.idestudiante
GROUP BY e.idestudiante;

-- Mejor y peor calificación de una evaluación específica
SELECT 
    ev.titulo AS evaluacion,
    MAX(ie.puntaje) AS mejor_calificacion,
    MIN(ie.puntaje) AS peor_calificacion
FROM INTENTO_EVALUACION ie
JOIN ASIGNACION a ON ie.idasignacion = a.idasignacion
JOIN EVALUACION ev ON a.idevaluacion = ev.idevaluacion
WHERE ev.titulo = 'Quiz de Ciencias'  
GROUP BY ev.titulo;

-- Promedio de calificaciones de un estudiante
SELECT 
    e.nombres,
    e.apellidos,
    AVG(ie.puntaje) AS promedio_calificaciones,
    COUNT(ie.idintento) AS evaluaciones_realizadas
FROM ESTUDIANTE e
JOIN ASIGNACION a ON e.idestudiante = a.idestudiante
JOIN INTENTO_EVALUACION ie ON a.idasignacion = ie.idasignacion
WHERE e.dni = '12345678'  -- Cambiar por el DNI del estudiante
GROUP BY e.idestudiante;
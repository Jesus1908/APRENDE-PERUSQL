<?php
require_once './config/conexion.php'; 

class Evaluacion {
    private $conn;
    private $table = 'EVALUACION';

    // Propiedades del objeto
    public $idevaluacion;
    public $titulo;
    public $fecha_inicio;
    public $fecha_fin;
    public $tiempo_maximo;
    public $idtipo;
    public $idarea;
    public $idestado;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Método para crear una nueva evaluación
    public function create() {
        $query = 'INSERT INTO ' . $this->table . ' 
                 (titulo, fecha_inicio, fecha_fin, tiempo_maximo, idtipo, idarea, idestado)
                 VALUES
                 (:titulo, :fecha_inicio, :fecha_fin, :tiempo_maximo, :idtipo, :idarea, :idestado)';

        $stmt = $this->conn->prepare($query);

        // Limpiar y vincular parámetros
        $this->titulo = htmlspecialchars(strip_tags($this->titulo));
        $this->fecha_inicio = htmlspecialchars(strip_tags($this->fecha_inicio));
        $this->fecha_fin = htmlspecialchars(strip_tags($this->fecha_fin));
        $this->tiempo_maximo = htmlspecialchars(strip_tags($this->tiempo_maximo));
        $this->idtipo = htmlspecialchars(strip_tags($this->idtipo));
        $this->idarea = htmlspecialchars(strip_tags($this->idarea));
        $this->idestado = htmlspecialchars(strip_tags($this->idestado));

        $stmt->bindParam(':titulo', $this->titulo);
        $stmt->bindParam(':fecha_inicio', $this->fecha_inicio);
        $stmt->bindParam(':fecha_fin', $this->fecha_fin);
        $stmt->bindParam(':tiempo_maximo', $this->tiempo_maximo);
        $stmt->bindParam(':idtipo', $this->idtipo);
        $stmt->bindParam(':idarea', $this->idarea);
        $stmt->bindParam(':idestado', $this->idestado);

    
        if($stmt->execute()) {
            return $this->conn->lastInsertId(); 
        }
        printf("Error: %s.\n", $stmt->error);
        return false;
    }

    // Método para obtener todas las evaluaciones con información relacionada
    public function getAll() {
        $query = 'SELECT 
                    e.idevaluacion, 
                    e.titulo, 
                    e.fecha_inicio, 
                    e.fecha_fin, 
                    e.tiempo_maximo,
                    t.nombre AS tipo_evaluacion,
                    a.nombre AS area,
                    es.estado
                 FROM ' . $this->table . ' e
                 LEFT JOIN TIPO_EVALUACION t ON e.idtipo = t.idtipo
                 LEFT JOIN AREA a ON e.idarea = a.idarea
                 LEFT JOIN ESTADO_EVALUACION es ON e.idestado = es.idestado
                 ORDER BY e.fecha_inicio DESC';

        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    // Método opcional para obtener una evaluación por ID
    public function getById($id) {
        $query = 'SELECT * FROM ' . $this->table . ' WHERE idevaluacion = ? LIMIT 1';
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $id);
        $stmt->execute();
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if($row) {
            $this->idevaluacion = $row['idevaluacion'];
            $this->titulo = $row['titulo'];
            $this->fecha_inicio = $row['fecha_inicio'];
            $this->fecha_fin = $row['fecha_fin'];
            $this->tiempo_maximo = $row['tiempo_maximo'];
            $this->idtipo = $row['idtipo'];
            $this->idarea = $row['idarea'];
            $this->idestado = $row['idestado'];
        }
        
        return $row;
    }
}
?>
<?php
require_once './config/conexion.php'; 

class evaluacion {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function create($data) {
        $sql = "INSERT INTO EVALUACION (titulo, fecha_inicio, fecha_fin, tiempo_maximo, idtipo, idarea, idestado) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute([
            $data['titulo'],
            $data['fecha_inicio'],
            $data['fecha_fin'],
            $data['tiempo_maximo'],
            $data['idtipo'],
            $data['idarea'],
            $data['idestado']
        ]);
    }

    public function getAll() {
        $sql = "SELECT * FROM EVALUACION ORDER BY fecha_inicio DESC";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}

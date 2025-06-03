<?php
require_once './config/conexion.php'; 

class Alternativa {
    private $conn;
    private $table = 'ALTERNATIVA';

    // Propiedades del objeto
    public $idalternativa;
    public $texto;
    public $es_correcta;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Método para crear una nueva alternativa
    public function create() {
        $query = 'INSERT INTO ' . $this->table . ' 
                 (texto, es_correcta)
                 VALUES
                 (:texto, :es_correcta)';

        $stmt = $this->conn->prepare($query);

        $this->texto = htmlspecialchars(strip_tags($this->texto));
        $this->es_correcta = filter_var($this->es_correcta, FILTER_VALIDATE_BOOLEAN);

        $stmt->bindParam(':texto', $this->texto);
        $stmt->bindParam(':es_correcta', $this->es_correcta, PDO::PARAM_BOOL);

        if($stmt->execute()) {
            return $this->conn->lastInsertId(); 
        }
        printf("Error: %s.\n", $stmt->error);
        return false;
    }

    // Método para obtener todas las alternativas
    public function getAll() {
        $query = 'SELECT 
                    idalternativa, 
                    texto, 
                    es_correcta 
                 FROM ' . $this->table . ' 
                 ORDER BY idalternativa ASC';

        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }
}
?>
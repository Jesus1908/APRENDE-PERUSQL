<?php
require_once 'config/database.php';

class Pregunta {
    private $conn;
    private $table = 'PREGUNTA';

    // Propiedades del objeto
    public $idpregunta;
    public $enunciado;
    public $valor;
    public $idalternativa_correcta;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Método para crear una nueva pregunta
    public function create() {
        $query = 'INSERT INTO ' . $this->table . ' 
                 (enunciado, valor, idalternativa_correcta)
                 VALUES
                 (:enunciado, :valor, :idalternativa_correcta)';

        $stmt = $this->conn->prepare($query);

        $this->enunciado = htmlspecialchars(strip_tags($this->enunciado));
        $this->valor = (float)$this->valor;
        $this->idalternativa_correcta = (int)$this->idalternativa_correcta;

        $stmt->bindParam(':enunciado', $this->enunciado);
        $stmt->bindParam(':valor', $this->valor);
        $stmt->bindParam(':idalternativa_correcta', $this->idalternativa_correcta);

        if($stmt->execute()) {
            return $this->conn->lastInsertId(); 
        }
        printf("Error: %s.\n", $stmt->error);
        return false;
    }

    public function getAll() {
        $query = 'SELECT 
                    p.idpregunta, 
                    p.enunciado, 
                    p.valor,
                    a.idalternativa,
                    a.texto as alternativa_correcta,
                    a.es_correcta
                 FROM ' . $this->table . ' p
                 LEFT JOIN ALTERNATIVA a ON p.idalternativa_correcta = a.idalternativa
                 ORDER BY p.idpregunta ASC';

        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }
}
?>
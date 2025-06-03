<?php
require_once './config/conexion.php';

class Pregunta {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    // Crear una nueva pregunta
    public function create($data) {
        $sql = "INSERT INTO PREGUNTA (enunciado, valor, idalternativa_correcta) VALUES (?, ?, ?)";
        $stmt = $this->pdo->prepare($sql);

        // Sanitizar enunciado y validar valores
        $enunciado = strip_tags($data['enunciado']);
        $valor = floatval($data['valor']);
        $idalternativa_correcta = intval($data['idalternativa_correcta']);

        return $stmt->execute([$enunciado, $valor, $idalternativa_correcta]);
    }

    // Obtener todas las preguntas
    public function getAll() {
        $sql = "SELECT * FROM PREGUNTA ORDER BY idpregunta ASC";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>

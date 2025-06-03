<?php
require_once './config/conexion.php'; 

class alternativa {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function create($data) {
        $sql = "INSERT INTO ALTERNATIVA (texto, es_correcta) VALUES (?, ?)";
        $stmt = $this->pdo->prepare($sql);

        $texto = strip_tags($data['texto']);
        $es_correcta = filter_var($data['es_correcta'], FILTER_VALIDATE_BOOLEAN) ? 1 : 0;

        return $stmt->execute([$texto, $es_correcta]);
    }

    public function getAll() {
        $sql = "SELECT * FROM ALTERNATIVA ORDER BY idalternativa ASC";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>


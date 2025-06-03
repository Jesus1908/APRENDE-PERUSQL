<?php
class Database
{
    private $host = '127.0.0.1';
    private $db_name = 'aprendeperu';
    private $username = 'root';
    private $password = '';
    private $conection;

    public function getConnection()
    {
        $this->conection = null;

        try {
            $this->conection = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->conection->exec("set names utf8mb4");
        } catch (PDOException $exception) {
            echo "Error de conexión: " . $exception->getMessage();
        }

        return $this->conection;
    }
}
<?php
namespace Src\Controllers;

use Src\Config\Connection;

class GenerosController
{
    public function index()
    {
        // Obtiene los valores del ENUM genero de la tabla usuarios
        $db = Connection::getInstance();
        $stmt = $db->query("SHOW COLUMNS FROM usuarios LIKE 'genero'");
        $row = $stmt->fetch();
        $enum = $row['Type'];
        preg_match("/^enum\((.*)\)$/", $enum, $matches);
        $values = [];
        if (isset($matches[1])) {
            foreach (explode(',', $matches[1]) as $value) {
                $v = trim($value, "'");
                $values[] = $v;
            }
        }
        header('Content-Type: application/json');
        echo json_encode($values);
    }
}
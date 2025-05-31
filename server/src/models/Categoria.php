<?php
namespace Src\Models;

use Src\Config\Connection;
use PDO;

class Categoria
{
    public static function all()
    {
        $db = Connection::getInstance();
        $stmt = $db->query("SELECT id, nombre, edad_minima, edad_maxima FROM categorias WHERE deleted_at IS NULL AND estado = 'Activo'");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
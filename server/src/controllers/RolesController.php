<?php
namespace Src\Controllers;

use Src\Config\Connection;

class RolesController
{
    public function index()
    {
        // Obtiene todos los roles de la base de datos
        $db = Connection::getInstance();
        $stmt = $db->query("SELECT id, nombre, descripcion FROM roles");
        $roles = $stmt->fetchAll();
        header('Content-Type: application/json');
        echo json_encode($roles);
    }
}
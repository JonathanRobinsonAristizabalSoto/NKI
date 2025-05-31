<?php
namespace Src\Controllers;

use Src\Config\Connection;

class TiposDocumentoController
{
    public function index()
    {
        // Obtiene todos los tipos de documento de la base de datos
        $db = Connection::getInstance();
        $stmt = $db->query("SELECT id, nombre, descripcion FROM tipos_documento");
        $tipos = $stmt->fetchAll();
        header('Content-Type: application/json');
        echo json_encode($tipos);
    }
}
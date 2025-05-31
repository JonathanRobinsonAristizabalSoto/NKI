<?php
namespace Src\Controllers;

use Src\Config\Connection;

class UsuariosController
{
    // Listar todos los usuarios (puedes ajustar los campos según tu necesidad)
    public function index()
    {
        $db = Connection::getInstance();
        $stmt = $db->query("SELECT id, nombre, apellido, tipo_documento_id, documento, genero, correo, telefono, direccion, fecha_nacimiento, rol_id, estado, last_login, foto, email_verificado, created_at, updated_at FROM usuarios WHERE deleted_at IS NULL");
        $usuarios = $stmt->fetchAll();
        header('Content-Type: application/json');
        echo json_encode($usuarios);
    }
}
<?php
namespace Src\Models;

use Src\Config\Connection;

class Usuario
{
    public $nombre, $apellido, $tipo_documento_id, $documento, $correo, $telefono, $fecha_nacimiento, $genero, $direccion, $rol_id, $contrasena;

    public function save()
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("INSERT INTO usuarios (nombre, apellido, tipo_documento_id, documento, correo, telefono, fecha_nacimiento, genero, direccion, rol_id, contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $success = $stmt->execute([
            $this->nombre,
            $this->apellido,
            $this->tipo_documento_id,
            $this->documento,
            $this->correo,
            $this->telefono,
            $this->fecha_nacimiento,
            $this->genero,
            $this->direccion,
            $this->rol_id,
            $this->contrasena
        ]);
        if ($success) {
            return $db->lastInsertId();
        }
        return false;
    }

    public static function getTipoDocumentoId($tipo)
    {
        // Si ya es numérico, retorna el valor como int
        if (is_numeric($tipo)) return (int)$tipo;
        $map = ['cc' => 1, 'ti' => 2, 'ce' => 3, 'passport' => 4];
        return $map[$tipo] ?? null;
    }

    public static function getRolId($rol)
    {
        // Si ya es numérico, retorna el valor como int
        if (is_numeric($rol)) return (int)$rol;
        $map = ['player' => 2, 'parent' => 5];
        return $map[$rol] ?? null;
    }
}
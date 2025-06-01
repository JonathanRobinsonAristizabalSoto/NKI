<?php
namespace Src\Models;

use Src\Config\Connection;

class Seguidor
{
    public $usuario_id;
    public $intereses;
    public $recibe_boletin;

    /**
     * Guarda un nuevo seguidor en la base de datos
     */
    public function save()
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("INSERT INTO seguidores (usuario_id, intereses, recibe_boletin) VALUES (?, ?, ?)");
        return $stmt->execute([
            $this->usuario_id,
            $this->intereses,
            $this->recibe_boletin
        ]);
    }

    /**
     * Obtener seguidor por usuario_id
     */
    public static function obtenerPorUsuario($usuario_id)
    {
        $db = Connection::getInstance();
        $sql = "SELECT * FROM seguidores WHERE usuario_id = ? AND deleted_at IS NULL";
        $stmt = $db->prepare($sql);
        $stmt->execute([$usuario_id]);
        return $stmt->fetch(\PDO::FETCH_ASSOC);
    }

    /**
     * Listar todos los seguidores activos
     */
    public static function listar()
    {
        $db = Connection::getInstance();
        $sql = "SELECT * FROM seguidores WHERE deleted_at IS NULL";
        $stmt = $db->query($sql);
        return $stmt->fetchAll(\PDO::FETCH_ASSOC);
    }
}
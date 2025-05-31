<?php
namespace Src\Models;

use Src\Config\Connection;

class Jugador
{
    public $usuario_id;
    public $categoria_id;
    public $fecha_ingreso;

    public function save()
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("INSERT INTO jugadores (usuario_id, categoria_id, fecha_ingreso) VALUES (?, ?, ?)");
        return $stmt->execute([$this->usuario_id, $this->categoria_id, $this->fecha_ingreso]);
    }
}
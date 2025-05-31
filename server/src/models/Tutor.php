<?php
namespace Src\Models;

use Src\Config\Connection;

class Tutor
{
    public $usuario_id;

    public function save()
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("INSERT INTO tutores (usuario_id) VALUES (?)");
        return $stmt->execute([$this->usuario_id]);
    }
}
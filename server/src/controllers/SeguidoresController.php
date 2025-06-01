<?php

namespace Src\Controllers;

use Src\Models\Seguidor;

class SeguidoresController
{
    /**
     * Registrar un nuevo seguidor (aficionado)
     * @param int $usuario_id
     * @param string|null $intereses
     * @param int $recibe_boletin
     * @return bool
     */
    public function registrarSeguidor($usuario_id, $intereses = null, $recibe_boletin = 1)
    {
        $seguidor = new Seguidor();
        $seguidor->usuario_id = $usuario_id;
        $seguidor->intereses = $intereses;
        $seguidor->recibe_boletin = $recibe_boletin;
        return $seguidor->save();
    }

    /**
     * Obtener seguidor por usuario_id
     */
    public function obtenerPorUsuario($usuario_id)
    {
        return Seguidor::obtenerPorUsuario($usuario_id);
    }

    /**
     * Listar todos los seguidores activos
     */
    public function listarSeguidores()
    {
        return Seguidor::listar();
    }
}
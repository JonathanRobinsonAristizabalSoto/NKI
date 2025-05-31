<?php
namespace Src\Controllers;

use Src\Models\Categoria;

class CategoriasController
{
    public function index()
    {
        $categorias = Categoria::all();
        header('Content-Type: application/json');
        echo json_encode($categorias);
    }
}
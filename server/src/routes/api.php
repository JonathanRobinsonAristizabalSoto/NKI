<?php
use Src\Controllers\Auth\RegisterController;
use Src\Controllers\TiposDocumentoController;
use Src\Controllers\RolesController;
use Src\Controllers\GenerosController;
use Src\Controllers\UsuariosController;
use Src\Controllers\CategoriasController; // Agrega el controlador de categorías

// Ruta para registrar usuario
$router->post('/api/auth/register', function() {
    $controller = new RegisterController();
    $controller->register();
});

// Ruta para obtener tipos de documento
$router->get('/api/tipos-documento', function() {
    $controller = new TiposDocumentoController();
    $controller->index();
});

// Ruta para obtener roles
$router->get('/api/roles', function() {
    $controller = new RolesController();
    $controller->index();
});

// Ruta para obtener géneros dinámicamente (ENUM)
$router->get('/api/generos', function() {
    $controller = new GenerosController();
    $controller->index();
});

// Ruta para obtener usuarios
$router->get('/api/usuarios', function() {
    $controller = new UsuariosController();
    $controller->index();
});

// Ruta para obtener categorías
$router->get('/api/categorias', function() {
    $controller = new CategoriasController();
    $controller->index();
});
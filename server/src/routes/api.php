<?php
use Src\Controllers\Auth\RegisterController;
use Src\Controllers\Auth\LoginController;
use Src\Controllers\TiposDocumentoController;
use Src\Controllers\RolesController;
use Src\Controllers\GenerosController;
use Src\Controllers\UsuariosController;
use Src\Controllers\CategoriasController;

// Ruta para registrar usuario
$router->post('/api/auth/register', function() {
    $controller = new RegisterController();
    $controller->register();
});

// Ruta para login (correo o documento)
$router->post('/api/auth/login', function() {
    LoginController::login();
});

// Ruta para login con Google
$router->post('/api/auth/google-login', function() {
    LoginController::googleLogin();
});

// Ruta para verificar el código de registro (verificación de email)
$router->post('/api/auth/verify-register-code', function() {
    $controller = new RegisterController();
    $controller->verificarCodigo();
});

// Rutas de catálogos y datos
$router->get('/api/tipos-documento', function() {
    $controller = new TiposDocumentoController();
    $controller->index();
});

$router->get('/api/roles', function() {
    $controller = new RolesController();
    $controller->index();
});

$router->get('/api/generos', function() {
    $controller = new GenerosController();
    $controller->index();
});

$router->get('/api/usuarios', function() {
    $controller = new UsuariosController();
    $controller->index();
});

$router->get('/api/categorias', function() {
    $controller = new CategoriasController();
    $controller->index();
});
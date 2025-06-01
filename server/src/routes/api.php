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

// Ruta para verificar el código de registro (verificación de email)
$router->post('/api/auth/verify-register-code', function() {
    $controller = new RegisterController();
    $controller->verificarCodigo();
});

// Ruta para verificar el código de autenticación (2FA por correo, login)
$router->post('/api/auth/verify-login-code', function() {
    LoginController::verifyCode();
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
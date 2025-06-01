<?php
require_once __DIR__ . '/../../vendor/autoload.php'; // Ajusta el path si es necesario

// Cargar variables de entorno desde .env
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();

use Bramus\Router\Router;

$router = new Router();

require_once __DIR__ . '/../src/routes/api.php';

$router->run();
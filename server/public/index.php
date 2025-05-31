<?php
require_once __DIR__ . '/../../vendor/autoload.php'; // Ajusta el path si es necesario

use Bramus\Router\Router;

$router = new Router();

require_once __DIR__ . '/../src/routes/api.php';

$router->run();
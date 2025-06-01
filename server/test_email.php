<?php
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/logs/error.log');

require_once __DIR__ . '/src/utils/EmailHelper.php';

use Src\Utils\EmailHelper;

EmailHelper::sendCode('TU_CORREO@gmail.com', '123456');
echo "Prueba de envío finalizada. Revisa el log de errores.";
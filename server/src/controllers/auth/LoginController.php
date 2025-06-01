<?php
namespace Src\Controllers\Auth;

use Src\Models\Usuario;
use Src\Validations\Auth\LoginValidation;
use Src\Utils\EmailHelper;

class LoginController
{
    public static function login()
    {
        $input = json_decode(file_get_contents('php://input'), true);

        // Validación de campos
        list($valido, $campo, $mensaje) = LoginValidation::validate($input);
        if (!$valido) {
            http_response_code(400);
            echo json_encode(['message' => $mensaje, 'field' => $campo]);
            return;
        }

        $user = trim($input['user']);
        $password = $input['password'];

        // Buscar usuario por correo o documento
        $usuario = Usuario::findByEmailOrDocumento($user);

        if (!$usuario) {
            http_response_code(401);
            echo json_encode(['message' => 'Usuario no encontrado.']);
            return;
        }

        // Verifica la contraseña
        if (!password_verify($password, $usuario['contrasena'])) {
            http_response_code(401);
            echo json_encode(['message' => 'Contraseña incorrecta.']);
            return;
        }

        // Genera y guarda el código de verificación
        $code = rand(100000, 999999);
        Usuario::saveVerificationCode($usuario['correo'], $code);

        // Envía el código por correo
        EmailHelper::sendCode($usuario['correo'], $code);

        echo json_encode(['message' => 'Código enviado por correo']);
    }

    public static function verifyCode()
    {
        $input = json_decode(file_get_contents('php://input'), true);
        $user = trim($input['user']);
        $code = $input['code'];

        $usuario = Usuario::verifyCode($user, $code);
        if (!$usuario) {
            http_response_code(401);
            echo json_encode(['message' => 'Código incorrecto o expirado.']);
            return;
        }

        // Aquí puedes generar el token JWT real
        $token = base64_encode(random_bytes(32));
        echo json_encode([
            'message' => 'Login exitoso',
            'token' => $token,
            'user' => [
                'id' => $usuario['id'],
                'nombre' => $usuario['nombre'],
                'email' => $usuario['correo'],
                'rol' => $usuario['rol_id']
            ]
        ]);
    }
}
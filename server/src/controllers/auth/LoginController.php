<?php

namespace Src\Controllers\Auth;

use Src\Models\Usuario;
use Src\Validations\Auth\LoginValidation;

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
        $usuario = Usuario::findByCorreoOrDocumento($user);

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

        // Login exitoso, genera un token (puedes usar JWT en producción)
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

    // Login con Google
    public static function googleLogin()
    {
        $input = json_decode(file_get_contents('php://input'), true);
        $tokenGoogle = $input['token'] ?? null;

        if (!$tokenGoogle) {
            http_response_code(400);
            echo json_encode(['message' => 'Token de Google no recibido.']);
            return;
        }

        // Validar el token con Google
        $payload = self::verifyGoogleToken($tokenGoogle);
        if (!$payload) {
            http_response_code(401);
            echo json_encode(['message' => 'Token de Google inválido.']);
            return;
        }

        // Buscar usuario por correo
        $usuario = Usuario::findByCorreoOrDocumento($payload['email']);
        if (!$usuario) {
            // Crear usuario nuevo si no existe
            $usuario = Usuario::crearDesdeGoogle($payload);
        }

        // Generar token de sesión (puedes usar JWT en producción)
        $token = base64_encode(random_bytes(32));
        echo json_encode([
            'message' => 'Login con Google exitoso',
            'token' => $token,
            'user' => [
                'id' => $usuario['id'],
                'nombre' => $usuario['nombre'],
                'email' => $usuario['correo'],
                'rol' => $usuario['rol_id']
            ]
        ]);
    }

    // Verifica el token de Google usando la API de Google
    private static function verifyGoogleToken($token)
    {
        $clientId = '226309003233-6jq415qlb9i6vi062q6b7kp8nf7a50hd.apps.googleusercontent.com'; // Tu Client ID
        $url = "https://oauth2.googleapis.com/tokeninfo?id_token=" . $token;
        $response = @file_get_contents($url);
        if ($response === false) {
            return false;
        }
        $payload = json_decode($response, true);

        // Verifica que el token sea válido y para tu Client ID
        if (isset($payload['aud']) && $payload['aud'] === $clientId) {
            return $payload;
        }
        return false;
    }
}
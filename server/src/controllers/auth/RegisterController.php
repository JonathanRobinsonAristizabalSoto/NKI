<?php

namespace Src\Controllers\Auth;

use Src\Models\Usuario;
use Src\Models\Jugador;
use Src\Models\Tutor;
use Src\Models\Seguidor;
use Src\Utils\EmailHelper;

class RegisterController
{
    public function register()
    {
        $input = json_decode(file_get_contents('php://input'), true);

        // Validación básica con nombres que coinciden con la base de datos y el frontend
        if (
            empty($input['nombre']) || empty($input['apellido']) || empty($input['documento']) ||
            empty($input['correo']) || empty($input['contrasena']) || empty($input['confirm_contrasena'])
        ) {
            http_response_code(400);
            echo json_encode(['message' => 'Todos los campos obligatorios deben ser completados.']);
            exit;
        }
        if (!filter_var($input['correo'], FILTER_VALIDATE_EMAIL)) {
            http_response_code(400);
            echo json_encode(['message' => 'Correo electrónico inválido.']);
            exit;
        }
        if ($input['contrasena'] !== $input['confirm_contrasena']) {
            http_response_code(400);
            echo json_encode(['message' => 'Las contraseñas no coinciden.']);
            exit;
        }
        if (strlen($input['contrasena']) < 6) {
            http_response_code(400);
            echo json_encode(['message' => 'La contraseña debe tener al menos 6 caracteres.']);
            exit;
        }

        // Permitir registro de Jugador, Tutor y Seguidor/Aficionado (IDs según tu base)
        $rolesPermitidos = [2, 5, 6]; // 2: Jugador, 5: Tutor, 6: Seguidor/Aficionado
        if (!in_array((int)$input['rol_id'], $rolesPermitidos)) {
            http_response_code(403);
            echo json_encode(['message' => 'No tienes permiso para registrarte con ese rol.']);
            exit;
        }

        // Verifica si el correo ya está registrado
        if (Usuario::existeCorreo($input['correo'])) {
            http_response_code(409);
            echo json_encode(['message' => 'El correo ya está registrado.']);
            exit;
        }

        // Verifica si el documento ya está registrado
        if (Usuario::existeDocumento($input['documento'])) {
            http_response_code(409);
            echo json_encode(['message' => 'El documento ya está registrado.']);
            exit;
        }

        $usuario = new Usuario();
        $usuario->nombre = $input['nombre'];
        $usuario->apellido = $input['apellido'];
        $usuario->tipo_documento_id = $input['tipo_documento_id'];
        $usuario->documento = $input['documento'];
        $usuario->correo = $input['correo'];
        $usuario->telefono = $input['telefono'] ?? null;
        $usuario->fecha_nacimiento = $input['fecha_nacimiento'] ?? null;
        $usuario->genero = $input['genero'] ?? null;
        $usuario->direccion = $input['direccion'] ?? null;
        $usuario->rol_id = $input['rol_id'];
        $usuario->contrasena = password_hash($input['contrasena'], PASSWORD_DEFAULT);

        $usuarioId = $usuario->save();

        if ($usuarioId) {
            if ((int)$usuario->rol_id === 2 && !empty($input['categoria_id'])) { // Jugador
                $jugador = new Jugador();
                $jugador->usuario_id = $usuarioId;
                $jugador->categoria_id = $input['categoria_id'];
                $jugador->fecha_ingreso = date('Y-m-d');
                $jugador->save();
            } elseif ((int)$usuario->rol_id === 5) { // Tutor
                $tutor = new Tutor();
                $tutor->usuario_id = $usuarioId;
                $tutor->save();
            } elseif ((int)$usuario->rol_id === 6) { // Seguidor/Aficionado
                $seguidor = new Seguidor();
                $seguidor->usuario_id = $usuarioId;
                $seguidor->intereses = $input['intereses'] ?? null;
                $seguidor->recibe_boletin = $input['recibe_boletin'] ?? 1;
                $seguidor->save();
            }

            // Generar código de verificación
            $codigo = Usuario::generarCodigoVerificacion();
            Usuario::saveVerificationCode($usuario->correo, $codigo);

            // Enviar correo con el código
            EmailHelper::enviarCodigoVerificacion($usuario->correo, $codigo);

            echo json_encode(['message' => 'Usuario registrado correctamente. Se envió un código de verificación a tu correo.']);
        } else {
            http_response_code(500);
            echo json_encode(['message' => 'Error al registrar usuario']);
        }
    }

    // Endpoint para verificar el código
    public function verificarCodigo()
    {
        $input = json_decode(file_get_contents('php://input'), true);
        if (empty($input['correo']) || empty($input['code'])) {
            http_response_code(400);
            echo json_encode(['message' => 'Datos incompletos']);
            exit;
        }

        $usuario = Usuario::findByCorreoOrDocumento($input['correo']);
        if (!$usuario) {
            http_response_code(404);
            echo json_encode(['message' => 'Usuario no encontrado']);
            exit;
        }

        if (Usuario::verifyCode($input['correo'], $input['code'])) {
            Usuario::marcarEmailVerificado($usuario['id']);
            echo json_encode(['message' => 'Correo verificado correctamente']);
        } else {
            http_response_code(400);
            echo json_encode(['message' => 'Código incorrecto o expirado']);
        }
    }
}
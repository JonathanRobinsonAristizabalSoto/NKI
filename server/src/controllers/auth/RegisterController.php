<?php

namespace Src\Controllers\Auth;

use Src\Models\Usuario;
use Src\Models\Jugador;
use Src\Models\Tutor;

class RegisterController
{
    public function register()
    {
        $input = json_decode(file_get_contents('php://input'), true);

        // Validación básica
        if (
            empty($input['name']) || empty($input['surname']) || empty($input['document']) ||
            empty($input['email']) || empty($input['password']) || empty($input['confirm_password'])
        ) {
            http_response_code(400);
            echo json_encode(['message' => 'Todos los campos obligatorios deben ser completados.']);
            exit;
        }
        if (!filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
            http_response_code(400);
            echo json_encode(['message' => 'Correo electrónico inválido.']);
            exit;
        }
        if ($input['password'] !== $input['confirm_password']) {
            http_response_code(400);
            echo json_encode(['message' => 'Las contraseñas no coinciden.']);
            exit;
        }
        if (strlen($input['password']) < 6) {
            http_response_code(400);
            echo json_encode(['message' => 'La contraseña debe tener al menos 6 caracteres.']);
            exit;
        }

        // Validar que solo se puedan registrar roles de Jugador o Tutor (IDs permitidos)
        $rolesPermitidos = [2, 5]; // Ajusta estos IDs según tu base de datos
        if (!in_array((int)$input['role'], $rolesPermitidos)) {
            http_response_code(403);
            echo json_encode(['message' => 'No tienes permiso para registrarte con ese rol.']);
            exit;
        }

        $usuario = new Usuario();
        $usuario->nombre = $input['name'];
        $usuario->apellido = $input['surname'];
        $usuario->tipo_documento_id = Usuario::getTipoDocumentoId($input['document_type']);
        $usuario->documento = $input['document'];
        $usuario->correo = $input['email'];
        $usuario->telefono = $input['phone'];
        $usuario->fecha_nacimiento = $input['birthdate'];
        $usuario->genero = $input['gender'];
        $usuario->direccion = $input['direccion'];
        $usuario->rol_id = Usuario::getRolId($input['role']);
        $usuario->contrasena = password_hash($input['password'], PASSWORD_DEFAULT);

        $usuarioId = $usuario->save();

        if ($usuarioId) {
            if ((int)$usuario->rol_id === 2) { // Jugador
                $jugador = new Jugador();
                $jugador->usuario_id = $usuarioId;
                $jugador->categoria_id = $input['categoria_id'];
                $jugador->fecha_ingreso = date('Y-m-d'); // O usa $input['fecha_ingreso'] si lo recibes del formulario
                $jugador->save();
            } elseif ((int)$usuario->rol_id === 5) { // Tutor
                $tutor = new Tutor();
                $tutor->usuario_id = $usuarioId;
                $tutor->save();
            }
            echo json_encode(['message' => 'Usuario registrado correctamente']);
        } else {
            http_response_code(500);
            echo json_encode(['message' => 'Error al registrar usuario']);
        }
    }
}

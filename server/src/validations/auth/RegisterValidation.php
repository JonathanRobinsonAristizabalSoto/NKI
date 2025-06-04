<?php

namespace Src\Validations\Auth;

class RegisterValidation
{
    public static function validate($input)
    {
        $errors = [];

        if (empty($input['nombre'])) {
            $errors[] = 'El nombre es obligatorio.';
        }
        if (empty($input['apellido'])) {
            $errors[] = 'El apellido es obligatorio.';
        }
        if (empty($input['documento'])) {
            $errors[] = 'El número de documento es obligatorio.';
        }
        if (empty($input['correo'])) {
            $errors[] = 'El correo electrónico es obligatorio.';
        } elseif (!filter_var($input['correo'], FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Correo electrónico inválido.';
        }
        if (empty($input['contrasena'])) {
            $errors[] = 'La contraseña es obligatoria.';
        } elseif (strlen($input['contrasena']) < 6) {
            $errors[] = 'La contraseña debe tener al menos 6 caracteres.';
        }
        if (!isset($input['confirm_contrasena']) || $input['contrasena'] !== $input['confirm_contrasena']) {
            $errors[] = 'Las contraseñas no coinciden.';
        }
        if (empty($input['rol_id'])) {
            $errors[] = 'El rol es obligatorio.';
        }

        return $errors;
    }
}
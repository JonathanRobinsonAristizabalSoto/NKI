<?php

namespace Src\Validations\Auth;

class RegisterValidation
{
    public static function validate($input)
    {
        $errors = [];

        if (empty($input['name'])) {
            $errors[] = 'El nombre es obligatorio.';
        }
        if (empty($input['surname'])) {
            $errors[] = 'El apellido es obligatorio.';
        }
        if (empty($input['document'])) {
            $errors[] = 'El número de documento es obligatorio.';
        }
        if (empty($input['email'])) {
            $errors[] = 'El correo electrónico es obligatorio.';
        } elseif (!filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Correo electrónico inválido.';
        }
        if (empty($input['password'])) {
            $errors[] = 'La contraseña es obligatoria.';
        } elseif (strlen($input['password']) < 6) {
            $errors[] = 'La contraseña debe tener al menos 6 caracteres.';
        }
        if (!isset($input['confirm_password']) || $input['password'] !== $input['confirm_password']) {
            $errors[] = 'Las contraseñas no coinciden.';
        }
        if (empty($input['role'])) {
            $errors[] = 'El rol es obligatorio.';
        }

        return $errors;
    }
}
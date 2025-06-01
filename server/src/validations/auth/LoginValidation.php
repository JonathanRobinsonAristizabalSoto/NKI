<?php
namespace Src\Validations\Auth;

class LoginValidation
{
    /**
     * Valida los datos recibidos para el login.
     * Permite login con correo o documento.
     * @param array $data
     * @return array [bool $valido, string $campo, string $mensaje]
     */
    public static function validate($data)
    {
        if (!isset($data['user']) || empty(trim($data['user']))) {
            return [false, 'user', 'El correo o documento es obligatorio.'];
        }
        if (!isset($data['password']) || empty(trim($data['password']))) {
            return [false, 'password', 'La contraseña es obligatoria.'];
        }
        return [true, '', ''];
    }
}
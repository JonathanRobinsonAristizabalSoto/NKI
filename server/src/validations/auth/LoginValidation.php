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
        if (!isset($data['user']) || trim($data['user']) === '') {
            return [false, 'user', 'El correo o número de documento es obligatorio.'];
        }
        if (!isset($data['password']) || trim($data['password']) === '') {
            return [false, 'password', 'La contraseña es obligatoria.'];
        }
        // Puedes agregar validaciones adicionales aquí si lo necesitas
        return [true, '', ''];
    }
}
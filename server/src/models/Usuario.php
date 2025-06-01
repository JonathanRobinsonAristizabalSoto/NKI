<?php
namespace Src\Models;

use Src\Config\Connection;

class Usuario
{
    public $nombre, $apellido, $tipo_documento_id, $documento, $correo, $telefono, $fecha_nacimiento, $genero, $direccion, $rol_id, $contrasena;

    public function save()
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("INSERT INTO usuarios (nombre, apellido, tipo_documento_id, documento, correo, telefono, fecha_nacimiento, genero, direccion, rol_id, contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $success = $stmt->execute([
            $this->nombre,
            $this->apellido,
            $this->tipo_documento_id,
            $this->documento,
            $this->correo,
            $this->telefono,
            $this->fecha_nacimiento,
            $this->genero,
            $this->direccion,
            $this->rol_id,
            $this->contrasena
        ]);
        if ($success) {
            return $db->lastInsertId();
        }
        return false;
    }

    public static function getTipoDocumentoId($tipo)
    {
        if (is_numeric($tipo)) return (int)$tipo;
        $map = ['cc' => 1, 'ti' => 2, 'ce' => 3, 'passport' => 4];
        return $map[$tipo] ?? null;
    }

    public static function getRolId($rol)
    {
        if (is_numeric($rol)) return (int)$rol;
        $map = ['player' => 2, 'parent' => 5];
        return $map[$rol] ?? null;
    }

    /**
     * Busca un usuario por correo o documento.
     * @param string $user Correo o documento
     * @return array|null
     */
    public static function findByEmailOrDocumento($user)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT * FROM usuarios WHERE correo = ? OR documento = ?");
        $stmt->execute([$user, $user]);
        $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
        return $usuario ?: null;
    }

    /**
     * Busca un usuario por ID.
     * @param int $id
     * @return array|null
     */
    public static function findById($id)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT * FROM usuarios WHERE id = ?");
        $stmt->execute([$id]);
        $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
        return $usuario ?: null;
    }

    /**
     * Guarda el código de verificación y su expiración (10 minutos).
     */
    public static function saveVerificationCode($correo, $code)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("UPDATE usuarios SET codigo_verificacion = ?, codigo_expira = DATE_ADD(NOW(), INTERVAL 10 MINUTE) WHERE correo = ?");
        $stmt->execute([$code, $correo]);
    }

    /**
     * Verifica si el código es correcto y no ha expirado.
     */
    public static function verifyCode($correo, $code)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT * FROM usuarios WHERE correo = ? AND codigo_verificacion = ? AND codigo_expira > NOW()");
        $stmt->execute([$correo, $code]);
        $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
        return $usuario ?: null;
    }

    /**
     * Verifica si un correo ya está registrado.
     */
    public static function existeCorreo($correo)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT id FROM usuarios WHERE correo = ? LIMIT 1");
        $stmt->execute([$correo]);
        return $stmt->fetch(\PDO::FETCH_ASSOC) ? true : false;
    }

    /**
     * Genera un código de verificación de 6 dígitos.
     */
    public static function generarCodigoVerificacion()
    {
        return str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    /**
     * Marca el correo como verificado para el usuario dado.
     * @param int $id
     * @return bool
     */
    public static function marcarEmailVerificado($id)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("UPDATE usuarios SET email_verificado = 1 WHERE id = ?");
        return $stmt->execute([$id]);
    }
}
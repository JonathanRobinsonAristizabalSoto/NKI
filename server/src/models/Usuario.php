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
        $map = ['cc' => 1, 'ti' => 2, 'ce' => 3, 'passport' => 4, 'pas' => 4, 'dni' => 5, 'otro' => 6];
        return $map[strtolower($tipo)] ?? null;
    }

    public static function getRolId($rol)
    {
        if (is_numeric($rol)) return (int)$rol;
        $map = ['player' => 2, 'parent' => 5];
        return $map[$rol] ?? null;
    }

    /**
     * Busca un usuario por correo o documento.
     * @param string $valor Correo o documento
     * @return array|null
     */
    public static function findByCorreoOrDocumento($valor)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT * FROM usuarios WHERE correo = ? OR documento = ? LIMIT 1");
        $stmt->execute([$valor, $valor]);
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
     * Verifica si un documento ya está registrado.
     */
    public static function existeDocumento($documento)
    {
        $db = Connection::getInstance();
        $stmt = $db->prepare("SELECT id FROM usuarios WHERE documento = ? LIMIT 1");
        $stmt->execute([$documento]);
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

    /**
     * Crea un usuario a partir de los datos de Google.
     * @param array $payload
     * @return array|null
     */
    public static function crearDesdeGoogle($payload)
    {
        $usuario = new self();
        $usuario->nombre = $payload['given_name'] ?? '';
        $usuario->apellido = $payload['family_name'] ?? '';
        $usuario->tipo_documento_id = 6; // 6 = 'OTRO' en tipos_documento
        $usuario->documento = isset($payload['sub']) ? 'google_' . $payload['sub'] : 'google_' . uniqid();
        $usuario->correo = $payload['email'];
        $usuario->telefono = null;
        $usuario->fecha_nacimiento = null;
        $usuario->genero = 'Otro';
        $usuario->direccion = null;
        $usuario->rol_id = 2; // O el rol que corresponda para usuarios Google
        $usuario->contrasena = bin2hex(random_bytes(16)); // Contraseña aleatoria, no se usa

        $id = $usuario->save();
        if ($id) {
            return self::findById($id);
        }
        return null;
    }
}
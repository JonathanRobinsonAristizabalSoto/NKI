<?php
namespace Src\Models;

use Src\Config\Connection;
use PDOException;

class Usuario
{
    public $nombre, $apellido, $tipo_documento_id, $documento, $correo, $telefono, $fecha_nacimiento, $genero, $direccion, $rol_id, $contrasena;

    public function save()
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("INSERT INTO usuarios (nombre, apellido, tipo_documento_id, documento, correo, telefono, fecha_nacimiento, genero, direccion, rol_id, contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $success = $stmt->execute([
                $this->nombre,
                $this->apellido,
                $this->tipo_documento_id,
                $this->documento,
                $this->correo,
                $this->telefono ?? null,
                $this->fecha_nacimiento ?? null,
                $this->genero ?? null,
                $this->direccion ?? null,
                $this->rol_id,
                $this->contrasena
            ]);
            if ($success) {
                return $db->lastInsertId();
            }
            return false;
        } catch (PDOException $e) {
            error_log("Error al guardar usuario: " . $e->getMessage());
            return false;
        } catch (\Exception $e) {
            error_log("Error general al guardar usuario: " . $e->getMessage());
            return false;
        }
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

    public static function findByCorreoOrDocumento($valor)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("SELECT * FROM usuarios WHERE correo = ? OR documento = ? LIMIT 1");
            $stmt->execute([$valor, $valor]);
            $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $usuario ?: null;
        } catch (PDOException $e) {
            error_log("Error al buscar usuario: " . $e->getMessage());
            return null;
        } catch (\Exception $e) {
            error_log("Error general al buscar usuario: " . $e->getMessage());
            return null;
        }
    }

    public static function findById($id)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("SELECT * FROM usuarios WHERE id = ?");
            $stmt->execute([$id]);
            $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $usuario ?: null;
        } catch (PDOException $e) {
            error_log("Error al buscar usuario por ID: " . $e->getMessage());
            return null;
        } catch (\Exception $e) {
            error_log("Error general al buscar usuario por ID: " . $e->getMessage());
            return null;
        }
    }

    public static function saveVerificationCode($correo, $code)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("UPDATE usuarios SET codigo_verificacion = ?, codigo_expira = DATE_ADD(NOW(), INTERVAL 10 MINUTE) WHERE correo = ?");
            $stmt->execute([$code, $correo]);
        } catch (PDOException $e) {
            error_log("Error al guardar código de verificación: " . $e->getMessage());
        } catch (\Exception $e) {
            error_log("Error general al guardar código de verificación: " . $e->getMessage());
        }
    }

    public static function verifyCode($correo, $code)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("SELECT * FROM usuarios WHERE correo = ? AND codigo_verificacion = ? AND codigo_expira > NOW()");
            $stmt->execute([$correo, $code]);
            $usuario = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $usuario ?: null;
        } catch (PDOException $e) {
            error_log("Error al verificar código: " . $e->getMessage());
            return null;
        } catch (\Exception $e) {
            error_log("Error general al verificar código: " . $e->getMessage());
            return null;
        }
    }

    public static function existeCorreo($correo)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("SELECT id FROM usuarios WHERE correo = ? LIMIT 1");
            $stmt->execute([$correo]);
            return $stmt->fetch(\PDO::FETCH_ASSOC) ? true : false;
        } catch (PDOException $e) {
            error_log("Error al verificar existencia de correo: " . $e->getMessage());
            return false;
        } catch (\Exception $e) {
            error_log("Error general al verificar existencia de correo: " . $e->getMessage());
            return false;
        }
    }

    public static function existeDocumento($documento)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("SELECT id FROM usuarios WHERE documento = ? LIMIT 1");
            $stmt->execute([$documento]);
            return $stmt->fetch(\PDO::FETCH_ASSOC) ? true : false;
        } catch (PDOException $e) {
            error_log("Error al verificar existencia de documento: " . $e->getMessage());
            return false;
        } catch (\Exception $e) {
            error_log("Error general al verificar existencia de documento: " . $e->getMessage());
            return false;
        }
    }

    public static function generarCodigoVerificacion()
    {
        return str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    public static function marcarEmailVerificado($id)
    {
        try {
            $db = Connection::getInstance();
            if (!$db) {
                throw new \Exception("No se pudo conectar a la base de datos.");
            }
            $stmt = $db->prepare("UPDATE usuarios SET email_verificado = 1 WHERE id = ?");
            return $stmt->execute([$id]);
        } catch (PDOException $e) {
            error_log("Error al marcar email como verificado: " . $e->getMessage());
            return false;
        } catch (\Exception $e) {
            error_log("Error general al marcar email como verificado: " . $e->getMessage());
            return false;
        }
    }

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
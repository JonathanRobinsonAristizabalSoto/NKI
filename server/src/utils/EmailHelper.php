<?php
namespace Src\Utils;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once __DIR__ . '/../../../vendor/autoload.php';

class EmailHelper
{
    /**
     * Envía un código por correo electrónico.
     */
    public static function sendCode($to, $code, $subject = 'Tu código de verificación', $body = null)
    {
        $mail = new PHPMailer(true);
        try {
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = $_ENV['MAIL_USER'] ?? 'clubnkiapp@gmail.com';
            $mail->Password = $_ENV['MAIL_PASS'] ?? '';
            $mail->SMTPSecure = 'tls';
            $mail->Port = 587;

            $mail->setFrom(
                $_ENV['MAIL_FROM'] ?? 'clubnkiapp@gmail.com',
                $_ENV['MAIL_FROM_NAME'] ?? 'NKI'
            );
            $mail->addAddress($to);

            $mail->isHTML(true);
            $mail->CharSet = 'UTF-8';

            $mail->Subject = $subject ?? 'Tu código de verificación de NKI';

            $mail->Body = $body ?? "
                <div style='font-family: Arial, sans-serif; color: #222;'>
                    <h2 style='color: #0066cc;'>¡Bienvenido a NKI!</h2>
                    <p>Hola,</p>
                    <p>Tu código de verificación es:</p>
                    <div style='font-size: 2em; font-weight: bold; color: #0066cc; margin: 20px 0;'>$code</div>
                    <p>Por favor, ingresa este código en la página para completar tu registro.</p>
                    <hr>
                    <small>Si no solicitaste este código, puedes ignorar este mensaje.</small>
                </div>
            ";

            // Debug solo en entorno local
            $mail->SMTPDebug = (($_ENV['APP_ENV'] ?? 'local') === 'local') ? 2 : 0;
            $mail->Debugoutput = function($str, $level) { error_log("SMTP: $str"); };

            $mail->send();
            return true;
        } catch (Exception $e) {
            error_log('Error enviando correo: ' . $mail->ErrorInfo);
            return false;
        }
    }

    // Alias para compatibilidad con el controlador
    public static function enviarCodigoVerificacion($to, $code)
    {
        return self::sendCode($to, $code);
    }
}
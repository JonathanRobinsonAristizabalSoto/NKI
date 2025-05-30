-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2025 a las 01:32:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nki`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alineaciones`
--

CREATE TABLE `alineaciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `partido_id` int(10) UNSIGNED DEFAULT NULL,
  `jugador_id` int(10) UNSIGNED DEFAULT NULL,
  `titular` tinyint(1) DEFAULT NULL,
  `suplente` tinyint(1) DEFAULT NULL,
  `minuto_ingreso` int(11) DEFAULT NULL,
  `minuto_salida` int(11) DEFAULT NULL,
  `goles` int(11) DEFAULT 0,
  `asistencias` int(11) DEFAULT 0,
  `tarjetas_amarillas` int(11) DEFAULT 0,
  `tarjetas_rojas` int(11) DEFAULT 0,
  `sustitucion` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Alineaciones de jugadores en partidos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id` int(10) UNSIGNED NOT NULL,
  `entrenamiento_id` int(10) UNSIGNED DEFAULT NULL,
  `jugador_id` int(10) UNSIGNED DEFAULT NULL,
  `presente` tinyint(1) DEFAULT NULL,
  `motivo_ausencia` text DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `comentarios` text DEFAULT NULL,
  `tipo_ausencia` enum('Justificada','No justificada') DEFAULT 'No justificada',
  `entrenador_id` int(10) UNSIGNED DEFAULT NULL,
  `tutor_id` int(10) UNSIGNED DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  `respuesta_tutor` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Registro de asistencia de jugadores a entrenamientos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `accion` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tabla_afectada` varchar(100) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bitácora de acciones importantes del sistema';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `edad_minima` int(11) NOT NULL CHECK (`edad_minima` >= 0),
  `edad_maxima` int(11) NOT NULL CHECK (`edad_maxima` >= `edad_minima`),
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Categorías de jugadores por edad';

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `edad_minima`, `edad_maxima`, `estado`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Baby', 'Iniciación (2019–2021)', 4, 6, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(2, 'Mini', 'Microfútbol o Escuela (2017–2018)', 7, 8, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(3, 'Preinfantil', 'Pony Fútbol (edades iniciales) (2015–2016)', 9, 10, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(4, 'Infantil', 'Categoría Pony Fútbol oficial (2013–2014)', 11, 12, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(5, 'Prejuvenil', 'Torneo Nacional Sub-13/Sub-14 (2011–2012)', 13, 14, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(6, 'Juvenil', 'Sub-15/Sub-16 (2009–2010)', 15, 16, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(7, 'Junior', 'Sub-17/Sub-18 (2007–2008)', 17, 18, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(8, 'Sub-20', 'Torneo Nacional Sub-20 (Difútbol) (2005–2006)', 19, 20, 'Activo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conceptos_cobro`
--

CREATE TABLE `conceptos_cobro` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Valores y detalles de cobros del club (inscripción, mensualidad, torneo, etc)';

--
-- Volcado de datos para la tabla `conceptos_cobro`
--

INSERT INTO `conceptos_cobro` (`id`, `nombre`, `descripcion`, `valor`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Inscripcion', 'Valor de inscripción al club', 35000.00, 'Activo', '2025-05-30 23:31:59', '2025-05-30 23:31:59'),
(2, 'Mensualidad', 'Pago mensual por pertenecer al club', 53000.00, 'Activo', '2025-05-30 23:31:59', '2025-05-30 23:31:59'),
(3, 'Torneo', 'Valor de participación en torneo', 35000.00, 'Activo', '2025-05-30 23:31:59', '2025-05-30 23:31:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_pagos`
--

CREATE TABLE `configuracion_pagos` (
  `id` int(10) UNSIGNED NOT NULL,
  `metodo_pago` enum('PSE','Tarjeta','Paypal','Otro') DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Configuración de métodos de pago y API keys';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrenadores`
--

CREATE TABLE `entrenadores` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `especialidad` enum('Físico','Táctico','Psicológico','Técnico','Preparación de Arqueros') DEFAULT 'Táctico',
  `experiencia` text DEFAULT NULL,
  `nivel_educativo` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `fecha_ingreso` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Entrenadores registrados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrenamientos`
--

CREATE TABLE `entrenamientos` (
  `id` int(10) UNSIGNED NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `objetivo` text DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `intensidad` enum('Baja','Media','Alta') DEFAULT NULL,
  `tipo_entrenamiento` enum('Físico','Técnico','Táctico','Mental') DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `entrenador_id` int(10) UNSIGNED DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Sesiones de entrenamiento';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadisticas`
--

CREATE TABLE `estadisticas` (
  `id` int(10) UNSIGNED NOT NULL,
  `partido_id` int(10) UNSIGNED DEFAULT NULL,
  `jugador_id` int(10) UNSIGNED DEFAULT NULL,
  `goles` int(11) DEFAULT 0,
  `asistencias` int(11) DEFAULT 0,
  `minutos_jugados` int(11) DEFAULT NULL,
  `tarjetas_amarillas` int(11) DEFAULT 0,
  `tarjetas_rojas` int(11) DEFAULT 0,
  `tiros` int(11) DEFAULT 0,
  `tiros_al_arco` int(11) DEFAULT 0,
  `pases` int(11) DEFAULT 0,
  `posesion` decimal(5,2) DEFAULT 0.00,
  `tiros_de_esquina` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Estadísticas individuales por partido';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `lugar` varchar(255) DEFAULT NULL,
  `organizador_id` int(10) UNSIGNED DEFAULT NULL,
  `estado` enum('Activo','Cancelado','Finalizado') DEFAULT 'Activo',
  `tipo` enum('Deportivo','Social','Formación','Otro') DEFAULT 'Otro',
  `capacidad` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Eventos deportivos y sociales';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_pagos`
--

CREATE TABLE `historial_pagos` (
  `id` int(10) UNSIGNED NOT NULL,
  `pago_id` int(10) UNSIGNED DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `monto` decimal(10,2) DEFAULT NULL,
  `estado_pago` enum('Pendiente','Completado','Fallido','Reembolsado') DEFAULT 'Pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Historial de cambios en pagos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indumentaria`
--

CREATE TABLE `indumentaria` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipo` enum('Camiseta','Pantaloneta','Medias','Zapatos','Accesorios','Balones','Guantes','Otro') DEFAULT 'Otro',
  `descripcion` varchar(100) DEFAULT NULL,
  `talla` enum('4','6','8','10','12','14','S','M','L','XL','XXL','XXXL') DEFAULT 'S',
  `cantidad` int(11) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `estado` enum('Nuevo','Usado','Dañado') DEFAULT 'Nuevo',
  `tipo_uniforme` enum('Local','Visitante','Entrenamiento') DEFAULT 'Entrenamiento',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Indumentaria y equipamiento';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Inventario de indumentaria';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadores`
--

CREATE TABLE `jugadores` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `posicion_id` int(10) UNSIGNED NOT NULL,
  `dorsal` int(11) NOT NULL,
  `estatura` decimal(5,2) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `categoria_id` int(10) UNSIGNED NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `habilidades` text DEFAULT NULL,
  `tutor_id` int(10) UNSIGNED DEFAULT NULL,
  `pie_habil` enum('Derecho','Izquierdo') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Jugadores registrados en el club';

--
-- Disparadores `jugadores`
--
DELIMITER $$
CREATE TRIGGER `tr_jugadores_delete_auditoria` AFTER DELETE ON `jugadores` FOR EACH ROW BEGIN
    INSERT INTO auditoria (usuario_id, accion, descripcion, tabla_afectada, created_at)
    VALUES (OLD.updated_by, 'DELETE', CONCAT('Jugador eliminado: ', OLD.id), 'jugadores', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_jugadores_update_auditoria` AFTER UPDATE ON `jugadores` FOR EACH ROW BEGIN
    INSERT INTO auditoria (usuario_id, accion, descripcion, tabla_afectada, created_at)
    VALUES (NEW.updated_by, 'UPDATE', CONCAT('Jugador actualizado: ', NEW.id), 'jugadores', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

CREATE TABLE `noticias` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `autor_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Noticias y comunicados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `asistencia_id` int(10) UNSIGNED DEFAULT NULL,
  `tutor_id` int(10) UNSIGNED DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `tipo` enum('Asistencia','Pago','Evento','General') DEFAULT 'General',
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0,
  `fecha_lectura` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Notificaciones enviadas a tutores';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(10) UNSIGNED NOT NULL,
  `tutor_id` int(10) UNSIGNED NOT NULL,
  `jugador_id` int(10) UNSIGNED NOT NULL,
  `concepto_id` int(10) UNSIGNED NOT NULL,
  `monto` decimal(10,2) NOT NULL CHECK (`monto` > 0),
  `metodo_pago` enum('Efectivo','Transferencia','Tarjeta','Paypal','PSE') NOT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  `fecha_pago` datetime DEFAULT current_timestamp(),
  `estado` enum('Pendiente','Pagado','Vencido','Rechazado') NOT NULL DEFAULT 'Pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Pagos realizados por tutores para jugadores';

--
-- Disparadores `pagos`
--
DELIMITER $$
CREATE TRIGGER `tr_pagos_delete_auditoria` AFTER DELETE ON `pagos` FOR EACH ROW BEGIN
    INSERT INTO auditoria (usuario_id, accion, descripcion, tabla_afectada, created_at)
    VALUES (OLD.tutor_id, 'DELETE', CONCAT('Pago eliminado: ', OLD.id), 'pagos', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_pagos_update_historial` AFTER UPDATE ON `pagos` FOR EACH ROW BEGIN
    INSERT INTO historial_pagos (pago_id, fecha_actualizacion, monto, estado_pago, created_at)
    VALUES (NEW.id, NOW(), NEW.monto, NEW.estado, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partidos`
--

CREATE TABLE `partidos` (
  `id` int(10) UNSIGNED NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `resultado_local` int(11) DEFAULT NULL,
  `resultado_visitante` int(11) DEFAULT NULL,
  `lugar` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `equipo_local` varchar(100) DEFAULT NULL,
  `equipo_visitante` varchar(100) DEFAULT NULL,
  `goles_local` int(11) DEFAULT NULL,
  `goles_visitante` int(11) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `comentarios` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Partidos jugados o programados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `token` varchar(255) NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiracion` datetime DEFAULT NULL,
  `usado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Solicitudes de recuperación de contraseña';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `producto_id` int(10) UNSIGNED DEFAULT NULL,
  `servicio_id` int(10) UNSIGNED DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL CHECK (`cantidad` > 0),
  `total` decimal(10,2) DEFAULT NULL CHECK (`total` >= 0),
  `estado` enum('Pendiente','Pagado','Cancelado') DEFAULT 'Pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Pedidos de productos y servicios';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` enum('Ver Usuarios','Crear Usuarios','Editar Usuarios','Eliminar Usuarios','Ver Entrenamientos','Crear Entrenamientos','Editar Entrenamientos','Eliminar Entrenamientos','Ver Partidos','Crear Partidos','Editar Partidos','Eliminar Partidos','Ver Estadisticas','Crear Estadisticas','Editar Estadisticas','Eliminar Estadisticas','Ver Pagos','Crear Pagos','Editar Pagos','Eliminar Pagos') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Permisos asignables a roles';

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Ver Usuarios', 'Permiso para ver usuarios', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(2, 'Crear Usuarios', 'Permiso para crear usuarios', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(3, 'Editar Usuarios', 'Permiso para editar usuarios', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(4, 'Eliminar Usuarios', 'Permiso para eliminar usuarios', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(5, 'Ver Entrenamientos', 'Permiso para ver entrenamientos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(6, 'Crear Entrenamientos', 'Permiso para crear entrenamientos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(7, 'Editar Entrenamientos', 'Permiso para editar entrenamientos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(8, 'Eliminar Entrenamientos', 'Permiso para eliminar entrenamientos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(9, 'Ver Partidos', 'Permiso para ver partidos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(10, 'Crear Partidos', 'Permiso para crear partidos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(11, 'Editar Partidos', 'Permiso para editar partidos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(12, 'Eliminar Partidos', 'Permiso para eliminar partidos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(13, 'Ver Estadisticas', 'Permiso para ver estadísticas', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(14, 'Crear Estadisticas', 'Permiso para crear estadísticas', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(15, 'Editar Estadisticas', 'Permiso para editar estadísticas', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(16, 'Eliminar Estadisticas', 'Permiso para eliminar estadísticas', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(17, 'Ver Pagos', 'Permiso para ver pagos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(18, 'Crear Pagos', 'Permiso para crear pagos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(19, 'Editar Pagos', 'Permiso para editar pagos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(20, 'Eliminar Pagos', 'Permiso para eliminar pagos', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posiciones`
--

CREATE TABLE `posiciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Posiciones de juego para los jugadores';

--
-- Volcado de datos para la tabla `posiciones`
--

INSERT INTO `posiciones` (`id`, `nombre`, `descripcion`, `estado`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'POR', 'Portero: Único que puede usar las manos en su área.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(2, 'DC', 'Defensa Central: Intercepta ataques por el centro.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(3, 'LD', 'Lateral Derecho: Defensa por la banda derecha.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(4, 'LI', 'Lateral Izquierdo: Defensa por la banda izquierda.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(5, 'LIB', 'Líbero: Defensa centralizado, último hombre.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(6, 'MCD', 'Mediocentro Defensivo: Recupera balones, protege a la defensa.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(7, 'MCO', 'Mediocentro Ofensivo: Crea juego ofensivo.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(8, 'MC', 'Mediocampista Central: Distribuye el juego desde el centro.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(9, 'ED', 'Extremo Derecho: Ataca por la banda derecha.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(10, 'EI', 'Extremo Izquierdo: Ataca por la banda izquierda.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(11, 'DCEN', 'Delantero Centro: Principal atacante, encargado de anotar goles.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL),
(12, 'SD', 'Segundo Delantero: Apoya al delantero centro, se mueve libremente en el frente.', 'Activo', '2025-05-30 23:31:57', '2025-05-30 23:31:57', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL CHECK (`precio` > 0),
  `indumentaria_id` int(10) UNSIGNED DEFAULT NULL,
  `estado` enum('Disponible','No disponible') DEFAULT 'Disponible',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Productos a la venta';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` enum('Administrador','Jugador','Entrenador','Asistente','Tutor') NOT NULL DEFAULT 'Tutor',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Roles del sistema';

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Administrador', 'Rol con acceso completo al sistema', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(2, 'Jugador', 'Rol para los jugadores del equipo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(3, 'Entrenador', 'Rol para los entrenadores del equipo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(4, 'Asistente', 'Rol para los asistentes del equipo', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL),
(5, 'Tutor', 'Rol para los tutores de los jugadores', '2025-05-30 23:31:56', '2025-05-30 23:31:56', '2025-05-30 23:31:56', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_permisos`
--

CREATE TABLE `roles_permisos` (
  `id` int(10) UNSIGNED NOT NULL,
  `rol_id` int(10) UNSIGNED DEFAULT NULL,
  `permiso_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Relación muchos a muchos entre roles y permisos';

--
-- Volcado de datos para la tabla `roles_permisos`
--

INSERT INTO `roles_permisos` (`id`, `rol_id`, `permiso_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(2, 1, 2, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(3, 1, 3, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(4, 1, 4, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(5, 1, 5, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(6, 1, 6, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(7, 1, 7, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(8, 1, 8, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(9, 1, 9, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(10, 1, 10, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(11, 1, 11, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(12, 1, 12, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(13, 1, 13, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(14, 1, 14, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(15, 1, 15, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(16, 1, 16, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(17, 1, 17, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(18, 1, 18, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(19, 1, 19, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(20, 1, 20, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(32, 2, 5, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(33, 2, 9, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(34, 2, 13, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(35, 3, 1, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(36, 3, 5, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(37, 3, 6, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(38, 3, 7, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(39, 3, 8, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(40, 3, 9, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(41, 3, 10, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(42, 3, 11, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(43, 3, 12, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(44, 3, 13, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(45, 3, 14, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(46, 3, 15, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(47, 3, 16, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(50, 4, 5, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(51, 4, 7, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(52, 4, 9, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(53, 4, 11, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(57, 5, 1, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(58, 5, 13, '2025-05-30 23:31:56', '2025-05-30 23:31:56'),
(59, 5, 17, '2025-05-30 23:31:56', '2025-05-30 23:31:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL CHECK (`precio` > 0),
  `tipo` enum('Mensualidad','Inscripcion') NOT NULL,
  `periodicidad` enum('Unico','Mensual','Anual') DEFAULT 'Unico',
  `estado` enum('Disponible','No disponible') DEFAULT 'Disponible',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Servicios ofrecidos (mensualidades, inscripciones, etc)';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_documento`
--

CREATE TABLE `tipos_documento` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(10) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Catálogo de tipos de documento para todas las personas';

--
-- Volcado de datos para la tabla `tipos_documento`
--

INSERT INTO `tipos_documento` (`id`, `nombre`, `descripcion`) VALUES
(1, 'CC', 'Cédula de ciudadanía'),
(2, 'TI', 'Tarjeta de Identidad'),
(3, 'CE', 'Cédula de Extranjería'),
(4, 'PAS', 'Pasaporte'),
(5, 'DNI', 'Documento Nacional de Identidad'),
(6, 'OTRO', 'Otro tipo de documento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `pedido_id` int(10) UNSIGNED DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL CHECK (`monto` >= 0),
  `metodo_pago` enum('Efectivo','Transferencia','Tarjeta','Paypal','PSE') DEFAULT 'Paypal',
  `estado_transaccion` enum('Pendiente','Completada','Fallida','Reembolsada') DEFAULT 'Pendiente',
  `transaccion_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Transacciones de pagos de pedidos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutores`
--

CREATE TABLE `tutores` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `telefono_secundario` varchar(50) DEFAULT NULL,
  `relacion_con_jugador` enum('Padre','Madre','Tío','Abuelo','Otro') DEFAULT NULL,
  `es_emergencia` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tutores y acudientes de los jugadores';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `tipo_documento_id` int(10) UNSIGNED NOT NULL,
  `documento` varchar(50) NOT NULL,
  `genero` enum('Masculino','Femenino','Otro') DEFAULT 'Otro',
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL COMMENT 'Contraseña hasheada',
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `rol_id` int(10) UNSIGNED DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `email_verificado` tinyint(1) DEFAULT 0,
  `token_verificacion` varchar(255) DEFAULT NULL,
  `ultimo_cambio_contrasena` timestamp NULL DEFAULT NULL,
  `intentos_fallidos` int(11) DEFAULT 0,
  `bloqueado_hasta` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Usuarios del sistema (login y gestión, puede ser jugador, entrenador, asistente o tutor)';

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `tr_usuarios_delete_auditoria` AFTER DELETE ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO auditoria (usuario_id, accion, descripcion, tabla_afectada, created_at)
    VALUES (OLD.id, 'DELETE', CONCAT('Usuario eliminado: ', OLD.nombre, ' ', OLD.apellido), 'usuarios', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_usuarios_insert_auditoria` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO auditoria (usuario_id, accion, descripcion, tabla_afectada, created_at)
    VALUES (NEW.id, 'INSERT', CONCAT('Nuevo usuario: ', NEW.nombre, ' ', NEW.apellido), 'usuarios', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_jugadores_activos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_jugadores_activos` (
`id` int(10) unsigned
,`usuario_id` int(10) unsigned
,`fecha_ingreso` date
,`posicion_id` int(10) unsigned
,`dorsal` int(11)
,`estatura` decimal(5,2)
,`peso` decimal(5,2)
,`categoria_id` int(10) unsigned
,`estado` tinyint(1)
,`habilidades` text
,`tutor_id` int(10) unsigned
,`pie_habil` enum('Derecho','Izquierdo')
,`created_at` timestamp
,`updated_at` timestamp
,`deleted_at` timestamp
,`updated_by` int(10) unsigned
,`created_by` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_pagos_pendientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_pagos_pendientes` (
`id` int(10) unsigned
,`tutor_id` int(10) unsigned
,`jugador_id` int(10) unsigned
,`concepto_id` int(10) unsigned
,`monto` decimal(10,2)
,`metodo_pago` enum('Efectivo','Transferencia','Tarjeta','Paypal','PSE')
,`referencia` varchar(50)
,`fecha_pago` datetime
,`estado` enum('Pendiente','Pagado','Vencido','Rechazado')
,`created_at` timestamp
,`updated_at` timestamp
,`deleted_at` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_usuarios_activos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_usuarios_activos` (
`id` int(10) unsigned
,`nombre` varchar(100)
,`apellido` varchar(100)
,`tipo_documento_id` int(10) unsigned
,`documento` varchar(50)
,`genero` enum('Masculino','Femenino','Otro')
,`correo` varchar(100)
,`contrasena` varchar(255)
,`telefono` varchar(50)
,`direccion` text
,`fecha_nacimiento` date
,`rol_id` int(10) unsigned
,`estado` tinyint(1)
,`last_login` timestamp
,`foto` varchar(255)
,`email_verificado` tinyint(1)
,`token_verificacion` varchar(255)
,`ultimo_cambio_contrasena` timestamp
,`intentos_fallidos` int(11)
,`bloqueado_hasta` datetime
,`created_at` timestamp
,`updated_at` timestamp
,`deleted_at` timestamp
,`updated_by` int(10) unsigned
,`created_by` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_jugadores_activos`
--
DROP TABLE IF EXISTS `vista_jugadores_activos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_jugadores_activos`  AS SELECT `jugadores`.`id` AS `id`, `jugadores`.`usuario_id` AS `usuario_id`, `jugadores`.`fecha_ingreso` AS `fecha_ingreso`, `jugadores`.`posicion_id` AS `posicion_id`, `jugadores`.`dorsal` AS `dorsal`, `jugadores`.`estatura` AS `estatura`, `jugadores`.`peso` AS `peso`, `jugadores`.`categoria_id` AS `categoria_id`, `jugadores`.`estado` AS `estado`, `jugadores`.`habilidades` AS `habilidades`, `jugadores`.`tutor_id` AS `tutor_id`, `jugadores`.`pie_habil` AS `pie_habil`, `jugadores`.`created_at` AS `created_at`, `jugadores`.`updated_at` AS `updated_at`, `jugadores`.`deleted_at` AS `deleted_at`, `jugadores`.`updated_by` AS `updated_by`, `jugadores`.`created_by` AS `created_by` FROM `jugadores` WHERE `jugadores`.`estado` = 1 AND `jugadores`.`deleted_at` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_pagos_pendientes`
--
DROP TABLE IF EXISTS `vista_pagos_pendientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pagos_pendientes`  AS SELECT `pagos`.`id` AS `id`, `pagos`.`tutor_id` AS `tutor_id`, `pagos`.`jugador_id` AS `jugador_id`, `pagos`.`concepto_id` AS `concepto_id`, `pagos`.`monto` AS `monto`, `pagos`.`metodo_pago` AS `metodo_pago`, `pagos`.`referencia` AS `referencia`, `pagos`.`fecha_pago` AS `fecha_pago`, `pagos`.`estado` AS `estado`, `pagos`.`created_at` AS `created_at`, `pagos`.`updated_at` AS `updated_at`, `pagos`.`deleted_at` AS `deleted_at` FROM `pagos` WHERE `pagos`.`estado` = 'Pendiente' AND `pagos`.`deleted_at` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_usuarios_activos`
--
DROP TABLE IF EXISTS `vista_usuarios_activos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_usuarios_activos`  AS SELECT `usuarios`.`id` AS `id`, `usuarios`.`nombre` AS `nombre`, `usuarios`.`apellido` AS `apellido`, `usuarios`.`tipo_documento_id` AS `tipo_documento_id`, `usuarios`.`documento` AS `documento`, `usuarios`.`genero` AS `genero`, `usuarios`.`correo` AS `correo`, `usuarios`.`contrasena` AS `contrasena`, `usuarios`.`telefono` AS `telefono`, `usuarios`.`direccion` AS `direccion`, `usuarios`.`fecha_nacimiento` AS `fecha_nacimiento`, `usuarios`.`rol_id` AS `rol_id`, `usuarios`.`estado` AS `estado`, `usuarios`.`last_login` AS `last_login`, `usuarios`.`foto` AS `foto`, `usuarios`.`email_verificado` AS `email_verificado`, `usuarios`.`token_verificacion` AS `token_verificacion`, `usuarios`.`ultimo_cambio_contrasena` AS `ultimo_cambio_contrasena`, `usuarios`.`intentos_fallidos` AS `intentos_fallidos`, `usuarios`.`bloqueado_hasta` AS `bloqueado_hasta`, `usuarios`.`created_at` AS `created_at`, `usuarios`.`updated_at` AS `updated_at`, `usuarios`.`deleted_at` AS `deleted_at`, `usuarios`.`updated_by` AS `updated_by`, `usuarios`.`created_by` AS `created_by` FROM `usuarios` WHERE `usuarios`.`estado` = 1 AND `usuarios`.`deleted_at` is null ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alineaciones`
--
ALTER TABLE `alineaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jugador_id` (`jugador_id`),
  ADD KEY `idx_alineaciones_partido_jugador` (`partido_id`,`jugador_id`),
  ADD KEY `idx_alineaciones_partido_titular` (`partido_id`,`titular`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jugador_id` (`jugador_id`),
  ADD KEY `entrenador_id` (`entrenador_id`),
  ADD KEY `tutor_id` (`tutor_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_asistencia_entrenamiento_jugador` (`entrenamiento_id`,`jugador_id`),
  ADD KEY `idx_asistencia_presente` (`presente`),
  ADD KEY `idx_asistencia_created_at` (`created_at`),
  ADD KEY `idx_asistencia_deleted_at` (`deleted_at`),
  ADD KEY `idx_asistencia_entrenamiento_jugador_fecha` (`entrenamiento_id`,`jugador_id`,`fecha_registro`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_auditoria_usuario_accion` (`usuario_id`,`accion`),
  ADD KEY `idx_auditoria_fecha` (`created_at`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_categorias_nombre` (`nombre`),
  ADD KEY `idx_categorias_estado` (`estado`);

--
-- Indices de la tabla `conceptos_cobro`
--
ALTER TABLE `conceptos_cobro`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracion_pagos`
--
ALTER TABLE `configuracion_pagos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_entrenadores_usuario_estado` (`usuario_id`,`estado`);

--
-- Indices de la tabla `entrenamientos`
--
ALTER TABLE `entrenamientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_entrenamientos_fecha_estado` (`fecha`,`estado`),
  ADD KEY `idx_entrenamientos_entrenador_estado` (`entrenador_id`,`estado`);

--
-- Indices de la tabla `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_estadisticas_partido_jugador` (`partido_id`,`jugador_id`),
  ADD KEY `idx_estadisticas_jugador_goles` (`jugador_id`,`goles`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizador_id` (`organizador_id`),
  ADD KEY `idx_eventos_fecha_estado` (`fecha`,`estado`),
  ADD KEY `idx_eventos_tipo_estado` (`tipo`,`estado`);

--
-- Indices de la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_historial_pagos_pago_estado` (`pago_id`,`estado_pago`),
  ADD KEY `idx_historial_pagos_fecha` (`fecha_actualizacion`);

--
-- Indices de la tabla `indumentaria`
--
ALTER TABLE `indumentaria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_indumentaria_tipo_estado` (`tipo`,`estado`),
  ADD KEY `idx_indumentaria_talla_estado` (`talla`,`estado`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_inventario_item_fecha` (`item_id`,`fecha_ingreso`);

--
-- Indices de la tabla `jugadores`
--
ALTER TABLE `jugadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_categoria_dorsal` (`categoria_id`,`dorsal`),
  ADD KEY `posicion_id` (`posicion_id`),
  ADD KEY `tutor_id` (`tutor_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_jugadores_usuario_categoria` (`usuario_id`,`categoria_id`),
  ADD KEY `idx_jugadores_categoria_estado` (`categoria_id`,`estado`),
  ADD KEY `idx_jugadores_estado` (`estado`),
  ADD KEY `idx_jugadores_created_at` (`created_at`),
  ADD KEY `idx_jugadores_deleted_at` (`deleted_at`),
  ADD KEY `idx_jugadores_categoria_dorsal` (`categoria_id`,`dorsal`,`estado`);

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor_id` (`autor_id`),
  ADD KEY `idx_noticias_fecha` (`fecha_publicacion`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asistencia_id` (`asistencia_id`),
  ADD KEY `idx_notificaciones_tutor_leido` (`tutor_id`,`leido`),
  ADD KEY `idx_notificaciones_tipo_fecha` (`tipo`,`fecha_envio`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pagos_tutor_jugador_estado` (`tutor_id`,`jugador_id`,`estado`),
  ADD KEY `idx_pagos_fecha_estado` (`fecha_pago`,`estado`),
  ADD KEY `idx_pagos_jugador_estado` (`jugador_id`,`estado`),
  ADD KEY `idx_pagos_concepto` (`concepto_id`);

--
-- Indices de la tabla `partidos`
--
ALTER TABLE `partidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_partidos_fecha_estado` (`fecha`,`estado`),
  ADD KEY `idx_partidos_equipos_fecha` (`equipo_local`,`equipo_visitante`,`fecha`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_password_resets_usuario` (`usuario_id`),
  ADD KEY `idx_password_resets_token` (`token`,`usuario_id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicio_id` (`servicio_id`),
  ADD KEY `idx_pedidos_usuario_estado` (`usuario_id`,`estado`),
  ADD KEY `idx_pedidos_producto_servicio` (`producto_id`,`servicio_id`,`estado`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_permisos_nombre` (`nombre`);

--
-- Indices de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `idx_posiciones_estado` (`estado`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_productos_estado_nombre` (`estado`,`nombre`),
  ADD KEY `idx_productos_indumentaria_estado` (`indumentaria_id`,`estado`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_roles_nombre` (`nombre`);

--
-- Indices de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permiso_id` (`permiso_id`),
  ADD KEY `idx_roles_permisos_rol_permiso` (`rol_id`,`permiso_id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_servicios_estado_tipo` (`estado`,`tipo`);

--
-- Indices de la tabla `tipos_documento`
--
ALTER TABLE `tipos_documento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `idx_tipos_documento_nombre` (`nombre`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transacciones_estado_metodo` (`estado_transaccion`,`metodo_pago`),
  ADD KEY `idx_transacciones_pedido_estado` (`pedido_id`,`estado_transaccion`);

--
-- Indices de la tabla `tutores`
--
ALTER TABLE `tutores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_tutores_usuario_emergencia` (`usuario_id`,`es_emergencia`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `tipo_documento_id` (`tipo_documento_id`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_usuarios_documento` (`documento`),
  ADD KEY `idx_usuarios_correo` (`correo`),
  ADD KEY `idx_usuarios_rol_estado` (`rol_id`,`estado`),
  ADD KEY `idx_usuarios_estado` (`estado`),
  ADD KEY `idx_usuarios_created_at` (`created_at`),
  ADD KEY `idx_usuarios_deleted_at` (`deleted_at`),
  ADD KEY `idx_usuarios_documento_correo` (`documento`,`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alineaciones`
--
ALTER TABLE `alineaciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `conceptos_cobro`
--
ALTER TABLE `conceptos_cobro`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `configuracion_pagos`
--
ALTER TABLE `configuracion_pagos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrenamientos`
--
ALTER TABLE `entrenamientos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estadisticas`
--
ALTER TABLE `estadisticas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indumentaria`
--
ALTER TABLE `indumentaria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jugadores`
--
ALTER TABLE `jugadores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `partidos`
--
ALTER TABLE `partidos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipos_documento`
--
ALTER TABLE `tipos_documento`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tutores`
--
ALTER TABLE `tutores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alineaciones`
--
ALTER TABLE `alineaciones`
  ADD CONSTRAINT `alineaciones_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alineaciones_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`entrenamiento_id`) REFERENCES `entrenamientos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_3` FOREIGN KEY (`entrenador_id`) REFERENCES `entrenadores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_4` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrenadores`
--
ALTER TABLE `entrenadores`
  ADD CONSTRAINT `entrenadores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `entrenadores_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `entrenadores_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrenamientos`
--
ALTER TABLE `entrenamientos`
  ADD CONSTRAINT `entrenamientos_ibfk_1` FOREIGN KEY (`entrenador_id`) REFERENCES `entrenadores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `entrenamientos_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `entrenamientos_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD CONSTRAINT `estadisticas_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `estadisticas_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`organizador_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  ADD CONSTRAINT `historial_pagos_ibfk_1` FOREIGN KEY (`pago_id`) REFERENCES `pagos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `indumentaria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `jugadores`
--
ALTER TABLE `jugadores`
  ADD CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_2` FOREIGN KEY (`posicion_id`) REFERENCES `posiciones` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_3` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_4` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `jugadores_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `noticias_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`asistencia_id`) REFERENCES `asistencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pagos_ibfk_3` FOREIGN KEY (`concepto_id`) REFERENCES `conceptos_cobro` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`indumentaria_id`) REFERENCES `indumentaria` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD CONSTRAINT `roles_permisos_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `roles_permisos_ibfk_2` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tutores`
--
ALTER TABLE `tutores`
  ADD CONSTRAINT `tutores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tutores_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tutores_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipos_documento` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

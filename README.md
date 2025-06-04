# 📦 Proyecto: Aplicación NKI - Escuela y Club de Fútbol ⚽

Sistema de gestión para la Escuela y Club de Fútbol NKI. Permite administrar jugadores, tutores, entrenadores, pagos, entrenamientos, perfiles y más desde una interfaz web optimizada para dispositivos móviles y compilable como APK mediante Apache Cordova.

---

## 🚀 Tecnologías Usadas

**Frontend:**
- HTML5, CSS3, JavaScript
- Tailwind CSS
- jQuery
- Apache Cordova

**Backend:**
- PHP nativo
- API RESTful
- JWT para autenticación

**Base de Datos:**
- MySQL

**Herramientas:**
- Git & GitHub
- VS Code
- Postman
- XAMPP / Laragon

---

## 🔒 Verificación de Login por Correo

- El sistema envía un código de verificación al correo electrónico del usuario tras el login.
- El usuario debe ingresar el código recibido para acceder al sistema.
- El envío de correos se realiza mediante PHPMailer y SMTP (Gmail o proveedor propio).


## 📁 Estructura del Proyecto

```
NKI/
├── client/                                              # Frontend de la aplicación (web y Cordova)
│   ├── node_modules/                                    # Dependencias npm del frontend
│   ├── public/                                          # Archivos públicos estáticos
│   │   ├── favicon.ico                                  # Ícono del sitio web
│   │   └── robots.txt                                   # Configuración para bots de búsqueda
│   ├── src/                                             # Código fuente del frontend
│   │   ├── assets/                                      # Recursos estáticos (CSS, imágenes, JS utilitarios)
│   │   │   ├── css/                                     # Hojas de estilo CSS
│   │   │   │   ├── components/                          # CSS para componentes reutilizables
│   │   │   │   │   ├── botonanimado.css                 # Estilos de botón animado
│   │   │   │   │   ├── hamburgermenu.css                # Estilos menú hamburguesa
│   │   │   │   │   ├── menu-hambur-dash.css             # Estilos menú dashboard
│   │   │   │   ├── styles.css                           # Estilos globales
│   │   │   │   ├── tailwind.css                         # Tailwind generado
│   │   │   ├── img/                                     # Imágenes y logos
│   │   │   │   ├── logos/                               # Logos del club/escuela
│   │   │   │   │   ├── logo1.svg                        # Logo principal 1
│   │   │   │   │   ├── logo2.svg                        # Logo principal 2
│   │   │   │   ├── perfiles/                            # Avatares/perfiles de usuario
│   │   │   │   │   ├── perfil1.jpg                      # Imagen de perfil ejemplo
│   │   │   ├── js/                                      # Scripts JS del frontend
│   │   │   │   ├── api/                                 # Lógica de conexión a la API
│   │   │   │   │   ├── api.js                           # Funciones para consumir la API
│   │   │   │   ├── auth/                                # Scripts de autenticación y recuperación
│   │   │   │   │   ├── forgot-password.js               # Recuperar contraseña
│   │   │   │   │   ├── login.js                         # Login de usuario
│   │   │   │   │   ├── modal-verificacion.js            # Modal de verificación de código
│   │   │   │   │   ├── register.js                      # Registro de usuario
│   │   │   │   │   ├── reset-password.js                # Restablecer contraseña
│   │   │   │   │   ├── verify-code.js                   # Verificar código enviado por email
│   │   │   │   ├── components/                          # Componentes JS reutilizables (UI)
│   │   │   │   │   ├── drop-down.js                     # Menú desplegable
│   │   │   │   │   ├── menu.js                          # Menú principal
│   │   │   │   │   ├── password-visible.js              # Mostrar/ocultar contraseña
│   │   │   │   │   ├── pay-button.js                    # Botón de pago
│   │   │   │   │   ├── phone-input.js                   # Input de teléfono
│   │   │   │   │   ├── submenu.js                       # Submenús
│   │   │   │   │   ├── theme-toggle.js                  # Cambiar tema claro/oscuro
│   │   │   │   │   ├── whatsapp-button.js               # Botón de WhatsApp
│   │   │   │   │   ├── birthdate-datepicker.js          # Selector de fecha de nacimiento
│   │   │   │   │   ├── theme-system.js                  # Tema según sistema operativo
│   │   │   │   ├── jquery/                              # Librería jQuery
│   │   │   │   │   ├── jquery-3.7.1.min.js              # jQuery minificado
│   │   │   │   ├── pages/                               # Lógica JS por página/módulo
│   │   │   │   │   ├── alineaciones.js                  # Página de alineaciones
│   │   │   │   │   ├── asistencia.js                    # Página de asistencia
│   │   │   │   │   ├── auditoria.js                     # Página de auditoría
│   │   │   │   │   ├── categorias.js                    # Página de categorías
│   │   │   │   │   ├── entrenadores.js                  # Página de entrenadores
│   │   │   │   │   ├── entrenamientos.js                # Página de entrenamientos
│   │   │   │   │   ├── estadisticas.js                  # Página de estadísticas
│   │   │   │   │   ├── eventos.js                       # Página de eventos
│   │   │   │   │   ├── historialpagos.js                # Página de historial de pagos
│   │   │   │   │   ├── indumentaria.js                  # Página de indumentaria
│   │   │   │   │   ├── inscripciones.js                 # Página de inscripciones
│   │   │   │   │   ├── inventario.js                    # Página de inventario
│   │   │   │   │   ├── jugadores.js                     # Página de jugadores
│   │   │   │   │   ├── noticias.js                      # Página de noticias
│   │   │   │   │   ├── notificaciones.js                # Página de notificaciones
│   │   │   │   │   ├── pagos.js                         # Página de pagos
│   │   │   │   │   ├── partidos.js                      # Página de partidos
│   │   │   │   │   ├── pedidos.js                       # Página de pedidos
│   │   │   │   │   ├── permisos.js                      # Página de permisos
│   │   │   │   │   ├── posiciones.js                    # Página de posiciones
│   │   │   │   │   ├── productos.js                     # Página de productos
│   │   │   │   │   ├── roles.js                         # Página de roles
│   │   │   │   │   ├── rolespermisos.js                 # Página de roles y permisos
│   │   │   │   │   ├── servicios.js                     # Página de servicios
│   │   │   │   │   ├── tiposdocumento.js                # Página de tipos de documento
│   │   │   │   │   ├── transacciones.js                 # Página de transacciones
│   │   │   │   │   ├── tutores.js                       # Página de tutores
│   │   │   │   │   ├── usuarios.js                      # Página de usuarios
│   │   │   │   ├── utils/                               # Utilidades y helpers JS
│   │   │   │   │   ├── dateformat.js                    # Formateo de fechas
│   │   │   │   │   ├── helpers.js                       # Funciones auxiliares
│   │   │   │   │   ├── validators.js                    # Validaciones JS
│   │   │   ├── config.js                                # Configuración global JS
│   │   ├── views/                                       # Vistas HTML por módulo/página
│   │   │   ├── alineaciones/                            # Vistas de alineaciones
│   │   │   │   ├── alineaciones.html                    # HTML alineaciones
│   │   │   ├── asistencia/                              # Vistas de asistencia
│   │   │   │   ├── asistencia.html                      # HTML asistencia
│   │   │   ├── auditoria/                               # Vistas de auditoría
│   │   │   │   ├── auditoria.html                       # HTML auditoría
│   │   │   ├── auth/                                    # Vistas de autenticación
│   │   │   │   ├── forgotpassword.html                  # Recuperar contraseña
│   │   │   │   ├── login.html                           # Login
│   │   │   │   ├── register.html                        # Registro
│   │   │   │   ├── resetpassword.html                   # Restablecer contraseña
│   │   │   │   ├── verify-code.html                     # Verificar código
│   │   │   ├── categorias/                              # Vistas de categorías
│   │   │   │   ├── categorias.html                      # HTML categorías
│   │   │   ├── dashboard/                               # Vistas del dashboard
│   │   │   │   ├── dashboard.html                       # HTML dashboard
│   │   │   ├── entrenadores/                            # Vistas de entrenadores
│   │   │   │   ├── entrenadores.html                    # HTML entrenadores
│   │   │   ├── entrenamientos/                          # Vistas de entrenamientos
│   │   │   │   ├── entrenamientos.html                  # HTML entrenamientos
│   │   │   ├── estadisticas/                            # Vistas de estadísticas
│   │   │   │   ├── estadisticas.html                    # HTML estadísticas
│   │   │   ├── eventos/                                 # Vistas de eventos
│   │   │   │   ├── eventos.html                         # HTML eventos
│   │   │   ├── historialpagos/                          # Vistas de historial de pagos
│   │   │   │   ├── historialpagos.html                  # HTML historial pagos
│   │   │   ├── indumentaria/                            # Vistas de indumentaria
│   │   │   │   ├── indumentaria.html                    # HTML indumentaria
│   │   │   ├── info/                                    # Información institucional
│   │   │   │   ├── about.html                           # Sobre la escuela/club
│   │   │   │   ├── contact.html                         # Contacto
│   │   │   ├── inscripciones/                           # Vistas de inscripciones
│   │   │   │   ├── inscripciones.html                   # HTML inscripciones
│   │   │   ├── inventario/                              # Vistas de inventario
│   │   │   │   ├── inventario.html                      # HTML inventario
│   │   │   ├── jugadores/                               # Vistas de jugadores
│   │   │   │   ├── jugadores.html                       # HTML jugadores
│   │   │   ├── modals/                                  # Modales HTML reutilizables
│   │   │   │   ├── modal-categoria-no-disponible.html   # Modal categoría no disponible
│   │   │   │   ├── modal-confirmar-eliminacion.html     # Modal confirmar eliminación
│   │   │   │   ├── modal-error-login.html               # Modal error login
│   │   │   │   ├── modal-error-registro.html            # Modal error registro
│   │   │   │   ├── modal-exito-login.html               # Modal éxito login
│   │   │   │   ├── modal-exito-registro.html            # Modal éxito registro
│   │   │   │   ├── modal-info-bienvenida.html           # Modal bienvenida
│   │   │   │   ├── modal-verificacion-codigo.html       # Modal verificación código
│   │   │   ├── noticias/                                # Vistas de noticias
│   │   │   │   ├── noticias.html                        # HTML noticias
│   │   │   ├── notificaciones/                          # Vistas de notificaciones
│   │   │   │   ├── notificaciones.html                  # HTML notificaciones
│   │   │   ├── pagos/                                   # Vistas de pagos
│   │   │   │   ├── pagos.html                           # HTML pagos
│   │   │   │   ├── payment.html                         # HTML pago individual
│   │   │   ├── partidos/                                # Vistas de partidos
│   │   │   │   ├── partidos.html                        # HTML partidos
│   │   │   ├── pedidos/                                 # Vistas de pedidos
│   │   │   │   ├── pedidos.html                         # HTML pedidos
│   │   │   ├── permisos/                                # Vistas de permisos
│   │   │   │   ├── permisos.html                        # HTML permisos
│   │   │   ├── posiciones/                              # Vistas de posiciones
│   │   │   │   ├── posiciones.html                      # HTML posiciones
│   │   │   ├── productos/                               # Vistas de productos
│   │   │   │   ├── productos.html                       # HTML productos
│   │   │   ├── roles/                                   # Vistas de roles
│   │   │   │   ├── roles.html                           # HTML roles
│   │   │   ├── rolespermisos/                           # Vistas de roles y permisos
│   │   │   │   ├── rolespermisos.html                   # HTML roles y permisos
│   │   │   ├── servicios/                               # Vistas de servicios
│   │   │   │   ├── servicios.html                       # HTML servicios
│   │   │   ├── tiposdocumento/                          # Vistas de tipos de documento
│   │   │   │   ├── tiposdocumento.html                  # HTML tipos documento
│   │   │   ├── transacciones/                           # Vistas de transacciones
│   │   │   │   ├── transacciones.html                   # HTML transacciones
│   │   │   ├── tutores/                                 # Vistas de tutores
│   │   │   │   ├── tutores.html                         # HTML tutores
│   │   │   ├── usuarios/                                # Vistas de usuarios
│   │   │   │   ├── usuarios.html                        # HTML usuarios
│   ├── index.html                                       # Entrada principal del frontend
│   ├── package-lock.json                                # Lockfile npm
│   ├── package.json                                     # Dependencias y scripts npm
│   ├── tailwind.config.js                               # Configuración Tailwind CSS
├── database/                                            # Scripts y archivos de base de datos
│   ├── base de datos.txt                                # Instrucciones o backup de la BD
│   ├── nki.sql                                          # Script SQL para crear la BD
├── server/                                              # Backend PHP (API RESTful)
├── node_modules/                                        # Dependencias npm del backend
│   ├── public/                                          # DocumentRoot para Apache
│   │   ├── .htaccess                                    # Reglas de Apache (URLs amigables)
│   │   ├── index.php                                    # Front controller PHP
│   ├── src/                                             # Código fuente backend
│   │   ├── config/                                      # Configuración (DB, etc)
│   │   │   ├── connection.php                           # Conexión a la base de datos
│   │   ├── controllers/                                 # Controladores por entidad/módulo
│   │   │   ├── auth/                                    # Controladores de autenticación
│   │   │   │   ├── ForgotPasswordController.php         # Recuperar contraseña
│   │   │   │   ├── LoginController.php                  # Login
│   │   │   │   ├── PasswordResetsController.php         # Restablecer contraseña
│   │   │   │   ├── RegisterController.php               # Registro
│   │   │   ├── AlineacionesController.php               # Controlador alineaciones
│   │   │   ├── AsistenciaController.php                 # Controlador asistencia
│   │   │   ├── AuditoriaController.php                  # Controlador auditoría
│   │   │   ├── CategoriasController.php                 # Controlador categorías
│   │   │   ├── EntrenadoresController.php               # Controlador entrenadores
│   │   │   ├── EntrenamientosController.php             # Controlador entrenamientos
│   │   │   ├── EstadisticasController.php               # Controlador estadísticas
│   │   │   ├── EventosController.php                    # Controlador eventos
│   │   │   ├── GenerosController.php                    # Controlador géneros
│   │   │   ├── HistorialPagosController.php             # Controlador historial pagos
│   │   │   ├── IndumentariaController.php               # Controlador indumentaria
│   │   │   ├── InventarioController.php                 # Controlador inventario
│   │   │   ├── InscripcionesController.php              # Controlador inscripciones
│   │   │   ├── JugadoresController.php                  # Controlador jugadores
│   │   │   ├── NoticiasController.php                   # Controlador noticias
│   │   │   ├── NotificacionesController.php             # Controlador notificaciones
│   │   │   ├── PagosController.php                      # Controlador pagos
│   │   │   ├── PartidosController.php                   # Controlador partidos
│   │   │   ├── PedidosController.php                    # Controlador pedidos
│   │   │   ├── PermisosController.php                   # Controlador permisos
│   │   │   ├── PosicionesController.php                 # Controlador posiciones
│   │   │   ├── ProductosController.php                  # Controlador productos
│   │   │   ├── RolesController.php                      # Controlador roles
│   │   │   ├── RolesPermisosController.php              # Controlador roles y permisos
│   │   │   ├── SeguidoresController.php                 # Controlador seguidores
│   │   │   ├── ServiciosController.php                  # Controlador servicios
│   │   │   ├── TiposDocumentoController.php             # Controlador tipos documento
│   │   │   ├── TransaccionesController.php              # Controlador transacciones
│   │   │   ├── TutoresController.php                    # Controlador tutores
│   │   │   ├── UsuariosController.php                   # Controlador usuarios
│   │   ├── middleware/                                  # Middlewares de seguridad y control de acceso
│   │   │   ├── CsrfMiddleware.php                       # Protección CSRF
│   │   │   ├── GuestMiddleware.php                      # Acceso solo para invitados
│   │   │   ├── LoginMiddleware.php                      # Requiere login
│   │   │   ├── PermissionMiddleware.php                 # Control de permisos
│   │   │   ├── RegisterMiddleware.php                   # Middleware de registro
│   │   │   ├── RoleMiddleware.php                       # Control de roles
│   │   │   ├── ThrottleMiddleware.php                   # Limitador de peticiones
│   │   ├── models/                                      # Modelos de datos (ORM)
│   │   │   ├── Alineacion.php                           # Modelo alineación
│   │   │   ├── Asistencia.php                           # Modelo asistencia
│   │   │   ├── Auditoria.php                            # Modelo auditoría
│   │   │   ├── Categoria.php                            # Modelo categoría
│   │   │   ├── Entrenador.php                           # Modelo entrenador
│   │   │   ├── Entrenamiento.php                        # Modelo entrenamiento
│   │   │   ├── Estadistica.php                          # Modelo estadística
│   │   │   ├── Evento.php                               # Modelo evento
│   │   │   ├── HistorialPago.php                        # Modelo historial pago
│   │   │   ├── Indumentaria.php                         # Modelo indumentaria
│   │   │   ├── Inscripcion.php                          # Modelo inscripción
│   │   │   ├── Inventario.php                           # Modelo inventario
│   │   │   ├── Jugador.php                              # Modelo jugador
│   │   │   ├── Noticia.php                              # Modelo noticia
│   │   │   ├── Notificacion.php                         # Modelo notificación
│   │   │   ├── Pago.php                                 # Modelo pago
│   │   │   ├── Partido.php                              # Modelo partido
│   │   │   ├── Pedido.php                               # Modelo pedido
│   │   │   ├── Permiso.php                              # Modelo permiso
│   │   │   ├── Posicion.php                             # Modelo posición
│   │   │   ├── Producto.php                             # Modelo producto
│   │   │   ├── Rol.php                                  # Modelo rol
│   │   │   ├── RolPermiso.php                           # Modelo rol-permiso
│   │   │   ├── Seguidor.php                             # Modelo seguidor
│   │   │   ├── Servicio.php                             # Modelo servicio
│   │   │   ├── TipoDocumento.php                        # Modelo tipo documento
│   │   │   ├── Transaccion.php                          # Modelo transacción
│   │   │   ├── Tutor.php                                # Modelo tutor
│   │   │   ├── Usuario.php                              # Modelo usuario
│   │   ├── routes/                                      # Definición de rutas de la API
│   │   │   ├── api.php                                  # Rutas de la API REST
│   │   ├── utils/                                       # Utilidades backend (helpers, validadores, email)
│   │   │   ├── DateHelper.php                           # Helper de fechas
│   │   │   ├── Helpers.php                              # Funciones auxiliares
│   │   │   ├── EmailHelper.php                          # Envío de emails
│   │   │   ├── Validator.php                            # Validaciones backend
│   │   ├── validations/                                 # Validaciones por entidad/módulo
│   │   │   ├── auth/                                    # Validaciones de autenticación
│   │   │   │   ├── ForgotPasswordValidation.php         # Validar recuperar contraseña
│   │   │   │   ├── LoginValidation.php                  # Validar login
│   │   │   │   ├── PasswordResetsValidation.php         # Validar restablecer contraseña
│   │   │   │   ├── RegisterValidation.php               # Validar registro
│   │   │   ├── AlineacionesValidation.php               # Validar alineaciones
│   │   │   ├── AsistenciaValidation.php                 # Validar asistencia
│   │   │   ├── AuditoriaValidation.php                  # Validar auditoría
│   │   │   ├── CategoriasValidation.php                 # Validar categorías
│   │   │   ├── EntrenadoresValidation.php               # Validar entrenadores
│   │   │   ├── EntrenamientosValidation.php             # Validar entrenamientos
│   │   │   ├── EstadisticasValidation.php               # Validar estadísticas
│   │   │   ├── EventosValidation.php                    # Validar eventos
│   │   │   ├── HistorialPagosValidation.php             # Validar historial pagos
│   │   │   ├── IndumentariaValidation.php               # Validar indumentaria
│   │   │   ├── InventarioValidation.php                 # Validar inventario
│   │   │   ├── InscripcionesValidation.php              # Validar inscripciones
│   │   │   ├── JugadoresValidation.php                  # Validar jugadores
│   │   │   ├── NoticiasValidation.php                   # Validar noticias
│   │   │   ├── NotificacionesValidation.php             # Validar notificaciones
│   │   │   ├── PagosValidation.php                      # Validar pagos
│   │   │   ├── PartidosValidation.php                   # Validar partidos
│   │   │   ├── PedidosValidation.php                    # Validar pedidos
│   │   │   ├── PermisosValidation.php                   # Validar permisos
│   │   │   ├── PosicionesValidation.php                 # Validar posiciones
│   │   │   ├── ProductosValidation.php                  # Validar productos
│   │   │   ├── RolesPermisosValidation.php              # Validar roles y permisos
│   │   │   ├── RolesValidation.php                      # Validar roles
│   │   │   ├── ServiciosValidation.php                  # Validar servicios
│   │   │   ├── TiposDocumentoValidation.php             # Validar tipos documento
│   │   │   ├── TransaccionesValidation.php              # Validar transacciones
│   │   │   ├── TutoresValidation.php                    # Validar tutores
│   │   │   ├── UsuariosValidation.php                   # Validar usuarios
│   ├── vendor/                                          # Dependencias PHP (Composer)
│   │   ├── bramus/                                      # Librería Bramus Router (ruteo PHP)
│   │   ├── composer/                                    # Archivos internos de Composer
│   │   ├── graham-campbell/                             # Utilidades Graham Campbell
│   │   ├── phpmailer/                                   # Librería PHPMailer (envío de emails)
│   │   ├── phpoption/                                   # Utilidades PHPOption
│   │   ├── symfony/                                     # Componentes Symfony (dependencias)
│   │   ├── twilio/                                      # SDK Twilio (envío SMS)
│   │   ├── vlucas/                                      # Librería PHP dotenv (variables entorno)
│   │   ├── autoload.php                                 # Autoloader generado por Composer
│   ├── composer.json                                    # Configuración Composer (PHP)
│   ├── .env                                             # Variables de entorno del backend (configuración sensible, credenciales, etc)
│   ├── composer.lock                                    # Lockfile Composer
│   ├── package-lock.json                                # Lockfile npm raíz (asegura versiones exactas de dependencias JS)
│   ├── package.json                                     # Configuración y dependencias npm raíz del proyecto
├── README.md                                            # Documentación principal del proyecto
```

---

## 🔧 Instalación del Proyecto

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/tuusuario/nki.git
   cd nki
   ```

2. **Instala dependencias frontend**
   ```bash
   cd client
   npm install
   ```

3. **Configura la base de datos**
   - Crea la BD en MySQL
   - Importa `database/base de datos.txt` o `database/nki.sql`
   - Edita las credenciales en `server/src/config/connection.php`

4. **Levanta el servidor**
   - Asegúrate de tener Apache/MySQL activos
   - Coloca el proyecto en htdocs o usa virtual host

5. **Abre en el navegador:**
   ```
   http://localhost/nki/client/src/index.html
   ```

---

## 📱 Compilación APK con Cordova

1. Instala Apache Cordova
   ```bash
   npm install -g cordova
   ```
2. Agrega plataforma Android
   ```bash
   cordova platform add android
   ```
3. Compila el APK
   ```bash
   cordova build android
   ```

---

## ✅ Funcionalidades Clave

- Autenticación JWT (login y registro separados)
- Gestión de usuarios (jugadores, tutores, entrenadores, roles, permisos)
- Módulo de pagos y transacciones
- Dashboard administrativo
- Middleware para control de acceso por roles/permisos
- Auditoría y bitácora de acciones
- UI responsiva y mobile-first
- Versión APK con Cordova

---

## 📌 Recomendaciones

- Modulariza JS y PHP en componentes y controladores por entidad
- Valida tanto en frontend como backend
- Usa fetch/Axios con try/catch
- Documenta endpoints y funciones clave
- Mantén el código limpio y ordenado
- Usa la estructura de carpetas para mantener la escalabilidad

---

## 👤 Autor

Jonathan Artistizabal  
Tecnólogo en Análisis y Desarrollo de Software  
GitHub: https://github.com/tuusuario

---
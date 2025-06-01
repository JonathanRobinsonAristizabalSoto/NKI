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


## 📁 Estructura del Proyecto (Alfabética y Modular)

```
NKI/
├── client/
│   ├── node_modules/
│   ├── public/
│   │   ├── favicon.ico
│   │   └── robots.txt
│   ├── src/
│   │   ├── assets/
│   │   │   ├── css/
│   │   │   │   ├── components/
│   │   │   │   │   ├── botonanimado.css
│   │   │   │   │   ├── hamburgermenu.css
│   │   │   │   │   ├── menu-hambur-dash.css
│   │   │   │   ├── styles.css
│   │   │   │   ├── tailwind.css
│   │   │   ├── img/
│   │   │   │   ├── logos/
│   │   │   │   │   ├── logo1.svg
│   │   │   │   │   ├── logo2.svg
│   │   │   │   ├── perfiles/
│   │   │   │   │   ├── perfil1.jpg
│   │   │   ├── js/
│   │   │   │   ├── api/
│   │   │   │   │   ├── api.js
│   │   │   │   ├── auth/
│   │   │   │   │   ├── forgot-password.js
│   │   │   │   │   ├── login.js
│   │   │   │   │   ├── register.js
│   │   │   │   │   ├── reset-password.js
│   │   │   │   │   ├── verify-code.js
│   │   │   │   ├── components/
│   │   │   │   │   ├── drop-down.js
│   │   │   │   │   ├── menu.js
│   │   │   │   │   ├── password-visible.js
│   │   │   │   │   ├── pay-button.js
│   │   │   │   │   ├── phone-input.js
│   │   │   │   │   ├── submenu.js
│   │   │   │   │   ├── theme-toggle.js
│   │   │   │   │   ├── whatsapp-button.js
│   │   │   │   ├── jquery/
│   │   │   │   │   ├── jquery-3.7.1.min.js
│   │   │   │   ├── pages/
│   │   │   │   │   ├── alineaciones.js
│   │   │   │   │   ├── asistencia.js
│   │   │   │   │   ├── auditoria.js
│   │   │   │   │   ├── categorias.js
│   │   │   │   │   ├── entrenadores.js
│   │   │   │   │   ├── entrenamientos.js
│   │   │   │   │   ├── estadisticas.js
│   │   │   │   │   ├── eventos.js
│   │   │   │   │   ├── historialpagos.js
│   │   │   │   │   ├── indumentaria.js
│   │   │   │   │   ├── inscripciones.js
│   │   │   │   │   ├── inventario.js
│   │   │   │   │   ├── jugadores.js
│   │   │   │   │   ├── noticias.js
│   │   │   │   │   ├── notificaciones.js
│   │   │   │   │   ├── pagos.js
│   │   │   │   │   ├── partidos.js
│   │   │   │   │   ├── pedidos.js
│   │   │   │   │   ├── permisos.js
│   │   │   │   │   ├── posiciones.js
│   │   │   │   │   ├── productos.js
│   │   │   │   │   ├── roles.js
│   │   │   │   │   ├── rolespermisos.js
│   │   │   │   │   ├── servicios.js
│   │   │   │   │   ├── tiposdocumento.js
│   │   │   │   │   ├── transacciones.js
│   │   │   │   │   ├── tutores.js
│   │   │   │   │   ├── usuarios.js
│   │   │   │   ├── tests/
│   │   │   │   │   ├── usuarios.test.js
│   │   │   │   │   ├── pagos.test.js
│   │   │   │   │   ├── inscripciones.test.js
│   │   │   │   ├── utils/
│   │   │   │   │   ├── dateformat.js
│   │   │   │   │   ├── helpers.js
│   │   │   │   │   ├── validators.js
│   │   │   ├── config.js
│   │   │   ├── .env.example
│   │   ├── views/
│   │   │   ├── alineaciones/
│   │   │   │   ├── alineaciones.html
│   │   │   ├── asistencia/
│   │   │   │   ├── asistencia.html
│   │   │   ├── auditoria/
│   │   │   │   ├── auditoria.html
│   │   │   ├── auth/
│   │   │   │   ├── forgotpassword.html
│   │   │   │   ├── login.html
│   │   │   │   ├── register.html
│   │   │   │   ├── resetpassword.html
│   │   │   │   ├── verify-code.html
│   │   │   ├── categorias/
│   │   │   │   ├── categorias.html
│   │   │   ├── dashboard/
│   │   │   │   ├── dashboard.html
│   │   │   ├── entrenadores/
│   │   │   │   ├── entrenadores.html
│   │   │   ├── entrenamientos/
│   │   │   │   ├── entrenamientos.html
│   │   │   ├── estadisticas/
│   │   │   │   ├── estadisticas.html
│   │   │   ├── eventos/
│   │   │   │   ├── eventos.html
│   │   │   ├── historialpagos/
│   │   │   │   ├── historialpagos.html
│   │   │   ├── indumentaria/
│   │   │   │   ├── indumentaria.html
│   │   │   ├── info/
│   │   │   │   ├── about.html
│   │   │   │   ├── contact.html
│   │   │   ├── inscripciones/
│   │   │   │   ├── inscripciones.html
│   │   │   ├── inventario/
│   │   │   │   ├── inventario.html
│   │   │   ├── jugadores/
│   │   │   │   ├── jugadores.html
│   │   │   ├── noticias/
│   │   │   │   ├── noticias.html
│   │   │   ├── notificaciones/
│   │   │   │   ├── notificaciones.html
│   │   │   ├── pagos/
│   │   │   │   ├── pagos.html
│   │   │   │   ├── payment.html
│   │   │   ├── partidos/
│   │   │   │   ├── partidos.html
│   │   │   ├── pedidos/
│   │   │   │   ├── pedidos.html
│   │   │   ├── permisos/
│   │   │   │   ├── permisos.html
│   │   │   ├── posiciones/
│   │   │   │   ├── posiciones.html
│   │   │   ├── productos/
│   │   │   │   ├── productos.html
│   │   │   ├── roles/
│   │   │   │   ├── roles.html
│   │   │   ├── rolespermisos/
│   │   │   │   ├── rolespermisos.html
│   │   │   ├── servicios/
│   │   │   │   ├── servicios.html
│   │   │   ├── tiposdocumento/
│   │   │   │   ├── tiposdocumento.html
│   │   │   ├── transacciones/
│   │   │   │   ├── transacciones.html
│   │   │   ├── tutores/
│   │   │   │   ├── tutores.html
│   │   │   ├── usuarios/
│   │   │   │   ├── usuarios.html
│   ├── index.html
│   ├── package-lock.json
│   ├── package.json
│   ├── tailwind.config.js
├── database/
│   ├── base de datos.txt
│   ├── migrations/
│   │   ├── 20250530_create_usuarios.sql
│   ├── nki.sql
├── docs/
│   ├── api.md
│   ├── postman_collection.json
│   ├── swagger/
│   │   ├── openapi.yaml
├── server/
│   ├── logs/
│   │   ├── error.log
│   │   ├── system.log
│   ├── public/
│   │   ├── index.php
│   │   ├── .htaccess
│   ├── src/
│   │   ├── config/
│   │   │   ├── connection.php
│   │   ├── controllers/
│   │   │   ├── auth/
│   │   │   │   ├── ForgotPasswordController.php
│   │   │   │   ├── LoginController.php
│   │   │   │   ├── PasswordResetsController.php
│   │   │   │   ├── RegisterController.php
│   │   │   ├── AlineacionesController.php
│   │   │   ├── AsistenciaController.php
│   │   │   ├── AuditoriaController.php
│   │   │   ├── CategoriasController.php
│   │   │   ├── EntrenadoresController.php
│   │   │   ├── EntrenamientosController.php
│   │   │   ├── EstadisticasController.php
│   │   │   ├── EventosController.php
│   │   │   ├── GenerosController.php
│   │   │   ├── HistorialPagosController.php
│   │   │   ├── IndumentariaController.php
│   │   │   ├── InventarioController.php
│   │   │   ├── InscripcionesController.php
│   │   │   ├── JugadoresController.php
│   │   │   ├── NoticiasController.php
│   │   │   ├── NotificacionesController.php
│   │   │   ├── PagosController.php
│   │   │   ├── PartidosController.php
│   │   │   ├── PedidosController.php
│   │   │   ├── PermisosController.php
│   │   │   ├── PosicionesController.php
│   │   │   ├── ProductosController.php
│   │   │   ├── RolesController.php
│   │   │   ├── RolesPermisosController.php
│   │   │   ├── ServiciosController.php
│   │   │   ├── TiposDocumentoController.php
│   │   │   ├── TransaccionesController.php
│   │   │   ├── TutoresController.php
│   │   │   ├── UsuariosController.php
│   │   ├── error/
│   │   │   ├── errorhandler.php
│   │   ├── middleware/
│   │   │   ├── CsrfMiddleware.php
│   │   │   ├── GuestMiddleware.php
│   │   │   ├── LoginMiddleware.php
│   │   │   ├── PermissionMiddleware.php
│   │   │   ├── RegisterMiddleware.php
│   │   │   ├── RoleMiddleware.php
│   │   │   ├── ThrottleMiddleware.php
│   │   ├── models/
│   │   │   ├── Alineacion.php
│   │   │   ├── Asistencia.php
│   │   │   ├── Auditoria.php
│   │   │   ├── Categoria.php
│   │   │   ├── Entrenador.php
│   │   │   ├── Entrenamiento.php
│   │   │   ├── Estadistica.php
│   │   │   ├── Evento.php
│   │   │   ├── HistorialPago.php
│   │   │   ├── Indumentaria.php
│   │   │   ├── Inventario.php
│   │   │   ├── Inscripcion.php
│   │   │   ├── Jugador.php
│   │   │   ├── Noticia.php
│   │   │   ├── Notificacion.php
│   │   │   ├── Pago.php
│   │   │   ├── Partido.php
│   │   │   ├── Pedido.php
│   │   │   ├── Permiso.php
│   │   │   ├── Posicion.php
│   │   │   ├── Producto.php
│   │   │   ├── Rol.php
│   │   │   ├── RolPermiso.php
│   │   │   ├── Servicio.php
│   │   │   ├── TipoDocumento.php
│   │   │   ├── Transaccion.php
│   │   │   ├── Tutor.php
│   │   │   ├── Usuario.php
│   │   ├── routes/
│   │   │   ├── api.php
│   │   ├── tests/
│   │   │   ├── controllers/
│   │   │   │   ├── UsuariosControllerTest.php
│   │   │   │   ├── PagosControllerTest.php
│   │   │   │   ├── InscripcionesControllerTest.php
│   │   │   ├── models/
│   │   │   │   ├── UsuariosModelTest.php
│   │   │   │   ├── PagosModelTest.php
│   │   │   │   ├── InscripcionesModelTest.php
│   │   ├── utils/
│   │   │   ├── DateHelper.php
│   │   │   ├── Helpers.php
│   │   │   ├── EmailHelper.php
│   │   │   ├── Validator.php

│   │   ├── validations/
│   │   │   ├── auth/
│   │   │   │   ├── ForgotPasswordValidation.php
│   │   │   │   ├── LoginValidation.php
│   │   │   │   ├── PasswordResetsValidation.php
│   │   │   │   ├── RegisterValidation.php
│   │   │   ├── AlineacionesValidation.php
│   │   │   ├── AsistenciaValidation.php
│   │   │   ├── AuditoriaValidation.php
│   │   │   ├── CategoriasValidation.php
│   │   │   ├── EntrenadoresValidation.php
│   │   │   ├── EntrenamientosValidation.php
│   │   │   ├── EstadisticasValidation.php
│   │   │   ├── EventosValidation.php
│   │   │   ├── HistorialPagosValidation.php
│   │   │   ├── IndumentariaValidation.php
│   │   │   ├── InventarioValidation.php
│   │   │   ├── InscripcionesValidation.php
│   │   │   ├── JugadoresValidation.php
│   │   │   ├── NoticiasValidation.php
│   │   │   ├── NotificacionesValidation.php
│   │   │   ├── PagosValidation.php
│   │   │   ├── PartidosValidation.php
│   │   │   ├── PedidosValidation.php
│   │   │   ├── PermisosValidation.php
│   │   │   ├── PosicionesValidation.php
│   │   │   ├── ProductosValidation.php
│   │   │   ├── RolesPermisosValidation.php
│   │   │   ├── RolesValidation.php
│   │   │   ├── ServiciosValidation.php
│   │   │   ├── TiposDocumentoValidation.php
│   │   │   ├── TransaccionesValidation.php
│   │   │   ├── TutoresValidation.php
│   │   │   ├── UsuariosValidation.php
│   ├── .env
├── vendor/
├── composer.json
├── composer.lock
├── README.md
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
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
│   │   │   │   │   ├── menu_hambur_dash.css
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
│   │   │   │   │   ├── forgotpassword.js
│   │   │   │   │   ├── login.js
│   │   │   │   │   ├── register.js
│   │   │   │   │   ├── resetpassword.js
│   │   │   │   ├── components/
│   │   │   │   │   ├── dropdown.js
│   │   │   │   │   ├── menu.js
│   │   │   │   │   ├── passwordvisible.js
│   │   │   │   │   ├── paybutton.js
│   │   │   │   │   ├── phoneinput.js
│   │   │   │   │   ├── submenu.js
│   │   │   │   │   ├── themetoggle.js
│   │   │   │   │   ├── whatsappbutton.js
│   │   │   │   ├── jquery/
│   │   │   │   │   ├── jquery-3.7.1.min.js
│   │   │   │   ├── middleware/
│   │   │   │   │   ├── errorhandler.js
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
│   │   │   │   │   ├── inventario.js
│   │   │   │   │   ├── jugadores.js
│   │   │   │   │   ├── noticias.js
│   │   │   │   │   ├── notificaciones.js
│   │   │   │   │   ├── pagos.js
│   │   │   │   │   ├── partidos.js
│   │   │   │   │   ├── passwordresets.js
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
│   │   │   │   │   ├── pages/
│   │   │   │   │   │   ├── usuarios.test.js
│   │   │   │   │   │   ├── pagos.test.js
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
│   │   │   ├── partidos/
│   │   │   │   ├── partidos.html
│   │   │   ├── passwordresets/
│   │   │   │   ├── passwordresets.html
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
│   │   ├── index.html
│   ├── package-lock.json
│   ├── package.json
│   ├── tailwind.config.js
├── database/
│   ├── base de datos.txt
│   ├── migrations/
│   │   ├── 20250530_create_tables.sql
│   ├── nki.sql
├── docs/
│   ├── api.md
│   ├── postman_collection.json
│   ├── swagger/
│   │   ├── openapi.yaml
├── server/
│   ├── .env.example
│   ├── logs/
│   │   ├── error.log
│   │   ├── system.log
│   ├── public/
│   │   ├── index.php
│   ├── src/
│   │   ├── config/
│   │   │   ├── connection.php
│   │   ├── controllers/
│   │   │   ├── alineacionescontroller.php
│   │   │   ├── asistenciacontroller.php
│   │   │   ├── auditoriacontroller.php
│   │   │   ├── categoriascontroller.php
│   │   │   ├── entrenadorescontroller.php
│   │   │   ├── entrenamientoscontroller.php
│   │   │   ├── estadisticascontroller.php
│   │   │   ├── eventoscontroller.php
│   │   │   ├── historialpagoscontroller.php
│   │   │   ├── indumentariacontroller.php
│   │   │   ├── inventariocontroller.php
│   │   │   ├── jugadorescontroller.php
│   │   │   ├── noticiascontroller.php
│   │   │   ├── notificacionescontroller.php
│   │   │   ├── pagoscontroller.php
│   │   │   ├── partidoscontroller.php
│   │   │   ├── pedidoscontroller.php
│   │   │   ├── permisoscontroller.php
│   │   │   ├── posicionescontroller.php
│   │   │   ├── productoscontroller.php
│   │   │   ├── rolescontroller.php
│   │   │   ├── rolespermisoscontroller.php
│   │   │   ├── servicioscontroller.php
│   │   │   ├── tiposdocumentocontroller.php
│   │   │   ├── transaccionescontroller.php
│   │   │   ├── tutorescontroller.php
│   │   │   ├── usuarioscontroller.php
│   │   │   ├── auth/
│   │   │   │   ├── forgotpasswordcontroller.php
│   │   │   │   ├── logincontroller.php
│   │   │   │   ├── passwordresetscontroller.php
│   │   │   │   ├── registercontroller.php
│   │   ├── error/
│   │   │   ├── errorhandler.php
│   │   ├── middleware/
│   │   │   ├── authmiddleware.php
│   │   │   ├── rolemiddleware.php
│   │   ├── models/
│   │   │   ├── alineaciones.php
│   │   │   ├── asistencia.php
│   │   │   ├── auditoria.php
│   │   │   ├── categorias.php
│   │   │   ├── entrenadores.php
│   │   │   ├── entrenamientos.php
│   │   │   ├── estadisticas.php
│   │   │   ├── eventos.php
│   │   │   ├── historialpagos.php
│   │   │   ├── indumentaria.php
│   │   │   ├── inventario.php
│   │   │   ├── jugadores.php
│   │   │   ├── noticias.php
│   │   │   ├── notificaciones.php
│   │   │   ├── pagos.php
│   │   │   ├── partidos.php
│   │   │   ├── pedidos.php
│   │   │   ├── permisos.php
│   │   │   ├── posiciones.php
│   │   │   ├── productos.php
│   │   │   ├── roles.php
│   │   │   ├── rolespermisos.php
│   │   │   ├── servicios.php
│   │   │   ├── tiposdocumento.php
│   │   │   ├── transacciones.php
│   │   │   ├── tutores.php
│   │   │   ├── usuarios.php
│   │   ├── routes/
│   │   │   ├── api.php
│   │   ├── tests/
│   │   │   ├── controllers/
│   │   │   │   ├── usuarioscontrollertest.php
│   │   │   │   ├── pagoscontrollertest.php
│   │   │   ├── models/
│   │   │   │   ├── usuariosmodeltest.php
│   │   │   │   ├── pagosmodeltest.php
│   │   ├── utils/
│   │   │   ├── datehelper.php
│   │   │   ├── helpers.php
│   │   │   ├── validator.php
│   │   ├── validations/
│   │   │   ├── alineacionesvalidation.php
│   │   │   ├── asistenciavalidation.php
│   │   │   ├── auditoriavalidation.php
│   │   │   ├── categoriasvalidation.php
│   │   │   ├── entrenadoresvalidation.php
│   │   │   ├── entrenamientosvalidation.php
│   │   │   ├── estadisticasvalidation.php
│   │   │   ├── eventosvalidation.php
│   │   │   ├── historialpagosvalidation.php
│   │   │   ├── indumentariavalidation.php
│   │   │   ├── inventariovalidation.php
│   │   │   ├── jugadoresvalidation.php
│   │   │   ├── noticiasvalidation.php
│   │   │   ├── notificacionesvalidation.php
│   │   │   ├── pagosvalidation.php
│   │   │   ├── partidosvalidation.php
│   │   │   ├── pedidosvalidation.php
│   │   │   ├── permisosvalidation.php
│   │   │   ├── posicionesvalidation.php
│   │   │   ├── productosvalidation.php
│   │   │   ├── rolespermisosvalidation.php
│   │   │   ├── rolesvalidation.php
│   │   │   ├── serviciosvalidation.php
│   │   │   ├── tiposdocumentovalidation.php
│   │   │   ├── transaccionesvalidation.php
│   │   │   ├── tutoresvalidation.php
│   │   │   ├── usuariosvalidation.php
│   │   │   ├── auth/
│   │   │   │   ├── forgotpasswordvalidation.php
│   │   │   │   ├── loginvalidation.php
│   │   │   │   ├── passwordresetsvalidation.php
│   │   │   │   ├── registervalidation.php
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
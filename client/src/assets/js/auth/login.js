import { apiPost, API_BASE } from "../api/api.js";
import { mostrarModal, ocultarModal } from "./modals.js";

// Selecciona el formulario de login
const form = document.getElementById("login-form");

if (form) {
  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    // Obtiene los valores del formulario
    const user = document.getElementById("user").value.trim();
    const password = document.getElementById("password").value;

    // Validación básica
    if (!user || !password) {
      mostrarModal("modal-error-login");
      const msgDiv = document.getElementById("error-login-msg");
      if (msgDiv) msgDiv.textContent = "Por favor, ingresa tu correo o documento y la contraseña.";
      return;
    }

    // Construye el payload para la API (solo correo/documento y contraseña)
    const data = {
      user,
      password
    };

    try {
      // Realiza la petición a la API de login
      const res = await apiPost(`${API_BASE}/api/auth/login`, data);

      // Si el login es exitoso, muestra modal y redirige a dashboard
      if (res.message === "Login exitoso" || res.token) {
        mostrarModal("modal-exito-login");
        setTimeout(() => {
          window.location.href = "../dashboard/dashboard.html";
        }, 3000); // 3 segundos
        const btnExito = document.getElementById("cerrar-modal-exito-login");
        if (btnExito) {
          btnExito.onclick = function () {
            window.location.href = "../dashboard/dashboard.html";
          };
        }
      } else {
        mostrarModal("modal-error-login");
        const msgDiv = document.getElementById("error-login-msg");
        if (msgDiv) msgDiv.textContent = res.message || "Usuario o contraseña incorrectos.";
      }
    } catch (error) {
      mostrarModal("modal-error-login");
      const msgDiv = document.getElementById("error-login-msg");
      if (msgDiv) msgDiv.textContent = error.message || "Error al iniciar sesión.";
    }
  });
}

// Función para mostrar/ocultar contraseña
window.togglePasswordVisibility = function (inputId) {
  const input = document.getElementById(inputId);
  if (input.type === "password") {
    input.type = "text";
  } else {
    input.type = "password";
  }
};

// Evento para cerrar el modal de error
document.body.addEventListener("click", function(e) {
  if (e.target && e.target.id === "cerrar-modal-error-login") {
    ocultarModal("modal-error-login");
    const msgDiv = document.getElementById("error-login-msg");
    if (msgDiv) msgDiv.textContent = "";
  }
});

// Callback que se ejecuta cuando el usuario inicia sesión con Google
window.onGoogleSignIn = async function(response) {
  try {
    const res = await apiPost(`${API_BASE}/api/auth/google-login`, {
      token: response.credential
    });
    if (res.token) {
      mostrarModal("modal-exito-login");
      setTimeout(() => {
        window.location.href = "../dashboard/dashboard.html";
      }, 3000); // 3 segundos
    } else {
      mostrarModal("modal-error-login");
      const msgDiv = document.getElementById("error-login-msg");
      if (msgDiv) msgDiv.textContent = res.message || "No se pudo iniciar sesión con Google.";
    }
  } catch (error) {
    mostrarModal("modal-error-login");
    const msgDiv = document.getElementById("error-login-msg");
    if (msgDiv) msgDiv.textContent = error.message || "Error al iniciar sesión con Google.";
  }
};
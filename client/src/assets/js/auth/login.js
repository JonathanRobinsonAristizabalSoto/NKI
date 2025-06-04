import { apiPost, API_BASE } from "../api/api.js";
import { mostrarModal, ocultarModal } from "./modals.js";

// Selecciona el formulario de login
const form = document.getElementById("login-form");

// Función para redirigir al dashboard
function irADashboard() {
  window.location.href = "../dashboard/dashboard.html";
}

// Asigna el evento al botón del modal de éxito (fuera del submit para asegurar que siempre funcione)
const btnExito = document.getElementById("cerrar-modal-exito-login");
if (btnExito) {
  btnExito.onclick = irADashboard;
}

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
        setTimeout(irADashboard, 3000); // 3 segundos
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
      setTimeout(irADashboard, 3000); // 3 segundos
      // También asigna el evento al botón por si el modal se muestra desde Google
      const btnExito = document.getElementById("cerrar-modal-exito-login");
      if (btnExito) {
        btnExito.onclick = irADashboard;
      }
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
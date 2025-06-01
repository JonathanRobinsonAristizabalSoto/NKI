import { apiPost, API_BASE } from "../api/api.js";

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
      alert("Por favor, ingresa tu correo o documento y la contraseña.");
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

      // Si la respuesta es "Código enviado por correo", redirige a la verificación
      if (res.message === "Código enviado por correo") {
        localStorage.setItem("pendingUser", user);
        window.location.href = "verify-code.html";
      } else {
        alert(res.message || "Inicio de sesión exitoso, pero sin token.");
      }
    } catch (error) {
      alert(error.message || "Error al iniciar sesión.");
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
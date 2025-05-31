import { apiPost } from '../api/api.js';

// Cambia esta constante según la ruta real de tu backend
const API_BASE = "http://localhost/NKI/server/public";

// ------------------------Carga dinámica de tipos de documento-------------------
async function cargarTiposDocumento() {
  const res = await fetch(`${API_BASE}/api/tipos-documento`);
  const tipos = await res.json();
  const select = document.getElementById("document-type");
  select.innerHTML = '<option value disabled selected>Selecciona el tipo de documento</option>';
  tipos.forEach(tipo => {
    select.innerHTML += `<option value="${tipo.id}">${tipo.descripcion}</option>`;
  });
}

// ------------------------Carga dinámica de roles-------------------
async function cargarRoles() {
  const res = await fetch(`${API_BASE}/api/roles`);
  const roles = await res.json();
  const select = document.getElementById("role");
  select.innerHTML = '<option value disabled selected>Escoge tu rol</option>';
  roles.forEach(rol => {
    select.innerHTML += `<option value="${rol.id}">${rol.nombre}</option>`;
  });
}

// ------------------------Carga dinámica de géneros-------------------
async function cargarGeneros() {
  const res = await fetch(`${API_BASE}/api/generos`);
  const generos = await res.json();
  const select = document.getElementById("gender");
  select.innerHTML = '<option value disabled selected>Selecciona el género</option>';
  generos.forEach(genero => {
    select.innerHTML += `<option value="${genero}">${genero}</option>`;
  });
}

document.addEventListener("DOMContentLoaded", function () {
  // ------------------------Carga los catálogos dinámicamente al cargar la página-------------------
  cargarTiposDocumento();
  cargarRoles();
  cargarGeneros();

  // ------------------------Selecciona el formulario de registro-------------------
  const form = document.querySelector("form");
  if (!form) return;

  // ------------------------Escucha el evento submit del formulario-------------------
  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    // ------------------------Recolecta y estructura los datos del formulario-------------------
    const data = {
      name: document.getElementById("name").value.trim(),
      surname: document.getElementById("surname").value.trim(),
      document_type: document.getElementById("document-type").value,
      document: document.getElementById("document").value.trim(),
      email: document.getElementById("email").value.trim(),
      phone: document.getElementById("phone").value.trim(),
      birthdate: document.getElementById("birthdate").value,
      gender: document.getElementById("gender").value,
      direccion: [
        document.getElementById("street").value,
        document.getElementById("number").value,
        document.getElementById("neighborhood").value,
        document.getElementById("city").value,
        document.getElementById("state").value
      ].filter(Boolean).join(", "),
      role: document.getElementById("role").value,
      password: document.getElementById("password").value,
      confirm_password: document.getElementById("confirm-password").value
    };

    // ------------------------Validación básica de campos obligatorios-------------------
    if (!data.name || !data.surname || !data.document || !data.email || !data.password) {
      alert("Por favor, completa todos los campos obligatorios.");
      return;
    }
    // ------------------------Verifica que las contraseñas coincidan-------------------
    if (data.password !== data.confirm_password) {
      alert("Las contraseñas no coinciden.");
      return;
    }

    try {
      await apiPost(`${API_BASE}/api/auth/register`, data);
      alert("¡Registro exitoso! Ahora puedes iniciar sesión.");
      window.location.href = "login.html";
    } catch (error) {
      alert(error.message);
    }
  });
});
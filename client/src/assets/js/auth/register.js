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

// ------------------------Carga dinámica de roles (solo Jugador y Tutor)-------------------
async function cargarRoles() {
  const res = await fetch(`${API_BASE}/api/roles`);
  const roles = await res.json();
  const select = document.getElementById("role");
  select.innerHTML = '<option value disabled selected>Escoge tu rol</option>';
  // Solo permite los roles de jugador y tutor
  roles.forEach(rol => {
    if (rol.nombre === 'Jugador' || rol.nombre === 'Tutor') {
      select.innerHTML += `<option value="${rol.id}">${rol.nombre}</option>`;
    }
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

// ------------------------Carga dinámica de categorías-------------------
async function cargarCategorias() {
  const res = await fetch(`${API_BASE}/api/categorias`);
  const categorias = await res.json();
  const select = document.getElementById("categoria_id");
  if (!select) return;
  select.innerHTML = '<option value disabled selected>Selecciona la categoría</option>';
  categorias.forEach(cat => {
    // Si tu API devuelve edad_minima y edad_maxima:
    if (cat.edad_minima !== undefined && cat.edad_maxima !== undefined) {
      select.innerHTML += `<option value="${cat.id}" data-edad-min="${cat.edad_minima}" data-edad-max="${cat.edad_maxima}">${cat.nombre} (${cat.edad_minima}-${cat.edad_maxima} años)</option>`;
    } else if (cat.descripcion) {
      // Si solo tienes descripción
      select.innerHTML += `<option value="${cat.id}">${cat.nombre} (${cat.descripcion})</option>`;
    } else {
      // Solo el nombre
      select.innerHTML += `<option value="${cat.id}">${cat.nombre}</option>`;
    }
  });
  // Opción para cuando no hay categoría para la edad
  select.innerHTML += `<option value="no-categoria" disabled style="color:red;">Sin categoría para la edad</option>`;
}

// ------------------------Calcular edad a partir de la fecha de nacimiento-------------------
function calcularEdad(fechaNacimiento) {
  const hoy = new Date();
  const nacimiento = new Date(fechaNacimiento);
  let edad = hoy.getFullYear() - nacimiento.getFullYear();
  const m = hoy.getMonth() - nacimiento.getMonth();
  if (m < 0 || (m === 0 && hoy.getDate() < nacimiento.getDate())) {
    edad--;
  }
  return edad;
}

// ------------------------Seleccionar categoría automáticamente según edad-------------------
function seleccionarCategoriaPorEdad() {
  const birthdate = document.getElementById("birthdate").value;
  if (!birthdate) return;
  const edad = calcularEdad(birthdate);
  const select = document.getElementById("categoria_id");
  if (!select) return;

  let encontrada = false;
  for (let option of select.options) {
    const edadMin = parseInt(option.getAttribute("data-edad-min"));
    const edadMax = parseInt(option.getAttribute("data-edad-max"));
    if (!isNaN(edadMin) && !isNaN(edadMax) && edad >= edadMin && edad <= edadMax) {
      select.value = option.value;
      encontrada = true;
      break;
    }
  }
  // Si no se encontró categoría, selecciona la opción de advertencia
  if (!encontrada) {
    select.value = "no-categoria";
  }
}

document.addEventListener("DOMContentLoaded", function () {
  // ------------------------Carga los catálogos dinámicamente al cargar la página-------------------
  cargarTiposDocumento();
  cargarRoles();
  cargarGeneros();
  cargarCategorias().then(() => {
    // Agrega el listener después de cargar las categorías
    const birthdateInput = document.getElementById("birthdate");
    if (birthdateInput) {
      birthdateInput.addEventListener("change", seleccionarCategoriaPorEdad);
    }
  });

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

    // Si el rol es Jugador, agrega la categoría
    if (data.role === "2") {
      data.categoria_id = document.getElementById("categoria_id").value;
      // Validación: si no hay categoría válida seleccionada, no permitir registro
      if (!data.categoria_id || data.categoria_id === "no-categoria") {
        alert("Sin categoría para la edad.");
        return;
      }
    }

    // ------------------------Validación básica de campos obligatorios-------------------
    if (!data.name || !data.surname || !data.document || !data.email || !data.password) {
      alert("Por favor, completa todos los campos obligatorios.");
      return;
    }
    // Si es jugador, valida que la categoría esté seleccionada
    if (data.role === "2" && !data.categoria_id) {
      alert("Por favor, selecciona la categoría.");
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
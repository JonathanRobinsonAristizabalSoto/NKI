import { apiPost, API_BASE } from "../api/api.js"; // Importa también API_BASE centralizado

// ------------------------Carga dinámica de tipos de documento-------------------
async function cargarTiposDocumento() {
  const res = await fetch(`${API_BASE}/api/tipos-documento`);
  const tipos = await res.json();
  const select = document.getElementById("document-type");
  select.innerHTML =
    "<option value disabled selected>Selecciona el tipo de documento</option>";
  tipos.forEach((tipo) => {
    select.innerHTML += `<option value="${tipo.id}">${tipo.descripcion}</option>`;
  });
}

// ------------------------Carga dinámica de roles (Jugador, Tutor y Seguidor)-------------------
async function cargarRoles() {
  const res = await fetch(`${API_BASE}/api/roles`);
  const roles = await res.json();
  const select = document.getElementById("role");
  select.innerHTML = "<option value disabled selected>Escoge tu rol</option>";
  // Permite los roles de jugador, tutor y seguidor/aficionado
  roles.forEach((rol) => {
    if (
      rol.nombre === "Jugador" ||
      rol.nombre === "Tutor" ||
      rol.nombre === "Seguidor" ||
      rol.nombre === "Aficionado"
    ) {
      select.innerHTML += `<option value="${rol.id}">${rol.nombre}</option>`;
    }
  });
}

// ------------------------Carga dinámica de géneros-------------------
async function cargarGeneros() {
  const res = await fetch(`${API_BASE}/api/generos`);
  const generos = await res.json();
  const select = document.getElementById("gender");
  select.innerHTML =
    "<option value disabled selected>Selecciona el género</option>";
  generos.forEach((genero) => {
    select.innerHTML += `<option value="${genero}">${genero}</option>`;
  });
}

// ------------------------Carga dinámica de categorías-------------------
async function cargarCategorias() {
  const res = await fetch(`${API_BASE}/api/categorias`);
  const categorias = await res.json();
  const select = document.getElementById("categoria_id");
  if (!select) return;
  select.innerHTML =
    "<option value disabled selected>Selecciona la categoría</option>";
  categorias.forEach((cat) => {
    if (cat.edad_minima !== undefined && cat.edad_maxima !== undefined) {
      select.innerHTML += `<option value="${cat.id}" data-edad-min="${cat.edad_minima}" data-edad-max="${cat.edad_maxima}">${cat.nombre} (${cat.edad_minima}-${cat.edad_maxima} años)</option>`;
    } else if (cat.descripcion) {
      select.innerHTML += `<option value="${cat.id}">${cat.nombre} (${cat.descripcion})</option>`;
    } else {
      select.innerHTML += `<option value="${cat.id}">${cat.nombre}</option>`;
    }
  });
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
    if (
      !isNaN(edadMin) &&
      !isNaN(edadMax) &&
      edad >= edadMin &&
      edad <= edadMax
    ) {
      select.value = option.value;
      encontrada = true;
      break;
    }
  }
  if (!encontrada) {
    select.value = "no-categoria";
  }
}

// ------------------------Mostrar/Ocultar modal de verificación-------------------
function mostrarModalVerificacion() {
  document.getElementById("verify-modal").classList.remove("hidden");
}
function ocultarModalVerificacion() {
  document.getElementById("verify-modal").classList.add("hidden");
  document.getElementById("verify-code-input").value = "";
  document.getElementById("verify-error").textContent = "";
}

document.addEventListener("DOMContentLoaded", function () {
  cargarTiposDocumento();
  cargarRoles();
  cargarGeneros();
  cargarCategorias().then(() => {
    const birthdateInput = document.getElementById("birthdate");
    if (birthdateInput) {
      birthdateInput.addEventListener("change", seleccionarCategoriaPorEdad);
    }
  });

  // Mostrar/ocultar campo de categoría según el rol
  const roleSelect = document.getElementById("role");
  if (roleSelect) {
    roleSelect.addEventListener("change", function () {
      const categoriaRow = document.getElementById("categoria-row");
      // "2" es Jugador, busca el id de seguidor/aficionado si lo necesitas
      if (this.options[this.selectedIndex].text === "Jugador") {
        categoriaRow.style.display = "flex";
      } else {
        categoriaRow.style.display = "none";
      }
    });
  }

  // Modal: cerrar
  document.getElementById("close-verify-modal").onclick = ocultarModalVerificacion;

  // ------------------------Formulario de registro-------------------
  const form = document.getElementById("register-form");
  if (!form) return;

  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    // Usa intl-tel-input para obtener el número en formato internacional
    const phoneInputField = document.getElementById("phone");
    let phone = phoneInputField.value.trim();
    if (window.intlTelInputGlobals && window.intlTelInputGlobals.getInstance) {
      const iti = window.intlTelInputGlobals.getInstance(phoneInputField);
      if (iti) {
        phone = iti.getNumber();
      }
    }

    const data = {
      name: document.getElementById("name").value.trim(),
      surname: document.getElementById("surname").value.trim(),
      document_type: document.getElementById("document-type").value,
      document: document.getElementById("document").value.trim(),
      email: document.getElementById("email").value.trim(),
      phone: phone,
      birthdate: document.getElementById("birthdate").value,
      gender: document.getElementById("gender").value,
      direccion: [
        document.getElementById("street-type").value,
        document.getElementById("street-number").value,
        document.getElementById("street-letter").value,
        document.getElementById("street-number2").value,
        document.getElementById("block").value,
        document.getElementById("apartment").value,
        document.getElementById("reference").value,
        document.getElementById("neighborhood").value,
        document.getElementById("city").value,
        document.getElementById("state").value,
      ]
        .filter(Boolean)
        .join(", "),
      role: document.getElementById("role").value,
      password: document.getElementById("password").value,
      confirm_password: document.getElementById("confirm-password").value,
    };

    // Si es jugador, requiere categoría
    const roleSelect = document.getElementById("role");
    const selectedRoleText = roleSelect.options[roleSelect.selectedIndex].text;
    if (selectedRoleText === "Jugador") {
      data.categoria_id = document.getElementById("categoria_id").value;
      if (!data.categoria_id || data.categoria_id === "no-categoria") {
        alert("Sin categoría para la edad.");
        return;
      }
    }

    if (
      !data.name ||
      !data.surname ||
      !data.document ||
      !data.email ||
      !data.password
    ) {
      alert("Por favor, completa todos los campos obligatorios.");
      return;
    }
    if (selectedRoleText === "Jugador" && !data.categoria_id) {
      alert("Por favor, selecciona la categoría.");
      return;
    }
    if (data.password !== data.confirm_password) {
      alert("Las contraseñas no coinciden.");
      return;
    }

    // Si es seguidor/aficionado, puedes agregar campos extra aquí si los tienes en el formulario
    if (
      selectedRoleText === "Seguidor" ||
      selectedRoleText === "Aficionado"
    ) {
      // Ejemplo: intereses y boletín (ajusta los IDs si tienes estos campos)
      const interesesInput = document.getElementById("intereses");
      const boletinInput = document.getElementById("recibe_boletin");
      if (interesesInput) data.intereses = interesesInput.value;
      if (boletinInput) data.recibe_boletin = boletinInput.checked ? 1 : 0;
    }

    try {
      // Enviar datos de registro, esperar respuesta de éxito
      await apiPost(`${API_BASE}/api/auth/register`, data);

      // Mostrar modal de verificación de código
      mostrarModalVerificacion();

      // Evita listeners duplicados reemplazando el botón
      const oldBtn = document.getElementById("verify-code-btn");
      const newBtn = oldBtn.cloneNode(true);
      oldBtn.parentNode.replaceChild(newBtn, oldBtn);

      newBtn.addEventListener("click", async function () {
        const code = document.getElementById("verify-code-input").value.trim();
        if (!/^\d{6}$/.test(code)) {
          document.getElementById("verify-error").textContent = "El código debe tener 6 dígitos.";
          return;
        }
        newBtn.disabled = true;
        try {
          await apiPost(`${API_BASE}/api/auth/verify-register-code`, {
            email: data.email,
            code: code,
          });
          ocultarModalVerificacion();
          alert("¡Cuenta verificada! Ahora puedes iniciar sesión.");
          window.location.href = "login.html";
        } catch (error) {
          document.getElementById("verify-error").textContent = error.message || "Código incorrecto.";
        }
        newBtn.disabled = false;
      });
    } catch (error) {
      alert(error.message);
    }
  });
});
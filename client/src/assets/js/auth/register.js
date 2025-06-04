import { apiPost, API_BASE } from "../api/api.js";
import {
  mostrarModalVerificacion,
  ocultarModalVerificacion,
  activarAutoAvanceInputs,
  asignarEventosCerrarModal
} from "./modal-verificacion.js";
import { mostrarModal, ocultarModal, asignarEventosCerrarModales } from "./modals.js";

// ------------------------Carga dinámica de tipos de documento-------------------
// Llama a la API y llena el select de tipo de documento
async function cargarTiposDocumento() {
  const res = await fetch(`${API_BASE}/api/tipos-documento`);
  const tipos = await res.json();
  const select = document.getElementById("document-type");
  if (!select) return;
  select.innerHTML =
    "<option value disabled selected>Selecciona el tipo de documento</option>";
  tipos.forEach((tipo) => {
    select.innerHTML += `<option value="${tipo.id}">${tipo.descripcion}</option>`;
  });
}

// ------------------------Carga dinámica de roles-------------------
// Llama a la API y llena el select de roles permitidos
async function cargarRoles() {
  const res = await fetch(`${API_BASE}/api/roles`);
  const roles = await res.json();
  const select = document.getElementById("role");
  if (!select) return;
  select.innerHTML = "<option value disabled selected>Escoge tu rol</option>";
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
// Llama a la API y llena el select de géneros
async function cargarGeneros() {
  const res = await fetch(`${API_BASE}/api/generos`);
  const generos = await res.json();
  const select = document.getElementById("gender");
  if (!select) return;
  select.innerHTML =
    "<option value disabled selected>Elige tu género</option>";
  generos.forEach((genero) => {
    select.innerHTML += `<option value="${genero}">${genero}</option>`;
  });
}

// ------------------------Carga dinámica de categorías-------------------
// Llama a la API y llena el select de categorías, guardando el array global para validaciones
let categoriasGlobal = [];
async function cargarCategorias() {
  const res = await fetch(`${API_BASE}/api/categorias`);
  const categorias = await res.json();
  categoriasGlobal = categorias; // Guardar para validación posterior
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
// Devuelve la edad en años a partir de una fecha en formato YYYY-MM-DD
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
// Selecciona la categoría automáticamente según la edad y muestra el modal si no hay categoría
function seleccionarCategoriaPorEdad() {
  const birthdate = document.getElementById("birthdate")?.value;
  const categoriaSelect = document.getElementById("categoria_id");
  const roleSelect = document.getElementById("role");
  const categoriaRow = document.getElementById("categoria-row");
  const msgId = "msg-no-categoria";
  const modalCategoria = document.getElementById("modal-categoria-no-disponible");

  // Limpiar selección y mensaje siempre
  if (categoriaSelect) categoriaSelect.value = "";
  let msg = document.getElementById(msgId);
  if (msg) msg.remove();

  if (!birthdate || !categoriaSelect || !roleSelect) return;

  // Solo validar si el rol es Jugador
  const selectedRoleText = roleSelect.options[roleSelect.selectedIndex]?.text;
  if (selectedRoleText !== "Jugador") return;

  // Formatear fecha a YYYY-MM-DD si viene en dd/mm/yyyy
  let partes = birthdate.split("/");
  let fechaISO = birthdate;
  if (partes.length === 3) {
    fechaISO = `${partes[2]}-${partes[1].padStart(2, "0")}-${partes[0].padStart(2, "0")}`;
  }
  const edad = calcularEdad(fechaISO);

  let encontrada = false;
  for (let option of categoriaSelect.options) {
    const edadMin = parseInt(option.getAttribute("data-edad-min"));
    const edadMax = parseInt(option.getAttribute("data-edad-max"));
    if (
      !isNaN(edadMin) &&
      !isNaN(edadMax) &&
      edad >= edadMin &&
      edad <= edadMax
    ) {
      categoriaSelect.value = option.value;
      encontrada = true;
      break;
    }
  }

  if (!encontrada) {
    categoriaSelect.value = "no-categoria";
    // Mostrar el modal y limpiar el rol
    if (modalCategoria) {
      mostrarModal("modal-categoria-no-disponible");
      const cerrarBtn = document.getElementById("cerrar-modal-categoria");
      if (cerrarBtn) {
        cerrarBtn.onclick = function () {
          ocultarModal("modal-categoria-no-disponible");
          if (roleSelect) roleSelect.selectedIndex = 0;
          if (categoriaRow) categoriaRow.style.display = "none";
        };
      }
    }
    return;
  }
}

// ------------------------Formatear fecha a YYYY-MM-DD-------------------
// Convierte una fecha en formato dd/mm/yyyy a YYYY-MM-DD
function formatearFechaNacimiento(valor) {
  if (/^\d{4}-\d{2}-\d{2}$/.test(valor)) return valor;
  const partes = valor.split("/");
  if (partes.length === 3) {
    return `${partes[2]}-${partes[1].padStart(2, "0")}-${partes[0].padStart(2, "0")}`;
  }
  return "";
}

document.addEventListener("DOMContentLoaded", function () {
  // Inicializa selects y componentes al cargar la página
  cargarTiposDocumento();
  cargarRoles();
  cargarGeneros();
  cargarCategorias().then(() => {
    const birthdateInput = document.getElementById("birthdate");
    if (birthdateInput) {
      // Limpiar categoría, mensaje y rol al hacer click o cambiar la fecha de nacimiento
      const resetRolCategoria = function () {
        const categoriaSelect = document.getElementById("categoria_id");
        if (categoriaSelect) categoriaSelect.value = "";
        const msg = document.getElementById("msg-no-categoria");
        if (msg) msg.remove();
        const roleSelect = document.getElementById("role");
        if (roleSelect) roleSelect.selectedIndex = 0; // Deja el select en "Escoge tu rol"
        const categoriaRow = document.getElementById("categoria-row");
        if (categoriaRow) categoriaRow.style.display = "none";
      };
      birthdateInput.addEventListener("change", resetRolCategoria);
      birthdateInput.addEventListener("focus", resetRolCategoria);
      birthdateInput.addEventListener("click", resetRolCategoria);
    }
  });

  // Mostrar/ocultar campo de categoría según el rol seleccionado
  const roleSelect = document.getElementById("role");
  if (roleSelect) {
    roleSelect.addEventListener("change", function () {
      const categoriaRow = document.getElementById("categoria-row");
      if (categoriaRow) {
        if (this.options[this.selectedIndex].text === "Jugador") {
          categoriaRow.style.display = "flex";
          seleccionarCategoriaPorEdad(); // Asignar categoría automáticamente al cambiar a Jugador
        } else {
          categoriaRow.style.display = "none";
          // Ocultar mensaje si existe
          const msg = document.getElementById("msg-no-categoria");
          if (msg) msg.remove();
        }
      }
    });
  }

  // Inicializa eventos de inputs y cierre de modales
  activarAutoAvanceInputs();
  asignarEventosCerrarModal();
  asignarEventosCerrarModales();

  // ------------------------Formulario de registro-------------------
  // Maneja el envío del formulario de registro
  const form = document.getElementById("register-form");
  if (!form) return;

  form.addEventListener("submit", async function (e) {
    e.preventDefault();

    // Usa intl-tel-input para obtener el número en formato internacional
    const phoneInputField = document.getElementById("phone");
    let phone = phoneInputField ? phoneInputField.value.trim() : "";
    if (window.intlTelInputGlobals && window.intlTelInputGlobals.getInstance && phoneInputField) {
      const iti = window.intlTelInputGlobals.getInstance(phoneInputField);
      if (iti) {
        phone = iti.getNumber();
      }
    }

    // Construye la dirección a partir de los campos del formulario
    const direccionCampos = [
      { value: document.getElementById("street-type")?.value },
      { value: document.getElementById("street-number")?.value },
      { value: document.getElementById("street-letter")?.value },
      { value: document.getElementById("street-compound")?.value },
      { value: document.getElementById("complex-type")?.value },
      { value: document.getElementById("complex-number")?.value },
      { value: document.getElementById("unit-type")?.value },
      { value: document.getElementById("unit-number")?.value },
      { value: document.getElementById("neighborhood")?.value },
      { value: document.getElementById("city")?.value },
      { value: document.getElementById("state")?.value },
    ];
    const direccion = direccionCampos
      .filter(
        (campo) =>
          campo.value &&
          campo.value !== "Letra (opcional)" &&
          campo.value !== "Tipo de unidad" &&
          campo.value !== "Tipo de conjunto"
      )
      .map((campo) => campo.value)
      .join(", ");

    let birthdateRaw = document.getElementById("birthdate")?.value || "";
    let birthdate = formatearFechaNacimiento(birthdateRaw);

    // Mapea los nombres JS a los de la base de datos
    const data = {
      nombre: document.getElementById("name")?.value?.trim() || "",
      apellido: document.getElementById("surname")?.value?.trim() || "",
      tipo_documento_id: document.getElementById("document-type")?.value || "",
      documento: document.getElementById("document")?.value?.trim() || "",
      correo: document.getElementById("email")?.value?.trim() || "",
      telefono: phone,
      fecha_nacimiento: birthdate,
      genero: document.getElementById("gender")?.value || "",
      direccion: direccion,
      rol_id: document.getElementById("role")?.value || "",
      contrasena: document.getElementById("password")?.value || "",
      confirm_contrasena: document.getElementById("confirm-password")?.value || "",
    };

    let selectedRoleText = "";
    const roleSelect = document.getElementById("role");
    if (roleSelect && roleSelect.selectedIndex > -1) {
      selectedRoleText = roleSelect.options[roleSelect.selectedIndex].text;
    }
    if (selectedRoleText === "Jugador") {
      data.categoria_id = document.getElementById("categoria_id")?.value || "";
      if (!data.categoria_id || data.categoria_id === "no-categoria") {
        // El mensaje ya se muestra debajo del campo, solo bloquea el submit
        return;
      }
    }

    // Validación de campos obligatorios y reglas de negocio
    if (
      !data.nombre ||
      !data.apellido ||
      !data.tipo_documento_id ||
      !data.documento ||
      !data.correo ||
      !data.contrasena
    ) {
      mostrarModal("modal-error-registro");
      // Limpia y muestra mensaje genérico
      const msgDiv = document.getElementById("error-registro-msg");
      if (msgDiv) msgDiv.textContent = "Por favor, completa todos los campos obligatorios.";
      return;
    }
    if (selectedRoleText === "Jugador" && !data.categoria_id) {
      mostrarModal("modal-error-registro");
      const msgDiv = document.getElementById("error-registro-msg");
      if (msgDiv) msgDiv.textContent = "Debes seleccionar una categoría válida.";
      return;
    }
    if (data.contrasena !== data.confirm_contrasena) {
      mostrarModal("modal-error-registro");
      const msgDiv = document.getElementById("error-registro-msg");
      if (msgDiv) msgDiv.textContent = "Las contraseñas no coinciden.";
      return;
    }

    try {
      // Envía los datos al backend para crear la cuenta
      await apiPost(`${API_BASE}/api/auth/register`, data);

      // Muestra el modal de verificación de código
      mostrarModalVerificacion();

      // Reemplaza el botón de verificación para evitar múltiples listeners
      const oldBtn = document.getElementById("verify-code-btn");
      if (!oldBtn) return;
      const newBtn = oldBtn.cloneNode(true);
      oldBtn.parentNode.replaceChild(newBtn, oldBtn);

      // Lógica para verificar el código de registro
      newBtn.addEventListener("click", async function () {
        const code = Array.from(
          document.querySelectorAll('#verify-modal input[type="text"]')
        )
          .map((input) => input.value.trim())
          .join("");
        if (!/^\d{6}$/.test(code)) {
          document.getElementById("verify-error").textContent = "El código debe tener 6 dígitos.";
          return;
        }
        newBtn.disabled = true;
        try {
          await apiPost(`${API_BASE}/api/auth/verify-register-code`, {
            correo: data.correo,
            code: code,
          });
          ocultarModalVerificacion();
          mostrarModal("modal-exito-registro");

          // Asigna el evento al botón "Aceptar" del modal de éxito para redirigir al login
          setTimeout(() => {
            const btnExito = document.getElementById("cerrar-modal-exito-registro");
            if (btnExito) {
              btnExito.onclick = function () {
                window.location.href = "login.html";
              };
            }
          }, 100);

        } catch (error) {
          document.getElementById("verify-error").textContent = error.message || "Código incorrecto.";
        }
        newBtn.disabled = false;
      });
    } catch (error) {
      // Si ocurre un error en el registro, muestra el modal de error y el mensaje específico
      mostrarModal("modal-error-registro");
      const msgDiv = document.getElementById("error-registro-msg");
      if (msgDiv) {
        msgDiv.textContent = error?.message || "Ocurrió un problema al registrar tu cuenta.";
      }
    }
  });

  // Evento global para cerrar el modal de error y limpiar el mensaje
  document.body.addEventListener("click", function(e) {
    if (e.target && e.target.id === "cerrar-modal-error-registro") {
      ocultarModal("modal-error-registro");
      const msgDiv = document.getElementById("error-registro-msg");
      if (msgDiv) msgDiv.textContent = "";
    }
  });
});
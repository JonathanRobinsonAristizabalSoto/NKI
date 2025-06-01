// Mostrar el modal y bloquear el scroll
export function mostrarModalVerificacion() {
  document.getElementById("verify-modal").classList.remove("hidden");
  document.body.classList.add("overflow-hidden");
}

// Ocultar el modal y restaurar el scroll
export function ocultarModalVerificacion() {
  document.getElementById("verify-modal").classList.add("hidden");
  document.body.classList.remove("overflow-hidden");
  // Limpia los inputs y errores si existen
  document.querySelectorAll('#verify-modal input[type="text"]').forEach(input => input.value = "");
  const error = document.getElementById("verify-error");
  if (error) error.textContent = "";
}

// Auto-avance entre inputs de dígitos
export function activarAutoAvanceInputs() {
  const inputs = document.querySelectorAll('#verify-modal input[type="text"]');
  inputs.forEach((input, idx, arr) => {
    input.addEventListener('input', function () {
      if (this.value.length === 1 && idx < arr.length - 1) {
        arr[idx + 1].focus();
      }
    });
    input.addEventListener('keydown', function (e) {
      if (e.key === "Backspace" && !this.value && idx > 0) {
        arr[idx - 1].focus();
      }
    });
  });
}

// Asigna eventos a los botones de cerrar del modal
export function asignarEventosCerrarModal() {
  const close1 = document.getElementById("close-verify-modal");
  const close2 = document.getElementById("close-verify-modal-2");
  if (close1) close1.onclick = ocultarModalVerificacion;
  if (close2) close2.onclick = ocultarModalVerificacion;
}
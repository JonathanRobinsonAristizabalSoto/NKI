export function mostrarModalVerificacion() {
  const modal = document.getElementById("verify-modal");
  if (modal) {
    modal.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
  }
}

export function ocultarModalVerificacion() {
  const modal = document.getElementById("verify-modal");
  if (modal) {
    modal.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }
}

export function activarAutoAvanceInputs() {
  const inputs = document.querySelectorAll('#verify-modal input[type="text"]');
  inputs.forEach((input, idx, arr) => {
    // Solo permite números y avanza automáticamente
    input.addEventListener('input', function (e) {
      let value = this.value.replace(/\D/g, '');
      if (value.length > 1) value = value[0];
      this.value = value;

      if (value && idx < arr.length - 1) {
        arr[idx + 1].focus();
      }
    });

    // Permite pegar el código completo o parcial
    input.addEventListener('paste', function (e) {
      const paste = (e.clipboardData || window.clipboardData).getData('text').replace(/\D/g, '');
      if (paste.length > 0) {
        arr.forEach((inp, i) => {
          inp.value = paste[i] || '';
        });
        arr[Math.min(paste.length, arr.length) - 1].focus();
        e.preventDefault();
      }
    });

    // Retrocede al anterior si borras, avanza si escribes número con casilla llena
    input.addEventListener('keydown', function (e) {
      if (e.key === "Backspace" && !this.value && idx > 0) {
        arr[idx - 1].focus();
      } else if (e.key.match(/^[0-9]$/) && this.value && idx < arr.length - 1) {
        this.value = e.key;
        arr[idx + 1].focus();
        e.preventDefault();
      }
    });
  });
}

// Asigna eventos a los botones de cierre del modal de verificación
export function asignarEventosCerrarModalVerificacion() {
  const btnX = document.getElementById("close-verify-modal");
  const btnCancelar = document.getElementById("close-verify-modal-2");
  if (btnX) {
    btnX.onclick = ocultarModalVerificacion;
  }
  if (btnCancelar) {
    btnCancelar.onclick = ocultarModalVerificacion;
  }
}
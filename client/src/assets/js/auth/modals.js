export function mostrarModal(id) {
  const modal = document.getElementById(id);
  if (modal) {
    modal.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
  }
}

export function ocultarModal(id) {
  const modal = document.getElementById(id);
  if (modal) {
    modal.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }
}

export function asignarEventosCerrarModales() {
  document.querySelectorAll("[data-modal-close]").forEach(btn => {
    btn.onclick = () => {
      const modalId = btn.getAttribute("data-modal-close");
      ocultarModal(modalId);
    };
  });
}
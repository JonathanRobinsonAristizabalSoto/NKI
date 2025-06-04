const modales = [
  "modal-exito-registro.html",
  "modal-error-registro.html",
  "modal-categoria-no-disponible.html",
  "modal-verificacion-codigo.html",
  "modal-error-login.html",      // Agrega el modal de error de login
  "modal-exito-login.html"       // Agrega el modal de éxito de login
];

const ruta = "../modals/";

window.addEventListener("DOMContentLoaded", () => {
  const contenedor = document.createElement("div");
  contenedor.id = "modals-container";
  document.body.appendChild(contenedor);

  modales.forEach(nombre => {
    fetch(ruta + nombre)
      .then(res => res.text())
      .then(html => {
        contenedor.insertAdjacentHTML("beforeend", html);
      });
  });
});
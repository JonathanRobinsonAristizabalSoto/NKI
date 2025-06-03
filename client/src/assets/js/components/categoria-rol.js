// Mostrar categoría a la derecha si el rol es jugador (en web)
  document.addEventListener("DOMContentLoaded", function () {
    const roleSelect = document.getElementById("role");
    const categoriaRow = document.getElementById("categoria-row");
    roleSelect.addEventListener("change", function () {
      if (this.value === "2" || this.value === "jugador") {
        categoriaRow.style.display = "flex";
      } else {
        categoriaRow.style.display = "none";
        document.getElementById("categoria_id").value = "";
      }
    });
  });
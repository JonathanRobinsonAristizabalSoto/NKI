// Lógica para manejar el submenú
document.addEventListener('DOMContentLoaded', function () {
    // Función para alternar la visibilidad del submenú
    window.toggleSubmenu = function (id, button) {
        const submenu = document.getElementById(id);
        submenu.classList.toggle('hidden');
        const icon = button.querySelector('i.fas.fa-chevron-down, i.fas.fa-chevron-up');
        if (icon) {
            icon.classList.toggle('fa-chevron-up');
            icon.classList.toggle('fa-chevron-down');
        }
    };

    // Lógica para el botón del menú hamburguesa
    const menuBtn = document.getElementById('menu-btn');
    const menu = document.getElementById('menu');
    const overlay = document.getElementById('overlay');

    if (menuBtn && menu && overlay) {
        menuBtn.addEventListener('click', function () {
            menu.classList.toggle('translate-x-0');
            overlay.classList.toggle('hidden');
            this.classList.toggle('active');
        });
    }
});
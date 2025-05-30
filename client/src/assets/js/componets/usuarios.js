// Maneja el botón del menú hamburguesa
document.getElementById('menu-btn').addEventListener('click', function () {
    document.getElementById('menu').classList.toggle('translate-x-0');
    document.getElementById('overlay').classList.toggle('hidden');
    this.classList.toggle('active');
});

// Función para mostrar/ocultar submenús
function toggleSubmenu(id, button) {
    const submenu = document.getElementById(id);
    submenu.classList.toggle('hidden');
    const icon = button.querySelector('i.fas.fa-chevron-down, i.fas.fa-chevron-up');
    if (icon) {
        icon.classList.toggle('fa-chevron-up');
        icon.classList.toggle('fa-chevron-down');
    }
}

// Maneja el botón del menú desplegable
document.getElementById('dropdown-btn').addEventListener('click', function () {
    const dropdownMenu = document.getElementById('dropdown-menu');
    const dropdownIcon = document.getElementById('dropdown-icon');
    dropdownMenu.classList.toggle('hidden');
    dropdownIcon.classList.toggle('fa-chevron-down');
    dropdownIcon.classList.toggle('fa-chevron-up');
});

// Muestra el modal para agregar un usuario
document.getElementById('agregar-usuario-btn').addEventListener('click', function () {
    document.getElementById('usuario-modal').classList.remove('hidden');
    document.getElementById('modal-titulo').textContent = 'Agregar Usuario';
    document.getElementById('usuario-form').reset();
});

// Oculta el modal al cancelar
document.getElementById('cancelar-btn').addEventListener('click', function () {
    document.getElementById('usuario-modal').classList.add('hidden');
});

// Oculta el modal al cerrar
document.getElementById('close-modal-btn').addEventListener('click', function () {
    document.getElementById('usuario-modal').classList.add('hidden');
});

// Maneja el envío del formulario de usuario
document.getElementById('usuario-form').addEventListener('submit', function (event) {
    event.preventDefault();
    // Aquí puedes agregar la lógica para guardar el usuario
    document.getElementById('usuario-modal').classList.add('hidden');
});

// Función para cerrar sesión
function logout() {
    // Aquí puedes agregar la lógica para cerrar la sesión
    window.location.href = '../../index.html';
}

// Oculta el modal al presionar la tecla Escape
document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        document.getElementById('usuario-modal').classList.add('hidden');
    }
});
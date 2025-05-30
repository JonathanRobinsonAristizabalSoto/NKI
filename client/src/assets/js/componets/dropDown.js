// Script para manejar el menú desplegable
document.addEventListener('DOMContentLoaded', function () {
    const dropdownBtn = document.getElementById('dropdown-btn');
    const dropdownMenu = document.getElementById('dropdown-menu');
    const dropdownIcon = document.getElementById('dropdown-icon');

    if (dropdownBtn && dropdownMenu && dropdownIcon) {
        dropdownBtn.addEventListener('click', function () {
            dropdownMenu.classList.toggle('hidden');
            dropdownIcon.classList.toggle('fa-chevron-down');
            dropdownIcon.classList.toggle('fa-chevron-up');
        });
    }
});
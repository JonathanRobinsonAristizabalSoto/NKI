const dropdownBtn = document.getElementById('dropdown-btn');
const dropdownMenu = document.getElementById('dropdown-menu');
const dropdownIcon = document.getElementById('dropdown-icon');
const main = document.querySelector('main');
const footer = document.querySelector('footer');
const whatsappBtn = document.getElementById('whatsapp-button');
const payBtn = document.getElementById('pay-now-button');
const overlay = document.getElementById('overlay');

function isMobile() {
    return window.innerWidth < 768; // Tailwind md: breakpoint
}

function toggleBlurAndOverlay(apply) {
    if (isMobile()) {
        [main, footer, whatsappBtn, payBtn].forEach(el => {
            if (el) {
                if (apply) {
                    el.classList.add('blur-sm');
                } else {
                    el.classList.remove('blur-sm');
                }
            }
        });
        if (overlay) {
            if (apply) {
                overlay.classList.remove('hidden');
            } else {
                overlay.classList.add('hidden');
            }
        }
    }
}

if (dropdownBtn && dropdownMenu && dropdownIcon) {
    dropdownBtn.addEventListener('click', function (e) {
        e.stopPropagation();
        dropdownMenu.classList.toggle('hidden');
        dropdownIcon.classList.toggle('fa-chevron-down');
        dropdownIcon.classList.toggle('fa-chevron-up');
        toggleBlurAndOverlay(!dropdownMenu.classList.contains('hidden'));
    });

    // Cierra el menú si se hace clic fuera
    document.addEventListener('click', function (e) {
        if (!dropdownMenu.classList.contains('hidden')) {
            if (!dropdownMenu.contains(e.target) && !dropdownBtn.contains(e.target)) {
                dropdownMenu.classList.add('hidden');
                dropdownIcon.classList.add('fa-chevron-down');
                dropdownIcon.classList.remove('fa-chevron-up');
                toggleBlurAndOverlay(false);
            }
        }
    });

    // Quita el blur y overlay si se cambia el tamaño de pantalla a desktop
    window.addEventListener('resize', function () {
        if (!isMobile()) {
            toggleBlurAndOverlay(false);
        }
    });
}
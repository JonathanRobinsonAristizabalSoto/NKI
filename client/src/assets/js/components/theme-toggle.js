// Script para cambiar el tema
const themeToggle = $('#theme-toggle');
const themeIcon = $('#theme-icon');
const menuThemeIcon = $('#menu-theme-icon');
const htmlElement = $('html');

themeToggle.on('click', function() {
    if (htmlElement.hasClass('dark')) {
        htmlElement.removeClass('dark').addClass('light');
        themeToggle.removeClass('bg-secondary').addClass('bg-primary');
        themeIcon.removeClass('fa-sun').addClass('fa-moon');
        menuThemeIcon.removeClass('fa-sun').addClass('fa-moon');
        themeToggle.html('<i id="menu-theme-icon" class="fas fa-moon"></i> Tema Dark');
    } else {
        htmlElement.removeClass('light').addClass('dark');
        themeToggle.removeClass('bg-primary').addClass('bg-secondary');
        themeIcon.removeClass('fa-moon').addClass('fa-sun');
        menuThemeIcon.removeClass('fa-moon').addClass('fa-sun');
        themeToggle.html('<i id="menu-theme-icon" class="fas fa-sun"></i> Tema Light ');
    }
});
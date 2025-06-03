// Detecta el tema del sistema operativo y aplica la clase dark automáticamente
(function () {
  function setThemeBySystem() {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const html = document.documentElement;
    if (prefersDark) {
      html.classList.add('dark');
      html.classList.remove('light');
    } else {
      html.classList.remove('dark');
      html.classList.add('light');
    }
  }
  setThemeBySystem();
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', setThemeBySystem);
})();
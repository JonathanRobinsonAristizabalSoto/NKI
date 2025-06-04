document.addEventListener('DOMContentLoaded', function () {
  // Definir el idioma español para Vanilla JS Datepicker 1.3.x
  if (typeof Datepicker !== "undefined") {
    Datepicker.locales.es = {
      days: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
      daysShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
      daysMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
      months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
      today: 'Hoy',
      clear: 'Limpiar',
      titleFormat: 'MM yyyy',
      weekStart: 1
    };
  }

  const birthdateInput = document.getElementById('birthdate');
  if (birthdateInput && typeof Datepicker !== "undefined") {
    new Datepicker(birthdateInput, {
      format: 'dd/mm/yyyy',
      autohide: true,
      maxDate: new Date(),
      language: 'es'
    });
  }
});
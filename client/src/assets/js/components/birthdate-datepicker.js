document.addEventListener('DOMContentLoaded', function () {
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
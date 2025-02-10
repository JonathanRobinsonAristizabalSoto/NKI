$(document).ready(function() {
  // Selecciona el campo de entrada de teléfono
  const phoneInputField = $("#phone")[0];

  // Inicializa el plugin intlTelInput en el campo de entrada de teléfono
  const phoneInput = window.intlTelInput(phoneInputField, {
      initialCountry: "auto",
      geoIpLookup: function(success, failure) {
          // Realiza una solicitud para obtener la información de geolocalización
          fetch("https://ipinfo.io/json?token=<YOUR_TOKEN>")
              .then((resp) => resp.json())
              .then((resp) => success(resp.country))
              .catch(() => success("us"));
      },
      utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
  });
});
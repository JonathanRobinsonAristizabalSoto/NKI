// Lógica para el botón de WhatsApp
document.addEventListener('DOMContentLoaded', function () {
    const whatsappButton = document.getElementById('whatsapp-button');
    if (whatsappButton) {
        whatsappButton.addEventListener('click', function () {
            window.location.href = 'https://wa.me/+573207763644?text=Hola%20,%20Deseo%20obtener%20información%20acerca%20del%20club,%20inscripciones,%20horarios%20y%20precios'; // Reemplaza con el número de WhatsApp del club
        });
    }
});
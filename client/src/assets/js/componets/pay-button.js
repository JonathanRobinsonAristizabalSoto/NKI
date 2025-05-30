// Lógica para el botón de pago
document.addEventListener('DOMContentLoaded', function () {
    const payNowButton = document.getElementById('pay-now-button');
    if (payNowButton) {
        payNowButton.addEventListener('click', function () {
            window.location.href = 'src/pages/payment.html';
        });

        function togglePayButton() {
            payNowButton.classList.add('expanded');
            setTimeout(() => {
                if (payNowButton.querySelector('i').style.display === 'none') {
                    payNowButton.querySelector('i').style.display = 'inline';
                    payNowButton.querySelector('span').style.display = 'none';
                } else {
                    payNowButton.querySelector('i').style.display = 'none';
                    payNowButton.querySelector('span').style.display = 'inline';
                }
                payNowButton.classList.remove('expanded');
            }, 1000); // Duración de la animación
        }

        setInterval(togglePayButton, 3000); // Cambia entre el icono y el texto cada 3 segundos
    }
});
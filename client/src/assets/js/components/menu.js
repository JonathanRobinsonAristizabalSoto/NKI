// Script para menú hamburguesa
$(document).ready(function() {
  const menuBtn = $("#menu-btn");
  const closeMenuBtn = $("#close-menu");
  const menu = $("#menu");
  const overlay = $("#overlay");
  const main = $("main");
  const footer = $("footer");
  const whatsappBtn = $("#whatsapp-button");
  const payBtn = $("#pay-now-button");

  function isMobile() {
    return window.innerWidth < 768;
  }

  function toggleBlur(apply) {
    if (isMobile()) {
      [main, footer, whatsappBtn, payBtn].forEach($el => {
        if ($el && $el.length) {
          if (apply) {
            $el.addClass("blur-sm");
          } else {
            $el.removeClass("blur-sm");
          }
        }
      });
    }
  }

  menuBtn.on("click", function() {
    menu.toggleClass("-translate-x-full");
    overlay.toggleClass("hidden");
    toggleBlur(!menu.hasClass("-translate-x-full"));
  });

  closeMenuBtn.on("click", function() {
    menu.toggleClass("-translate-x-full");
    overlay.toggleClass("hidden");
    toggleBlur(!menu.hasClass("-translate-x-full"));
  });

  overlay.on("click", function() {
    menu.addClass("-translate-x-full");
    overlay.addClass("hidden");
    toggleBlur(false);
  });

  $(window).on("resize", function() {
    if (!isMobile()) {
      toggleBlur(false);
    }
  });
});
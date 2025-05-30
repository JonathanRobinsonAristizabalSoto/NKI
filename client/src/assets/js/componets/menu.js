// Script para menú hamburguesa
$(document).ready(function() {
  const menuBtn = $("#menu-btn");
  const closeMenuBtn = $("#close-menu");
  const menu = $("#menu");
  const overlay = $("#overlay");

  menuBtn.on("click", function() {
      menu.toggleClass("-translate-x-full");
      overlay.toggleClass("hidden");
  });

  closeMenuBtn.on("click", function() {
      menu.toggleClass("-translate-x-full");
      overlay.toggleClass("hidden");
  });

  overlay.on("click", function() {
      menu.addClass("-translate-x-full");
      overlay.addClass("hidden");
  });
});
function togglePasswordVisibility(id) {
  const passwordInput = $(`#${id}`);
  const passwordIcon = passwordInput.next().find("i");
  if (passwordInput.attr("type") === "password") {
      passwordInput.attr("type", "text");
      passwordIcon.removeClass("fa-eye").addClass("fa-eye-slash");
  } else {
      passwordInput.attr("type", "password");
      passwordIcon.removeClass("fa-eye-slash").addClass("fa-eye");
  }
}
function clearForm(form) {
  const inputs = form.querySelectorAll(
    "input:not([type=button]):not([type=checkbox]):not([type=hidden]):not([type=radio]):not([type=reset]):not([type=submit])"
  );
  Array.from(inputs).forEach((input) => {
    const element = input;
    element.value = "";
  });

  const checkboxes = form.querySelectorAll(
    "input[type=checkbox], input[type=radio]"
  );
  Array.from(checkboxes).forEach((checkbox) => {
    const element = checkbox;
    element.checked = false;
  });
}

function addClearForm(button) {
  button.addEventListener("click", function (event) {
    event.preventDefault();
    clearForm(this.form);
  });
}

document.addEventListener("turbolinks:load", function () {
  const clearButtons = document.getElementsByClassName("clear-form");
  Array.from(clearButtons).forEach(addClearForm);
});

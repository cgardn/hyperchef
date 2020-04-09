function fireForm(form, item) {
  Rails.fire(form, 'submit');
}

document.addEventListener("DOMContentLoaded", function () {
  form = document.getElementById("unit_form");

  document.addEventListener("change", (e) => {
    select = document.getElementById("servings");
    if (e.target === select) {
      fireForm(form, e);
    }
  });
  
});

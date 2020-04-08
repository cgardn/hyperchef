function fireForm(form) {
  Rails.fire(form, 'submit');
}

document.addEventListener("DOMContentLoaded", function () {
  form = document.getElementById("unit_form");
  select = document.getElementById("servings");
  radio_true = document.getElementById("convert_true");
  radio_false = document.getElementById("convert_false");

  select.addEventListener("change", (e) => {
    fireForm(form);
  });

  [radio_true, radio_false].forEach( (item) => {
    item.addEventListener("click", (e) => {
      fireForm(form);
    });
  });
});

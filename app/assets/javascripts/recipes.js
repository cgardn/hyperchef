function fireForm(form, item) {
  console.log(item);
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

  document.getElementById("convert_true").addEventListener("mouseup", (e) => {
    fireForm(form, e);
  });
  document.getElementById("convert_false").addEventListener("mouseup", (e) => {
    fireForm(form, e);
  });
});

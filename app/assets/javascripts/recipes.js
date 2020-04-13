function submitUnitForm(form, newValue) {
  if (newValue) {
    document.getElementById("unit_field").setAttribute('value', newValue);
  }
  Rails.fire(form, 'submit');
}

document.addEventListener("turbolinks:load", function () {
  form = document.getElementById("unit_form");

  document.addEventListener("change", function (e) {
    select = document.getElementById("servings");
    if (e.target === select) {
      fireForm(form);
    }
  });

  metric = document.getElementById("button_metric");
  metric.addEventListener("mousedown", function () {
    submitUnitForm(form, 'metric');
  });

  imperial = document.getElementById("button_imperial");
  imperial.addEventListener("mousedown", function() {
    submitUnitForm(form, "imperial");
  });
  
});

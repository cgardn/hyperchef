function fireForm(form, item) {
  console.log(item);
  Rails.fire(form, 'submit');
}

document.addEventListener("DOMContentLoaded", function () {
  console.log("recipe js");
  form = document.getElementById("unit_form");

  document.addEventListener("change", (e) => {
    console.log("listener 1");
    select = document.getElementById("servings");
    if (e.target === select) {
      fireForm(form, e);
    }
  });
  
  document.getElementById("convert_true").addEventListener("mouseup", (e) => {
    console.log("listener 2");
    fireForm(form, e);
  });
  document.getElementById("convert_false").addEventListener("mouseup", (e) => {
    console.log("listener 3");
    fireForm(form, e);
  });
});

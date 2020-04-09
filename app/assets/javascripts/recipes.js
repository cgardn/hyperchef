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
  
});

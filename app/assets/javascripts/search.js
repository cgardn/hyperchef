// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function submitSearchForm(form) {
  console.log("in submit");
  Rails.fire(form, 'submit');
}

//document.addEventListener("turbolinks:load", function () {
//  form = document.getElementById("searchform");
//  modal = document.getElementById("filterModal");
//  console.log(modal);
//
//  modal.on("hidden.bs.modal", function () {
//    console.log("in event");
//    submitSearchForm(form);
//  });
//});
  

$(function() {
  return $("#filterModal").on('hidden.bs.modal', function() {
    form = document.getElementById("searchform");
    submitSearchForm(form);
  });
});

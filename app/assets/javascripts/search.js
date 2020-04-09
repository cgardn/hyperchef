// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  return $("#filterModal").on('hidden.bs.modal', function() {
    return $("#searchform").trigger("submit.rails");
  });
});

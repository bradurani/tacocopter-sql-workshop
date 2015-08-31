// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $(".show-answer").click(function () {
    $button = $(this);
    $content = $button.siblings('.answer-content');
    $content.slideToggle(100, function(){
      $button.text(function () {
        return $content.is(":visible") ? "Hide Answer" : "Show Answer";
      });
    });
  });
});

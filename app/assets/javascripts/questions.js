// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $(".answer").click(function () {
    $answer = $(this);
    $content = $answer.find('.answer-content');
    $content.slideToggle(100, function(){
      $answer.find('.show-answer').text(function () {
        return $content.is(":visible") ? "Hide Answer" : "Show Answer";
      });
    });
  });
});

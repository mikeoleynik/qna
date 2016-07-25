$ ->
  $('.edit_question_link').click (e) ->
    e.preventDefault();
    $('.question').hide();
    $('.edit_question').show()
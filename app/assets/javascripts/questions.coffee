$ ->
  $(document).on 'click', '.edit_question_link', (e) ->
    e.preventDefault();
    $('.question .content').hide();
    $('.edit_question_show').show()
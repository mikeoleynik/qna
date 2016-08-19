$ ->
  $(document).on 'click', '.edit_question_link', (e) ->
    e.preventDefault();
    $('.question .content').hide();
    $('.edit_question_show').show()

  PrivatePub.subscribe '/questions', (data, channel) ->
    question = $.parseJSON(data['question'])
    $('.questions').append('<p>' + question.title + '</p>' + '<a href="/questions/' + question.id + '">' + 'Показать' + '</a>')
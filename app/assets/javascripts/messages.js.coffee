# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@callUpdate = (topic_id) ->
  @topic_id = topic_id
  update()

update = ->
  $.get '/topics/' + @topic_id + '/messages.json', null, (data, status, jqXHR) ->
    msgsSorted = _.sortBy data, (message) ->
      new Date(message.created_at).getTime()

    $('#chat').empty()
    for m in msgsSorted
      d = moment(m.created_at)
      $('#chat').append('<li>' +
      '<span class="created_at">' + d.format('hh:mm') + '</span>' +
      m.body +
      '</li>')

    setTimeout update, 750

$(document).ready ->
  ws = new WebSocket("ws://localhost:9000/chat")

  ws.onopen = ->
    console.log "connected..."

  ws.onmessage = (event) ->
    console.log event
    $("<li>#{event.data}</li>").prependTo("#msg")

  ws.onclose = ->
    console.log "socket closed"

  $("#submit").click ->
    nick = $("#nick").val()
    msg = $("#message").val()
    ws.send "#{nick}: #{msg}"
    false
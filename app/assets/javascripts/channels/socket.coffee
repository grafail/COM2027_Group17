$(document).on "turbolinks:load", ->
  id = $("#eventID")[0]

  App.socket = App.cable.subscriptions.create {
    channel: "SocketChannel"
# You can grab the conversation id as a data attribute from the messages container of your conversation and pass it as a parameter to the channel
    eventID: id.value
  },
  connected: ->
    # Called when the subscription is ready for use on the server
    this.viewed()
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#viewingNow').html(data.value.toFixed(0));

  viewed: ->
    @perform 'viewed'

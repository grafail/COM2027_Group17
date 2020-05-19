class SocketChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "viewed_#{params[:eventID]}"
    @event = Event.find_by(id:params[:eventID])
    @event.increment!(:viewCount, 1)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @event = Event.find_by(id:params[:eventID])
    @event.increment!(:viewCount, -1)
    viewed
  end

  def viewed
    @event = Event.find_by(id:params[:eventID])
    ActionCable.server.broadcast "viewed_#{params[:eventID]}", {value: @event.viewCount}
  end
end

# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BoothChannel < ApplicationCable::Channel
  def subscribed
    stream_from "booth_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def traffic(data)
    p data["action"] + " is received."
    Booth.find(5).update(state: data["message"])
  end
end

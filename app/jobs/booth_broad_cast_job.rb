class BoothBroadCastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'booth_channel', {boothId: data.id ,message: render_message(data)}
  end

  private

  def render_message(data)
    ApplicationController.renderer.render(partial: 'booths/booth', locals: { booth: data })
  end
end

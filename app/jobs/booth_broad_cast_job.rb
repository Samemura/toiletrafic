class BoothBroadCastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'booth_channel', {boothId: data.id, boothState: data.state, html: render_html(data)}
  end

  private

  def render_html(data)
    ApplicationController.renderer.render(partial: 'booths/booth', locals: { booth: data, without_class: true })
  end
end

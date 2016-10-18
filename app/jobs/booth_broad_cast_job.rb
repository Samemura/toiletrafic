class BoothBroadCastJob < ApplicationJob
  queue_as :default

  def perform(booth)
    ActionCable.server.broadcast 'booth_channel', {boothId: booth.id, boothState: booth.state, html: render_html(booth)}
  end

  private

  def render_html(booth)
    ApplicationController.renderer.render(partial: 'booths/booth', locals: { booth: booth, without_class: true })
  end
end

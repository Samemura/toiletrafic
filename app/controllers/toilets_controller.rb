class ToiletsController < ApplicationController
  before_action :set_usage, only: [:index, :show]

  def index
  end

  def show
  end

  private

  def set_usage
    @usage = {
      today: BoothUsage.by_hour(Date.today),
      average: BoothUsage.average_by_hour
    }
  end
end

class ToiletsController < ApplicationController
  def index
    @usage = {
      today: BoothUsage.by_hour(Date.today),
      average: BoothUsage.average_by_hour(7.day.ago..Time.now)
    }
  end

  def show
    @usage = {
      today: BoothUsage.by_hour(Date.today),
      average: BoothUsage.average_by_hour(7.day.ago..Time.now)
    }
  end
end

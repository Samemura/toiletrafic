class BoothsController < ApplicationController
  protect_from_forgery :except => ["update"]
  before_action :set_booth, only: [:show, :edit, :update]

  def index
    @booths = Booth.all.order(id: 'asc')
  end

  def show
  end

  def update
    respond_to do |format|
      if @booth.state != params[:state]
        if @booth.update(booth_params)
          format.json { render :show, status: :ok, location: @booth }
        else
          format.json { render json: @booth.errors, status: :unprocessable_entity }
        end
      else
        format.json { render :show, status: :accepted, location: @booth }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booth
    @booth = Booth.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booth_params
    params.permit(:state)
  end
end

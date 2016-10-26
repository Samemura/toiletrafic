class TokensController < ApplicationController
  protect_from_forgery

  def create
    token = Token.create(token_params)
    render json: token, status: :accepted

  rescue => error
    render json: {error: error}, status: :unprocessable_entity
  end

  private

  def token_params
    params.permit(:platform, :token)
  end

end

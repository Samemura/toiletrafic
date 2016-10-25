class TokensController < ApplicationController
  protect_from_forgery

  def create
    respond_to do |format|
      if Token.create(token_params)
        return head :ok
      else
        return head :error
      end
    end
  end

  private

  def token_params
    params.permit(:platform, :token)
  end
end

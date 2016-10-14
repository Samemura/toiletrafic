class GitController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pull
    @return = system 'git pull origin master'
  end
end

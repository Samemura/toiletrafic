class GitController < ApplicationController
  def pull
    @return = system 'git pull origin master'
  end
end

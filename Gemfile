source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '5.0.0'
gem 'puma'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'config'
gem 'sprockets-rails'
gem 'unicorn'
gem 'turbolinks'
gem 'mysql2'
gem 'redis'

gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', github: 'sferik/rails_admin'
gem 'rails_admin_history_rollback'
gem 'devise'
gem 'paper_trail'

# front developmentbundl
gem 'slim-rails'
gem 'html2slim'
gem 'autoprefixer-rails'
gem 'sass-globbing'
gem 'jpmobile'
gem 'colorable'
gem 'milligram'

# Chart
gem "chartkick"
gem 'groupdate'

# Push notification
gem 'rpush'
gem 'net-http-persistent', '2.9.4'

group :development, :test do
  gem 'dotenv-rails'
  gem 'bullet'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'annotate'
  gem 'spring' if ENV['DEBUG_WITH_SPRING'] == 'true'
end

# Heroku
group :production do
  gem 'rails_12factor'
end

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

gem 'sass-rails',   '~> 4.0.0.rc1'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass', '~> 2.3.1.2'


# INFRASTRUCTURE
gem 'pg'
gem 'newrelic_rpm'
gem 'dalli'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'mandrill-rails'

# MODELS
gem 'friendly_id', github: 'FriendlyId/friendly_id', branch: 'rails4'
gem 'acts_as_list'
gem 'carrierwave'
gem 'mime-types'
gem "mini_magick"
gem 'rinku'
#gem 'postrank-uri'

# VIEWS
gem 'slim', '>= 1.3.8'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.4.1'
gem 'font-awesome-sass-rails'
gem 'redcarpet'
gem 'reform'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'capistrano'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'thin'
  gem 'cane'
  gem 'garb'
  gem 'hirb'
  gem 'bullet'
  # gem 'better_errors'
  # # gem 'binding_of_caller'
end

group :test do
  gem 'minitest-spec-rails'
  gem 'capybara'
  gem 'turn'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

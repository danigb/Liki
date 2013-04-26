source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

gem 'pg'
gem 'newrelic_rpm'
gem 'dalli'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
#gem 'friendly_id'
gem 'friendly_id', :github => 'FriendlyId/friendly_id', :branch => 'rails4'
gem 'acts_as_list'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

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

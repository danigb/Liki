ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require 'sidekiq/testing'

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include Capybara::DSL

  include FactoryGirl::Syntax::Methods

  def click_submit(name = 'commit')
    page.find("input[name=\"#{name}\"]").click
  end

  def login(user)
    if user
      visit enter_path(user)
    else 
      visit logout_path
    end
  end
end

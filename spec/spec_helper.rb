ENV['RACK_ENV'] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'simplecov'
require 'coveralls'
require 'shoulda-matchers'
require 'rack/test'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = MicrolearningController

DatabaseCleaner.strategy = :truncation

Coveralls.wear!

SimpleCov.start
RSpec.configure do |c|
  c.include Capybara::DSL

  c.before(:all) do
    DatabaseCleaner.clean
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end
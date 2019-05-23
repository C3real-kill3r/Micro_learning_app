ENV['RACK_ENV'] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'rack/test'
require 'capybara/dsl'
require 'database_cleaner'

set :environment, :test
set :database, :microlearning_test

Capybara.app = MicrolearningController

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include Capybara::DSL

  c.before(:all) do
    DatabaseCleaner.clean
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end
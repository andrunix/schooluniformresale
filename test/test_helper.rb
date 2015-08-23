ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rubygems'

require 'rails/test_help'

require "minitest/autorun"
require "minitest/pride"
require "database_cleaner"
require "awesome_print"

require "fabrication"
Fabrication.configure do |config|
  fabricator_path = "test/fabricators"
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end


module TestHelper

  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  def teardown
    Rails.cache.clear if File.directory?(File.join(Rails.root, "/tmp/cache/"))
    DatabaseCleaner.clean
  end

end

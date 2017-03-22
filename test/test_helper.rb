ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun' # for stubs

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start

class ActionDispatch::IntegrationTest
  def json_response
    JSON.parse @response.body
  end
end

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  teardown do
    DatabaseCleaner.clean
  end
end

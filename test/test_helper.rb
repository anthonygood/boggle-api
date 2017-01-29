ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start


class ActiveSupport::TestCase
  teardown do
    DatabaseCleaner.clean
  end
end

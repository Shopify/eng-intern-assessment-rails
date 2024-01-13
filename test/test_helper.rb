# clean database to start with 0 articles
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

class ActiveSupport::TestCase
  # Setup for running tests
  setup do
    DatabaseCleaner.start
  end

  # Teardown after running tests
  teardown do
    DatabaseCleaner.clean
  end
end


ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

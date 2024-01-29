ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "database_cleaner/active_record"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Set cleaner strategy to truncation
    DatabaseCleaner.strategy = :truncation

    # Clean db before each test run
    setup do
      DatabaseCleaner.clean_with(:truncation)
    end

    # Ensure db is clean after each test
    teardown do
      DatabaseCleaner.clean
    end
  end
end
